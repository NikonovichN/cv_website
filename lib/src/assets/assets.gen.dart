/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFilesGen {
  const $AssetsFilesGen();

  /// File path: assets/files/00_CV_Nikonovich_En.pdf
  String get a00CVNikonovichEn => 'assets/files/00_CV_Nikonovich_En.pdf';

  /// File path: assets/files/00_CV_Nikonovich_Ru.pdf
  String get a00CVNikonovichRu => 'assets/files/00_CV_Nikonovich_Ru.pdf';

  /// List of all assets
  List<String> get values => [a00CVNikonovichEn, a00CVNikonovichRu];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/svg
  $AssetsIconsSvgGen get svg => const $AssetsIconsSvgGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/avatar.png
  AssetGenImage get avatar => const AssetGenImage('assets/images/avatar.png');

  /// List of all assets
  List<AssetGenImage> get values => [avatar];
}

class $AssetsIconsSvgGen {
  const $AssetsIconsSvgGen();

  /// File path: assets/icons/svg/down-arrow.svg
  String get downArrow => 'assets/icons/svg/down-arrow.svg';

  /// File path: assets/icons/svg/download-minimalistic.svg
  String get downloadMinimalistic =>
      'assets/icons/svg/download-minimalistic.svg';

  /// File path: assets/icons/svg/git.svg
  String get git => 'assets/icons/svg/git.svg';

  /// File path: assets/icons/svg/heart-angle.svg
  String get heartAngle => 'assets/icons/svg/heart-angle.svg';

  /// File path: assets/icons/svg/heart-pulse.svg
  String get heartPulse => 'assets/icons/svg/heart-pulse.svg';

  /// File path: assets/icons/svg/heart-small.svg
  String get heartSmall => 'assets/icons/svg/heart-small.svg';

  /// File path: assets/icons/svg/heart.svg
  String get heart => 'assets/icons/svg/heart.svg';

  /// File path: assets/icons/svg/linked_in.svg
  String get linkedIn => 'assets/icons/svg/linked_in.svg';

  /// File path: assets/icons/svg/mail.svg
  String get mail => 'assets/icons/svg/mail.svg';

  /// File path: assets/icons/svg/oops.svg
  String get oops => 'assets/icons/svg/oops.svg';

  /// File path: assets/icons/svg/telegram.svg
  String get telegram => 'assets/icons/svg/telegram.svg';

  /// List of all assets
  List<String> get values => [
        downArrow,
        downloadMinimalistic,
        git,
        heartAngle,
        heartPulse,
        heartSmall,
        heart,
        linkedIn,
        mail,
        oops,
        telegram
      ];
}

class Assets {
  Assets._();

  static const $AssetsFilesGen files = $AssetsFilesGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
