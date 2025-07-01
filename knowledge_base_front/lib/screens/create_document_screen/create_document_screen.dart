import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:knowledge_base_front/screens/create_document_screen/bloc/create_document_screen_bloc.dart';
import 'package:knowledge_base_front/screens/create_document_screen/bloc/create_document_screen_event.dart';
import 'package:knowledge_base_front/screens/create_document_screen/bloc/create_document_screen_state.dart';

class CreateDocumentScreen extends StatelessWidget {
  const CreateDocumentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateDocumentScreenBloc(),
      child: const _CreateDocumentBody(),
    );
  }
}

class _CreateDocumentBody extends StatefulWidget {
  const _CreateDocumentBody({Key? key}) : super(key: key);

  @override
  State<_CreateDocumentBody> createState() => _CreateDocumentBodyState();
}

class _CreateDocumentBodyState extends State<_CreateDocumentBody> {
  final TextEditingController _titleController = TextEditingController();
  final quill.QuillController _quillController = quill.QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _isPublic = false;

  void _onSavePressed() {
    final title = _titleController.text.trim();
    final content = jsonEncode(_quillController.document.toDelta().toJson());

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title cannot be empty')),
      );
      return;
    }

    context.read<CreateDocumentScreenBloc>().add(
          CreateDocumentButtonPressed(
            title: title,
            content: content,
            isPublic: _isPublic,
          ),
        );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Document'),
        actions: [
          BlocBuilder<CreateDocumentScreenBloc, CreateDocumentScreenState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.save),
                onPressed: state is CreateDocumentScreenLoading
                    ? null
                    : _onSavePressed,
              );
            },
          )
        ],
      ),
      body: BlocListener<CreateDocumentScreenBloc, CreateDocumentScreenState>(
        listener: (context, state) {
          if (state is CreateDocumentScreenSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Document created successfully")),
            );
            Navigator.pop(context); // or redirect to document list
          } else if (state is CreateDocumentScreenFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter Document Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text("Make this document public"),
                value: _isPublic,
                onChanged: (value) {
                  setState(() {
                    _isPublic = value;
                  });
                },
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
      ),
    );
  }
}
