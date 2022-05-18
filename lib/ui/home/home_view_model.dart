import 'package:chat/base.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/model/room.dart';
import 'package:chat/ui/home/navigator.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator>{
  List<Room>rooms = [];
  void getRooms()async{
  rooms = await DataBaseUtils.getRoomsFireStore();
  }
}