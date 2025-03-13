/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/add_message.svg
  SvgGenImage get addMessage =>
      const SvgGenImage('assets/icons/add_message.svg');

  /// File path: assets/icons/app_icon.png
  AssetGenImage get appIcon => const AssetGenImage('assets/icons/app_icon.png');

  /// File path: assets/icons/apple_logo.png
  AssetGenImage get appleLogo =>
      const AssetGenImage('assets/icons/apple_logo.png');

  /// File path: assets/icons/chat.svg
  SvgGenImage get chat => const SvgGenImage('assets/icons/chat.svg');

  /// File path: assets/icons/closed.png
  AssetGenImage get closed => const AssetGenImage('assets/icons/closed.png');

  /// File path: assets/icons/dislike.png
  AssetGenImage get dislike => const AssetGenImage('assets/icons/dislike.png');

  /// File path: assets/icons/folder.svg
  SvgGenImage get folder => const SvgGenImage('assets/icons/folder.svg');

  /// File path: assets/icons/google_logo.png
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/icons/google_logo.png');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/like.png
  AssetGenImage get like => const AssetGenImage('assets/icons/like.png');

  /// File path: assets/icons/logout.svg
  SvgGenImage get logout => const SvgGenImage('assets/icons/logout.svg');

  /// File path: assets/icons/news_new.svg
  SvgGenImage get newsNew => const SvgGenImage('assets/icons/news_new.svg');

  /// File path: assets/icons/open.png
  AssetGenImage get open => const AssetGenImage('assets/icons/open.png');

  /// File path: assets/icons/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/icons/profile.svg');

  /// File path: assets/icons/rating.svg
  SvgGenImage get rating => const SvgGenImage('assets/icons/rating.svg');

  /// File path: assets/icons/search.svg
  SvgGenImage get search => const SvgGenImage('assets/icons/search.svg');

  /// File path: assets/icons/send_message.svg
  SvgGenImage get sendMessage =>
      const SvgGenImage('assets/icons/send_message.svg');

  /// File path: assets/icons/share.svg
  SvgGenImage get share => const SvgGenImage('assets/icons/share.svg');

  /// List of all assets
  List<dynamic> get values => [
        addMessage,
        appIcon,
        appleLogo,
        chat,
        closed,
        dislike,
        folder,
        googleLogo,
        home,
        like,
        logout,
        newsNew,
        open,
        profile,
        rating,
        search,
        sendMessage,
        share
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bg.png
  AssetGenImage get bg => const AssetGenImage('assets/images/bg.png');

  /// File path: assets/images/bottom_bg.png
  AssetGenImage get bottomBg =>
      const AssetGenImage('assets/images/bottom_bg.png');

  /// File path: assets/images/floating_button.png
  AssetGenImage get floatingButton =>
      const AssetGenImage('assets/images/floating_button.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo_text.png
  AssetGenImage get logoText =>
      const AssetGenImage('assets/images/logo_text.png');

  /// File path: assets/images/no_image.png
  AssetGenImage get noImage =>
      const AssetGenImage('assets/images/no_image.png');

  /// File path: assets/images/rating_bg.png
  AssetGenImage get ratingBg =>
      const AssetGenImage('assets/images/rating_bg.png');

  /// File path: assets/images/send_message.svg
  SvgGenImage get sendMessage =>
      const SvgGenImage('assets/images/send_message.svg');

  /// List of all assets
  List<dynamic> get values => [
        bg,
        bottomBg,
        floatingButton,
        logo,
        logoText,
        noImage,
        ratingBg,
        sendMessage
      ];
}

class Assets {
  Assets._();

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

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
