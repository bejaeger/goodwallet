import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_preview_details.freezed.dart';
part 'project_preview_details.g.dart';

@freezed
class ProjectPreviewDetails with _$ProjectPreviewDetails {
  factory ProjectPreviewDetails({
    required String projectName,
  }) = _ProjectPreviewDetails;

  factory ProjectPreviewDetails.fromJson(Map<String, dynamic> json) =>
      _$ProjectPreviewDetailsFromJson(json);
}
