import 'package:designhub/features/design_sos/provider/design_sos_notifier.dart';
import 'package:designhub/features/home/provider/home_notifier.dart';
import 'package:designhub/features/home/widgets/section_switcher.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SosView extends StatefulWidget {
  const SosView({super.key});

  @override
  State<SosView> createState() => _SosViewState();
}

class _SosViewState extends State<SosView> {
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DesignSosNotifier>().loadInitialData();
    });
  }

  void _onScroll() {
    final homeNotifier = context.read<HomeNotifier>();
    final currentItem = _scrollController.selectedItem;

    if (currentItem >= (homeNotifier.posts.length) - 3 &&
        !homeNotifier.isLoadingMore) {
      homeNotifier.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final designSosNotifier = context.watch<DesignSosNotifier>();

    if (designSosNotifier.hasError) {
      return Center(child: Text(designSosNotifier.error ?? "Unknown error"));
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _sectionHeader(),
            _sectionSubheadline(),
            SectionSwitcher(
              activeTab: designSosNotifier.activeTab,
              onTabChanged: (index) =>
                  designSosNotifier.handleSectionSwitch(index),
            ),
            const SizedBox(height: 8),
            if (designSosNotifier.isLoading &&
                (designSosNotifier.sosData.isEmpty))
              const Center(child: CircularProgressIndicator()),
            ...designSosNotifier.getPostWidgets(context),
            if (designSosNotifier.isLoadingMore)
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              )),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader() => Padding(
        padding:
            const EdgeInsets.only(bottom: 8.0, right: 16, left: 16, top: 16),
        child: Text("Unblock Your Creativity. Fast",
            style:
                CustomTextStyles.headlineSmallBold(context, FontWeight.bold)),
      );
  Widget _sectionSubheadline() => Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 16, left: 16),
        child: Text(
          "Share Your Design Dilemma and Get Solutions from Fellow Designers.",
          style: CustomTextStyles.bodyMedium(context),
        ),
      );
}
