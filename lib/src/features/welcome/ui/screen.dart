import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../../src/src.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _padding = EdgeInsets.symmetric(vertical: 20.0);
  static const _descriptionTextPadding = EdgeInsets.symmetric(horizontal: 136.0);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Padding(
          padding: _padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Welcome!',
                style: CvAppFonts.header,
              ),
              const SizedBox(height: 62.0),
              const Padding(
                padding: _descriptionTextPadding,
                child: Text(
                  'There are many variations of passages of Lconst orem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
                  style: CvAppFonts.robotoRegular,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 76.0),
              Assets.images.avatar.image(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      const _PhoneText(phone: '+375 (29) 76 71 382'),
                      const SizedBox(height: 8),
                      const _PhoneText(phone: '+375 (44) 73 00 246'),
                      Row(
                        children: [
                          
                        ],
                      )
                    ],
                  ),
                  SvgPicture.asset(
                    Assets.icons.svg.heart,
                    colorFilter: const ColorFilter.mode(
                      CvAppBasicColors.buttercup,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneText extends StatelessWidget {
  final String phone;

  const _PhoneText({required this.phone});

  @override
  Widget build(BuildContext context) {
    return Text(
      phone,
      style: CvAppFonts.robotoSmallRegular.copyWith(
        color: CvAppBasicColors.silverWare,
      ),
    );
  }
}
