import 'package:chat/base.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/ui/add_room/navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator>{
  void createRoom(String roomTitle, String roomDesc, String catId)async{
    navigator?.showLoading(message: 'creating room');
    String? message = null;
    try{
      var res = await DataBaseUtils.createRoom(roomTitle, roomDesc, catId);

    }catch(ex){
      message = ex.toString();
      message = 'something wrong';
    }
    navigator?.hideLoading();
    if(message!=null){
      navigator?.showMessage(message);
    }else{
      navigator?.roomCreated();
    }
  }
}