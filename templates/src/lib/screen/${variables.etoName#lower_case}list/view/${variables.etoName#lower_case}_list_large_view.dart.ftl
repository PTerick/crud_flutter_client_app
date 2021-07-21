import 'package:devon4ng_flutter_application_template/core_packages.dart';
import 'package:devon4ng_flutter_application_template/model/bloc/bloc_state.dart';
import 'package:devon4ng_flutter_application_template/model/bloc/${variables.etoName?lower_case}list/${variables.etoName?lower_case}_list_bloc.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}list/${variables.etoName?lower_case}_list_content_response_dto.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}list/${variables.etoName?lower_case}_list_response_dto.dart';
import 'package:devon4ng_flutter_application_template/screen/abstract_state.dart';
import 'package:devon4ng_flutter_application_template/screen/${variables.etoName?lower_case}list/util/detail.dart';
import 'package:devon4ng_flutter_application_template/themes.dart';
import 'package:devon4ng_flutter_application_template/ui/ui_dialog_helper.dart';
import 'package:devon4ng_flutter_application_template/ui/ui_screen_widget_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ${variables.etoName?cap_first}ListLargeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScreenState();
}

class _ScreenState
    extends AbstractState<${variables.etoName?cap_first}ListBloc, {variables.etoName?cap_first}ListLargeView> {
  late List<${variables.etoName?cap_first}ListContentResponseDto> _list;
  int id = 0;

  @override
  void initState() {
    super.initState();
    getBloc!.add(Retrieve${variables.etoName?cap_first}ListBlocEvent());
    //id initialized at 0
    id = 0;
  }

  @override
  ${variables.etoName?cap_first}ListBloc provideBloc() {
    return ${variables.etoName?cap_first}ListBloc();
  }

  @override
  Widget buildWidget(BuildContext context, AbstractBlocState state) {
    var body;
    if (state is OnSuccessState<${variables.etoName?cap_first}ListResponseDto>) {
      if (state.id == OnSuccessState.${variables.etoName?cap_first}_LIST) {
        _list = state.data.content;

        body = Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ListView.builder(
                  itemCount: state.data.content.length,
                  itemBuilder: (context, index) {
                    final item = state.data.content[index];
                    return Dismissible(
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                      key: Key(item.${variables.etoName?lower_case}Id.toString()),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        setState(() {
                          _list.removeAt(index);
                        });

                        getBloc!.add(Delete${variables.etoName?cap_first}BlocEvent(item.id));
                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("$item dismissed")));
                      },

                      // Show a red background as the item is swiped away.
                      background: Container(
                          color:
                              Provider.of<AppTheme>(context).mainMaterialColor),
                      child: _listViewItem(item, state, _list),
                    );
                  }),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        );
      }
    } else {
      body = Container();
    }

    return PlatformScaffold(
        material: (_, __) => MaterialScaffoldData(
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  var results = await Navigator.pushNamed(
                      context, "/${variables.etoName?lower_case}InsertScreen");
                  if (results != null) {
                    getBloc!.add(Retrieve${variables.etoName?cap_first}ListBlocEvent());
                  }
                },
                child: const Icon(Icons.add),
                backgroundColor:
                    Provider.of<AppTheme>(context).mainMaterialColor)),
        cupertino: (_, __) => CupertinoPageScaffoldData(
                navigationBar: CupertinoNavigationBar(
              trailing: Icon(CupertinoIcons.add),
            )),
        backgroundColor: Provider.of<AppTheme>(context).bg1,
        appBar: PlatformAppBar(
          title: Text("${variables.etoName?cap_first} List"),
          backgroundColor: Provider.of<AppTheme>(context).mainMaterialColor,
        ),
        body: body);
  }

  Widget _listViewItem(${variables.etoName?cap_first}ListContentResponseDto item,
      AbstractBlocState state, List<${variables.etoName?cap_first}ListContentResponseDto> _list) {
    return Card(
      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: ListTile(
              leading: InkWell(
                child: Icon(Icons.account_circle_outlined),
                onTap: () => {
                  Navigator.pushNamed(context, "/${variables.etoName?lower_case}DetailScreen",
                      arguments: item),
                },
              ),
              trailing: InkWell(
                child: Icon(Icons.border_color_outlined),
                onTap: () async {
                  var results = await Navigator.pushNamed(
                      context, "/${variables.etoName?lower_case}UpdateScreen",
                      arguments: item);
                  if (results != null) {
                    getBloc!.add(Retrieve${variables.etoName?cap_first}ListBlocEvent());
                  }
                },
              ),
              title: Text("${r"${item.surname} ${item.name}"}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
           subtitle: Text("${r"${item.email}"}"),
                  style: TextStyle(fontSize: FontSizes.s10)),
            ),
          ),
        ],
      ),
    );
  }

  _selectItem(
      BuildContext context,
      ${variables.etoName?cap_first}ListBloc bloc,
      ${variables.etoName?cap_first}ListContentResponseDto item,
      List<${variables.etoName?cap_first}ListContentResponseDto> list) {
    id = list.indexOf(item);
  }

  @override
  BlocWidgetListener<AbstractBlocState> provideBlocListener(
      BuildContext context) {
    return (context, state) {
      if (state is LoadingState) {
        showDialog(
            context: context, builder: UiDialogHelper.loadingDialog(context));
      }

      if (state is OnSuccessState) {
        Navigator.pop(context);
      }

      if (state is OnErrorState) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: UiDialogHelper.errorAlertDialog(context, state.message));
      }
    };
  }
}
