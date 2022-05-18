import 'package:chat/base.dart';
import 'package:chat/ui/add_room/add_room_screen.dart';
import 'package:chat/ui/home/home_view_model.dart';
import 'package:chat/ui/home/navigator.dart';
import 'package:chat/ui/home/room_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
static const String routName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen,HomeViewModel>implements HomeNavigator {

  @override
  HomeViewModel initViewModel() =>HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    viewModel.getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>viewModel,
      child:  Stack(
        children: [
        Container(
        color: Colors.white,
        child: Image.asset('assets/images/background_image.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('home'),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).pushNamed(AddRoomScreen.routeName);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: Consumer<HomeViewModel>(
                builder: (buildContext,homeViewmodel,child){
                 return GridView.builder(
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     crossAxisSpacing: 12,
                     mainAxisSpacing: 12,
                     childAspectRatio: 1
                   ),
                   itemBuilder: (_,index){
                    return RoomWidget(homeViewmodel.rooms[index]);
                  },itemCount: homeViewmodel.rooms.length,);
                },
              ))
            ],
          ),
        ),
      )
        ],
    )
    );
  }
}
