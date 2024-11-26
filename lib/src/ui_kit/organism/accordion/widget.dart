import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'controller.dart';
import '../../atoms/colors.dart';
import '../../../assets/assets.gen.dart';

class AccordionContainer<T> extends StatelessWidget {
  final List<Widget> sections;
  final String? initialActiveId;
  final EdgeInsets? scrollContainerPadding;

  const AccordionContainer({
    super.key,
    required this.sections,
    this.initialActiveId,
    this.scrollContainerPadding,
  });

  @override
  Widget build(BuildContext context) {
    if (sections.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(children: sections);
  }
}

typedef AccordionSectionTapCallback<T> = void Function(T sectionId);

class AccordionSection<T> extends StatelessWidget {
  /// Key should be static for every section!
  final T uniqueId;
  final Widget header;
  final Widget content;
  final EdgeInsets? margin;
  final AccordionSectionTapCallback? onTap;

  AccordionSection({
    super.key,
    required this.uniqueId,
    required this.header,
    required this.content,
    this.margin = const EdgeInsets.symmetric(vertical: 24.0),
    this.onTap,
  });

  final _controller = AccordionControllerImpl<T>();

  static const _containerAnimationDuration = Duration(milliseconds: 140);
  static const _textAnimationDuration = Duration(milliseconds: 60);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AccordionState<T>>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        final isSectionActive = snapshot.data?.activeSections.contains(uniqueId) ?? false;
        return Padding(
          padding: margin ?? EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  onTap?.call(uniqueId);
                  isSectionActive
                      ? _controller.removeActiveSection(uniqueId)
                      : _controller.addActiveSection(uniqueId);
                },
                child: AnimatedContainer(
                  duration: _textAnimationDuration,
                  child: _AnimatedHeader(
                    isActive: isSectionActive,
                    header: header,
                  ),
                ),
              ),
              AnimatedCrossFade(
                duration: _containerAnimationDuration,
                firstChild: Container(height: 0.0),
                secondChild: content,
                crossFadeState:
                    isSectionActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AnimatedHeader extends StatelessWidget {
  static const _animationDuration = Duration(milliseconds: 300);

  final Widget header;
  final bool isActive;

  const _AnimatedHeader({required this.header, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        header,
        AnimatedRotation(
          turns: isActive ? 0 : .5,
          duration: _animationDuration,
          child: SvgPicture.asset(
            Assets.icons.svg.downArrow,
            colorFilter: const ColorFilter.mode(
              CvAppBasicColors.buttercup,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
