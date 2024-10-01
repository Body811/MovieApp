import 'package:flutter/material.dart';


class OtpField extends StatefulWidget {
  const OtpField({super.key});

  @override
  OtpFieldState createState() => OtpFieldState();
}

class OtpFieldState extends State<OtpField> {
  List<TextEditingController> controllers =
  List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  List<Color> borderColors = List.generate(4, (index) => Colors.grey);

  void _updateBorderColor(int index) {
    setState(() {
      borderColors[index] =
      controllers[index].text.isNotEmpty ? Colors.green : Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 65,
          child: TextFormField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: borderColors[index]),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              _updateBorderColor(index);
              if (value.isNotEmpty && index < 3) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }
            },
          ),
        );
      }),
    );
  }
}
