import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moveon/views/mechanicListView.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedIssue = 'Puncture';
  String selectedVehicle = 'Car';
  final TextEditingController _priceController = TextEditingController();

  final List<String> issues = [
    'Puncture',
    'Tire Change',
    'Flat Tire',
    'Air Refill',
  ];

  final List<String> vehicles = [
    'Car',
    'Bike',
    'Truck',
    'Suzuki',
  ];

  void _showPriceModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets.add(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter Your Price',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price in PKR',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                      final price = _priceController.text.trim();
                      if (price.isNotEmpty) {
                        Navigator.pop(context); // close modal
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MechanicListView(
                              selectedIssue: selectedIssue,
                              selectedVehicle: selectedVehicle,
                              price: price,
                            ),
                          ),
                        );
                      }
                    },
                child: Text('Find Mechanics',style: TextStyle(color: Colors.white,fontSize: 20),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF756EF3),
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Issue & Vehicle'),
        backgroundColor: const Color(0xFF756EF3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedIssue,
              items: issues.map((issue) {
                return DropdownMenuItem(
                  value: issue,
                  child: Text(issue),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedIssue = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Issue',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedVehicle,
              items: vehicles.map((vehicle) {
                return DropdownMenuItem(
                  value: vehicle,
                  child: Text(vehicle),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedVehicle = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Vehicle',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _showPriceModal,
              child: Text('Next', style: TextStyle( color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF756EF3),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
