import 'package:designhub/features/chat/provider/chat_notifier.dart';
import 'package:designhub/features/chat/widgets/empty_view.dart';
import 'package:designhub/features/chat/widgets/error_view.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/features/chat/view/chat_item_view.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  final bool isSmallView;

  const ChatView({super.key, required this.isSmallView});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final Profile currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = context.read<CurrentProfileNotifier>().getProfile();
    Future.microtask(() {
      if (mounted) {
        context.read<ChatNotifier>().init(currentUser.userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatNotifier = context.watch<ChatNotifier>();

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 16.0, vertical: widget.isSmallView ? 0 : 24),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          Expanded(child: _buildChatListView(context, chatNotifier)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        _buildTitle(context),
        const Spacer(),
        _buildHeaderActionButton(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      "Chats",
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildHeaderActionButton(BuildContext context) {
    return widget.isSmallView
        ? _buildViewAllButton(context)
        : _buildCloseButton();
  }

  Widget _buildViewAllButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        CustomBottomSheet.show(
          context,
          const ChatView(isSmallView: false),
          1,
        );
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: DesignhubColors.primary),
      ),
      child: Text(
        "View all",
        style: CustomTextStyles.labelLargeColorBold(
            context, DesignhubColors.primary, FontWeight.w600),
      ),
    );
  }

  Widget _buildCloseButton() {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.close),
    );
  }

  Widget _buildChatListView(BuildContext context, ChatNotifier chatNotifier) {
    if (chatNotifier.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (chatNotifier.hasError) {
      return ErrorView(
        message: chatNotifier.error ?? 'Unknown error',
        onRetry: () => chatNotifier.init(currentUser.userId),
      );
    }

    if (chatNotifier.data.keys.isEmpty) return const EmptyView();

    return ListView.builder(
      itemCount: chatNotifier.data.length,
      itemBuilder: (context, index) {
        final key = chatNotifier.data.keys.toList()[index];
        final data = chatNotifier.data[key]!;
        return ChatItemView(
          chat: data['chat'],
          senderProfile: data['profile'],
          isUnread: data['chat'].unread,
        );
      },
    );
  }
}
