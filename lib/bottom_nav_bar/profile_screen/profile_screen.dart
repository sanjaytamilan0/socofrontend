import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dashboard_screen/dashboard_screen.dart';
import 'Settings_screens/Policies.dart';
import '../../business_product_upload/reverpod/create_product_api_notifier.dart';
import '../../common/colors.dart';

import '../../common/ui_widgets/common_appbar.dart';
import '../order_history_screen/order_history_screen.dart';

import '../../common/ui_widgets/user_profile_header.dart';

import '../account_switching/account_choosing_screen.dart';
import '../account_switching/page_registration/bussness_reverpod/user_account_notifier.dart';

import '../../business_product_upload/product_upload_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _fetchAccountData();
  }

  void _fetchAccountData() async {
    await Future.delayed(Duration.zero);
    ref.read(accountProvider.notifier).fetchAccount();
    ref.read(createProductProvider.notifier).getProduct();
  }

  final GlobalKey<ScaffoldState> profileKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userAccount = ref.watch(accountProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: profileKey,
      appBar: buildAppBar(context),
      body: userAccount.status == AccountStateStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
          vertical: screenHeight * 0.01,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            // SizedBox(height: screenHeight * 0.01),
            DefaultTabController(
              length: 7,
              initialIndex: 0, // Ensures the first tab is selected by default
              child: Column(
                children: [
                  const TabBar(
                    isScrollable: true,
                    labelStyle: TextStyle(fontSize: 12),
                    labelColor: Colors.red, // Set the selected tab color to red
                    unselectedLabelColor: Colors.black,
                    indicatorColor: AppColors.primaryColor,
                    tabs: [
                      Tab(text: 'Uploads'),
                      Tab(text: 'About'),
                      Tab(text: 'Recommended'),
                      Tab(text: 'Popularity'),
                      Tab(text: 'More'),
                      Tab(text: 'DashBoard'),
                      Tab(text: 'OrderStatus'),
                    ],
                  ),
                  SizedBox(

                    height: screenHeight * 0.695 - kBottomNavigationBarHeight- kToolbarHeight, // Adjusted based on the screen height
                    child: TabBarView(
                      children: [
                        userAccount.userAccounts!.first.businessProfile.id != null
                            ? UploadTab()
                            : const Text("no Account"),
                        AboutTab(),
                        RecommendationsTab(),
                        PopulartyScreen(),
                        MoreTab(),
                        const Center(child: Text('data')),
                        OrderStatusTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class UploadTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ProductGridPage();
  }

}

class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false, // Disable scrollbars
      ),
      child: SingleChildScrollView(
        child: ProfileForm(),
      ),
    );
  }
}


class RecommendationsTab extends StatefulWidget {
  @override
  _RecommendationsTabState createState() => _RecommendationsTabState();
}

class _RecommendationsTabState extends State<RecommendationsTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF7DCFF),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              dividerColor: Colors.white,
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.textFieldTextColor,
                borderRadius: BorderRadius.circular(25),
              ),
              labelColor: Colors.white,
              unselectedLabelColor:AppColors.textFieldTextColor,
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
              tabs: const [
                Tab(
                  child: Center(
                    child: Text(
                      'Pin',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Tab(
                  child: Center(
                    child: Text(
                      'Shared',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FolderDialog();
                },
              );
            },
            child: const Text(
              '+ Add new folder',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _tabController.animateTo(index);
              },
              children: [
                _buildGridView('Pin Page'),
                _buildGridView('Shared Page'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(String title) {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: [
        // First container with nested grid
        Column(
          children: [
            Expanded(
              child: _buildInnerGrid(),
            ),
            Text(title),
          ],
        ),
        const SizedBox(width: 10),
        // Second container with nested grid
        Column(
          children: [
            Expanded(
              child: _buildInnerGrid(),
            ),
            const Text('Fun'),
          ],
        ),
      ],
    );
  }

  Widget _buildInnerGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // Prevent inner grid from scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of items per row in the inner grid
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount:9, // Total items in the inner grid
      itemBuilder: (context, index) {
        return Container(
          color: Colors.blue, // Placeholder styling
          child: Center(child: Text('Item $index')),
        );
      },
    );
  }

}


class OrderStatusTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrderHistoryScreen();
  }
}

class MoreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
   behavior: ScrollConfiguration.of(context).copyWith(
      scrollbars: false, // Disable scrollbars
    ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          margin:  const EdgeInsets.all(8),
          decoration: BoxDecoration(
            // border: Border.all(
            //   color: AppColors.textFieldColor
            // )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildListTile(context,Icons.dashboard, 'SOCO Dashboard'),
              const SizedBox(height: 10,),
              _buildListTile(context,Icons.business, 'Business Settings'),
              const SizedBox(height: 10,),
              _buildListTile(context,Icons.people, 'Invite friends'),
              const SizedBox(height: 10,),
              _buildListTile(context,Icons.notifications, 'Notifications'),
              const SizedBox(height: 10,),
              _buildListTile(context,Icons.help, 'Help center'),
              const SizedBox(height: 10,),
              _buildListTile(context,Icons.privacy_tip, 'Privacy'),
              const SizedBox(height: 10,),
              _buildListTile(context,Icons.policy, 'Policies'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData leadingIcon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(leadingIcon, color: Colors.purple[700]),
        title: Text(
          title,
          style: TextStyle(color: Colors.purple[700], fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.purple[700], size: 18),
        onTap: () {
          switch (title) {
            case 'Privacy':
              Navigator.pushNamed(context, '/settings');
              break;
            case 'Policies':
              Navigator.push(context, MaterialPageRoute(builder: (context) => PoliciesScreen()));
              break;
            case 'Business Settings':
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountChoosingScreen()));
              break;
            default:
            // Handle any other cases if necessary
              break;
          }
        },
      ),
    );
  }

}

class ProfileForm extends StatelessWidget {
  ProfileForm({super.key});

  FocusNode phone = FocusNode();
  FocusNode email = FocusNode();
  FocusNode code = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCustomInputField(
              context: context,
              label: 'Phone Number',
              hint: '9084939202',
              focusNode: phone,
              focusNodeString: email),
          _buildCustomInputField(
              context: context,
              label: 'I am living in',
              hint: 'India',
              focusNode: email,
              focusNodeString: code),
          _buildCustomInputField(
              context: context,
              label: 'DOB',
              hint: 'DD/MM/YYYY',
              focusNode: code),
          _buildCustomInputField(
            context: context,
            label: 'I work with',
            hint: 'Enter here',
          ),
          _buildCustomInputField(
            context: context,
            label: 'I studied at',
            hint: 'Enter here',
          ),
          _buildCustomInputField(
            context: context,
            label: 'Website',
            hint: 'Enter here',
          ),
          _buildCustomInputField(
            context: context,
            label: 'Social media links',
            hint: 'Enter here',
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add your logic here to handle the form submission
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              'Save Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 20.3),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCustomInputField({
  required BuildContext context,
  required String label,
  required String hint,
  IconData? icon,
  Icon? sufIcon,
  Color enabledBorderColor = AppColors.textFieldColor,
  Color focusedBorderColor = AppColors.textFieldColor,
  Color errorBorderColor = AppColors.textFieldColor,
  FocusNode? focusNode,
  FocusNode? focusNodeString,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: TextFormField(
      focusNode: focusNode,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(focusNodeString);
      },
      decoration: InputDecoration(
        suffixIcon: sufIcon,
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.textFieldColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.5,
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColors.textFieldTextColor,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.5,
        ),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: enabledBorderColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: enabledBorderColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: focusedBorderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: errorBorderColor, width: 2),
        ),
      ),
    ),
  );
}



class FolderDialog extends StatefulWidget {
  @override
  _FolderDialogState createState() => _FolderDialogState();
}

class _FolderDialogState extends State<FolderDialog> {
  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 16, top: 50, right: 16, bottom: 16),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                constraints: const BoxConstraints(
                  minHeight: 145,
                  minWidth: 145
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/folder.png',
                    ),
                    fit: BoxFit.cover
                  )
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF70DCE2),
                    borderRadius: BorderRadius.circular(25)
                ),
                child:  TextField(

                  decoration: InputDecoration(                
                    hintText: "Name the folder-like category, place",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25)
                    ),
                
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _isPrivate,
                    onChanged: (bool? value) {
                      setState(() {
                        _isPrivate = value!;
                      });
                    },
                  ),
                  const Text("Keep the folder private",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 16.5 / 11.0,
                    ),
                    textAlign: TextAlign.center,),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll( AppColors.textFieldTextColor)
                ),
                child: const Text("Create folder",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 11.0,
                    height: 16.5 / 11.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  // Implement folder creation logic here
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        Positioned(
          right:16,
          top: 32,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close, color: Colors.black),
          ),
        ),
      ],
    );
  }
}