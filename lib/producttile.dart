import 'dart:math';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ProductItemTile extends StatefulWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;

  void Function()? onPressed;

  ProductItemTile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  State<ProductItemTile> createState() => _ProductItemTileState();
}

class _ProductItemTileState extends State<ProductItemTile> {
   bool isBgColorSet = false;
  
  getColor() async {
    final image = Image.network(widget.imagePath);
    final palette = await PaletteGenerator.fromImageProvider(image.image);
    return palette.dominantColor!.color;
}
late var bgColor = Colors.white;
late var imagecolor ;




  _getColor() async {
    bgColor = await getColor();
    print(bgColor);
  }

  @override
  Widget build(BuildContext context) {
    final _random = Random();
   
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
     return FutureBuilder(
        future: _getColor(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:

            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                if (snapshot.error.toString() ==
                    'Exception: Failed to load album') {
                  return Text('No user found');
                } else {
                  return Text('Error: ${snapshot.error}');
                }}
          
              }
    return InkWell(
      onTap: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // item image

              Container(
                height: height*0.177,
                width: width*.45,
                decoration: BoxDecoration(
                  color: bgColor,

                      
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(
                  widget.imagePath,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(
                height: 20,
              ),
              // item name
              Padding(
                padding: const EdgeInsets.only(left:1.0),
                child: Text(
                  widget.itemName,textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,color: Colors.grey[600]
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '\₹' + widget.itemPrice,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );}
     );
  }}
    
  

