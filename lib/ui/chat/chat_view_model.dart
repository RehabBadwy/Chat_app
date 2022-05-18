import 'package:chat/base.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/model/message.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator>{
  late Room room;
  late MyUser currentUser ;
 late Stream<QuerySnapshot<Message>> messagesStream;
  void sendMessage(messageContent)async{
    if(messageContent.trim().isEmpty){
      return;
    }
    var message =Message(roomId: room.id,
        content: messageContent,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        senderName: currentUser.userName,
        senderId: currentUser.id);
  try{
    var res=  DataBaseUtils.insertMessageToRoom(message);
    navigator?.clearMessageText();
  }catch(error){
    navigator?.showMessage(error.toString());
  }
  }

  void listenForUpdates()async{
   messagesStream = DataBaseUtils.getMessagesStream(room.id);
  }
  @override
  void dispose() {
    super.dispose();
  }
}


abstract class ChatNavigator extends BaseNavigator{
  void clearMessageText();
}