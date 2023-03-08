import 'package:flutter/material.dart';

class ProductCustomWidget extends StatefulWidget {
  const ProductCustomWidget({
    Key? key,
    this.width,
    this.height,
    this.name,
    this.price,
    this.image,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? name;
  final int? price;
  final String? image;

  @override
  _ProductCustomWidgetState createState() => _ProductCustomWidgetState();
}

class _ProductCustomWidgetState extends State<ProductCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 200,
        width: 300,
        color: Colors.grey,
        child: Row(children: [
          Stack(
            children: [
              Container(
                height: 120,width: 100,
                // child: Image.network(
                //     ,fit: BoxFit.cover,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage('https://plus.unsplash.com/premium_photo-1669226092193-e907513b3383?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDE4NXx4alBSNGhsa0JHQXx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60'),fit: BoxFit.cover)
              ),
              ),
              Positioned(
                  top: 12,right: 6,
                  child: Container(
                decoration: BoxDecoration(color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.favorite,color: Colors.red,),
              ))
            ],
          ),
          Column(children: [
            Text('widget.name'),
            Text('By Setto'),
            Text('Ergnomical for humans body curve'),
            Row(children: [
              Text('\$${widget.price}.00'),
              SizedBox(width: 10),
              Container(
                width: 50,
                height: 20,
                child: Text('Buy'),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  gradient: LinearGradient(
                      colors: [Colors.amber, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      offset: Offset(10, 20),
                      blurRadius: 30,
                    )
                  ],
                ),
              ),
            ])
          ])
        ]));
  }
}