import 'dart:io';

import 'package:flutter/material.dart';

import 'package:palette_generator/palette_generator.dart';

class ProductDetails extends StatefulWidget {
  String name;
  String price;
  String image;
  String description;

  ProductDetails(
      {super.key,
      required this.description,
      required this.image,
      required this.name,
      required this.price});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  getMainColor() async {
    final image = Image.network(widget.image);
    final palette = await PaletteGenerator.fromImageProvider(image.image);
    return palette.dominantColor!.color;
  }

  late var bgColor =Colors.white;

  
  _getMainColor() async {
    bgColor = await getMainColor();
    print(bgColor);
  }

  List<Color> _colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow];
  int _currentIndex = 0;
  bool isFavourite = false;

  late int quantity = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    print(height);
    var width = size.width;
 print(width);
    return FutureBuilder(
        future: _getMainColor(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:

            case ConnectionState.active:
            case ConnectionState.waiting:
              
            case ConnectionState.done:
              if (snapshot.hasError) {
                if (snapshot.error.toString() ==
                    'Exception: Failed to load album') {
                  return Text('No user found');
                } else {
                  return Text('Error: ${snapshot.error}');
                }
              }

              return SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: bgColor,
                    bottomOpacity: 0.0,
                    elevation: 0.0,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  body: Stack(children: [
                    
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: height * .32,
                              color: bgColor,
                              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Text('${widget.name}',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500,color: Colors.white),),
                                  ), SizedBox(height: 160,),
                                  Padding(
                                    padding: const EdgeInsets.only(left:25.0),
                                    child: Row( 
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Price",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white),),
                                            Text("₹ ${widget.price}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.white),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                              SizedBox(height: 25,),
                          Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text('Color'),
                                    ),
                                    SizedBox(
                                        height: height*0.057,
                                        width: width*.51,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _colors.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _currentIndex = index;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(8.0),
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: _colors[index],
                                                      border: _currentIndex ==
                                                              index
                                                          ? Border.all(
                                                              width: 3.0,
                                                              color: Colors.white)
                                                          : null),
                                                ),
                                              );
                                            })),
                                  ],
                                ),SizedBox(width: width*.15,),
                                Column(
                                  children: [
                                    Text('Size'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('12 cm',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('${widget.description}',textAlign: TextAlign.left,),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width*0.45,
                                height: height*.057,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FloatingActionButton(
                                       heroTag: null,
                                        onPressed: () {
                                          setState(() {
                                            if (quantity > 0) quantity--;
                                          });
                                        },
                                        child: Icon(Icons.remove,
                                            color: Colors.black87),
                                        backgroundColor: Colors.white),
                                    Text(quantity.toString()),
                                    FloatingActionButton(
                                       heroTag: null,
                                      child: Icon(Icons.add,
                                          color: Colors.black87),
                                      backgroundColor: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 25.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isFavourite = !isFavourite;
                                    });
                                  },
                                  child: Icon(
                                    isFavourite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavourite ? Colors.red : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  width: width * .18,
                                  height: height * .08,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Icon(Icons.shopping_cart,
                                        color: Colors.black87),
                                  )),
                              Container(
                                  width: width * .6,
                                  height: height * .08,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 44, 69, 151),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Buy Now",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Positioned( top: 20, right: 20,
                      bottom: 350,
                      child: Container(
                          height: height * .25,
                          width: width * 0.6,
                          child: Image.network('${widget.image}')),
                    ),
                  ]),
                ),
              );
          }
        });
  }
}
