import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class dropDownMenu extends StatefulWidget {
  const dropDownMenu({Key? key}) : super(key: key);

  @override
  State<dropDownMenu> createState() => _dropDownMenuState();
}

class _dropDownMenuState extends State<dropDownMenu> {

  String _dropDownValue = 'S';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: null,
        icon: Icon(Icons.arrow_drop_down , size: 5.h,color: Colors.white70,),
        elevation: 16,
        isExpanded: true,
        dropdownColor: Color(0xFF171725),

        style: TextStyle(color: Colors.white70, fontSize: 18.sp),

      underline: Container(

        height: 0.05.h,
        color: Colors.white,
      ),

      hint: Text(
          "Size",
        style: TextStyle(
          color: Colors.white70
        ),
      ),



      items: <String> ['S', 'M', 'L'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),


        onChanged: (String? newValue){
        setState(() {
          _dropDownValue= newValue!;
        });


        }

    );
  }
}
