import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soiscan/Bloc/Registration/registration_bloc.dart';
import 'package:soiscan/theme.dart';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
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
              "Sing-up",
              style: TextStyle(color: darkgreyColor),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationFailed) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is RegistrationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sign-up Success")));
                context.goNamed("login");
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
                          "Sign-up",
                          style: TextStyle(
                              fontSize: 35,
                              color: darkgreyColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Enter your valid data to Sign-up",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "Name",
                          ),
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? "Please Enter Your Name"
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
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
                            if (value == null || value.isEmpty) {
                              return "Password at least 8 charracters in length";
                            } else {
                              RegExp regex = RegExp(r'^.{8,}$');
                              if (!regex.hasMatch(value)) {
                                return "Password at least 8 charracters in length";
                              } else {
                                return null;
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: BlocBuilder<RegistrationBloc, RegistrationState>(
                            builder: (context, state) {
                              if (state is RegistrationLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return ElevatedButton(
                                  onPressed: () {
                                    final isvalid = _formKey.currentState!.validate();
                                    if (isvalid) {
                                      context.read<RegistrationBloc>().add(UserSignup(name: _nameController.text, email: _emailController.text, password: _passwordController.text));
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
