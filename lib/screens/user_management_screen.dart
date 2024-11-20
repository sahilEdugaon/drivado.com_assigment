import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:task_assignment2/screens/user_deatils_screen.dart';

import '../controller/company_controller.dart';
import '../controller/user_controller.dart';
import 'comapny_details_screen.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  final focusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();
  final ScrollController _subScrollController = ScrollController();

  int selected = 2;
  final controller = PageController();
 final  UserController userController =Get.put(UserController());
 final  CompanyController companyController =Get.put(CompanyController());
// Sample list of users
  List<String> dropDownValue = [
    'Add user',
    'abc@drivado.com',
    'jkl@drivado.com',
    'pqr@drivado.com',
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
    _subScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.black,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage:AssetImage('assets/profile.png'),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Test Drivado",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold, color: Colors.white
                      ),
                    ),
                    Text(
                      "test@drivado.com",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: Colors.grey[700],
              child: const badges.Badge(
                badgeContent: Text('3'),
                child: Icon(Icons.notifications_none_outlined, color: Colors.white,),
              )
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:userController.searchController,
                    focusNode: focusNode,
                    onChanged: (value){

                      userController.isActiveFilter.value== false
                      ?userController.searchList.value = userController.userList
                          .where((ele) => ele['name'].toString().toUpperCase().contains(value.toUpperCase()))
                          .toList()
                      :companyController.companySearchList.value = companyController.companyList
                          .where((ele) => ele['companyName'].toString().toUpperCase().contains(value.toUpperCase()))
                          .toList();
                      print('userController.userList..${userController.searchList.length}');
                      print('companyController.companySearchList.value..${companyController.companySearchList.value.length}');
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_alt),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xffe4e7e7),
                borderRadius: BorderRadius.circular(8),
              ),

              child: TabBar(
                indicatorWeight: 0,
                dividerHeight: 0,
                controller: _tabController,
                labelColor: Colors.black,
                tabAlignment: TabAlignment.fill,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                  color: Colors.white,
                ),
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: 'Users'),
                  Tab(text: 'Sub-company'),
                ],
                onTap: (value){
                  print('value...$value');
                  value == 1
                      ? userController.isActiveFilter.value  = true
                      : userController.isActiveFilter.value  = false;
                },
              ),
            ),
          ),

         Obx(() {
           log('getUserDarta..${userController.userList}');
           print('userController.userList..${userController.searchList.length}');
           print('companySearchList..${companyController.companySearchList.length}');
           print('txtfiled...${userController.searchController.text.isEmpty}');
           print('isActiveFilte..${userController.isActiveFilter.value}' );
           return Expanded(
           child: TabBarView(
             controller: _tabController,
             children: [
               // Simple list for Users
               userController.isLoading==true
               ?loadingList(10, _scrollController)
               : userController.searchController.text.isEmpty
               ?buildList(userController.userList, _scrollController)
               :userSearchList(userController.searchList.value, _scrollController),

               // Expansion list for Sub-companies
               userController.searchController.text.isEmpty
               ?buildExpansionList(companyController.companyList, _subScrollController)
               :companySearchListList(companyController.companySearchList, _subScrollController),

             ],
           ),
         );
         },)
        ],
      ),

      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
            iconSize: 22,
            barAnimation: BarAnimation.blink,
            iconStyle: IconStyle.Default,
            padding: const EdgeInsets.symmetric(vertical: 10)
        ),
        items: [
          BottomBarItem(
            icon: const Icon(
              Icons.house_outlined,
            ),
            selectedIcon: const Icon(Icons.house_rounded),
            selectedColor: Colors.pink,
            unSelectedColor: Colors.grey,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.train_outlined),
            selectedIcon: const Icon(Icons.star_rounded),
            selectedColor: Colors.red,
            title: const Text('Bookings'),
          ),
          BottomBarItem(
              icon: const Icon(
                Icons.manage_accounts,
              ),
              selectedIcon: const Icon(
                Icons.manage_accounts,
              ),
              selectedColor: Colors.pink,
              title: const Text('Manage')),
          BottomBarItem(
              icon: const Icon(
                Icons.person_outline,
              ),
              selectedIcon: const Icon(
                Icons.person,
              ),
              selectedColor: Colors.deepPurple,
              title: const Text('Profile')),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected,
        notchStyle: NotchStyle.circle,
        onTap: (index) {
          if (index == selected) return;
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
        ? FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onPressed: () {
        // Your FAB action
      },
      backgroundColor: Colors.pink,
      child: const Icon(
        CupertinoIcons.add,
        color: Colors.white,
      ),
    )
        : null,
    floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget userSearchList(List<dynamic> items, ScrollController controller) {
    return ListView.builder(
      controller: controller,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: const Icon(Icons.person),
          title: Text(items[index]["name"]),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserDetailsScreen(userDetails:items[index]??{} ,),));

          },
        );
      },
    );
  }
  Widget buildList(List<dynamic> items, ScrollController controller) {
    // userController.isActiveFilter.value = false;
    return ListView.builder(
      controller: controller,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: const Icon(Icons.person),
          title: Text(items[index]["name"]),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserDetailsScreen(userDetails:items[index]??{} ,),));

          },
        );
      },
    );
  }
  Widget loadingList(int lenght, ScrollController controller) {
    return ListView.builder(
      controller: controller,
      itemCount: lenght, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // For the sub-company expansion list
  Widget buildExpansionList(List<dynamic> items, ScrollController controller) {
    // userController.isActiveFilter.value = true;

    return ListView.builder(
      controller: controller,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: const Icon(Icons.business),
              title: Text(items[index]["companyName"]),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  CompanyDetailsScreen(companyDetails: items[index]??{},),));
              },
              trailing: IconButton(
                icon: Icon(companyController.isExpandedList[index]
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
                onPressed: () {
                    companyController.isExpandedList[index] = !companyController.isExpandedList[index];
                },
              ),
            ),
            Obx((){
              return companyController.isExpandedList[index]
                ?Column(
                children:  dropDownValue.map((user) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Card(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white, // Background color
                          prefixIcon: user.toUpperCase()=='Add user'.toUpperCase()?Icon(Icons.person_add_alt, color: Colors.pink,size: 20,):Icon(Icons.person, color: Colors.grey,size: 20),
                          hintText: user,
                          hintStyle: TextStyle(color: user.toUpperCase()=='Add user'.toUpperCase()?Colors.pink:Colors.grey[500],fontSize: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              //   child: Column(
              //     children: [
              //       ListTile(
              //         title: Text('Details about ${items[index]["companyName"]}'),
              //         subtitle: const Text('Additional information can go here.'),
              //       ),
              //     ],
              //   ),
              // )
              :Container();
            })
          ],
        );

        //   ExpansionTile(
        //   title: Text(items[index]["companyName"]),
        //   leading: const Icon(Icons.business),
        //   children: [
        //     ListTile(
        //       title: Text('Details about ${items[index]["companyName"]}'),
        //       subtitle: const Text('Additional information can go here.'),
        //     ),
        //   ],
        // );
      },
    );
  }  // For the sub-company expansion list
  Widget companySearchListList(List<dynamic> items, ScrollController controller) {
    // userController.isActiveFilter.value = true;
    return ListView.builder(
      controller: controller,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: const Icon(Icons.business),
          title: Text(items[index]["companyName"]),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  CompanyDetailsScreen(companyDetails: items[index]??{},),));
          },
          trailing: IconButton(
              onPressed: () {
                  ExpansionTile(
                  title: const Text('Heloo'),
                  children: [
                    ListTile(
                      title: Text('Details about ${items[index]["companyName"]}'),
                      subtitle: const Text('Additional information can go here.'),
                    ),
                  ],
                );
              },
            icon: Icon(Icons.arrow_drop_down),)
        );
      },
    );
  }
}

