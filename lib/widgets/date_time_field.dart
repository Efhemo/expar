import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/utils/palette.dart';

class DateTimeField extends StatefulWidget {
  final String labelText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final FormFieldValidator<DateTime>? validator;
  final ValueChanged<DateTime?>? onChanged;

  const DateTimeField({
    Key? key,
    required this.labelText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  _DateTimeFieldState createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  DateTime? _selectedDate;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _updateControllerText();
  }

  @override
  void didUpdateWidget(covariant DateTimeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate) {
      _selectedDate = widget.initialDate;
      _updateControllerText();
    }
  }

  void _updateControllerText() {
    if (_selectedDate != null) {
      _controller.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    } else {
      _controller.text = '';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _updateControllerText();
      });
      widget.onChanged?.call(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: fillGrey,
              hintText: 'Select date',
              // errorText: errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: strokeGrey, width: 1),
              ),
              prefixIcon: const Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () => _selectDate(context),
            validator: (value) {
              if (widget.validator != null) {
                return widget.validator!(_selectedDate);
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
