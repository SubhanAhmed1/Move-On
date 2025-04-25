import 'package:flutter/material.dart';
import 'package:moveon/mechanic_data.dart';
import 'package:moveon/views/homeView.dart';
import 'package:url_launcher/url_launcher.dart';

class MechanicDetailPage extends StatefulWidget {
  final Mechanic mechanic;
  final String price;

  const MechanicDetailPage({
    Key? key,
    required this.mechanic,
    required this.price,
  }) : super(key: key);

  @override
  State<MechanicDetailPage> createState() => _MechanicDetailPageState();
}

class _MechanicDetailPageState extends State<MechanicDetailPage> {
  int selectedRating = 0;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),  
          title: Text("Thank You!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Please rate the mechanic:"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: selectedRating >= index && index > 0 ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedRating = index;
                      });
                      Navigator.of(context).pop(); // Close the dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('You rated $index star${index == 1 ? '' : 's'}')),
                      );
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false,
                        );
                      });
                    },
                  );
                }),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mechanic = widget.mechanic;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Mechanic Details"),
        backgroundColor: const Color(0xFF756EF3),
      ),
       body: Center(
  child: SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(mechanic.imageUrl),
        ),
        SizedBox(height: 16),
        Text(
          mechanic.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          mechanic.expertise,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        SizedBox(height: 16),
        Text(
          "Service Price: \$${widget.price}",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () => _makePhoneCall(mechanic.phone),
          icon: Icon(Icons.call),
          label: Text("Call Mechanic", style: TextStyle(color: Colors.white, fontSize: 20)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _showThankYouDialog,
          child: Text("Task Completed", style: TextStyle(color: Colors.white, fontSize: 20)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF756EF3),
          ),
        ),
      ],
    ),
  ),
),

    );
  }
}
