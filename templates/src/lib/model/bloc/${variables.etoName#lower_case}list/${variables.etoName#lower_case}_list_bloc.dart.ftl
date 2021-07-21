import 'package:devon4ng_flutter_application_template/model/bloc/abstract_bloc.dart';
import 'package:devon4ng_flutter_application_template/model/bloc/bloc_event.dart';
import 'package:devon4ng_flutter_application_template/model/bloc/bloc_state.dart';
import 'package:devon4ng_flutter_application_template/model/repository/${variables.etoName?lower_case}_repository.dart';
import 'package:devon4ng_flutter_application_template/util/safe_print.dart';
import 'package:dio/dio.dart';

class ${variables.etoName?cap_first}ListBloc
    extends AbstractBloc<AbstractBlocEvent, AbstractBlocState> {
  ${variables.etoName?cap_first}ListBloc() : super(EmptyInitialState());

  @override
  Stream<AbstractBlocState> mapEventToState(AbstractBlocEvent event) async* {
    try {
      if (await hasConnectivity()) {
        if (event is Delete${variables.etoName?cap_first}BlocEvent) {
          yield LoadingState();

          var repository = ${variables.etoName?cap_first}ListRepository();
          await repository.delete(event.id);
          yield OnSuccessState(OnSuccessState.EMPLOYEE_DELETE, true);
        }

        if (event is Retrieve${variables.etoName?cap_first}ListBlocEvent) {
          yield LoadingState();

          var repository = ${variables.etoName?cap_first}ListRepository();
          var response = await repository.search(15, 0);
          yield OnSuccessState(OnSuccessState.EMPLOYEE_LIST, response);
        }
      } else {
        yield NoConnectivityState();
      }
    } catch (e) {
      safePrint(e);
      if (e is DioError) {
        if (e.response != null) {
          var statusCode = e.response!.statusCode;
          var statusMessage = e.response!.statusMessage;
          safePrint('$statusCode - $statusMessage');
        }
      }

      yield OnErrorState(
          OnErrorState.GENERIC_ERROR_CODE, OnErrorState.GENERIC_ERROR_MESSAGE);
    }
  }
}

class Retrieve${variables.etoName?cap_first}ListBlocEvent extends AbstractBlocEvent {
  @override
  List<Object> get props => [];
}

class Delete${variables.etoName?cap_first}BlocEvent extends AbstractBlocEvent {
  final int id;

  Delete${variables.etoName?cap_first}BlocEvent(this.id);

  @override
  List<Object> get props => [id];
}
