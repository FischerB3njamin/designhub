import 'package:designhub/features/posts/provider/post_new_notifier.dart';
import 'package:designhub/features/posts/widgets/section_image.dart';
import 'package:designhub/features/posts/widgets/section_inputfields.dart';
import 'package:designhub/features/posts/widgets/section_overview.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewPostNotifier(context),
      child: Consumer<NewPostNotifier>(
        builder: (context, notifier, _) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: _buildAppBar(context, notifier),
              body: SafeArea(child: _buildBody(context, notifier)),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, NewPostNotifier notifier) {
    return AppBar(
      title: Text(notifier.currentPageTitle),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: notifier.isMetadataPage
            ? () => Navigator.of(context).pop()
            : notifier.goToPreviousPage,
      ),
    );
  }

  Widget _buildBody(BuildContext context, NewPostNotifier notifier) {
    if (notifier.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        if (notifier.currentPageDescription.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Text(
              notifier.currentPageDescription,
              style: CustomTextStyles.bodyLargeColorBold(
                  context, DesignhubColors.black87, FontWeight.normal),
              textAlign: TextAlign.left,
            ),
          ),
        if (notifier.hasError) const Text("Error occurred"),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PageView(
              controller: notifier.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                SectionInputfields(),
                SectionImage(),
                SectionOverview(),
              ],
            ),
          ),
        ),
        _buildFooter(context, notifier),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, NewPostNotifier notifier) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBackButton(context, notifier),
              _buildPageIndicators(notifier),
              _buildNextButton(context, notifier),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context, NewPostNotifier notifier) {
    return TextButton(
      onPressed: notifier.isMetadataPage ? null : notifier.goToPreviousPage,
      child: Text(
        notifier.isMetadataPage ? "" : "Back",
        style: CustomTextStyles.bodyLarge(context),
      ),
    );
  }

  Widget _buildPageIndicators(NewPostNotifier notifier) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: notifier.currentIndex == index
                  ? DesignhubColors.primary
                  : DesignhubColors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, NewPostNotifier notifier) {
    return TextButton(
      onPressed: () => notifier.goToNextPage(context),
      child: notifier.isUploading
          ? CircularProgressIndicator()
          : Text(
              notifier.isOverview ? "Submit" : "Next",
              style: CustomTextStyles.bodyLargeColorBold(
                  context, DesignhubColors.primary, FontWeight.bold),
            ),
    );
  }
}
