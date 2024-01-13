import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soiscan/Bloc/Authentication/authentication_bloc.dart';
import 'package:soiscan/Bloc/Login/login_bloc.dart';
import 'package:soiscan/theme.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: darkgreyColor),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Login",
              style: TextStyle(color: darkgreyColor),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
              if (state is LoginSuccess) {
                context.read<AuthenticationBloc>().add(UserLoginEvent(state.user));
              }
            },
            child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 35,
                              color: darkgreyColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Enter your valid data to login",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "Email",
                          ),
                          validator: (value) {
                            if (value != null && EmailValidator.validate(value)) {
                              return null;
                            } else {
                              return "Please enter a valid email";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "Password",
                          ),
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? "Please Enter Some Text"
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return ElevatedButton(
                                  onPressed: () {
                                    final isvalid = _formKey.currentState!.validate();
                                    if (isvalid) {
                                      context.read<LoginBloc>().add(
                                        LoginWithEmailPasswordEvent(_emailController.text, _passwordController.text));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      elevation: 0,
                                      backgroundColor: darkgreyColor),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 25,)
                      ],
                    ),
                  ),
                ),
              )
            ),
          ),
        ));
  }
}
