
  import 'dart:convert';
import 'dart:developer';

  import 'package:http/http.dart' as http;

  List<dynamic> products = [];
  

  getProducts() async {
    var response = await http.get(Uri.parse(
        'http://174.138.121.52:3009/v1/product/getAllProduct'));
    if (response.statusCode == 200) {
       products = jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to load products");
    }
  }