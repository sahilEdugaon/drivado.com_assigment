import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CompanyDetailsScreen extends StatefulWidget {
  final Map companyDetails;
  const CompanyDetailsScreen({super.key, required this.companyDetails});

  @override
  _CompanyDetailsScreenState createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  bool isSwitchOn = true; // Variable to hold switch state

  @override
  Widget build(BuildContext context) {
    print('widgets..${widget.companyDetails}');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                          'Company Details',
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
                    const SizedBox(height: 16),
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
                              '${widget.companyDetails['logo']}',
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/company_logo.jpg');
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${widget.companyDetails['companyName']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('${widget.companyDetails['email']}', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    _buildUserInfoRow(Icons.link, 'Website', 'drivado.com'),
                    _buildUserInfoRow(Icons.phone_in_talk, 'Mob.number', '${widget.companyDetails['mobileNumber']??""}'),
                    _buildUserInfoRow(Icons.attach_money, 'GST/VAT', '${widget.companyDetails['gst_num']??"Undefined"}'),
                    _buildUserInfoRow(Icons.add_location_alt, 'Address', '${widget.companyDetails['address']??""}'),
                  ],
                ),
              ),
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
                      _buildCreditInfoRow('Total unpaid booking', 'USD ${widget.companyDetails['totalUnpaidBooking']??'00'}'),
                      _buildCreditInfoRow('Available credit limit', 'USD ${widget.companyDetails['availableCreditLimit']??'00'}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

}
