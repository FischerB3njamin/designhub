import 'package:designhub/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Privacy',
          style: CustomTextStyles.titleMediumBold(context, FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Conditions',
              style: CustomTextStyles.titleLargeBold(context, FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              '1. Scope\n'
              'These terms apply to the use of the app "designhub". By using the app, you agree to these conditions.\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '2. Subject Matter\n'
              'designhub provides a platform for creative exchange and sharing of design content. Usage is subject to these terms.\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '3. Use of the App\n'
              '- The app is free to use.\n'
              '- No illegal, offensive, or harmful content may be uploaded.\n'
              '- Misuse of the app is prohibited.\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '4. Registration and Account\n'
              'Some features require registration. You must provide accurate information.\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '5. User Content\n'
              'Users are solely responsible for their content. designhub reserves the right to review and remove content if necessary.\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '6. Liability\n'
              'designhub is not liable for damages resulting from the use of the app, except in cases of intent or gross negligence.\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '7. Modifications\n'
              'We reserve the right to update these terms at any time. You will be informed of significant changes.\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '8. Governing Law\n'
              'German law applies. The place of jurisdiction, where permitted, is the location of Benjamin Fischer.\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            const SizedBox(height: 24),
            Text(
              'Privacy Policy',
              style: CustomTextStyles.titleLargeBold(context, FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              '1. Responsible Party\n'
              'Benjamin Fischer\n'
              'info@designhub.de\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '2. Data Collected\n'
              '- User data during registration (e.g., name, email)\n'
              '- Usage data (e.g., activity within the app)\n'
              '- Device information (e.g., operating system)\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '3. Purpose of Processing\n'
              '- To provide app functionality\n'
              '- To improve our services\n'
              '- To contact users when necessary\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '4. Data Sharing\n'
              'No data is shared with third parties unless legally required or necessary to fulfill the service.\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '5. Storage Duration\n'
              'Data is stored only as long as necessary for the purpose or as required by law.\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '6. Your Rights\n'
              '- Access to your stored data\n'
              '- Correction of incorrect data\n'
              '- Deletion of your data\n'
              '- Restriction of processing\n'
              '- Data portability\n'
              '- Objection to data processing\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            Text(
              '7. Contact for Data Protection\n'
              'Email: info@designhub.de\n',
              style: CustomTextStyles.bodyMedium(context),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
