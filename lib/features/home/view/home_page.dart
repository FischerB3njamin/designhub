import 'package:designhub/features/home/provider/home_notifier.dart';
import 'package:designhub/features/home/widgets/section_header.dart';
import 'package:designhub/features/home/widgets/section_switcher.dart';
import 'package:designhub/shared/widgets/empty_posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final homeNotifier = context.read<HomeNotifier>();

    if (_scrollController.position.atEdge) {
      // Check if we're at the bottom
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final currentItem = homeNotifier.posts.length;

        if (currentItem >= (homeNotifier.posts.length) - 3 &&
            !homeNotifier.isLoadingMore) {
          homeNotifier.loadMore();
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    final homeNotifier = context.read<HomeNotifier>();
    await homeNotifier.resetAndLoadData(); // Reset the UI and reload the data
  }

  @override
  Widget build(BuildContext context) {
    final homeNotifier = context.watch<HomeNotifier>();

    if (homeNotifier.hasError) {
      return Center(child: Text(" ${homeNotifier.error ?? 'Unknown error'}"));
    }

    return SafeArea(
      child: Column(
        children: [
          const SectionHeader(),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RefreshIndicator(
                onRefresh: _onRefresh, // Trigger the refresh logic
                child: ListView(
                  controller: _scrollController, // Use a ScrollController
                  children: [
                    SectionSwitcher(
                      activeTab: homeNotifier.activeTab,
                      onTabChanged: (index) =>
                          homeNotifier.handleSectionSwitch(index),
                    ),
                    const SizedBox(height: 8),
                    if (homeNotifier.isLoading && homeNotifier.posts.isEmpty)
                      const Center(child: CircularProgressIndicator()),
                    ...homeNotifier.getPostWidgets(),
                    if (homeNotifier.isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (homeNotifier.posts.isEmpty && !homeNotifier.isLoading)
                      EmptyPosts(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
