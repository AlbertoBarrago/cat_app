// Future<void> downloadImage(String imageUrl) async {
//   final response = await http.get(Uri.parse(imageUrl));
//
//   if (response.statusCode == 200) {
//     // Get the app's document directory
//     final appDir = await getApplicationDocumentsDirectory();
//
//     // Create a file name for the downloaded image
//     final fileName = imageUrl.split('/').last;
//
//     // Create a file reference to the path
//     final file = File('${appDir.path}/$fileName');
//
//     // Write the image data to the file
//     await file.writeAsBytes(response.bodyBytes);
//
//     // Show a success message
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Download Complete'),
//         content: Text('Image downloaded successfully.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   } else {
//     // Show an error message
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Download Failed'),
//         content: Text('Failed to download the image.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }