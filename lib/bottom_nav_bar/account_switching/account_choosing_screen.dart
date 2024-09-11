import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'page_registration/bussness_registration_page_form.dart';
import 'page_registration/bussness_reverpod/user_account_notifier.dart';

class AccountChoosingScreen extends StatelessWidget {
  const AccountChoosingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Page'),
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOption(context, 'Business Page', const BusinessSettingsScreen()),
            const SizedBox(height: 16),
            _buildOption(context, 'New Event', EventScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, String title, Widget nextScreen) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextScreen),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 17.14,
                  fontWeight: FontWeight.w500,
                  height: 25.71 / 17.14,
                )
                ,    textAlign: TextAlign.center,
              ),
              const Icon(
                Icons.radio_button_unchecked,
                color: Colors.pinkAccent,
              ),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}


class BusinessSettingsScreen extends ConsumerStatefulWidget {
  const BusinessSettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BusinessSettingsScreen> createState() => _BusinessSettingsScreenState();
}


class _BusinessSettingsScreenState extends ConsumerState<BusinessSettingsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchAccountData();
  }

  void _fetchAccountData() async {
    await Future.delayed(Duration.zero);
    ref.read(accountProvider.notifier).fetchAccount();
  }

  @override
  Widget build(BuildContext context) {
    final userAccount = ref.watch(accountProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> ref.read(accountProvider.notifier).fetchAccount(),
      ),
      appBar: AppBar(
        title: const Text('Business Settings'),
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildActionButton(
            context,
            'Create new page / event',
            Icons.add,
            const PageRegistrationForm(),
          ),
          const SizedBox(height: 16),
          const Text('Pages', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('My pages'),
          userAccount.status == AccountStateStatus.loading?
          const Center(child: CircularProgressIndicator()):
          userAccount.status == AccountStateStatus.error?
               Center(
                child: GestureDetector(
                  onTap: (){
                    ref.read(accountProvider.notifier).fetchAccount();
                  }
                ,child: const Text('reTry')),
              ):
          userAccount.status == AccountStateStatus.success?

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:  userAccount.userAccounts!.length,
            itemBuilder: (context, index) {
              final account =  userAccount.userAccounts![index];
              return

                _buildPageItem(
                context,
                account.user.name,
                account.user.email,
                account.businessProfile.termsAgreed,
                PageDetailScreen(account.user.name,),
              );
            },
          ):
          const Center(
            child: Text('Account Not Available'),
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            context,
            'Following pages',
            Icons.add,
            FollowingPagesScreen(),
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            context,
            'Page Invitation',
            Icons.add,
            PageInvitationScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String title, IconData icon, Widget nextScreen) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.pinkAccent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(title),
        trailing: Icon(icon, color: Colors.pinkAccent),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextScreen),
          );
        },
      ),
    );
  }

  Widget _buildPageItem(
      BuildContext context, String name, String followers, bool isSelected, Widget nextScreen) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://example.com/placeholder.jpg'),
      ),
      title: Text(name),
      subtitle: Text(followers),
      trailing: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: Colors.pinkAccent,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      },
    );
  }
}


class CreatePageEventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Page / Event')),
    );
  }
}

class PageDetailScreen extends StatelessWidget {
  final String pageName;

  PageDetailScreen(this.pageName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Detail: $pageName')),
    );
  }
}

class FollowingPagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Following Pages')),
    );
  }
}

class PageInvitationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Invitation')),
    );
  }
}

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Event')),
      body: const Center(child: Text('Event Screen')),
    );
  }
}
