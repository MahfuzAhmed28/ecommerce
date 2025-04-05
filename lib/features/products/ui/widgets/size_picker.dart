import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.sizes, required this.onChange});

  final List<String> sizes;
  final Function(String) onChange;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {

  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size',style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600
        ),),
        SizedBox(height: 8,),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.sizes.length,
            itemBuilder: (context,index){
              String size=widget.sizes[index];
              return GestureDetector(
                onTap: (){
                  selectedSize=size;
                  setState(() {});
                },
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: selectedSize==size ? AppColors.themeColor :null,
                  ),
                  child: Text(size,style: TextStyle(
                    color: selectedSize==size ? Colors.white :null,
                  ),),
                  alignment: Alignment.center,
                ),
              );
            }
          ),
        )
      ],
    );
  }
}
