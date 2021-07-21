import 'package:devon4ng_flutter_application_template/model/network/common/pageable_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part '${variables.etoName?lower_case}_list_request_dto.g.dart';

@JsonSerializable()
class ${variables.etoName?cap_first}ListRequestDto {
  <#list pojo.fields as field>
  final ${JavaUtil.getDartType(field.type)}? ${field.name} ;
  </#list>
  final PageableDto pageable;

  ${variables.etoName?cap_first}ListRequestDto(
       <#list pojo.fields as field> this.${field.name}, </#list> this.pageable);

  factory ${variables.etoName?cap_first}ListRequestDto.fromJson(Map<String, dynamic> json) =>
      _$${variables.etoName?cap_first}ListRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$${variables.etoName?cap_first}ListRequestDtoToJson(this);
}
