import 'package:json_annotation/json_annotation.dart';
part '${variables.etoName?lower_case}_insert_request_dto.g.dart';

@JsonSerializable()
class ${variables.etoName?cap_first}InsertRequestDto {
  <#list pojo.fields as field>
  <#if field?is_first><#else> final ${JavaUtil.getDartType(field.type)} ${field.name}</#if> ;
  </#list>
  ${variables.etoName?cap_first}InsertRequestDto(<#list pojo.fields as field><#if field?is_first><#else><#if field?has_next>this.${field.name}, <#else>this.${field.name}</#if></#if></#list>);

  factory ${variables.etoName?cap_first}InsertRequestDto.fromJson(Map<String, dynamic> json) =>
      _$${variables.etoName?cap_first}InsertRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$${variables.etoName?cap_first}InsertRequestDtoToJson(this);
}
