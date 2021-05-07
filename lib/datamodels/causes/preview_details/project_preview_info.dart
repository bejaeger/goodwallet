import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_preview_info.freezed.dart';
part 'project_preview_info.g.dart';

@freezed
class ProjectPreviewInfo with _$ProjectPreviewInfo {
  factory ProjectPreviewInfo({
    required String projectName,
  }) = _ProjectPreviewInfo;

  factory ProjectPreviewInfo.fromJson(Map<String, dynamic> json) =>
      _$ProjectPreviewInfoFromJson(json);
}
