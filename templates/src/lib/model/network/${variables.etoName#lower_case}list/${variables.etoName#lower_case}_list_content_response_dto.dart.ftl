import 'package:json_annotation/json_annotation.dart';
part '${variables.etoName?lower_case}_list_content_response_dto.g.dart';

@JsonSerializable()
class ${variables.etoName?cap_first}ListContentResponseDto {
  final int modificationCounter;
  final int id;
  <#list pojo.fields as field>
  final ${JavaUtil.getDartType(field.type)} ${field.name} ;
  </#list>

  ${variables.etoName?cap_first}ListContentResponseDto(this.modificationCounter, this.id <#list pojo.fields as field> , this.${field.name} </#list>);

  factory ${variables.etoName?cap_first}ListContentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$${variables.etoName?cap_first}ListContentResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$${variables.etoName?cap_first}ListContentResponseDtoToJson(this);
}
