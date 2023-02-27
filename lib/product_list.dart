

import 'package:flutter/material.dart';
import 'package:prueba_sqlite/models.dart';
import 'package:prueba_sqlite/shop_database.dart';

class ProductScreen extends StatelessWidget {
   
  
  var products=[
    Product(1, "Samsung A5_1", "Celular muy bonito", 150),
    Product(2, "Samsung A5_2", "Celular muy Medio", 250),
    Product(3, "Samsung A5_3", "Celular muy Maso", 350),
    Product(4, "Samsung A5_4", "Celular muy Bien", 450),
    ];

  ProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int  index){
        return GestureDetector(
          child: Container(
            
            color: Colors.blue,
            child: _ProductItem(products[index])),
            onTap: () async {
              await addToCart(products[index]);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Producto agregado!"),
                  duration: Duration(seconds: 1),
                ),
              );
            },
        );
      } ,
      separatorBuilder: (BuildContext context, int  index)=> const Divider(
        height: 5,
      ),
      itemCount: products.length);
    
    
  }
  
  Future<void> addToCart(Product product) async {
    final item = CartItem(
      id: product.id,
      name: product.name,
      price: product.price,
      quantity: 1,
    );
    await ShopDatabase.instance.insert(item);
  }
}

class _ProductItem extends StatelessWidget{
  final Product product;
 const _ProductItem( this.product);


@override
Widget build(BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Image.asset('assets/images/Samsung_A5.jpg',width: 100,),
        Padding(padding: EdgeInsets.only(right: 3,left: 3)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(product.name),
          Text(product.description),
          Text("\$"+product.price.toString()),
        ],)
      ],
    ),
  );
}
}
