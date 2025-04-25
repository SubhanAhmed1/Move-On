import 'package:flutter/material.dart';
import 'package:moveon/mechanic_data.dart'; // Assuming you have dummy mechanic data here
import 'package:moveon/views/mechanicDetailView.dart';

class MechanicListView extends StatelessWidget {
  final String selectedIssue;
  final String selectedVehicle;
  final String price;

  const MechanicListView({
    Key? key,
    required this.selectedIssue,
    required this.selectedVehicle,
    required this.price,
  }) : super(key: key);

  double _parseDistance(String distanceStr) {
    try {
      return double.parse(distanceStr.replaceAll(' km away', '').trim());
    } catch (e) {
      return double.infinity;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMechanics = allMechanics.where((mechanic) {
      final issueMatch = selectedIssue == 'All' || mechanic.issues.contains(selectedIssue);
      final vehicleMatch = selectedVehicle == 'All' || mechanic.vehicleType == selectedVehicle;
      return issueMatch && vehicleMatch;
    }).toList()
      ..sort((a, b) => _parseDistance(a.distance).compareTo(_parseDistance(b.distance)));

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Mechanics'),
        backgroundColor: const Color(0xFF756EF3),
      ),
      body: filteredMechanics.isEmpty
          ? Center(child: Text('No mechanics found nearby.'))
          : ListView.builder(
              itemCount: filteredMechanics.length,
              itemBuilder: (context, index) {
                final mechanic = filteredMechanics[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(mechanic.imageUrl),
                          radius: 30,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mechanic.name,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${mechanic.expertise} • ${mechanic.vehicleType}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                mechanic.distance,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MechanicDetailPage(mechanic: mechanic, price: price),
                              ),
                            );
                          },
                          child: const Text('Book Now', style: TextStyle(color: Colors.white, fontSize: 20)),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF756EF3)),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
