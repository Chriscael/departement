// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, duplicate_ignore

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart'; // Import the path_provider package
import 'package:permission_handler/permission_handler.dart';

class PdfPage extends StatelessWidget {
  final String fullName;
  final String emailAddress;
  final String subject;
  final String agency;
  final String currency;
  final String reason;
  final String phoneNumber;
  final String operationNumber;
  final int amount;
  final String date;
  final String merchantName;
  final String qrCode;
  final String schoolSignature;

  PdfPage({
    required this.fullName,
    required this.emailAddress,
    required this.subject,
    required this.agency,
    required this.currency,
    required this.reason,
    required this.phoneNumber,
    required this.operationNumber,
    required this.amount,
    required this.date,
    required this.merchantName,
    required this.qrCode,
    required this.schoolSignature,
  });

  Future<void> requestStoragePermission(BuildContext context) async {
    if (await Permission.storage.request().isGranted) {
      // Permission granted
    } else {
      // Permission denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required to save PDF.')),
      );
    }
  }

  Future<void> savePdf(pw.Document pdf, BuildContext context) async {
    await requestStoragePermission(context); // Request permission here
    try {
      // Get the external storage directory
      final directory = await getExternalStorageDirectory();
      // Create a new folder named "Reçu ICT" inside the external storage directory
      final folderPath = '${directory!.path}/Reçu ICT';
      final folder = Directory(folderPath);

      // Check if the folder exists, if not create it
      if (!await folder.exists()) {
        await folder.create();
        print('Folder "Reçu ICT" created at ${folder.path}');
      } else {
        print('Folder "Reçu ICT" already exists at ${folder.path}');
      }

      // Create a file in the "Reçu ICT" folder
      final file = File('$folderPath/receipt.pdf');
      // Save the PDF to the file
      await file.writeAsBytes(await pdf.save());
      print('PDF saved to ${file.path}');
    } catch (e) {
      print('Error saving PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final pdf = pw.Document();

    // Decode base64 encoded QR code image
    final Uint8List qrCodeImage = base64Decode(
      qrCode.substring('data:image/png;base64,'.length),
    );

    // Define content for PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: <pw.Widget>[
              pw.Text('Receipt Details', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 20),
              pw.Text('Full Name: $fullName'),
              pw.Text('Email Address: $emailAddress'),
              pw.Text('Subject: $subject'),
              pw.Text('Agency: $agency'),
              pw.Text('Currency: $currency'),
              pw.Text('Reason: $reason'),
              pw.Text('Phone Number: $phoneNumber'),
              pw.Text('Operation Number: $operationNumber'),
              pw.Text('Amount: $amount'),
              pw.Text('Date: $date'),
              pw.Text('Merchant Name: $merchantName'),
              // Display QR Code image
              if (qrCode.isNotEmpty) ...[
                pw.SizedBox(height: 20),
                pw.Image(
                  pw.MemoryImage(qrCodeImage),
                ),
              ],
              if (schoolSignature.isNotEmpty) ...[
                pw.SizedBox(height: 20),
                pw.Text('School Signature:'),
                pw.Image(pw.MemoryImage(base64Decode(schoolSignature))),
              ],
            ],
          ),
        ),
      ),
    );

    // Save the PDF and display a success message
    savePdf(pdf, context).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved successfully')),
      );
    });

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color(0xFF363f93),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Receipt PDF'),
          backgroundColor: Color(0xFF363f93),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Text(
            'PDF Generated',
            style: TextStyle(
                fontSize: 30,
                backgroundColor: Colors.white30,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}




// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, use_build_context_synchronously, avoid_web_libraries_in_flutter, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

// import 'dart:convert';
// import 'dart:typed_data';  // Import dart:typed_data for Uint8List
// import 'dart:html' as html; // import 'dart:html' as html;  // Import dart:html for web support
// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pw;

// class PdfPage extends StatelessWidget {
//   final String fullName;
//   final String emailAddress;
//   final String subject;
//   final String agency;
//   final String currency;
//   final String reason;
//   final String phoneNumber;
//   final String operationNumber;
//   final int amount;
//   final String date;
//   final String merchantName;
//   final String qrCode;
//   final String schoolSignature;

//   PdfPage({
//     required this.fullName,
//     required this.emailAddress,
//     required this.subject,
//     required this.agency,
//     required this.currency,
//     required this.reason,
//     required this.phoneNumber,
//     required this.operationNumber,
//     required this.amount,
//     required this.date,
//     required this.merchantName,
//     required this.qrCode,
//     required this.schoolSignature,
//   });

//   void downloadPdf(pw.Document pdf, BuildContext context) async {
//     try {
//       final bytes = await pdf.save();
//       final blob = html.Blob([bytes], 'application/pdf');
//       final url = html.Url.createObjectUrlFromBlob(blob);
//       html.AnchorElement(href: url)
//         ..setAttribute('download', 'receipt.pdf')
//         ..click();
//       html.Url.revokeObjectUrl(url);
//       print('PDF downloaded successfully');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('PDF downloaded successfully')),
//       );
//     } catch (e) {
//       print('Failed to download PDF: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to download PDF')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pdf = pw.Document();

//     Uint8List qrCodeImage;
//     try {
//       if (qrCode.startsWith('data:image/png;base64,')) {
//         qrCodeImage = base64Decode(qrCode.substring('data:image/png;base64,'.length));
//       } else {
//         qrCodeImage = base64Decode(qrCode);
//       }
//     } catch (e) {
//       print('Failed to decode QR code: $e');
//       qrCodeImage = Uint8List(0); // Use an empty Uint8List if decoding fails
//     }

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Center(
//           child: pw.Column(
//             mainAxisAlignment: pw.MainAxisAlignment.center,
//             children: <pw.Widget>[
//               pw.Text('Receipt Details', style: pw.TextStyle(fontSize: 20)),
//               pw.SizedBox(height: 20),
//               pw.Text('Full Name: $fullName'),
//               pw.Text('Email Address: $emailAddress'),
//               pw.Text('Subject: $subject'),
//               pw.Text('Agency: $agency'),
//               pw.Text('Currency: $currency'),
//               pw.Text('Reason: $reason'),
//               pw.Text('Phone Number: $phoneNumber'),
//               pw.Text('Operation Number: $operationNumber'),
//               pw.Text('Amount: $amount'),
//               pw.Text('Date: $date'),
//               pw.Text('Merchant Name: $merchantName'),
//               if (qrCodeImage.isNotEmpty) ...[
//                 pw.SizedBox(height: 20),
//                 pw.Image(pw.MemoryImage(qrCodeImage)),
//               ],
//               if (schoolSignature.isNotEmpty) ...[
//                 pw.SizedBox(height: 20),
//                 pw.Text('School Signature:'),
//                 pw.Image(pw.MemoryImage(base64Decode(schoolSignature))),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       downloadPdf(pdf, context);
//     });

//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.white,
//             Color(0xFF363f93),
//           ],
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: Text('Receipt PDF'),
//           centerTitle: true,
//           foregroundColor: Colors.white,
//         ),
//         body: Center(
//           child: Text('Generated PDF'),
//         ),
//       ),
//     );
//   }
// }
