import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../business_product_upload/reverpod/create_product_api_notifier.dart';
import '../../common/colors.dart';

import '../../common/ui_widgets/common_appbar.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}


class _FeedScreenState extends ConsumerState<FeedScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future <void> fetchData()async {
    await Future.delayed(Duration.zero);
    ref.read(createProductProvider.notifier).getProduct();
  }


  bool showGridView = true;

  @override
  Widget build(BuildContext context) {
    ref.read(createProductProvider.notifier);
   final productNotifier =  ref.watch(createProductProvider);
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView.builder(
        itemCount: productNotifier.products.length,
        itemBuilder: (context, index) {
      final   product =  productNotifier.products[index];
          return Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Placeholder(child: CircleAvatar()),
                    const SizedBox(width: 10),
                    Text(
                      product.owner,
                      style: const TextStyle(
                        color: AppColors.textFieldColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height / 6,
                  child: (product.productImage != null && product.productImage!.isNotEmpty)
                      ? Image.network(
                    product.productImage.toString(),
                    fit: BoxFit.fill,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      print(exception.toString());
                      // Show alternative widget if image fails to load
                      return const Center(
                        child: Icon(Icons.error, size: 50, color: Colors.red),
                      );
                    },
                  )
                      : const Center(child: Icon(Icons.ad_units, size: 50, color: Colors.blue)),
                ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border_outlined)),
                    const Text(
                      "100",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontSize: 11,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.comment_bank_outlined)),
                    const Text(
                      "100",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontSize: 11,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
                    const Text(
                      "100",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontSize: 11,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.store)),
                    const Text(
                      "100",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "View all Comments",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontSize: 15,
                  ),
                ),
               const SizedBox(height: 5,),
               if(index == 0 ) Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text('Suggest all pages',style: TextStyle(
                       color: AppColors.textFieldColor,
                     fontSize: 20,
                     fontWeight: FontWeight.w600
                   ),),
                   const SizedBox(height: 10,),
                   SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (showGridView) ? 6 : 0,
                        itemBuilder: (context, i) {
                          return Container(
                            // alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.textFieldColor,
                                width: 2
                              ),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            width: 100.0, // Adjust width as needed
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),// Placeholder color
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color:AppColors.textFieldColor,width: 2 ),
                                      borderRadius: BorderRadius.circular(25)

                                    ),
                                    child: const CircleAvatar(
                                      child: Icon(Icons.person_outline,color: AppColors.textFieldColor,),
                                    ),
                                  ),
                                 const SizedBox(height: 5,),
                                  const Text("unKnown",
                                    style:TextStyle(
                                      color: AppColors.textFieldTextColor,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                    ),
                                  ),
                                const SizedBox(height: 5,),
                                  TextButton(
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(AppColors.textFieldTextColor)
                                    ),
                                      onPressed: (){}, child: const Text('Follow'))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                 ],
               ),
              ],
            ),
          );
        },
      ),
    );
  }
}