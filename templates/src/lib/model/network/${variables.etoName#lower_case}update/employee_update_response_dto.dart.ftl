import 'package:json_annotation/json_annotation.dart';
part '${variables.etoName?lower_case}_update_response_dto.g.dart';

@JsonSerializable()
class ${variables.etoName?cap_first}UpdateResponseDto {
  final int modificationCounter;
  final int id;
 <#list pojo.fields as field>
  final ${JavaUtil.getDartType(field.type)} ${field.name} ;
  </#list>

  ${variables.etoName?cap_first}UpdateResponseDto(
      this.modificationCounter, this.id <#list pojo.fields as field> , this.${field.name} </#list>);

  factory ${variables.etoName?cap_first}UpdateResponseDto.fromJson(Map<String, dynamic> json) =>
      _$${variables.etoName?cap_first}UpdateResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$${variables.etoName?cap_first}UpdateResponseDtoToJson(this);
}
