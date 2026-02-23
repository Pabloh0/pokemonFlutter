import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SeleccionScreen extends StatelessWidget {
  const SeleccionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEF5350), Color(0xFFB71C1C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(child: SeleccionDiv()),
      ),
    );
  }
}

class SeleccionDiv extends StatelessWidget {
  const SeleccionDiv({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.catching_pokemon, size: 60, color: Colors.redAccent),

          const SizedBox(height: 10),

          const Text(
            '¿Cómo quieres entrar?',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => context.push('/login'),
              icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
              label: const Text(
                'Entrar como Admin',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => context.pushReplacement('/home'),
              icon: const Icon(Icons.catching_pokemon, color: Colors.white),
              label: const Text(
                'Entrar como Invitado',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
