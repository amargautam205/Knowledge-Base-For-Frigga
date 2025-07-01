import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:knowledge_base_front/model/DocumentModel.dart';
import 'package:knowledge_base_front/repository/api_repository.dart';
import 'package:knowledge_base_front/utils/api_const.dart';

class EditDocumentScreen extends StatefulWidget {
  final DocumentModel document;

  const EditDocumentScreen({Key? key, required this.document})
      : super(key: key);

  @override
  State<EditDocumentScreen> createState() => _EditDocumentScreenState();
}

class _EditDocumentScreenState extends State<EditDocumentScreen> {
  late TextEditingController _titleController;
  late quill.QuillController _quillController;
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.document.title);
    _quillController = quill.QuillController(
      document: quill.Document.fromJson(jsonDecode(widget.document.content)),
      selection: const TextSelection.collapsed(offset: 0),
    );

    _quillController.addListener(_onContentChanged);
    _titleController.addListener(_onContentChanged);
  }

  void _onContentChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      _autoSave();
    });
  }

  Future<void> _autoSave() async {
    final updatedTitle = _titleController.text.trim();
    final updatedContent =
        jsonEncode(_quillController.document.toDelta().toJson());

    if (updatedTitle.isEmpty) return;

    try {
      await ApiRepository.putAPI(
        endpoint: "${ApiConst.updateDocument}/${widget.document.id}",
        data: {
          "title": updatedTitle,
          "content": updatedContent,
          "is_public": widget.document.isPublic, // no toggle here yet
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Document auto-saved")),
      );
    } catch (e) {
      print("Auto-save failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Auto-save failed: $e")),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Document"),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Document Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            quill.QuillToolbar.simple(
              configurations: quill.QuillSimpleToolbarConfigurations(
                controller: _quillController,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: quill.QuillEditor(
                  configurations: quill.QuillEditorConfigurations(
                    controller: _quillController,
                    scrollable: true,
                    autoFocus: true,
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
