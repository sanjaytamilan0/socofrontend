
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/colors.dart';
import '../../common/ui_widgets/user_profile_header.dart';

class PopulartyScreen extends StatefulWidget {
  @override
  State<PopulartyScreen> createState() => _PopulartyScreenState();
}

class _PopulartyScreenState extends State<PopulartyScreen> {
  String? token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  void getToken()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     token = prefs.getString('fcm_token');
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return  ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false, // Disable scrollbars
      ),
      child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                token != null
                    ? TextButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: token!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Token copied to clipboard'),

                      ),
                    );
                  },
                  child: Text(
                    token!,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
                    : const SizedBox(),
                const Text('Ratings 4.0', style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 10,),
                Row(
                  children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.yellow, size: 20)),
                ),
                const SizedBox(height: 16),
                _followersList(context),
                // _buildChartSection(context, isSmallScreen),
                const SizedBox(height: 16),
                _buildVisitorsSection(context, isSmallScreen),
                const SizedBox(height: 16),
                _buildOrderHistory(context),
                const SizedBox(height: 16),
                _buildTicketSummary(context),

              ],
            ),
          ),
      ),
    );
  }
}

Widget _followersList(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: AppColors.dashBoardBorderColor),
    ),
    padding: const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '102',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '2',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 8), // Add spacing between the rows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Followers',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'Rating',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildChartSection(BuildContext context, bool isSmallScreen) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Followers and Non Followers",
              style: TextStyle(
                  color: AppColors.textFieldTextColor,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.dashBoardBorderColor,)
                  ,borderRadius: BorderRadius.circular(10)
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Last 7 Days", style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500
                  ),),
                  Icon(Icons.arrow_drop_down,size: 20,)
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10,),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.textFieldTextColor),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          height: isSmallScreen ? 400 : 300,
          child: Column(
            children: [
              const Expanded(
                child: PieChartSample3(),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.only(left: 10,right: 10),
                child:  Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(

                                color: AppColors.textFieldColor,
                                borderRadius: BorderRadius.circular(50)

                              ),
                            ),
                            const SizedBox(width: 5,),
                            const Text('Followers',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500
                              ),),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(

                                  color: AppColors.textFieldTextColor,
                                  borderRadius: BorderRadius.circular(50)

                              ),
                            ),
                            const SizedBox(width: 5,),
                            const Text('Non-Followers',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500
                              ),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('102',
                          style: TextStyle(
                              color: AppColors.textFieldTextColor,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500
                          ),),
                        Text('1254',
                          style: TextStyle(
                              color: AppColors.textFieldTextColor,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500
                          ),),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Top Interested Categories',
                                style: TextStyle(
                                    color: AppColors.textFieldTextColor,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500
                                ),),
                              Text('• Travel',
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500
                                ),),
                              Text('• Fashion',
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500
                                ),),
                              Text('• Arts',
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500
                                ),),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Top 3 Follower Cities',
                                style: TextStyle(
                                    color: AppColors.textFieldTextColor,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500
                                ),),
                              Text('• Bengaluru',
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500
                                ),),
                              Text('• Kochi',
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500
                                ),),
                              Text('• Mangaluru',
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500
                                ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVisitorsSection(BuildContext context, bool isSmallScreen) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Visitor Profile",
              style: TextStyle(
                  color: AppColors.textFieldTextColor,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,)
                  ,borderRadius: BorderRadius.circular(10)
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("View More", style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500
                  ),),
                  Icon(Icons.arrow_forward_ios,size: 20,)
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10,),
        Container(
          height: isSmallScreen ? 200 : 300,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.textFieldTextColor),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: BarChart(
            BarChartData(
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 200)]),
                BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 300)]),
                BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 100)]),
                BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 450)]),
                BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 50)]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderHistory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Order History",
          style: TextStyle(
              color: AppColors.textFieldTextColor,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8,right: 8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black,)
              ,borderRadius: BorderRadius.circular(10)
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("View More", style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500
              ),),
              Icon(Icons.arrow_forward_ios,size: 20,)
            ],
          ),
        )
      ],
    ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.dashBoardBorderColor
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOrderItem(context, Colors.blue, '\$', '250'),
              _buildOrderItem(context, Colors.orange, '30', 'Days'),
              _buildOrderItem(context, Colors.red, '20', '%'),
              _buildOrderItem(context, Colors.green, '30', 'Orders'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem(BuildContext context, Color color, String value, String label) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500
            ),),
            Text(label, style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500
            ),),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketSummary(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Ticket Summary",
              style: TextStyle(
                  color: AppColors.textFieldTextColor,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,)
                    ,borderRadius: BorderRadius.circular(10)
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("View More", style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500
              ),),
                  Icon(Icons.arrow_forward_ios,size: 20,)
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10,),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('20', style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500
              ),),
              Text('Booking tickets', style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500
              ),),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Container(
          
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.dashBoardBorderColor,)
              ,borderRadius: BorderRadius.circular(10)
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("View More", style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500
              ),),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        )
      ],
    );
  }


class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State<PieChartSample3> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            showTitle: false,
            color: Colors.pink,
            value: 102,
            title: 'Followers',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            showTitle: false,
            color: Colors.purple,
            value: 1254,
            title: 'Non-Followers',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Exception('Invalid index');
      }
    });
  }
}





