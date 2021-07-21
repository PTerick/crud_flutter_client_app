import 'package:devon4ng_flutter_application_template/model/bloc/abstract_bloc.dart';
import 'package:devon4ng_flutter_application_template/model/bloc/bloc_event.dart';
import 'package:devon4ng_flutter_application_template/model/bloc/bloc_state.dart';
import 'package:devon4ng_flutter_application_template/model/repository/${variables.etoName?lower_case}_repository.dart';
import 'package:devon4ng_flutter_application_template/util/safe_print.dart';
import 'package:dio/dio.dart';

class ${variables.etoName?cap_first}InsertBloc
    extends AbstractBloc<AbstractBlocEvent, AbstractBlocState> {
  ${variables.etoName?cap_first}InsertBloc() : super(EmptyInitialState());

  @override
  Stream<AbstractBlocState> mapEventToState(AbstractBlocEvent event) async* {
    try {
      if (event is ${variables.etoName?cap_first}InsertBlocEvent) {
        if (await hasConnectivity()) {
          yield LoadingState();

          var repository = ${variables.etoName?cap_first}ListRepository();
          var response =
              await repository.insert(event.name, event.surname, event.email);
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

class ${variables.etoName?cap_first}InsertBlocEvent extends AbstractBlocEvent {
  final String name;
  final String surname;
  final String email;

  ${variables.etoName?cap_first}InsertBlocEvent(this.name, this.surname, this.email);

  @override
  List<Object> get props => [name, surname, email];
}
