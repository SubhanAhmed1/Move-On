// import 'package:flutter/material.dart';


// class ReviewDialog extends StatefulWidget {
//   const ReviewDialog({super.key});

//   @override
//   State<ReviewDialog> createState() => _ReviewDialogState();
// }

// class _ReviewDialogState extends State<ReviewDialog> {
//   double rating = 3;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Rate the Mechanic'),
//       content: RatingBar.builder(
//         initialRating: rating,
//         minRating: 1,
//         allowHalfRating: true,
//         itemCount: 5,
//         itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
//         onRatingUpdate: (value) => setState(() => rating = value),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Submit'),
//         )
//       ],
//     );
//   }
// }

// class RatingBar {
//   static builder({required double initialRating, required int minRating, required bool allowHalfRating, required int itemCount, required Icon Function(dynamic context, dynamic _) itemBuilder, required void Function(dynamic value) onRatingUpdate}) {}
// }