import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class UserController extends GetxController{
  RxBool isLoading=false.obs;
  final TextEditingController searchController = TextEditingController();

  RxInt page=1.obs;
  List<dynamic> userList=<dynamic>[].obs;
  RxList searchList = [].obs;
  RxBool isActiveFilter = false.obs;
  @override
  void onInit() {
    super.onInit();
    getUserList();
  }
  Future getUserList() async {
    try {
      isLoading.value=true;
      final response = await http.get(Uri.parse("https://673736a9aafa2ef222330e54.mockapi.io/users"),);

      if (response.statusCode == 200){
        final data = jsonDecode(response.body);
        // print('dataa..$data');
        userList.addAll(data);
        isLoading.value=false;
      }
      else {
        isLoading.value=false;
      }
    }
    catch (e) {
      print("Error: $e");
      isLoading.value=false;
    }
  }
}





