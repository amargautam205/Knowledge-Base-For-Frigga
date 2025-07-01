import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ViewDocumentScreen extends StatelessWidget {
  final int documentId;
  final String title;
  final String content;

  const ViewDocumentScreen({
    Key? key,
    required this.documentId,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quill.QuillController _controller = quill.QuillController(
      document: quill.Document.fromJson(jsonDecode(content)),
      selection: const TextSelection.collapsed(offset: 0),
    );
    final FocusNode _focusNode = FocusNode();
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Document #$documentId'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: quill.QuillEditor(
                  configurations: quill.QuillEditorConfigurations(
                    controller: _controller,
                    scrollable: true,
                    autoFocus: false,
                    expands: true,
                    padding: EdgeInsets.zero,
                  ),
                  scrollController: _scrollController,
                  focusNode: _focusNode,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;

// class ViewDocumentScreen extends StatelessWidget {
//   final int documentId;

//   const ViewDocumentScreen({Key? key, required this.documentId})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Sample data for demo purpose. Replace this with data from API.
//     final String title = "Sample Document Title #$documentId";
//     final quill.QuillController _controller = quill.QuillController(
//       document: quill.Document.fromJson([
//         {"insert": "This is the content of Document #$documentId\n"}
//       ]),
//       selection: const TextSelection.collapsed(offset: 0),
//     );
//     final FocusNode _focusNode = FocusNode();
//     final ScrollController _scrollController = ScrollController();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Document #$documentId'),
//         backgroundColor: Colors.blue.shade600,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Divider(height: 24),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: quill.QuillEditor(
//                   configurations: quill.QuillEditorConfigurations(
//                     controller: _controller,
//                     scrollable: true,
//                     autoFocus: false,
//                     expands: true,
//                     padding: EdgeInsets.zero,
//                   ),
//                   scrollController: _scrollController,
//                   focusNode: _focusNode,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
