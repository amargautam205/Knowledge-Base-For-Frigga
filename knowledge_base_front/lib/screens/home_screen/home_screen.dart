import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base_front/screens/create_document_screen/create_document_screen.dart';
import 'package:knowledge_base_front/screens/edit_document_screen/edit_document_screen.dart';
import 'package:knowledge_base_front/screens/login_screen/login_screen.dart';
import 'package:knowledge_base_front/screens/view_document_screen/view_document_screen.dart';
import 'package:knowledge_base_front/screens/home_screen/bloc/home_screen_bloc.dart';
import 'package:knowledge_base_front/screens/home_screen/bloc/home_screen_event.dart';
import 'package:knowledge_base_front/screens/home_screen/bloc/home_screen_state.dart';
import 'package:knowledge_base_front/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenBloc>().add(FetchDocumentsEvent());

    // Rebuild when search text changes (for suffix icon visibility)
    _searchController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // clear all stored data

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged out successfully")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Task By Frigga',
            style: AppTheme.headingTextStyle.copyWith(fontSize: 24),
          ),
          actions: [
            IconButton(
              iconSize: 35,
              icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateDocumentScreen(),
                  ),
                ).then((_) {
                  // Trigger re-fetch of documents
                  context.read<HomeScreenBloc>().add(FetchDocumentsEvent());
                });
                ;
              },
              tooltip: 'New Document',
            ),

            // 🔓 Logout Button
            IconButton(
              iconSize: 35,
              icon: const Icon(Icons.logout, color: Colors.red),
              onPressed: _logout,
              tooltip: 'Logout',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search documents...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            FocusScope.of(context).unfocus(); // close keyboard
                            context
                                .read<HomeScreenBloc>()
                                .add(FetchDocumentsEvent());
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    context.read<HomeScreenBloc>().add(
                          SearchDocumentsEvent(keyword: value.trim()),
                        );
                  }
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Documents",
                style: AppTheme.headingTextStyle.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                  builder: (context, state) {
                    if (state is HomeScreenLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HomeScreenUserFetchedSuccessState) {
                      final docs = state.documents;
                      if (docs.isEmpty) {
                        return const Center(
                            child: Text("No documents available."));
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 2,
                        ),
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ViewDocumentScreen(
                                    documentId: doc.id,
                                    title: doc.title,
                                    content: doc.content,
                                  ),
                                ),
                              ).then((_) {
                                // Trigger re-fetch of documents
                                context
                                    .read<HomeScreenBloc>()
                                    .add(FetchDocumentsEvent());
                              });
                              ;
                            },
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title and Edit button row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            doc.title,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme
                                                  .primaryButtonBackgroundColor,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              size: 16, color: Colors.grey),
                                          tooltip: "Edit Document",
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    EditDocumentScreen(
                                                        document: doc),
                                              ),
                                            ).then((_) {
                                              // Trigger re-fetch of documents
                                              context
                                                  .read<HomeScreenBloc>()
                                                  .add(FetchDocumentsEvent());
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "By: ${doc.authorEmail}",
                                      style: AppTheme.bodyTextStyle.copyWith(
                                        fontSize: 10,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Last Modify: ${doc.lastModifiedAt.split('T')[0]}",
                                      style: AppTheme.bodyTextStyle.copyWith(
                                        fontSize: 10,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: doc.isPublic
                                            ? AppTheme
                                                .primaryButtonBackgroundColor
                                                .withOpacity(0.1)
                                            : Colors.red.withOpacity(0.1),
                                        border: Border.all(
                                          color: doc.isPublic
                                              ? AppTheme
                                                  .primaryButtonBackgroundColor
                                              : Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.remove_red_eye,
                                            size: 12,
                                            color: doc.isPublic
                                                ? AppTheme
                                                    .primaryButtonBackgroundColor
                                                : Colors.red,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            doc.isPublic ? "Public" : "Private",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: doc.isPublic
                                                  ? AppTheme
                                                      .primaryButtonBackgroundColor
                                                  : Colors.red,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is HomeScreenErrorState) {
                      return Center(child: Text("Error: ${state.error}"));
                    } else {
                      return const Center(child: Text("Something went wrong."));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
