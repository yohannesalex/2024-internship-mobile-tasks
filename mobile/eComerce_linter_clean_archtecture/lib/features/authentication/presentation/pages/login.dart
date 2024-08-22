import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../eCommerce/presentation/bloc/product_bloc.dart';
import '../../domain/entity/login_entity.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widget/text_field_widget.dart';

class Login extends StatelessWidget {
  final String email;
  final String password;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  Login({super.key, this.email = '', this.password = ''})
      : _emailController = TextEditingController(text: email),
        _passwordController = TextEditingController(text: password);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            context.read<ProductBloc>().add(LoadAllProductEvent());
            Navigator.pushNamed(context, '/home');
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Failed to Login')));
          }
        },
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
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
                      offset: const Offset(
                          0, 2), // Shadow offset (elevation effect)
                    ),
                  ],
                ),
                child: const Text(
                  'ECOM',
                  style: TextStyle(
                    fontFamily: 'CaveatBrush', // Specify the font family
                    fontSize: 40.0, // Font size
                    fontWeight: FontWeight.w500, // Font weight
                    color: Color.fromARGB(255, 59, 86, 243), // Text color
                    height: 117.41 /
                        100.89, // Line height (multiplier of font size)
                    letterSpacing:
                        0.02 * 100.89, // Letter spacing (converted to px)
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              const Text(
                'Sign into your account',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 30,
              ),
              textWidget.displayTextField(
                  'Email', 'johnsmith@gmail.com', _emailController),
              const SizedBox(
                height: 15,
              ),
              textWidget.displayTextField(
                  'Password', '*********', _passwordController),
              const SizedBox(
                height: 30,
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
                    context.read<AuthBloc>().add(LoginEvent(LoginEntity(
                        email: _emailController.text,
                        password: _passwordController.text)));
                  },
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
              const SizedBox(
                height: 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Don't  have an account?",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 158, 152, 152)),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 18, 33, 197)),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
