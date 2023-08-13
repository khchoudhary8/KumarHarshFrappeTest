import 'package:flutter/material.dart';

class DepositedConfirmation extends StatefulWidget {
  String operation;

  DepositedConfirmation({
    Key? key,
    required this.operation,
  }) : super(key: key);

  @override
  State<DepositedConfirmation> createState() => _DepositedConfirmationState();
}

class _DepositedConfirmationState extends State<DepositedConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 10000,
        leading: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black87,
                ),
                onPressed: () => {Navigator.of(context).pop()},
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              './assets/confirmation_item.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            "Data Imported successfully",
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, color: Colors.teal),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Count: ${widget.operation.toLowerCase()}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              child: const Text(
                'Go back',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: Colors.blue, width: 1)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
