import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/global/repository/users/user_repository.dart';
import 'package:crm_spx/src/models/user_model.dart';
import 'package:crm_spx/src/navigation/layouts/layouts.dart';
import 'package:crm_spx/src/provider/theme_provider.dart';
import 'package:crm_spx/src/utils/loading.dart';
import 'package:crm_spx/src/utils/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool isloading = false;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<User> userLog = [];

  @override
  void initState() {
    super.initState();
  }

  Future getUser() async {
    final user = await UserRepository().getAllData();

    setState(() {
      userLog = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    var headline6 = Theme.of(context).textTheme.headline6;
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: Responsive.isDesktop(context)
              ? const EdgeInsets.all(50.0)
              : const EdgeInsets.all(10.0),
          child: Card(
            elevation: 10,
            shadowColor: Colors.deepPurpleAccent,
            child: Row(
              children: [
                if (!Responsive.isMobile(context))
                  Expanded(
                    child: Stack(
                      children: [
                        Image.asset('assets/images/spx_large.png',
                            fit: BoxFit.cover,
                            // width: double.infinity,
                            height: Responsive.isDesktop(context)
                                ? height
                                : height / 2),
                        Positioned(
                          bottom: 50,
                          left: 20,
                          child: DefaultTextStyle(
                            style: headline6!.copyWith(color: Colors.black),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                    'Bienvenue sur l\'interface CRM.',
                                    textStyle: TextStyle(
                                        color: ThemeProvider().isDarkMode
                                            ? Colors.white
                                            : Colors.black)),
                                TypewriterAnimatedText(
                                    'Générez vos scripting instanement.',
                                    textStyle: TextStyle(
                                        color: ThemeProvider().isDarkMode
                                            ? Colors.white
                                            : Colors.black)),
                                TypewriterAnimatedText(
                                    'Gerer le reporting calls et campaigns.',
                                    textStyle: TextStyle(
                                        color: ThemeProvider().isDarkMode
                                            ? Colors.white
                                            : Colors.black)),
                                TypewriterAnimatedText(
                                    'Travaillez sur differents campaigns.',
                                    textStyle: TextStyle(
                                        color: ThemeProvider().isDarkMode
                                            ? Colors.white
                                            : Colors.black)),
                                TypewriterAnimatedText(
                                    'Gardez le contrôle de votre agenda.',
                                    textStyle: TextStyle(
                                        color: ThemeProvider().isDarkMode
                                            ? Colors.white
                                            : Colors.black)),
                                TypewriterAnimatedText(
                                    'Gérez carnet d\'adresse.',
                                    textStyle: TextStyle(
                                        color: ThemeProvider().isDarkMode
                                            ? Colors.white
                                            : Colors.black)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                Expanded(
                    child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: helpWidget()),
                          logoWidget(),
                          // titleText(),
                          const SizedBox(height: 20),
                          userNameBuild(),
                          const SizedBox(height: 20),
                          passwordBuild(),
                          const SizedBox(height: 20),
                          loginButtonBuild(),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              forgotPasswordWidget(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logoWidget() {
    var height = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    return Image.asset(
      "assets/images/spx.png",
      height: Responsive.isDesktop(context) ? 100 : height / 5,
      width: size.width,
    );
  }

  Widget userNameBuild() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: userNameController,
        decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.person,
            ),
            labelText: 'Username'),
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'votre Username est obligatoire';
          } else {
            return null;
          }
        },
        onChanged: (value) {
          setState(() {
            userNameController.text = value.trim();
            userNameController.selection = TextSelection.fromPosition(
                TextPosition(offset: userNameController.text.length));
          });
        },
      ),
    );
  }

  Widget passwordBuild() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        controller: passwordController,
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
          ),
          labelText: 'Password',
        ),
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'Le mot de passe est obligatoire';
          } else if (RegExpIsValide().isValidPassword.hasMatch(value!)) {
            return 'Le mot de passe n\'est pas correct';
          } else {
            return null;
          }
        },
        onChanged: (value) {
          setState(() {
            passwordController.text = value.trim();
            passwordController.selection = TextSelection.fromPosition(
                TextPosition(offset: passwordController.text.length));
          });
        },
      ),
    );
  }

  Widget loginButtonBuild() {
    final _size = MediaQuery.of(context).size;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          height: 50,
          width: _size.width,
          margin: const EdgeInsets.only(bottom: 5),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 10),
                primary: Colors.teal,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () async {
                final form = _form.currentState!;
                if (form.validate()) {
                  setState(() => isloading = true);
                  await UserRepository()
                      .login(userNameController.text, passwordController.text)
                      .then((value) {
                    if (value) {
                      userLog
                        .map((e) async {
                          if (userNameController.text == e.userName) {
                            final user = User(
                              id: e.id,
                              firstName: e.firstName,
                              lastName: e.lastName,
                              userName: e.userName,
                              email: e.email,
                              telephone: e.telephone,
                              adresse: e.adresse,
                              sexe: e.sexe,
                              role: e.role,
                              campaign: e.campaign,
                              superviseur: e.superviseur,
                              isOnline: true,
                              isActive: e.isActive,
                              createdAt: e.createdAt,
                              password: e.password
                            );
                            await UserRepository().updateData(user);
                          }
                        });
                      // Le reboot permet deja de naviger vers la page layouts
                      Phoenix.rebirth(context); 
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => const Layouts())));

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("Login succès!"),
                        backgroundColor: Colors.green[700],
                      ));
                      setState(() => isloading = false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            const Text("Username ou mot de passe incorrect"),
                        backgroundColor: Colors.red[700],
                      ));
                      setState(() => isloading = false);
                    }
                  });
                }
              },
              child: isloading
                  ? loading()
                  : Text(
                      'CONNEXION',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height / 50,
                      ),
                    ))),
    ]);
  }

  Widget forgotPasswordWidget() {
    final button = Theme.of(context).textTheme.button;
    return TextButton(
        onPressed: () {},
        child: Text(
          'Mot de passe oublié ?',
          style: button,
          textAlign: TextAlign.start,
        ));
  }

  Widget helpWidget() {
    final button = Theme.of(context).textTheme.button;
    return TextButton.icon(
        onPressed: () {},
        icon: const Icon(
          Icons.help,
          color: Colors.teal,
        ),
        label: Text(
          'Besoin d\'aide?',
          style: button,
        ));
  }
}
