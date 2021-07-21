import 'package:devon4ng_flutter_application_template/model/network/common/pageable_dto.dart';
import 'package:devon4ng_flutter_application_template/model/network/common/pageable_sort_dto.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}detail/${variables.etoName?lower_case}_detail_response_dto.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}insert/${variables.etoName?lower_case}_insert_request_dto.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}insert/${variables.etoName?lower_case}_insert_response_dto.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}list/${variables.etoName?lower_case}_list_request_dto.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}list/${variables.etoName?lower_case}_list_response_dto.dart';
import 'package:devon4ng_flutter_application_template/model/repository/abstract_repository.dart';

class ${variables.etoName?cap_first}ListRepository extends AbstractRepository {
  Future<${variables.etoName?cap_first}ListResponseDto> search(int pageSize, int pageNumber) {
    var sort = PageableSortDto("${variables.etoName?lower_case}Id", "ASC");
    var pageable = PageableDto(pageSize, pageNumber, [sort]);
    var request = ${variables.etoName?cap_first}ListRequestDto(null, null, null, null, pageable);

    return restClient.search(apiVersion, request);
  }

  Future<${variables.etoName?cap_first}DetailResponseDto> getDetail(int id) {
    return restClient.getDetail(apiVersion, id);
  }

  Future<${variables.etoName?cap_first}InsertResponseDto> insert(
      String name, String surname, String email) {
    ${variables.etoName?cap_first}InsertRequestDto dto =
        ${variables.etoName?cap_first}InsertRequestDto(name, surname, email);
    return restClient.insert(apiVersion, dto);
  }

  Future<void> delete(int id) {
    return restClient.delete(apiVersion, id);
  }
}
