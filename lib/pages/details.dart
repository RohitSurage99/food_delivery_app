import 'package:flutter/material.dart';
import 'package:fooddeliveryapp2/service/database.dart';

import '../service/shared_pref.dart';
import '../widget/widget_support.dart';

class Details extends StatefulWidget {
  final String? image;
  final String? name;
  final String? description;
  final String? price;
  const Details({super.key, required this.image, required this.name, required this.description, required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1;
  int total = 0;
  
  @override
  void initState() {
    total = int.parse(widget.price.toString()??"");
    getSharePref();
    super.initState();
  }

  String? id;

  getSharePref() async{
     id = await SharedPreferenceHelper().getUserId();
     setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                )),
            Image.network(
              widget.image??"",
              // "images/salad2.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mediterranean",
                      style: AppWidget.semiBoldTextFeildStyle(),
                    ),
                    Text(
                      widget.name??"",
                      // "Chickpea Salad",
                      style: AppWidget.boldTextFeildStyle(),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;
                      total = total - int.parse(widget.price.toString()??"");
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  a.toString(),
                  style: AppWidget.semiBoldTextFeildStyle(),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    ++a;
                    total = total + int.parse(widget.price.toString()??"");
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
           const SizedBox(height: 20.0,),
            Text(
              widget.description??"",
              maxLines: 4,
              style: AppWidget.LightTextFeildStyle(),
            ),
            const SizedBox(height: 30.0,),
            Row(children: [
              Text("Delivery Time", style: AppWidget.semiBoldTextFeildStyle(),),
               const SizedBox(width: 25.0,),
              const Icon(Icons.alarm, color: Colors.black54,),
              const SizedBox(width: 5.0,),
              Text("30 min", style: AppWidget.semiBoldTextFeildStyle(),)
            ],),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Total Price", style: AppWidget.semiBoldTextFeildStyle(),),
                   Text("\$$total", style: AppWidget.HeadlineTextFeildStyle(),)
                ],),
                InkWell(
                  onTap: (){
                    Map<String, dynamic>addFoodToCart = {
                      "name" : widget.name ?? '',
                      "image" : widget.image ??"",
                      "description" : widget.description??'',
                      "price" : widget.price??'',
                      "total_price" : total ?? '',
                      "quantity" : a ?? '',
                    };
                     DatabaseMethods().addToCart(addFoodToCart, id??"");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "Item is added in cart!",
                          style: TextStyle(fontSize: 18.0, color: Colors.green),
                        )));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      const Text("Add to cart", style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'Poppins'),),
                      const SizedBox(width: 30.0,),
                      Container(

                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.grey, borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Icon(Icons.shopping_cart_outlined, color: Colors.white,),
                      ),
                       const SizedBox(width: 10.0,),
                    ],),
                  ),
                )
              ],),
            )
          ],
        ),
      ),
    );
  }
}
