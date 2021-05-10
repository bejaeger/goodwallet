import 'package:freezed_annotation/freezed_annotation.dart';

part 'concise_project_info.freezed.dart';
part 'concise_project_info.g.dart';

@freezed
class ConciseProjectInfo with _$ConciseProjectInfo {
  factory ConciseProjectInfo({
    required String name,
    required String id,
    required String area,
    String? description,
    String? imagePath,
  }) = _ConciseProjectInfo;

  factory ConciseProjectInfo.fromJson(Map<String, dynamic> json) =>
      _$ConciseProjectInfoFromJson(json);
}
