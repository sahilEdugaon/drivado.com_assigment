import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart'as http;

class CompanyController extends GetxController{
  RxBool isLoading=false.obs;

  RxInt page=1.obs;
  List<dynamic> companyList=<dynamic>[].obs;
  RxList companySearchList = [].obs;
  RxList isExpandedList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getCompanyList();
  }
  Future getCompanyList() async {
    try {
      isLoading.value=true;
      final response = await http.get(Uri.parse("https://673736a9aafa2ef222330e54.mockapi.io/company"),);

      if (response.statusCode == 200){
        final data = jsonDecode(response.body);
        companyList.addAll(data);
        isExpandedList.value = List.generate(companyList.length, (_) => false); // Initialize all to false

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





