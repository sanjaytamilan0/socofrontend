
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'category_screen.dart';
import 'reverpod/create_product_api_notifier.dart';
import 'reverpod/uploaded_product_screen_notifier.dart';

import 'add_product.dart';

class ProductGridPage extends ConsumerStatefulWidget {

  @override
  ConsumerState<ProductGridPage> createState() => _ProductGridPageState();
}

class _ProductGridPageState extends ConsumerState<ProductGridPage> {
  @override
  Widget build(BuildContext context) {
    final productUpload = ref.read(productUploadProvider.notifier);
    final productNotifier = ref.watch(productUploadProvider);
  bool isTrue = true;
    return  Column(
        children: [
          _buildSortAndFilterBar(context),
          _buildCategoriesRow(context),
           Container(
             alignment: Alignment.centerRight,
             child: IconButton(

                 onPressed: (){
                   ref.read(createProductProvider.notifier).getProduct();
                   productUpload.toggleListButton();
                 }, icon: const Icon(Icons.menu)),
           ),
          Expanded(
            child: _buildProductGrid(isTrue,context,ref),
          ),
        ],

    );
  }

  Widget _buildSortAndFilterBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Make sure it fits content
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sort By",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 16.07,
                              fontWeight: FontWeight.w600,
                              height: 24.1 / 16.07,
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text(
                              "Sort Option 1",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 24.1 / 16.07,
                              ),
                            ),
                            onTap: () {
                              // Handle sort option 1
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text(
                              "Sort Option 2",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 24.1 / 16.07,
                              ),
                            ),
                            onTap: () {
                              // Handle sort option 2
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text(
                              "Sort Option 3",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 24.1 / 16.07,
                              ),
                            ),
                            onTap: () {
                              // Handle sort option 3
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.sort),
              label: const Text('Sort by'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // Filter action
              },
              icon: const Icon(Icons.filter_list),
              label: const Text('Filter'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesRow(BuildContext context) {
    final categories = ['Skin care', 'Kurtis', 'Pants', 'Palazzo'];
    return Column(
      children: [
        const SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Category",style: TextStyle(color: Colors.black,fontSize: 15),),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
              }, icon: const Icon(Icons.arrow_forward_ios,size:20 ,))
            ],
          ),
        ),
        const SizedBox(height: 10,),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 4 - 16, // Dividing the screen width by 4 to show 4 items
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.category, color: Colors.pink),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        categories[index],
                        textAlign: TextAlign.center, // Center the text below the icon
                        style: const TextStyle(fontSize: 12), // Adjust font size if needed
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid(isTrue, BuildContext context, WidgetRef ref) {
    final productState = ref.watch(createProductProvider);

    if (productState.isLoading) {
      // Show a loading spinner while the products are being fetched
      return const Center(child: CircularProgressIndicator());
    }

    if (productState.error.isNotEmpty) {
      // Show an error message if there is an issue fetching the products
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 50),
            const SizedBox(height: 10),
            Text(productState.error, textAlign: TextAlign.center),
            ElevatedButton(
              onPressed: () {
                ref.read(createProductProvider.notifier).getProduct();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (productState.products.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return Stack(
      children: [
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false, // Disable scrollbars
          ),
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ref.watch(productUploadProvider).listToggleButton ? 1 : 3,
              childAspectRatio: ref.watch(productUploadProvider).listToggleButton ? 1 : 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: ref.watch(productUploadProvider).listToggleButton ? 20 : 10,
            ),
            itemCount: productState.products.length,
            itemBuilder: (context, index) {
              final product = productState.products[index];
              return Card(
                margin: isTrue ? const EdgeInsets.all(20) : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.blue[100],
                        child: Center(
                          child: (product.productImage != null && product.productImage!.isNotEmpty)
                              ? Image.network(product.productImage.toString())
                              : const Icon(Icons.ad_units, size: 50, color: Colors.blue),
                        ),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.productName, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('Rs.${product.salesPrice}', style: const TextStyle(color: Colors.pink)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: IconButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage()));
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

}