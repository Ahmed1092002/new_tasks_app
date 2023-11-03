import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  String? hint;
  IconData? icon;
  TextEditingController? controller;
   CustomTextField({Key? key,this.hint ='',this.icon,this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
showCursor: true,
enabled: true,
          toolbarOptions: ToolbarOptions(
            copy: true,
            cut: true,
            paste: true,
            selectAll: true,
          ),



          validator: (value)
          {
  if(value!.isEmpty){
    return 'this field must not be empty';
  }
  if (hint == 'email') {
    if(!value.contains('@')){
      return 'this field must be a valid email';
    }
  }
  return null;
},
        decoration: InputDecoration(
        prefixIcon:icon != null ? Icon(icon) : null,
          hintText: hint,
          label: Text(hint!),
          border: OutlineInputBorder(
borderRadius: BorderRadius.circular(20)
          )
        )
      ),
    );
  }
}
