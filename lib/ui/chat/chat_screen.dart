import 'package:chat/base.dart';
import 'package:chat/model/message.dart';
import 'package:chat/model/room.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/chat/chat_view_model.dart';
import 'package:chat/ui/chat/chat_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat';


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen, ChatViewModel>
    implements ChatNavigator {
  @override
  ChatViewModel initViewModel() {
    // TODO: implement initViewModel
    return ChatViewModel();
  }

  String messageContent = '';
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Room room = ModalRoute.of(context)?.settings.arguments as Room;
    var userProvider = Provider.of<UserProvider>(context);
    viewModel.room = room;
    viewModel.currentUser = userProvider.user!;
    viewModel.listenForUpdates();
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Stack(children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            'assets/images/background_image.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(room.title),
              elevation: 0,
            ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 12,vertical: 32),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0,3),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
              ),
            child: Column(
              children: [
                Expanded(child: StreamBuilder<QuerySnapshot<Message>>(
                  stream: viewModel.messagesStream,
                  builder: (_,snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    else if(snapshot.hasError){
                      return Center(child: Text(snapshot.error.toString()),);
                    }
                   var message = snapshot.data?.docs.map((doc) => doc.data()).toList();
                    return ListView.builder(itemBuilder: (_,index){
                      return MessageWidget(message!.elementAt(index));
                    },itemCount:  message?.length??0,);
                  },
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (text){
                            messageContent = text;
                          },
                          controller: textController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(4),
                            hintText: 'message here',
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12)
                              ),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: .4
                              )
                            )
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      ElevatedButton(
                          onPressed: (){
                            viewModel.sendMessage(messageContent);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Send'),
                              SizedBox(width: 8,),
                              Icon(Icons.send)
                            ],
                          ) )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ]
      ),
    );
  }
  @override
  void clearMessageText() {
    textController.clear();
  }
}
