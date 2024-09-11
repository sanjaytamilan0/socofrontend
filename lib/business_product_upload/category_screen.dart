import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart screen
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Left filter column
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.pink[50],
              padding: const EdgeInsets.all(8),
              child: ListView(
                children: [
                  _buildFilterOption('Size', true),
                  _buildFilterOption('Color', false),
                  _buildFilterOption('Brand', false),
                  _buildFilterOption('Categories', false),
                  _buildFilterOption('Bundles', false),
                  _buildFilterOption('More Filters', false),
                  _buildFilterOption('Price Range', false),
                  _buildFilterOption('Discount', false),
                ],
              ),
            ),
          ),
          // Right size chart column
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Size chart',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Product available',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.pink,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  _buildSizeChartRow('S', '64946'),
                  _buildSizeChartRow('L', '63327'),
                  _buildSizeChartRow('M', '60341'),
                  _buildSizeChartRow('XL', '50911'),
                  _buildSizeChartRow('XXL', '37923'),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          // Cancel button action
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.pink,
                        ),
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Apply button action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                        child: Text('Apply'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String text, bool isSelected) {
    return ListTile(
      leading: Checkbox(
        value: isSelected,
        onChanged: (bool? value) {},
        activeColor: Colors.pink,
      ),
      title: Text(text),
    );
  }

  Widget _buildSizeChartRow(String size, String productCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(size),
          ),
          Expanded(
            child: Text(
              productCount,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
