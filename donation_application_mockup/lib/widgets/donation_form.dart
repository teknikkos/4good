import 'package:flutter/material.dart';

class DonationForm extends StatefulWidget {
  final Function(String, double) onSubmit;

  const DonationForm({super.key, required this.onSubmit});

  @override
  _DonationFormState createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _amount = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Make a Donation'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => _name = value,
              validator: (value) => value!.isEmpty ? 'Enter your name' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _amount = double.tryParse(value) ?? 0,
              validator: (value) => (double.tryParse(value!) ?? 0) > 0
                  ? null
                  : 'Enter a valid amount',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSubmit(_name, _amount);
            }
          },
          child: const Text('Donate'),
        ),
      ],
    );
  }
}
