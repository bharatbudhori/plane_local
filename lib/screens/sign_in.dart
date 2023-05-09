import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/screens/setup_profile_screen.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/text_styles.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final controller = PageController();
  int currentpge = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: LoadingWidget(
          loading: false,
          widgetClass: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/svg_images/logo.svg'),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Sign In to',
                              style: TextStylingWidget.mainHeading,
                            ),
                            Text(
                              ' Plane',
                              style: TextStylingWidget.mainHeading
                                  .copyWith(color: primaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                          style: TextStylingWidget.description
                              .copyWith(color: greyColor),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: currentpge == 0 ? 200 : 400,
                          child: PageView(
                            controller: controller,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [beforeSubmit(), afterSubmit()],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text(
                              'or',
                              style: TextStyle(color: greyColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Button(
                          text: 'Sign In with Google',
                          filledButton: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Button(
                          text: 'Sign In with Google',
                          filledButton: false,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_back,
                            color: greyColor,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: (){
                              if(currentpge == 0){
                                Navigator.of(context).pop();
                              }
                              else {
                                controller.previousPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
                                setState(() {
                                  currentpge = 0;
                                });
                              }
                            },
                            child: Text(
                              'Go back',
                              style: TextStylingWidget.description.copyWith(
                                  color: greyColor, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget beforeSubmit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email *', style: TextStylingWidget.description),
        const SizedBox(
          height: 10,
        ),
        TextField(
          decoration: kTextFieldDecoration,
        ),
        const SizedBox(
          height: 30,
        ),
        Button(
          text: 'Send Code',
          ontap: (){
            setState(() {
            currentpge = 1;
          });
          controller.animateToPage(1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
          },
        )
      ],
    );
  }

  Widget afterSubmit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(9, 169, 83, 0.15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color.fromRGBO(9, 169, 83, 1),
                  size: 18,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Please check your mail for code',
                  style: TextStylingWidget.description.copyWith(
                      color: const Color.fromRGBO(9, 169, 83, 1), fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Email *', style: TextStylingWidget.description),
        const SizedBox(
          height: 10,
        ),
        TextField(
          decoration: kTextFieldDecoration,
        ),
        const SizedBox(
          height: 15,
        ),
        const Text('Enter Code *', style: TextStylingWidget.description),
        const SizedBox(
          height: 10,
        ),
        TextField(
          decoration: kTextFieldDecoration,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Didn’t receive code? Get new code in 22secs.',
              style: TextStylingWidget.description
                  .copyWith(color: greyColor, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Button(
          text: 'Log In',
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SetupProfileScreen(),
              ),
            );
          },
        )
      ],
    );
  }
}
