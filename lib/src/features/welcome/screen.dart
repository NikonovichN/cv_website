import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'controller.dart';
import '../../src.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _padding = EdgeInsets.symmetric(vertical: 20.0);
  static const _descriptionTextPadding = EdgeInsets.symmetric(horizontal: 136.0);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WelcomeScreenState>(
        stream: injector(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || (snapshot.data?.isLoading != null && snapshot.data!.isLoading)) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data?.error != null) {
            return _ErrorState(
              message: snapshot.data?.error?.message,
              tryAgainLabel: snapshot.data?.value?.tryAgainLabel,
            );
          }

          final value = snapshot.data!.value!;

          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Padding(
                padding: _padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(value.title, style: CvAppFonts.header),
                    const SizedBox(height: 62.0),
                    Padding(
                      padding: _descriptionTextPadding,
                      child: Text(
                        value.description,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _PhoneText(phone: value.phone1),
                            const SizedBox(height: 8.0),
                            _PhoneText(phone: value.phone2),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // TODO: do not forget add real link
                                CvAppSvgIconButton.primary(
                                  iconPath: Assets.icons.svg.gmail,
                                  onPressed: () {},
                                ),
                                CvAppSvgIconButton(
                                  iconPath: Assets.icons.svg.git,
                                  onPressed: () {},
                                ),
                                CvAppSvgIconButton.primary(
                                  iconPath: Assets.icons.svg.linkedIn,
                                  onPressed: () {},
                                ),
                                CvAppSvgIconButton.primary(
                                  iconPath: Assets.icons.svg.telegram,
                                  onPressed: () {},
                                ),
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
        });
  }
}

class _ErrorState extends StatelessWidget {
  final String? message;
  final String? tryAgainLabel;

  const _ErrorState({this.message, this.tryAgainLabel});

  static const String _defaultTryAgainLabel = 'Try again!';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        if (message != null) ...[
          Text(message!, textAlign: TextAlign.center),
          const SizedBox(height: 40.0),
        ],
        Center(
          child: SizedBox(
            width: 180,
            child: CvAppButton.primary(
              onPressed: injector<WelcomeScreenController>().loadData,
              child: Text(tryAgainLabel ?? _defaultTryAgainLabel),
            ),
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}

class _PhoneText extends StatelessWidget {
  final String phone;

  const _PhoneText({required this.phone});

  static const _padding = EdgeInsets.only(left: 6.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: Text(
        phone,
        style: CvAppFonts.robotoSmallRegular.copyWith(
          color: CvAppBasicColors.silverWare,
        ),
      ),
    );
  }
}
