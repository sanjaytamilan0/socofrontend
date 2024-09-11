import 'package:flutter/material.dart';

import 'order_details_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String _selectedFilter = 'All Orders';

  final List<Map<String, String>> _orderData = [
    {'orderId': 'SDO6457854HJ', 'location': 'Bangalore', 'date': '25-04-2024', 'status': 'Open'},
    {'orderId': 'SDO6457855HJ', 'location': 'Chennai', 'date': '26-04-2024', 'status': 'Confirmed'},
    {'orderId': 'SDO6457856HJ', 'location': 'Delhi', 'date': '27-04-2024', 'status': 'Delivered'},
    {'orderId': 'SDO6457857HJ', 'location': 'Mumbai', 'date': '28-04-2024', 'status': 'Open'},
    {'orderId': 'SDO6457858HJ', 'location': 'Hyderabad', 'date': '29-04-2024', 'status': 'Confirmed'},
    {'orderId': 'SDO6457859HJ', 'location': 'Pune', 'date': '30-04-2024', 'status': 'Delivered'},
    {'orderId': 'SDO6457860HJ', 'location': 'Kolkata', 'date': '01-05-2024', 'status': 'Open'},
    {'orderId': 'SDO6457861HJ', 'location': 'Jaipur', 'date': '02-05-2024', 'status': 'Confirmed'},
    {'orderId': 'SDO6457862HJ', 'location': 'Surat', 'date': '03-05-2024', 'status': 'Delivered'},
    {'orderId': 'SDO6457863HJ', 'location': 'Ahmedabad', 'date': '04-05-2024', 'status': 'Open'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterDropdown(),
          const SizedBox(height: 16),
          _buildLegend(),
          const SizedBox(height: 16),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false, // Disable scrollbars
              ),
              child: ListView(
                children: _orderData
                    .where((order) => _selectedFilter == 'All Orders' || order['status'] == _selectedFilter)
                    .map((order) => _buildOrderCard(
                    order['orderId']!,
                    order['location']!,
                    order['date']!,
                    order['status']!))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: _selectedFilter,
        isExpanded: true,
        underline: const SizedBox(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedFilter = newValue!;
          });
        },
        items: <String>['All Orders', 'Open', 'Confirmed', 'Delivered']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildLegendItem(Colors.red, 'Open'),
        const SizedBox(width: 16),
        _buildLegendItem(Colors.purple, 'Confirmed'),
        const SizedBox(width: 16),
        _buildLegendItem(Colors.orange, 'Delivered'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),

        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildOrderCard(String orderId, String location, String date, String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'open':
        statusColor = Colors.red;
        break;
      case 'confirmed':
        statusColor = Colors.purple;
        break;
      case 'delivered':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context)=>  OrderDetailsScreen()
        )
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(orderId, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(location),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              color: statusColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
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
