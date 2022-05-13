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
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  bool _isLoginMode = true;
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
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 3,
                      color: Colors.amber,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: isPortrait ? null : size.height * 0.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // ========================= Username =========================
                Transform.rotate(
                  angle: 0.1,
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('Username'),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                // ========================= Password =========================
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _passwordController,
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
        ElevatedButton(
          onPressed: () => login(userProviderData),
          child: const Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: !_isLoginMode ? size.height * 0.33 : null,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // ========================= Username =========================
                Transform.rotate(
                  angle: -0.1,
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('Username'),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                // ========================= Email =========================
                TextFormField(
                  controller: _emailController,
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
        const SizedBox(height: 35),
        ElevatedButton(
          onPressed: () {},
          child: const Text(
            "Signup",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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

  void login(userDataProvider) async {
    String username = _usernameController.value.text;
    String password = _passwordController.value.text;
    bool result = await Provider.of<UserProvider>(context, listen: false)
        .loginUser(username: username, password: password);
    if (result) {
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Error"),
                content: Text("Invalid username or password!"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Ok"))
                ],
              ));
    }
  }

  void signup() {}
}
