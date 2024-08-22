import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/signup_entity.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widget/text_field_widget.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isChecked = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.blue,
              size: 30,
            )),
        actions: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: Colors.blue, // Border color
                width: 1, // Border width
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset:
                      const Offset(0, 2), // Shadow offset (elevation effect)
                ),
              ],
            ),
            child: const Text(
              'ECOM',
              style: TextStyle(
                fontFamily: 'CaveatBrush', // Specify the font family
                fontSize: 18.0, // Font size
                fontWeight: FontWeight.w500, // Font weight
                color: Color.fromARGB(255, 59, 86, 243), // Text color
                height:
                    117.41 / 100.89, // Line height (multiplier of font size)
                letterSpacing:
                    0.02 * 100.89, // Letter spacing (converted to px)
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ),
          const SizedBox(
            width: 60,
          )
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to SignUp')));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              ),
            );
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to SignUp')));
          }
        },
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                'Create your account',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 30,
              ),
              textWidget.displayTextField(
                  'Name', 'ex:johnsmith', _nameController),
              const SizedBox(
                height: 15,
              ),
              textWidget.displayTextField(
                  'email', 'ex:johnsmith@gmail.com', _emailController),
              const SizedBox(
                height: 15,
              ),
              textWidget.displayTextField(
                  'password', '**********', _passwordController),
              const SizedBox(
                height: 15,
              ),
              textWidget.displayTextField(
                  'confirm password', '**********', _confirmPasswordController),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ??
                            false; // Update the state when checkbox is toggled
                      });
                    },
                  ),
                  const Text(
                    'I understood the terms and policy',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 158, 152, 152)),
                  ),
                  const Text(
                    '  terms & policy',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 18, 33, 197)),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 53, 53, 240), // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 110.0, vertical: 5.0), // Custom padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0), // Button shape
                    ),
                  ),
                  onPressed: () {
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('The passwords are not match')));
                    } else {
                      context.read<AuthBloc>().add(SignUpEvent(SignUpEntity(
                          email: _emailController.text,
                          name: _nameController.text,
                          password: _passwordController.text)));
                    }
                  },
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'have an account?',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 158, 152, 152)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 18, 33, 197)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
