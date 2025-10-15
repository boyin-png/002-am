// In lib/src/features/auth/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/login_cubit.dart';
import '../../application/login_state.dart';

// Importa los otros archivos que crearás a continuación

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
  // Estado local para la visibilidad de la contraseña
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Inside the Column's children list
          SizedBox(
            height: 300,
            width: 300,
            child: Image.asset('assets/images/logo_app.png'),
          ),
          // Dentro del Column en _LoginFormState debajo del SizedBox
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Campos de texto y otros widgets irán aquí
              ],
            ),
          ),
          // Dentro del Column en _LoginFormState
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Después del SizedBox
          TextFormField(
            // El estado local controla si el texto se oculta
            obscureText: _isPasswordObscured,
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              // El ícono para mostrar/ocultar la contraseña
              suffixIcon: IconButton(
                icon: Icon(
                  // Cambia el ícono basado en el estado local
                  _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  // Llama a setState para reconstruir el widget con el nuevo estado
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16), // Después del TextFormField de contraseña
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return CheckboxListTile(
                title: const Text('Remember Me'),
                // El valor viene del estado del Cubit
                value: state.isRememberMeChecked,
                onChanged: (newValue) {
                  // Llama al método del Cubit para actualizar el estado
                  context.read<LoginCubit>().toggleRememberMe(
                    newValue ?? false,
                  );
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              );
            },
          ),
          const SizedBox(height: 24),
          // Al final del Column
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data...')),
                );
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
