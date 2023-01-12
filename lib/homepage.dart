import 'package:flutter/material.dart';
import 'package:touchworld_project/api.dart';
import 'package:touchworld_project/product_details.dart';
import 'package:touchworld_project/producttile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
elevation: 0.0,
        leading: IconButton(
          color: Colors.black54,
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black54,
            ),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.06),
          child: Container(
            width: double.infinity,
            height: height * .09,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Women',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: height * 0.02,
                      child: Row(
                        children: <Widget>[
                          const Text(
                            'Hand bag',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 40.0),
                          const Text(
                            'Jewellery',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 40.0),
                          const Text(
                            'Footwear',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 40.0),
                          const Text(
                            'Dress',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 40.0),
                          const Text(
                            'Hand bag',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start');
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
                }
              }
              return GridView.builder(
                padding: const EdgeInsets.all(1),
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.4,
                ),
                itemBuilder: (context, index) {
                  var productname=products[index]['name'].toUpperCase();
                  return ProductItemTile(
                    itemName: productname,
                    itemPrice: products[index]['price'],
                    imagePath: products[index]['image'],
                    onPressed: () {
                      var name = products[index]['name'].toUpperCase();
                      var price = products[index]['price'];
                      var image = products[index]['image'];
                      var descrption = products[index]['description'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                              description: '${descrption}',
                              image: '${image}',
                              name: '${name}',
                              price: '${price}'),
                        ),
                      );
                    },
                  );
                },
              );
          }
        },
      ),
    );
  }
}
