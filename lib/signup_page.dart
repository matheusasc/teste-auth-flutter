import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa o Firebase Auth

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Cria a instância do FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Função para registrar o usuário no Firebase
  Future<void> register() async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    // Validação da senha (mínimo de 6 caracteres)
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("A senha deve ter pelo menos 6 caracteres")),
      );
      return;
    }

    try {
      // Cria o usuário com email e senha
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Após o cadastro, você pode salvar o nome em uma base de dados (Firestore, por exemplo)
      // Aqui você pode salvar o nome ou qualquer outra informação do usuário em Firestore.
      // Exemplo de salvamento no Firestore:
      /*
      FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
      });
      */

      // Exibe uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cadastro realizado com sucesso!")));
      print('Cadastro realizado: $name, $email');
    } catch (e) {
      // Exibe uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao cadastrar: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: register,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
