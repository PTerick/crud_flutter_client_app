import 'package:devon4ng_flutter_application_template/model/bloc/bloc_state.dart';
import 'package:devon4ng_flutter_application_template/model/bloc/${variables.etoName?lower_case}update/${variables.etoName?lower_case}_update_bloc.dart';
import 'package:devon4ng_flutter_application_template/model/network/${variables.etoName?lower_case}list/${variables.etoName?lower_case}_list_content_response_dto.dart';
import 'package:devon4ng_flutter_application_template/screen/abstract_state.dart';
import 'package:devon4ng_flutter_application_template/themes.dart';
import 'package:devon4ng_flutter_application_template/ui/ui_dialog_helper.dart';
import 'package:devon4ng_flutter_application_template/ui/ui_screen_widget_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ${variables.etoName?cap_first}UpdateLargeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScreenState();
}

class _ScreenState
    extends AbstractState<${variables.etoName?cap_first}UpdateBloc, ${variables.etoName?cap_first}UpdateLargeView> {
  final _formKey = GlobalKey<FormState>();
  <#list pojo.fields as field>
  <#if field?is_first><#else>final TextEditingController _${field.name}TextController() = TextEditingController() ;</#if>
  </#list> 

  @override
  ${variables.etoName?cap_first}UpdateBloc provideBloc() {
    return ${variables.etoName?cap_first}UpdateBloc();
  }

  @override
  Widget buildWidget(BuildContext buildContext, AbstractBlocState state) {
    if (state is EmptyInitialState) {
      ${variables.etoName?cap_first}ListContentResponseDto item = ModalRoute.of(context)!
          .settings
          .arguments as ${variables.etoName?cap_first}ListContentResponseDto;
      getBloc!.add(Retrieve${variables.etoName?cap_first}IdBlocEvent(item.id));
    }

    double minWidth = 250;
    double maxWidth = MediaQuery.of(context).size.width * 50 / 100;
    if (maxWidth < minWidth) {
      maxWidth = minWidth;
    }
    double minHeight = 250;
    double maxHeight = MediaQuery.of(context).size.height * 60 / 100;
    if (maxHeight < minHeight) {
      maxHeight = minHeight;
    }

    var b1 = Container(
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(child: _updateForm(buildContext)),
      ),
    );

    List<Widget> children = <Widget>[];
    children.add(b1);

    return PlatformScaffold(
        material: (_, __) =>
            MaterialScaffoldData(resizeToAvoidBottomInset: false),
        cupertino: (_, __) => CupertinoPageScaffoldData(
                navigationBar: CupertinoNavigationBar(
              trailing: Icon(CupertinoIcons.add),
            )),
        backgroundColor: Provider.of<AppTheme>(context).bg1,
        appBar: PlatformAppBar(
          backgroundColor: Provider.of<AppTheme>(context).mainMaterialColor,
          title: Text("Create ${variables.etoName?cap_first}"),
        ),
        body: Center(
          child: b1,
        ));

/*

    List<Widget> children = <Widget>[];
    children.add(Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 60 / 100,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 64, right: 64),
        child: _updateForm(buildContext),
      ),
    ));

    return PlatformScaffold(
        material: (_, __) =>
            MaterialScaffoldData(resizeToAvoidBottomInset: false),
        backgroundColor: Colors.white,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children));*/
  }

  @override
  BlocWidgetListener<AbstractBlocState> provideBlocListener(
      BuildContext buildContext) {
    return (context, state) {
      if (state is LoadingState) {
        showDialog(
            context: context, builder: UiDialogHelper.loadingDialog(context));
        return;
      }

      if (state is OnSuccessState) {
        Navigator.pop(context);
        //List<Cookie> results = CookieJar().loadForRequest(Uri.parse("http://10.24.219.91:8081"));
        //print(results);

        //Navigator.pushReplacementNamed(context, "/${variables.etoName?lower_case}DetailScreen");
        //Navigator.pushReplacementNamed(context, "/${variables.etoName?lower_case}ListScreen");
        var result = true;
        Navigator.pop(context, result);

        return;
      }

      if (state is OnErrorState) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: UiDialogHelper.errorAlertDialog(context, state.message));
        return;
      }
    };
  }

  validateMail(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Widget _updateForm(BuildContext buildContext) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
            <#list pojo.fields as field>  
            <#if field?is_first><#else>
            UIScreenWidgetHelper.inputField(buildContext, _${field.name}TextController,  
            TextInputType.text, "${field.name} ", false, 32),
          </#if></#list>
          UIScreenWidgetHelper.button(buildContext, "Insert", () {
            FocusScope.of(buildContext).requestFocus(new FocusNode());
            if (
          <#list pojo.fields as field> <#if field?is_first><#else><#if field?has_next>_${field.name}TextController.text.isEmpty ||<#else>_${field.name}TextController.text.isEmpty</#if></#if></#list>{                 
              showDialog(
                  context: buildContext,
                  builder: UiDialogHelper.errorAlertDialog(
                      buildContext, "Missing parameters"));
            } else {
              buildContext.read<${variables.etoName?cap_first}UpdateBloc>().add(
                  ${variables.etoName?cap_first}InsertBlocEvent(<#list pojo.fields as field><#if field?is_first><#else><#if field?has_next>_${field.name}TextController.text, <#else>_${field.name}TextController.text</#if></#if></#list>
                  ));
            }
          })
        ]));
  }

 @override
  void dispose() {
  <#list pojo.fields as field>
  <#if field?is_first><#else> _${field.name}TextController.text.dispose();   </#if>
  </#list>;
    super.dispose();
  }
}