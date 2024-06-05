import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/screens/member/component/custom_input.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _nickname = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordCheck = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _nickname.dispose();
    _password.dispose();
    _passwordCheck.dispose();
    super.dispose();
  }

  // 비밀번호, 비밀번호 확인 유효성 검사 함수
  String? _validatePassword(String? value) {
    final passwordRegex = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$',
      caseSensitive: true,
      multiLine: false,
    );
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    } else if (!passwordRegex.hasMatch(value)) {
      return '문자, 숫자, 특수 문자가 포함된 8 ~ 15자를 입력해주세요.';
    }
    if (_password.text != _passwordCheck.text) {
      return '비밀번호가 일치하지 않습니다.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '회원가입',
                    style: CustomFontStyle.getTextStyle(
                        context, CustomFontStyle.yeonSung150),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  EmailField(
                    controller: _email,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  NicknameField(controller: _nickname),
                  PasswordField(
                      controller: _password,
                      validator: _validatePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction),
                  PasswordCheckField(
                    controller: _passwordCheck,
                    validator: _validatePassword,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.orange.shade100,
                            backgroundColor: AppColors.error,
                            textStyle: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.yeonSung70),
                          ),
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text("뒤로 가기")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.green.shade100,
                            backgroundColor: AppColors.basicgreen,
                            textStyle: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.yeonSung70),
                          ),
                          onPressed: () async {
                            final auth =
                                Provider.of<AuthModel>(context, listen: false);
                            if (_formKey.currentState!.validate()) {
                              // 유효성 검사를 통과한 경우 회원가입 로직을 실행합니다.
                              String email = _email.text;
                              String password = _password.text;
                              String nickName = _nickname.text;
                              // Fluttertoast.showToast(
                              //     msg: "회원가입 성공",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.TOP,
                              //     timeInSecForIosWeb: 2,
                              //     backgroundColor: Colors.green,
                              //     textColor: Colors.white,
                              //     fontSize: 20.0);
                              // print('이메일 $email 비밀번호 $password 닉네임 $nickName');
                              // 여기에 회원가입 로직을 구현합니다.
                              AuthStatus loginStatus =
                                  await auth.signUp(email, password, nickName);
                              if (loginStatus == AuthStatus.loginSuccess) {
                                context.go('/intro');
                              }
                            }
                          },
                          child: const Text("회원 가입"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final AutovalidateMode? autovalidateMode;

  const EmailField({
    super.key,
    required this.controller,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      autovalidateMode: autovalidateMode,
      controller: controller,
      keyboard: TextInputType.emailAddress,
      icon: const Icon(Icons.mail),
      hint: "Email",
      label: "이메일",
      validator: (value) {
        // 이메일 유효성 검사 정규 표현식
        final emailRegex = RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
          caseSensitive: false,
          multiLine: false,
        );

        if (value == null || value.isEmpty) {
          return '이메일을 입력하세요.';
        } else if (!emailRegex.hasMatch(value)) {
          return '올바른 이메일 양식을 입력하세요.';
        }
        return null;
      },
    );
  }
}

class NicknameField extends StatelessWidget {
  final TextEditingController controller;

  const NicknameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      controller: controller,
      icon: const Icon(Icons.person),
      hint: "Nickname",
      label: "닉네임",
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  const PasswordField({
    super.key,
    required this.controller,
    this.validator,
    this.autovalidateMode,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;

  void showTogglePassword() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      autovalidateMode: widget.autovalidateMode,
      suffixIcon: IconButton(
          iconSize: 20,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            showTogglePassword();
          },
          icon: isObscure
              ? const Icon(FontAwesomeIcons.eye)
              : const Icon(FontAwesomeIcons.eyeSlash)),
      controller: widget.controller,
      obscure: isObscure,
      icon: const Icon(Icons.key_sharp),
      hint: "Password",
      label: "비밀번호",
      validator: widget.validator,
    );
  }
}

class PasswordCheckField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordCheckField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  State<PasswordCheckField> createState() => _PasswordCheckFieldState();
}

class _PasswordCheckFieldState extends State<PasswordCheckField> {
  bool isObscure = true;

  void showTogglePassword() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      suffixIcon: IconButton(
          iconSize: 20,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            showTogglePassword();
          },
          icon: isObscure
              ? const Icon(FontAwesomeIcons.eye)
              : const Icon(FontAwesomeIcons.eyeSlash)),
      controller: widget.controller,
      obscure: isObscure,
      icon: const Icon(Icons.check),
      hint: "Password Check",
      label: "비밀번호 확인",
      validator: widget.validator,
    );
  }
}
