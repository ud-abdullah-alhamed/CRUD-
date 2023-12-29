import 'package:desktopapp/constant/color.dart';
import 'package:desktopapp/model/form_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormWidget extends StatefulWidget {
  FormWidget({required this.formmodel, Key? key, required this.color})
      : super(key: key);
  FormModel formmodel;
  Color color;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 2)),
          ],
        ),
        child: TextFormField(
            onTap: widget.formmodel.onTap,
            readOnly: widget.formmodel.enableText,
            inputFormatters: widget.formmodel.inputFormat,
            keyboardType: widget.formmodel.type,
            onChanged: widget.formmodel.onChange,
            validator: widget.formmodel.validator,
            obscureText: widget.formmodel.invisible,
            controller: widget.formmodel.controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.color,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorConstants.secondaryScaffoldBacground),
                  borderRadius: const BorderRadius.all(Radius.circular(7))),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorConstants.secondaryScaffoldBacground),
                  borderRadius: const BorderRadius.all(Radius.circular(7))),
              hintText: widget.formmodel.hintText,
            )),
      ),
    );
  }
}
