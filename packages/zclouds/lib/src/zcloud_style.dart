// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:zclouds/zclouds.dart';

/// {@template zclouds.zcloudstyle}
/// Specifies how a [ZCloud] shold appear.
/// {@endtemplate}
class ZCloudStyle {
  /// {@macro zclouds.zcloudstyle}
  const ZCloudStyle({
    this.color = Colors.white,
    this.frontColor,
    this.sideColor,
    this.opacity = 0,
  });

  factory ZCloudStyle.fromSwatch(
    MaterialColor primaryColor, {
    MaterialColor? secondaryColor,
    double opacity = 0,
  }) {
    return ZCloudStyle(
      color: primaryColor.shade500,
      frontColor: (secondaryColor ?? primaryColor).shade200,
      sideColor: (secondaryColor ?? primaryColor).shade100,
      opacity: opacity,
    );
  }

  final double opacity;
  final Color color;
  final Color? frontColor;
  final Color? sideColor;

  ZCloudStyle copyWith({
    Color? color,
    Color? frontColor,
    Color? sideColor,
    double? opacity,
  }) {
    return ZCloudStyle(
      color: color ?? this.color,
      frontColor: frontColor ?? this.frontColor,
      sideColor: sideColor ?? this.sideColor,
      opacity: opacity ?? this.opacity,
    );
  }
}
