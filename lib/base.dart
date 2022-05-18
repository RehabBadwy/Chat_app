import 'package:flutter/material.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier{
  N? navigator = null;
}

abstract class BaseNavigator{
  void showLoading({String message, bool isDismissable });
  void hideLoading();
  void showMessage(String message,{String? actionName, VoidCallback? action});
}

abstract class BaseState<T extends StatefulWidget , VM extends BaseViewModel>
  extends State<T> implements BaseNavigator{

  late VM viewModel;
  VM initViewModel();

  @override
  void initState() {
    super.initState();
   viewModel = initViewModel();
  }

  void showLoading({String message = "Loading", bool isDismissable=true}) {
    showDialog(context: context, builder: (_)=>AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Text(message),
        ],
      ),
    ),barrierDismissible: isDismissable);
  }

  @override
  void hideLoading() {
    Navigator.popUntil(context, (route) {
      bool isVisible = route is PopupRoute;
      return !isVisible;
    });
  }

  @override
  void showMessage(String message,{String? actionName, VoidCallback? action}) {
    List<Widget> actions = [];
    if(actionName!=null){
      actions.add(TextButton(onPressed: action, child: Text(actionName)));
    }
    showDialog(context: context, builder: (_)=>AlertDialog(
        actions : actions,
      content: Row(
        children: [
          Expanded(child: Text(message)),
        ],
      ),
    ));
  }
}