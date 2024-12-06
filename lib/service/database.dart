import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  UpdateUserwallet(String id, String amount) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"Wallet": amount});
  }


  // Future addAdminDetail(Map<String, dynamic> userInfoMap, String id) async {
  //   return await FirebaseFirestore.instance
  //       .collection('addmin')
  //       .doc(id)
  //       .set(userInfoMap);
  // }

  Future addFoodItems(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodItem (String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  //-----add to cart
  Future addToCart(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("cart")
        .add(userInfoMap);
  }
//-----get cart details

  Future<Stream<QuerySnapshot>> getFoodCart (String id) async {
    return await FirebaseFirestore.instance.collection("users").doc(id).collection("cart").snapshots();
  }


}
