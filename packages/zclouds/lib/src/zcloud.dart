import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zclouds/src/zcumulus.dart';
import 'package:zclouds/zclouds.dart';

/// {@template zclouds.zcloud}
/// Cloud made with ZFlutter.
/// {@endtemplate}
class ZCloud extends StatelessWidget {
  /// {@macro zclouds.zcloud}
  const ZCloud({
    Key? key,
    required this.type,
    required this.style,
  }) : super(key: key);

  /// {@macro zclouds.zcloudtype}
  final ZCloudType type;

  /// {@macro zclouds.zcloudstyle}
  final ZCloudStyle style;

  @override
  Widget build(BuildContext context) {
    late final Widget child;
    switch (type) {
      case ZCloudType.cumulus:
        child = const ZCumulus();
        break;
      case ZCloudType.cirrostratus:
      case ZCloudType.cirrocumulus:
      case ZCloudType.cirrus:
      case ZCloudType.altostratus:
      case ZCloudType.altocumulus:
      case ZCloudType.stratus:
      case ZCloudType.stratocumulus:
      case ZCloudType.nimbostratus:
      case ZCloudType.cumulonimbus:
        throw UnimplementedError(
          'Cloud type $type is not implemented yet.',
        );
    }

    return Provider<ZCloudStyle>.value(
      value: style,
      child: child,
    );
  }
}
