import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF05046a),
        title: const Text('FAQ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              FAQItem(
                question: 'Q: How was this school project divided?',
                answer:
                'A: We have two distinct front-end applications: one for mobile and another for web. Meanwhile, the back-end is managed by a single team while a different team handles the IoT aspect of the project. Each team member is assigned based on their expertise and interests, taking responsibility for specific components of the project.',
              ),
              SizedBox(height: 16),
              FAQItem(
                question: 'Q: Who are the leaders of this school project?',
                answer:
                'A: The leaders of this school project are Adrian Auguis, John Ray Cañete, Niel Opeña and Mark Gaje. They provide guidance and oversee the progress of the project, ensuring that it stays on track and meets the objectives.',
              ),
             // Add more FAQItems as needed
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.question,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
            ],
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(widget.answer),
          ),
      ],
    );
  }
}
