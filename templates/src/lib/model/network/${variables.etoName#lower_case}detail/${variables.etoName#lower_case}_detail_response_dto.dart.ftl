import 'package:json_annotation/json_annotation.dart';
part '${variables.etoName?lower_case}_detail_response_dto.g.dart';

@JsonSerializable()
class ${variables.etoName?cap_first}DetailResponseDto {
  final int modificationCounter;
  final int id;
  <#list pojo.fields as field>
  final ${JavaUtil.getDartType(field.type)} ${field.name} ;
  </#list>

  ${variables.etoName?cap_first}DetailResponseDto(this.modificationCounter, this.id, <#list pojo.fields as field><#if field?has_next>this.${field.name}, <#else>this.${field.name} </#if></#list>);

  factory ${variables.etoName?cap_first}DetailResponseDto.fromJson(Map<String, dynamic> json) =>
      _$${variables.etoName?cap_first}DetailResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$${variables.etoName?cap_first}DetailResponseDtoToJson(this);
}
