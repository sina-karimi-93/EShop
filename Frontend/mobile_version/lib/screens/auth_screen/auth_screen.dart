import 'package:flutter/material.dart';
import 'package:mobile_version/providers/user_provider.dart';
import 'package:mobile_version/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import '../../widgets/fancy_text.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = './auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;
  bool _isLoading = false;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    var userProviderData = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  height: isPortrait ? size.height * 0.1 : size.height * 0.01),
              // ========================= Welcome ============================
              Transform.rotate(
                angle: -0.2,
                child: FancyText(
                  text: "Welcome!",
                  fontSize: isPortrait ? 40 : 30,
                  letterSpacing: 5,
                  outlineColor: Colors.amber,
                  inlineColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: isPortrait ? 50 : 20),
              // ========================= Login/SignUp ============================
              Container(
                width: isPortrait ? size.width * 0.85 : size.width * 0.6,
                // height: !_isLoginMode ? size.height * 0.6 : null,
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 3,
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  ],
                ),
                child: _isLoginMode
                    ? _loginModeWidgets(size, isPortrait, userProviderData)
                    : _signupModeWidgets(size),
              ),
              // ========================= Actions ============================
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginModeWidgets(Size size, bool isPortrait, var userProviderData) {
    /*
    The method returns the widgets for Login user.
    */
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: isPortrait ? null : size.height * 0.4,
          child: SingleChildScrollView(
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // ========================= Username =========================
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username is required!";
                      } else if (value.length < 4) {
                        return "Username should be at least 4 charracter";
                      }
                      return null;
                    },
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('Username'),
                    ),
                  ),
                  const SizedBox(height: 35),
                  // ========================= Password =========================
                  TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required!";
                      } else if (value.length < 4) {
                        return "Password should be at least 4 charracters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text("Password"),
                    ),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => login(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_isLoading)
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 13,
                  height: 13,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    strokeWidth: 2.3,
                  ),
                ),
            ],
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () => setState(() {
            _isLoginMode = false;
          }),
          child: const Text("Create new account!"),
        ),
      ],
    );
  }

  Widget _signupModeWidgets(Size size) {
    /*
    The method returns the widgets for Signing.
    */
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: !_isLoginMode ? size.height * 0.33 : null,
          child: SingleChildScrollView(
            child: Form(
              key: _signupFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // ========================= Username =========================
                  TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username is required!";
                      } else if (value.length < 4) {
                        return "Username should be at least 4 charracter";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('Username'),
                    ),
                  ),

                  const SizedBox(height: 35),
                  // ========================= Email =========================
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "E-mail is required!";
                      } else if (!value.contains("@") || !value.contains(".")) {
                        return "Invalid email address";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('E-mail'),
                    ),
                  ),
                  const SizedBox(height: 35),
                  // ========================= Password =========================
                  TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required!";
                      } else if (value.length < 4) {
                        return "Password should be at least 4 charracters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text("Password"),
                    ),
                  ),
                  const SizedBox(height: 35),
                  // ========================= Password2 =========================
                  TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _password2Controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required!";
                      } else if (value.length < 4) {
                        return "Password should be at least 4 charracters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text("Re-enter password"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 35),
        ElevatedButton(
          onPressed: signup,
          child: Row(
            children: [
              const Text(
                "Signup",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_isLoading)
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 13,
                  height: 13,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    strokeWidth: 2.3,
                  ),
                ),
            ],
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () => setState(() {
            _isLoginMode = true;
          }),
          child: const Text("Already have an account?!"),
        ),
      ],
    );
  }

  void login() async {
    /*
    This method is for login a user.
    1 - Gets the form state for validation
    2 - if validation is ok, then it collect inputs data
    4 - Via provider, asks for checking the user credential
    5 - After successfull authentication, it will navigate to home screen
    */
    String username = _usernameController.value.text;
    String password = _passwordController.value.text;
    final form = _loginFormKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // It is ready for authentication
      bool result = await Provider.of<UserProvider>(context, listen: false)
          .loginUser(username: username, password: password);
      if (result) {
        // Successfullt authenticated
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      } else {
        setState(() {
          _isLoading = false;
        });
        // Username or Password are not correct
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Invalid username or password!"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Ok"))
                  ],
                ));
      }
    }
  }

  void signup() async {
    /*
    This method is for register new user.
    1 - Gets the form state for validation
    2 - if validation is ok, then it collect inputs data
    3 - check whether passwords are match or not
    4 - Via provider, asks for registering the user
    5 - After successfull registeration, it will show a dialog and
        leads user to login mode.
    */
    final form = _signupFormKey.currentState;
    if (form!.validate()) {
      var username = _usernameController.value.text;
      var email = _emailController.value.text;
      var password = _passwordController.value.text;
      var password2 = _password2Controller.value.text;
      if (password == password2) {
        // it is ready for registration.
        var result = await Provider.of<UserProvider>(context, listen: false)
            .signupUser(username: username, email: email, password: password);
        if (result == true) {
          // New User has beeen Registered
          setState(() {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: const Text("Successful"),
                      content:
                          const Text("You've been successfully registered."),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Ok"))
                      ],
                    ));
            _isLoginMode = !_isLoginMode;
          });
        } else {
          // There is some error, usually the username is taken, but for
          // security issues we don not show this type of message.
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Error"),
              content: Text(result),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Ok"))
              ],
            ),
          );
        }
      } else {
        // Passwords are not match
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Error"),
            content: const Text("Passwords are not match!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Ok"))
            ],
          ),
        );
      }
    }
  }
}
