
import 'package:flutter/material.dart';

import '../../search_bar_screen/people_search_screen.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title:  SizedBox(
      height: 40,
      child: TextField(
        onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PeopleSearchPage()));
            },
        readOnly: true,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(top: 5, left: 15),
          hintText: 'Search people, place, brand',
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
      ),
    ),
    actions: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {

            },
          ),
          Positioned(
            top: -1,
            right: -1,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: const Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            tooltip: 'Notification Button',
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          Positioned(
            top: 1,
            right: 2,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: const Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}