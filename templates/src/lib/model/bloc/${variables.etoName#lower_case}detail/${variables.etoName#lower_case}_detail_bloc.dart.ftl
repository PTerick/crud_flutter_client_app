import 'package:devon4ng_flutter_application_template/model/bloc/abstract_bloc.dart';
import 'package:devon4ng_flutter_application_template/model/bloc/bloc_event.dart';
import 'package:devon4ng_flutter_application_template/model/bloc/bloc_state.dart';
import 'package:devon4ng_flutter_application_template/model/repository/${variables.etoName?lower_case}_repository.dart';
import 'package:devon4ng_flutter_application_template/util/safe_print.dart';
import 'package:dio/dio.dart';

class ${variables.etoName?cap_first}DetailBloc
    extends AbstractBloc<AbstractBlocEvent, AbstractBlocState> {
  ${variables.etoName?cap_first}DetailBloc() : super(EmptyInitialState());

  @override
  Stream<AbstractBlocState> mapEventToState(AbstractBlocEvent event) async* {
    try {
      if (await hasConnectivity()) {
        if (event is Retrieve${variables.etoName?cap_first}DetailBlocEvent) {
          yield LoadingState();

          var repository = ${variables.etoName?cap_first}ListRepository();
          var response = await repository.getDetail(event.id);
          yield OnSuccessState(OnSuccessState.EMPLOYEE_DETAIL, response);
        }
        if (event is Delete${variables.etoName?cap_first}BlocEvent) {
          yield LoadingState();

          var repository = ${variables.etoName?cap_first}ListRepository();
          var response = await repository.delete(event.id);
          yield OnSuccessState(OnSuccessState.EMPLOYEE_DELETE, response);
        }
      } else {
        yield NoConnectivityState();
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

class Retrieve${variables.etoName?cap_first}DetailBlocEvent extends AbstractBlocEvent {
  final int id;

  Retrieve${variables.etoName?cap_first}DetailBlocEvent(this.id);

  @override
  List<Object> get props => [id];
}

class Delete${variables.etoName?cap_first}BlocEvent extends AbstractBlocEvent {
  final int id;

  Delete${variables.etoName?cap_first}BlocEvent(this.id);

  @override
  List<Object> get props => [id];
}
