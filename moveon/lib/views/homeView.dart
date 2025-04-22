import 'package:flutter/material.dart';
import 'package:moveon/mechanic_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedIssue = 'All';
  String selectedVehicle = 'Car';

  final List<String> issues = [
    'All',
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  double _parseDistance(String distanceStr) {
    try {
      return double.parse(distanceStr.replaceAll(' km away', '').trim());
    } catch (e) {
      return double.infinity; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMechanics = allMechanics.where((mechanic) {
      final matchIssue = selectedIssue == 'All' || mechanic.issues.contains(selectedIssue);
      final matchVehicle = selectedVehicle == 'All' || mechanic.vehicleType == selectedVehicle;
      return matchIssue && matchVehicle;
    }).toList()
      ..sort((a, b) => _parseDistance(a.distance).compareTo(_parseDistance(b.distance)));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF756EF3),
        title: Text("Hi, Buddy!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // TODO: Implement logout
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
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
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
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
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: filteredMechanics.isEmpty
                  ? Center(
                      child: Text(
                        'No Mechanic Available Nearby',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredMechanics.length,
                      itemBuilder: (context, index) {
                        final mechanic = filteredMechanics[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(mechanic.imageUrl),
                            ),
                            title: Text(mechanic.name),
                            subtitle: Text(
                              '${mechanic.expertise} • ${mechanic.vehicleType}\n${mechanic.distance}',
                            ),
                            isThreeLine: true,
                            trailing: IconButton(
                              icon: Icon(Icons.phone, color: Colors.green),
                              onPressed: () => _makePhoneCall(mechanic.phone),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
