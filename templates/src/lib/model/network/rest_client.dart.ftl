import 'package:devon4ng_flutter_application_template/config/config.dart';
import 'package:devon4ng_flutter_application_template/model/network/authentication/token_response_dto.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}detail/${variables.etoName?lower_case}_detail_response_dto.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}list/${variables.etoName?lower_case}_list_request_dto.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}list/${variables.etoName?lower_case}_list_response_dto.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'authentication/login_request_dto.dart';
import '${variables.etoName?lower_case}insert/${variables.etoName?lower_case}_insert_request_dto.dart';
import '${variables.etoName?lower_case}insert/${variables.etoName?lower_case}_insert_response_dto.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: Endpoint.kCurrentEndopoint)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/login")
  Future<void> login(
      @Body() LoginRequestDto dto, @Path("apiVersion") String apiVersion);

  @GET("/csrf/{apiVersion}/token")
  Future<TokenResponseResponseDto> getToken(
      @Path("apiVersion") String apiVersion);

  //@POST("/${variables.etoName?lower_case}management/{apiVersion}/${variables.etoName?lower_case}/")
  //Future<void> add(@Body() ${variables.etoName?cap_first}DetailDto dto, @Path("apiVersion") String apiVersion);

  @POST("/${variables.etoName?lower_case}management/{apiVersion}/${variables.etoName?lower_case}/search")
  Future<${variables.etoName?cap_first}ListResponseDto> search(@Path("apiVersion") String apiVersion,
      @Body() ${variables.etoName?cap_first}ListRequestDto dto);

  @GET("/${variables.etoName?lower_case}management/{apiVersion}/${variables.etoName?lower_case}/{id}")
  Future<${variables.etoName?cap_first}DetailResponseDto> getDetail(
      @Path("apiVersion") String apiVersion, @Path("id") int id);

  @POST("/${variables.etoName?lower_case}management/{apiVersion}/${variables.etoName?lower_case}")
  Future<${variables.etoName?cap_first}InsertResponseDto> insert(
      @Path("apiVersion") String apiVersion,
      @Body() ${variables.etoName?cap_first}InsertRequestDto dto);

  //@POST("/${variables.etoName?lower_case}management/{apiVersion}/${variables.etoName?lower_case}")
  //Future<void> update(@Body() ${variables.etoName?cap_first}DetailDto dto, @Path("apiVersion") String apiVersion);

  @DELETE("/${variables.etoName?lower_case}management/{apiVersion}/${variables.etoName?lower_case}/{id}")
  Future<void> delete(
      @Path("apiVersion") String apiVersion, @Path("id") int id);
}
