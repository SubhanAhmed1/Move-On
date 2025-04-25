// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:moveon/views/mechanicDetailView.dart';
// import 'package:moveon/views/mechanicListView.dart';

// class PriceSelector extends StatelessWidget {
//   final String issue;
//   final String vehicle;

//   const PriceSelector({super.key, required this.issue, required this.vehicle});

//   @override
//   Widget build(BuildContext context) {
//     final mechanics = [
//       {
//         'name': 'Ali Mechanic',
//         'phone': '+92 300 1234567',
//         'image': 'https://via.placeholder.com/150',
//         'rating': 4.5,
//         'price': '500 PKR'
//       },
//       {
//         'name': 'Ahmed Garage',
//         'phone': '+92 311 7654321',
//         'image': 'https://via.placeholder.com/150',
//         'rating': 4.0,
//         'price': '650 PKR'
//       },
//     ];

//     return Container(
//       padding: const EdgeInsets.all(16),
//       height: 400,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//         color: Colors.white,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               height: 5,
//               width: 40,
//               margin: const EdgeInsets.only(bottom: 12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//           Text(
//             'Available Mechanics for $issue (${vehicle})',
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 12),
//           Expanded(
//             child: ListView.builder(
//               itemCount: mechanics.length,
//               itemBuilder: (context, index) {
//                 final mechanic = mechanics[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                   elevation: 3,
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.all(12),
//                     leading: CircleAvatar(
//                       radius: 30,
//                       backgroundImage: NetworkImage(mechanic['image'] as String),
//                     ),
//                     title: Text(mechanic['name'] as String,
//                         style: const TextStyle(fontWeight: FontWeight.w600)),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Phone: ${mechanic['phone']}'),
//                         Row(
//                           children: [
//                             const Icon(Icons.star, color: Colors.amber, size: 16),
//                             Text('${mechanic['rating']}'),
//                           ],
//                         ),
//                         Text('Price: ${mechanic['price']}'),
//                       ],
//                     ),
//                     trailing: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => MechanicDetailPage(mechanic: mechanic),
//                           ),
//                         );
//                       },
//                       child: const Text('Book Now'),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
