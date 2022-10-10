import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:tiktok_clone/app/data/consts.dart';
import 'package:tiktok_clone/app/modules/Models/user_model.dart';
import 'package:tiktok_clone/app/modules/home/controllers/search_controller.dart';
import 'package:tiktok_clone/app/modules/home/views/Dasboard/personal_profile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchController searchController = Get.put(SearchController());
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    searchController.setListOfUsers = Rx<List<UserModel>?>(null);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onFieldSubmitted: (value) {
                searchController.searchUser(inputType: value);
              }),
        ),
        body: searchController.getUserList?.isEmpty == null
            ? const Center(
                child: Text(
                  'Search for users!',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: searchController.getUserList?.length,
                itemBuilder: (context, index) {
                  UserModel user = searchController.getUserList![index];
                  return InkWell(
                    onTap: () => Get.to(
                      () => ProfileScreen(
                        uid: user.uid,
                        isCurrentUser: false,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profileImage,
                        ),
                      ),
                      title: Text(
                        user.userName,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
