part of app.auth;

class ForgotPasswordView extends StatefulWidget {
  static String route = '${AuthView.route}/forgotpassword';

  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordView> {
  final AuthRepository repository = locator<AuthRepository>();
  final NavigatorService navigator = locator<NavigatorService>();
  TextEditingController emailController = TextEditingController();

  String? emailError;

  void onValidateEmail(String email) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    bool isValid = regex.hasMatch(email.trim());
    setState(() {
      isValid ? emailError = null : emailError = 'invalid email';
    });
  }

  Future<void> recoverPassword() async {
    bool sendEmail =
        await repository.restorePassword(email: emailController.text);
    if (sendEmail == true) {
      print('Email valid');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Password Reset Email has been sent!',
            style: TextStyle(fontSize: 18.0),
          )));
      navigator.replace(
          route: LoginView.route, key: navigator.authNavigatorKey);
    } else {
      print('No user found for that email.');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'No user found for that email.',
            style: TextStyle(fontSize: 18.0),
          )));
    }
  }

  void navigateToSignUp() {
    navigator.push(route: SignUpView.route, key: navigator.authNavigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(
              fontSize: getProportionsScreenHeigth(14), color: secondaryColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: SizeConfig.screenHeight! * 0.02,
              ),
              Text(
                'Forgot Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionsScreenHeigth(28),
                ),
              ),
              Text(
                'Please enter your email and we will send\nyou a link to return to your account',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.08,
              ),
              Input(
                label: 'Email',
                icon: Icons.email_outlined,
                controller: emailController,
                placeholder: 'Enter your email',
                onChange: onValidateEmail,
                error: emailError,
              ),
              SizedBox(
                height: getProportionsScreenHeigth(120),
              ),
              Button(label: 'Send', onPress: recoverPassword),
              SizedBox(
                height: getProportionsScreenHeigth(24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account? ",
                  ),
                  InkWell(
                    onTap: navigateToSignUp,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: primaryColor),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
