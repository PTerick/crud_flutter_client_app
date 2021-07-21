import 'package:devon4ng_flutter_application_template/model/network/common/pageable_dto.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}list/${variables.etoName?lower_case}_list_content_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part '${variables.etoName?lower_case}_list_response_dto.g.dart';

@JsonSerializable()
class ${variables.etoName?cap_first}ListResponseDto {
  final List<${variables.etoName?cap_first}ListContentResponseDto> content;
  final PageableDto pageable;
  final int totalElements;

  ${variables.etoName?cap_first}ListResponseDto(this.content, this.pageable, this.totalElements);

  factory ${variables.etoName?cap_first}ListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$${variables.etoName?cap_first}ListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$${variables.etoName?cap_first}ListResponseDtoToJson(this);
}
