import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  //este atributo sera importante para o novo usuario
  final TextInputType inputType;
  final String label;
  final String hint;
  final Icon icon;
  final bool isSecret;

  const CustomFormField({
    Key? key,
    required this.inputType,
    required this.label,
    required this.hint,
    required this.icon,
    this.isSecret = false, //atributo opcional
  }) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        obscureText: isObscure,
        keyboardType: widget.inputType,
        //aqui vem o controller
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: widget.icon,
          suffixIcon: widget
                  .isSecret // este atributo não é alterando no contrutor
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off))
              : null,
          label: Text(widget.label),
          hintText: widget.hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        ),
      ),
    );
  }
}
