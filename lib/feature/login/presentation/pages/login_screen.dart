import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_api_practice/core/utils/common_methods.dart';
import 'package:mock_api_practice/feature/home/presentation/pages/home.dart';
import 'package:mock_api_practice/feature/login/presentation/bloc/bloc.dart';

//typedef OnAuthenticatedCallback = void Function(BuildContext context);

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _isAuthenticating = false;
  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(
      listener: (context, states) {
        if (states is Authenticating) {
          print("Authenticating");
            _isAuthenticating = true;
            _showLoader = true;

            setState(() {});

        } else if (states is LoginSuccess) {
          setState(() {
            _isAuthenticating = false;
          });
            Future.delayed(Duration(milliseconds: 300), () {
           if(mounted) {
             setState(() {
              _showLoader = false;
            });
           }
          });

          print("Authenticated");

         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));

        }

        else if (states is LoginFailed) {

          print("Authentication Failed: ${states.error}");


          showSnackBar(context,states.error);

          setState(() {
            _isAuthenticating = false;
          });
          Future.delayed(Duration(milliseconds: 300), () {
            setState(() {
              _showLoader = false;
            });
          });
        }


      },
      child: Center(
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: _isAuthenticating ? 0.0 : 1.0,
              duration: Duration(milliseconds: 300),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                transform: _isAuthenticating
                    ? Matrix4.translationValues(0, -50, 0)
                    : Matrix4.translationValues(0, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 5,
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Log in',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'to start shopping',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _loginFieldController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              suffixIcon: const Icon(
                                Icons.email,
                                color: Colors.green,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordFieldController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Forgot password?',style: TextStyle(color: Colors.green)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _onLogin(context, _loginFieldController.text,
                                  _passwordFieldController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              backgroundColor: Colors.green
                            ),
                            child: const Text('Log in',style: TextStyle(color: Colors.white),),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  // Implement sign up functionality
                                },
                                child: const Text('Sign up now!',style: TextStyle(color: Colors.green)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_showLoader)
              Center(
                child: AnimatedAlign(
                  alignment: _isAuthenticating ? Alignment.center : Alignment.bottomCenter,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.bounceInOut,
                  child: AnimatedOpacity(
                    opacity: _isAuthenticating ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _onLogin(BuildContext context, String userEmail, String password) {
    BlocProvider.of<LoginBloc>(context).add(
        AuthenticateUser(userEmail: userEmail, password: password));
  }
}

