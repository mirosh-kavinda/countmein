import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:countmein/common/custom_form_button.dart';
import 'package:countmein/pages/home_page.dart';

class OrderSummary extends StatefulWidget {
  final String stealCount;
  final bool isMatched;
  final String id;

  const OrderSummary({
    Key? key,
    required this.stealCount,
    required this.isMatched,
    required this.id,
  }) : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  Future<void> updateStatus(String status) async {
    await FirebaseFirestore.instance
        .collection('USER_WORKORDERS')
        .doc(widget.id)
        .update({'status': status});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFEFF3F6),
        appBar: AppBar(
          title: Text('Order Summary'),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24.0),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (widget.isMatched == true)
                            const Icon(
                              Icons.verified_rounded,
                              color: Colors.black,
                              size: 170,
                              opticalSize: 1,
                            ),
                            if (widget.isMatched == false)
                            const Icon(
                              Icons.error_rounded,  
                              color: Colors.red,
                              size: 170,
                              opticalSize: 1,
                            ),
                            if (widget.stealCount != null)
                              Text(
                                '${widget.stealCount}',
                                style: const TextStyle(fontSize: 28),
                              ),
                            const SizedBox(height: 8),
                            Text(
                              'Is Matched: ${widget.isMatched}',
                              style: const TextStyle(fontSize: 28),
                            ),
                            const SizedBox(height: 24.0),
                            if (widget.isMatched == true)
                              CustomFormButton(
                                textSize: 15.0,
                                inputSize: 0.4,
                                onPressed: () async {
                                  await updateStatus('complete');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                },
                                innerText: 'Complete The Order',
                              ),
                            const SizedBox(height: 24.0),
                            if (widget.isMatched == false)
                              CustomFormButton(
                                textSize: 15.0,
                                inputSize: 0.4,
                                onPressed: () async {
                                  await updateStatus('hold');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                },
                                innerText: 'Report a Error',
                              ),
                            const SizedBox(height: 24.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
