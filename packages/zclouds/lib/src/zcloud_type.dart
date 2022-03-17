// ignore_for_file: public_member_api_docs

import 'package:zclouds/zclouds.dart';

/// {@template zclouds.zcloudtype}
/// Represents different types of clouds.
///
/// Used by [ZCloud] to determine the shape of the cloud.
///
/// For more information: https://en.wikipedia.org/wiki/List_of_cloud_types
/// {@endtemplate}
enum ZCloudType {
  cirrostratus,
  cirrocumulus,
  cirrus,
  altostratus,
  altocumulus,
  stratus,
  stratocumulus,
  nimbostratus,
  cumulus,
  cumulonimbus,
}
