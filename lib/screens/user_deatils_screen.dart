import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class UserDetailsScreen extends StatefulWidget {
  final Map userDetails;
  const UserDetailsScreen({super.key, required this.userDetails});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  bool isSwitchOn = true; // Variable to hold switch state

  Widget _buildUserInfoRow(IconData icon, String title, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Table(
        columnWidths: const {
          0:FixedColumnWidth(115),
          1:FixedColumnWidth(30),
          2:FlexColumnWidth(),
        },
        children:  [
          TableRow(
            children: [
              TableCell(child:
              Row(
                children: [
                  Icon(icon, size: 20, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(title, style: TextStyle(color: Colors.grey)),
                ],
              ),
              ),
              TableCell(child: Text(':')),
              TableCell(child: Text(info)),
            ]
          )
        ],
      )
    );
  }

  Widget _buildCreditInfoRow(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style:  TextStyle(fontSize: 14,color: Colors.black.withOpacity(0.5))),
          Text(amount, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print('widgets...${widget.userDetails}');
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: screenHeight * 0.1, // Adjust the height here
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20), // Adjusts spacing within the AppBar
            height: 36, // Adjust height to make it look balanced
            width: 36,  // Adjust width to make it look balanced
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.4), // Adjust opacity (0.0 to 1.0)
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
              size: 20, // Adjust icon size if needed
            ),
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Test Drivado', style: TextStyle(fontSize: 16,color: Colors.white)),
                Text('test@drivado.com', style: TextStyle(fontSize: 14, color: Colors.white70)),
              ],
            ),
          ],
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile.png'), // Replace with actual image URL
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SizedBox(
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Details Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                         Text(
                          'User Details',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.5)),
                        ),
                        Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            'Deactivate',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        FlutterSwitch(
                          width: 50.0,
                          height: 20.0,
                          toggleSize: 20.0,
                          value: isSwitchOn,
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey,
                          activeToggleColor: Colors.white, // Thumb color when active
                          onToggle: (val) {
                            setState(() {
                              isSwitchOn = val; // Update the switch state
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                     Row(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.all(Radius.circular(40),),
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 0.5, // Border width
                              ),
                            ) ,
                            child: Image.network(
                              fit:BoxFit.cover,
                              '${widget.userDetails['avatar']}',
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network('https://t4.ftcdn.net/jpg/02/19/63/31/360_F_219633151_BW6TD8D1EA9OqZu4JgdmeJGg4JBaiAHj.jpg');
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${widget.userDetails['name']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text('User • ${widget.userDetails['email']}', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    _buildUserInfoRow(Icons.person, 'Name', '${widget.userDetails['name']}'),
                    _buildUserInfoRow(Icons.email, 'Email ID', '${widget.userDetails['email']}'),
                    _buildUserInfoRow(Icons.phone_in_talk, 'Mob.number', '${widget.userDetails['mobileNumber']}'),
                    _buildUserInfoRow(Icons.language, 'Language', 'English'),
                    _buildUserInfoRow(Icons.attach_money, 'Currency', '${widget.userDetails['currency']}'),
                  ],
                ),
              ),
              // Credit Limit Section
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Credit limit', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.5))),
                      SizedBox(height: 8),
                      _buildCreditInfoRow('Total unpaid booking', 'USD ${widget.userDetails['totalUnpaidBooking']??'00'}'),
                      _buildCreditInfoRow('Available credit limit', 'USD ${widget.userDetails['availableLimit']??'00'}'),
                    ],
                  ),
                ),
              ),


              // Container(
              //   padding: EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Credit limit',
              //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(height: 8),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text('Total unpaid booking', style: TextStyle(color: Colors.grey)),
              //           Text('USD 462', style: TextStyle(fontWeight: FontWeight.bold)),
              //         ],
              //       ),
              //       SizedBox(height: 8),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text('Available credit limit', style: TextStyle(color: Colors.grey)),
              //           Text('USD 128450', style: TextStyle(fontWeight: FontWeight.bold)),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
