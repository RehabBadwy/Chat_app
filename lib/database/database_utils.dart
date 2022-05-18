import 'package:chat/model/message.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseUtils {
 // user
 static CollectionReference<MyUser> getUsersCollection() {
  return FirebaseFirestore.instance
      .collection(MyUser.collectionName)
      .withConverter<MyUser>(
      fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson());
 }

 static Future<void> createDBUser(MyUser user) async {
  return getUsersCollection()
      .doc(user.id)
      .set(user);
 }

 static  Future<MyUser?> readUser(String userId)async{
  var userDocSnapshot = await getUsersCollection()
      .doc(userId)
      .get();
  return userDocSnapshot.data();
 }
// room
 static CollectionReference<Room> getRoomsCollection() {
  return FirebaseFirestore.instance
      .collection(Room.collectionName)
      .withConverter<Room>(
      fromFirestore: (snapshot, _) => Room.fomJson(snapshot.data()!),
      toFirestore: (room, _) => room.toJson());
 }

 static Future<void> createRoom(String title,String desc,String catId){
  var roomsCollection =  getRoomsCollection();
  var docRef = roomsCollection.doc();
  Room room = Room(
      id: docRef.id,
      title: title,
      desc: desc,
      catId: catId);
  return docRef.set(room);

 }

 static Future<List<Room>> getRoomsFireStore()async{
 var qsnapshot = await getRoomsCollection()
      .get();
return qsnapshot.docs.map((doc) => doc.data()).toList();
 }

 //message
static CollectionReference<Message> getMessagesCollection(String roomId){
  return getRoomsCollection()
      .doc(roomId)
      .collection(Message.collectionName)
      .withConverter(fromFirestore: ((snapshot, options) => Message.fromFireStore(snapshot.data()!)),
      toFirestore: (message,_)=>message.toFireStore());
}

static Future<void> insertMessageToRoom(Message message){
  var roomMessages = getMessagesCollection(message.roomId);
 var docRef = roomMessages.doc();
 message.id = docRef.id;
return docRef.set(message);
}

static Stream<QuerySnapshot<Message>>getMessagesStream(String roomId){
 return getMessagesCollection(roomId)
 .orderBy('dataTime')
      .snapshots();
}
}