import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:designhub/features/search/provider/search_notifer.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchNotifier = context.watch<SearchNotifier>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Search')),
        body: searchNotifier.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildSegmentedButton(searchNotifier),
                    const SizedBox(height: 12),
                    _buildSearchField(searchNotifier),
                    const SizedBox(height: 10),
                    _buildSearchResults(searchNotifier),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSegmentedButton(SearchNotifier searchNotifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SegmentedButton(
        showSelectedIcon: false,
        onSelectionChanged: (newSelection) =>
            searchNotifier.changePage(newSelection),
        emptySelectionAllowed: true,
        selected: {searchNotifier.selectedTab},
        segments: const [
          ButtonSegment(value: "Post", label: Text("Post")),
          ButtonSegment(value: "SOS", label: Text("SOS")),
          ButtonSegment(value: "Person", label: Text("Person")),
        ],
      ),
    );
  }

  Widget _buildSearchField(SearchNotifier searchNotifier) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search...',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: DesignhubColors.grey100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: DesignhubColors.grey400),
        ),
      ),
      onChanged: (value) => searchNotifier.updateQuery(value),
    );
  }

  Widget _buildSearchResults(SearchNotifier searchNotifier) {
    if (!searchNotifier.hasResults()) {
      return const SizedBox.shrink();
    }

    return searchNotifier.isPerson
        ? Expanded(
            child: GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 16,
              children: [...searchNotifier.getWidgets()],
            ),
          )
        : Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [...searchNotifier.getWidgets()],
              ),
            ),
          );
  }
}
