import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto002/src/core/theme/app_theme.dart';
import '../../application/login_cubit.dart';
import '../../application/login_state.dart';
import 'package:proyecto002/src/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:confetti/confetti.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: const LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    // Aseguramos que el controlador de confeti se inicialice aquí
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          _confettiController.play();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('¡Inicio de sesión exitoso!'),
                backgroundColor: Colors.green,
              ),
            );
          _emailController.clear();
          _passwordController.clear();
        } else if (state is LoginFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error de inicio de sesión'),
              content: Text(state.error),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Column(
                children: [
                  Image.asset('assets/images/logo_app.png'),
                  const SizedBox(height: AppSpacing.large),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomTextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          labelText: 'Email Address',
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(
                              context,
                            ).requestFocus(_passwordFocusNode);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            );
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.medium),
                        CustomTextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          labelText: 'Password',
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submitForm(),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.medium),
                        BlocBuilder<LoginCubit, LoginState>(
                          buildWhen: (previous, current) =>
                              current is LoginInitial,
                          builder: (context, state) {
                            final isChecked = state is LoginInitial
                                ? state.isRememberMeChecked
                                : false;
                            return CheckboxListTile(
                              title: const Text('Remember Me'),
                              value: isChecked,
                              onChanged: (newValue) {
                                context.read<LoginCubit>().toggleRememberMe(
                                  newValue ?? false,
                                );
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.large),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return const KeyedSubtree(
                                  key: ValueKey('loading'),
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return KeyedSubtree(
                                key: const ValueKey('button'),
                                child: ElevatedButton(
                                  onPressed: _submitForm,
                                  child: const Text('Login'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
            ],
          ),
        ],
      ),
    );
  }
}
