import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_mart/consts/validator.dart';
import 'package:shop_mart/root_screen.dart';
import 'package:shop_mart/screens/auth/login_screen.dart';
import 'package:shop_mart/services/app_function.dart';
import 'package:shop_mart/services/auth/auth_service.dart';
import 'package:shop_mart/widgets/app_name_text.dart';
import 'package:shop_mart/widgets/auth/image_picker.dart';
import 'package:shop_mart/widgets/subtitle_text.dart';
import 'package:shop_mart/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureText = true;
  String passwordEntered = "";
  String repeatPasswordEntered = "";

  String nameEntered = "";
  String emailEntered = "";
  XFile? imageUploaded;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  // late final TextEditingController _passwordController;

  //_nameController
  //     _emailController,
  //     _passwordController,
  //     _repeatPasswordController;

  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _repeatPasswordFocusNode;

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // _nameController = TextEditingController();
    // _emailController = TextEditingController();
    // _passwordController = TextEditingController();
    // _repeatPasswordController = TextEditingController();
    // Focus Nodes
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      // _nameController.dispose();
      // _emailController.dispose();
      // _passwordController.dispose();
      // _repeatPasswordController.dispose();
      // Focus Nodes
      _nameFocusNode.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _repeatPasswordFocusNode.dispose();
    }
    super.dispose();
  }

  void handlePickImage(XFile imagePicked) {
    setState(() {
      imageUploaded = imagePicked;
    });
  }

  Future<void> handleRegister() async {
    bool isValid = _formkey.currentState!.validate();
    if (imageUploaded == null) {
      MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: 'Choose your avatar',
          fct: () {},
          isError: true);
      return;
    }
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isLoading = true;
        });

        await AuthService.signUp(auth, emailEntered, passwordEntered);

        setState(() {
          isLoading = false;
        });

        await Fluttertoast.showToast(
          msg: "Sign up successfully",
          textColor: Colors.white,
        );

        if (!mounted) return;
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => const RootScreen()));
      } catch (e) {
        await MyAppFunctions.showErrorOrWarningDialog(
            context: context,
            subtitle: e.toString(),
            fct: () {},
            isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // if (isLoading) {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(16.0)),
    //           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //           content: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Center(
    //                 child: LoadingAnimationWidget.inkDrop(
    //                   color: const Color(0xFF1A1A3F),
    //                   size: 200,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       });
    // }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const BackButton(),

                const AppNameText(
                  fontSize: 30,
                  text: 'Shopping',
                ),
                const SizedBox(
                  height: 16,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(label: "Welcome back!"),
                      SubtitleText(
                          title: "Sign up now to recieve special features..."),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                SizedBox(
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  child: ImagePickerField(
                    onPickImage: handlePickImage,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        //controller: _nameController,
                        focusNode: _nameFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: 'Full Name',
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                        onSaved: (value) {
                          nameEntered = value!;
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        onChanged: (value) {
                          setState(() {
                            nameEntered = value;
                          });
                        },
                        validator: (value) {
                          return MyValidators.displayNamevalidator(value);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        //   controller: _emailController,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email address",
                          prefixIcon: Icon(
                            IconlyLight.message,
                          ),
                        ),
                        onSaved: (value) {
                          emailEntered = value!;
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        onChanged: (value) {
                          setState(() {
                            emailEntered = value;
                          });
                        },
                        validator: (value) {
                          return MyValidators.emailValidator(value);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        // controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "***********",
                          prefixIcon: const Icon(
                            IconlyLight.lock,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_repeatPasswordFocusNode),
                        onSaved: (value) {
                          passwordEntered = value!;
                        },
                        onChanged: (value) => setState(() {
                          passwordEntered = value;
                        }),
                        validator: (value) {
                          return MyValidators.passwordValidator(value);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        //   controller: _repeatPasswordController,
                        focusNode: _repeatPasswordFocusNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,

                        decoration: InputDecoration(
                          hintText: "Repeat password",
                          prefixIcon: const Icon(
                            IconlyLight.lock,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          repeatPasswordEntered = value!;
                        },
                        onChanged: (value) {
                          setState(() {
                            repeatPasswordEntered = value;
                          });
                        },
                        validator: (value) {
                          return MyValidators.repeatPasswordValidator(
                            value: value,
                            password: passwordEntered,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 36.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12.0),
                            // backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                            ),
                          ),
                          icon: const Icon(IconlyLight.addUser),
                          label: const Text("Sign up"),
                          onPressed: () async {
                            await handleRegister();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
