import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'question': "faq_q1".tr(),
        'answer': "faq_a1".tr(),
      },
      {
        'question': "faq_q2".tr(),
        'answer': "faq_a2".tr(),
      },
      {
        'question': "faq_q3".tr(),
        'answer': "faq_a3".tr(),
      },
      {
        'question': "faq_q4".tr(),
        'answer': "faq_a4".tr(),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text("faq_title".tr())),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return ExpansionTile(
            leading: const Icon(Icons.help_outline, color: Colors.blueAccent),
            title: Text(faq['question']!),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faq['answer']!),
              ),
            ],
          );
        },
      ),
    );
  }
}
