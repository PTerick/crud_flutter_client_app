import 'package:devon4ng_flutter_application_template/model/bloc/abstract_bloc.dart';
import 'package:devon4ng_flutter_application_template/model/bloc/bloc_event.dart';
import 'package:devon4ng_flutter_application_template/model/bloc/bloc_state.dart';
import 'package:devon4ng_flutter_application_template/model/repository/${variables.etoName?lower_case}_repository.dart';
import 'package:devon4ng_flutter_application_template/util/safe_print.dart';
import 'package:dio/dio.dart';

class ${variables.etoName?cap_first}UpdateBloc
    extends AbstractBloc<AbstractBlocEvent, AbstractBlocState> {
  ${variables.etoName?cap_first}UpdateBloc() : super(EmptyInitialState());
  int id =0; 
  @override
  Stream<AbstractBlocState> mapEventToState(AbstractBlocEvent event) async* {

    if (event is Retrieve${variables.etoName?cap_first}IdBlocEvent) {
      id = event.id;     
    }

    try {

      if (event is ${variables.etoName?cap_first}UpdateBlocEvent) {
        if (await hasConnectivity()) {
          yield LoadingState();

          var repository = ${variables.etoName?cap_first}ListRepository();
          var response =
              await repository.update(id, <#list pojo.fields as field><#if field?is_first><#else> ,this.${field.name}</#if></#list>);
          yield OnSuccessState(OnSuccessState.LOGIN, response);
        } else {
          yield NoConnectivityState();
        }
      }
    } catch (e) {
      safePrint(e);
      if (e is DioError) {
        var statusCode = e.response!.statusCode;
        var statusMessage = e.response!.statusMessage;
        safePrint('$statusCode - $statusMessage');
      }

      yield OnErrorState(
          OnErrorState.GENERIC_ERROR_CODE, OnErrorState.GENERIC_ERROR_MESSAGE);
    }
  }
}

class Retrieve${variables.etoName?cap_first}IdBlocEvent extends AbstractBlocEvent {
  final int id;

  Retrieve${variables.etoName?cap_first}IdBlocEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ${variables.etoName?cap_first}UpdateBlocEvent extends AbstractBlocEvent {
  <#list pojo.fields as field>
  <#if field?is_first>
  <#else>
  final ${JavaUtil.getDartType(field.type)} ${field.name};
  </#if>
  </#list>

  ${variables.etoName?cap_first}UpdateBlocEvent(<#list pojo.fields as field><#if field?is_first><#else><#if field?has_next>this.${field.name}, <#else>this.${field.name}</#if></#if></#list>);

  @override
  List<Object> get props => [<#list pojo.fields as field><#if field?is_first><#else><#if field?has_next>${field.name}, <#else>${field.name}</#if></#if></#list>];
}
