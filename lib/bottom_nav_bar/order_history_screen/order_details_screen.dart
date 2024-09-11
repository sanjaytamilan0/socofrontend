
import 'package:flutter/material.dart';
import '../../common/colors.dart';

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: const Icon(Icons.arrow_back_ios),),
        centerTitle: true,
        title: const Text('SD06457654HJ'),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                Positioned(
                  top: -3,  // Adjusted for proper alignment
                  right: -3,  // Adjusted for proper alignment
                  child: Container(
                    height: 16,  // Increased size for better visibility
                    width: 16,  // Increased size for better visibility
                    decoration: BoxDecoration(
                      color: AppColors.dashBoardBorderColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text(
                        "1",
                        style: TextStyle(
                          fontSize: 10,  // Adjusted font size to fit within the badge
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderImage(),
            const SizedBox(height: 40,),
            _buildCompanyInfo(),
            _buildOrderInfo(),
            _buildOrderItems(),
            _buildOrderStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children:[
          Container(
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
              image: AssetImage('assets/header_image.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
          const Positioned(
            bottom: -50,
              child: CircleAvatar(
      maxRadius: 50,
                minRadius: 30,
          ))

        ],
      ),
    );
  }

  Widget _buildCompanyInfo() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Serville technologies',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,fontFamily:  'Poppins',
              color: AppColors.textFieldColor
            ),
          ),
          SizedBox(height: 10,),
          Divider()
        ],
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Column(
      children: [
        const Text("Order History",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,fontFamily:  'Poppins',
              color: AppColors.textFieldTextColor
          ),),
        Container(
          decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColors.dashBoardBorderColor
                  
            )
                
          ),
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Order ID', 'SFDSF04535351HJFg'),
                _buildInfoRow('Customer Name', 'Jees kariyi'),
                _buildInfoRow('Address', 'Serville Technologies\nKakkandu kochi\nKerala 682 067'),
                _buildInfoRow('Order Date', '25-04-2024'),
                _buildInfoRow('Current status', 'Online payment'),
                _buildInfoRow('Current status', 'Open'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600,fontFamily:  'Poppins',
                  color: Colors.black
              ),
            ),
          ),
          const Text(':'),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600,fontFamily:  'Poppins',
                  color: AppColors.dashBoardBorderColor
              ),
              textAlign: TextAlign.left,
            )
          ),
        ],
      ),
    );
  }


  Widget _buildOrderItems() {
    return Column(
      children: [
        _buildOrderItem('Chocolate cup cake', '1', '230'),
        _buildOrderItem('Chocolate Truffle cake', '1 (kg)', '230', message: 'HBD Jees'),
      ],
    );
  }

  Widget _buildOrderItem(String name, String quantity, String price, {String? message}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.dashBoardBorderColor)
      )
      ,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.all(4),

                    decoration: BoxDecoration(
                     border: Border.all(color:AppColors.dashBoardBorderColor)
                    ),
                  )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600,fontFamily:  'Poppins',
                            color: Colors.black
                        ),),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Quantity ',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,fontFamily:  'Poppins',
                                color: Colors.black
                            ),),
                          const Text(':'),
                          Text(quantity,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600,fontFamily:  'Poppins',
                                color: AppColors.dashBoardBorderColor
                            ),),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          const Text('Price',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,fontFamily:  'Poppins',
                                color: Colors.black
                            ),),
                          const Text(':'),
                          Text(price,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600,fontFamily:  'Poppins',
                                color: AppColors.dashBoardBorderColor
                            ),),
                        ],
                      ),
                      if (message != null) ...[
                        const SizedBox(height: 8),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Message',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,fontFamily:  'Poppins',
                                  color: Colors.black
                              ),),
                            const Text(':'),
                            Text(message,
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600,fontFamily:  'Poppins',
                                  color: AppColors.dashBoardBorderColor
                              ),),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              )
            ],
          ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                    side: const BorderSide(color: Colors.red, width: 2), // Red border
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: AppColors.textFieldColor, // Text color
                    ),
                  ),
                ),

                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.textFieldTextColor),
                  child: const Text('Confirm',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,fontFamily:  'Poppins',
                        color: Colors.white
                    ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatus() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 40,
              child: DropdownButtonFormField(menuMaxHeight: 50,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Order Confirmed',
                ),
                items: const [],
                onChanged: (value) {},
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textFieldTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
                ),
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            )
            ,
          ),
        ],
      ),
    );
  }
}