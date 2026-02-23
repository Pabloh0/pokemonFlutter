import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/widget/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _LoginView());
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEF5350), Color(0xFFB71C1C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                _HeaderPokeball(),
                SizedBox(height: 40),
                _LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderPokeball extends StatefulWidget {
  const _HeaderPokeball();

  @override
  State<_HeaderPokeball> createState() => _HeaderPokeballState();
}

class _HeaderPokeballState extends State<_HeaderPokeball>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return Transform.scale(scale: controller.value, child: child);
      },
      child: Column(
        children: const [
          Icon(Icons.catching_pokemon, size: 120, color: Colors.white),
          SizedBox(height: 10),
          Text(
            'Bienvenido Entrenador',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.redAccent, width: 4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            const Text(
              'Iniciar Sesión',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 25),

            CustomTextFormField(
              label: 'Usuario',
              icon: const Icon(Icons.person),
              onChanged: (value) => username = value,
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Requerido' : null,
            ),

            const SizedBox(height: 20),

            CustomTextFormField(
              label: 'Contraseña',
              obscureText: true,
              icon: const Icon(Icons.lock),
              onChanged: (value) => password = value,
              validator: (value) => (value == null || value.length < 3)
                  ? 'Mínimo 3 caracteres'
                  : null,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: pokemonProvider.isLoading
                    ? null
                    : () => _login(pokemonProvider),
                child: pokemonProvider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Entrar', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login(PokemonProvider provider) {
    //primero hacemos las comprobaciones a nivel de fallos del user y una vez todo eso este bien comprobamos con la info que nos trae el back
    if (!_formkey.currentState!.validate()) return;
    if (provider.admins[0].pass == password &&
        provider.admins[0].correo == username) {
      context.pushReplacement('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Credenciales incorrectas o servidor no disponible'),
        ),
      );
    }
  }
}
