import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp2/service/database.dart';
import '../service/shared_pref.dart';
import '../widget/widget_support.dart';
import 'details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;

  Stream? foodItemStream;

onTheLoad () async {
  foodItemStream = await DatabaseMethods().getFoodItem("Burger");
  setState(() {});
}

  String? userName;

  getSharePref() async{
    userName = await SharedPreferenceHelper().getUserName();
    setState(() {});
  }
@override
  void initState() {
  onTheLoad();
  getSharePref();
    super.initState();
  }

  Widget allItems (){
  return StreamBuilder(stream: foodItemStream, builder: (context, AsyncSnapshot snapshot){
    var screenH = MediaQuery.of(context).size.height;
    var screenW = MediaQuery.of(context).size.width;
    return snapshot.hasData? ListView.builder(
      padding: EdgeInsets.zero,
        itemCount : snapshot.data.docs.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          DocumentSnapshot ds = snapshot.data.docs[index];
          return  GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Details(image : ds["Image"]??"", name: ds["Name"]??"", description:ds["Full_Description"]??"", price:ds["Price"]??""))),
            child: Container(
              margin: EdgeInsets.all(4),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(14),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              ds["Image"],
                              // "images/salad2.png",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          ds['Name'],
                            //"Veggie Taco Hash",
                            style: AppWidget.semiBoldTextFeildStyle()),
                        SizedBox(
                          height: 5.0,
                        ),
                        SizedBox(
                          width: screenW/3.0,
                          child: Text(
                              ds['Full_Description'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              // "Fresh and Healthy",
                              style: AppWidget.LightTextFeildStyle()),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "\$ ${ds['Price']}",
                          style: AppWidget.semiBoldTextFeildStyle(),
                        )
                      ]),
                ),
              ),
            ),
          );
    }): const CupertinoActivityIndicator();
  });
  }

  Widget allItemsVertically (){
  return StreamBuilder(stream: foodItemStream, builder: (context, AsyncSnapshot snapshot){
    return snapshot.hasData? ListView.builder(
      padding: EdgeInsets.zero,
        itemCount : snapshot.data.docs.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        itemBuilder: (context, index){
          DocumentSnapshot ds = snapshot.data.docs[index];
          return Container(
            margin: EdgeInsets.only(right: 20.0,bottom: MediaQuery.of(context).size.height/40.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        ds["Image"],
                        // "images/salad4.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    Column(children: [
                      Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            ds["Name"],
                            // "Mediterranean Chickpea Salad",
                            style: AppWidget.semiBoldTextFeildStyle(),)),
                      SizedBox(height: 5.0,),
                      Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            ds["Full_Description"],
                            // "Honey goot cheese",
                            style: AppWidget.LightTextFeildStyle(),)),
                      SizedBox(height: 5.0,),
                      Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Text("\$${ds["Price"]}", style: AppWidget.semiBoldTextFeildStyle(),))
                    ],)
                  ],
                ),
              ),
            ),
          );
    }): const CupertinoActivityIndicator();
  });
  }

  @override
  Widget build(BuildContext context) {
  var screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello $userName,", style: AppWidget.boldTextFeildStyle()),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Delicious Food", style: AppWidget.HeadlineTextFeildStyle()),
              Text("Discover and Get Great Food",
                  style: AppWidget.LightTextFeildStyle()),
              SizedBox(
                height: 20.0,
              ),
              Container(margin: EdgeInsets.only(right: 20.0), child: showItem()),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: screenH/3.3,
                  child: allItems()),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       GestureDetector(
              //         onTap: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (context)=> Details()));
              //         },
              //         child: Container(
              //           margin: EdgeInsets.all(4),
              //           child: Material(
              //             elevation: 5.0,
              //             borderRadius: BorderRadius.circular(20),
              //             child: Container(
              //               padding: EdgeInsets.all(14),
              //               child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Image.asset(
              //                       "images/salad2.png",
              //                       height: 150,
              //                       width: 150,
              //                       fit: BoxFit.cover,
              //                     ),
              //                     Text("Veggie Taco Hash",
              //                         style: AppWidget.semiBoldTextFeildStyle()),
              //                     SizedBox(
              //                       height: 5.0,
              //                     ),
              //                     Text("Fresh and Healthy",
              //                         style: AppWidget.LightTextFeildStyle()),
              //                     SizedBox(
              //                       height: 5.0,
              //                     ),
              //                     Text(
              //                       "\$25",
              //                       style: AppWidget.semiBoldTextFeildStyle(),
              //                     )
              //                   ]),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 15.0,
              //       ),
              //       Container(
              //         margin: EdgeInsets.all(4),
              //         child: Material(
              //           elevation: 5.0,
              //           borderRadius: BorderRadius.circular(20),
              //           child: Container(
              //             padding: EdgeInsets.all(14),
              //             child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Image.asset(
              //                     "images/salad4.png",
              //                     height: 150,
              //                     width: 150,
              //                     fit: BoxFit.cover,
              //                   ),
              //                   Text("Mix Veg Salad",
              //                       style: AppWidget.semiBoldTextFeildStyle()),
              //                   SizedBox(
              //                     height: 5.0,
              //                   ),
              //                   Text("Spicy with Onion",
              //                       style: AppWidget.LightTextFeildStyle()),
              //                   SizedBox(
              //                     height: 5.0,
              //                   ),
              //                   Text(
              //                     "\$28",
              //                     style: AppWidget.semiBoldTextFeildStyle(),
              //                   )
              //                 ]),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 30.0),
              allItemsVertically(),
              // Container(
              //   margin: EdgeInsets.only(right: 20.0),
              //   child: Material(
              //     elevation: 5.0,
              //     borderRadius: BorderRadius.circular(20),
              //     child: Container(
              //       padding: EdgeInsets.all(5),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Image.asset(
              //             "images/salad4.png",
              //             height: 120,
              //             width: 120,
              //             fit: BoxFit.cover,
              //           ),
              //           SizedBox(width: 20.0,),
              //           Column(children: [
              //             Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("Mediterranean Chickpea Salad", style: AppWidget.semiBoldTextFeildStyle(),)),
              //               SizedBox(height: 5.0,),
              //               Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("Honey goot cheese", style: AppWidget.LightTextFeildStyle(),)),
              //                 SizedBox(height: 5.0,),
              //               Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("\$28", style: AppWidget.semiBoldTextFeildStyle(),))
              //           ],)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              //   SizedBox(
              //   height: 30.0,
              // ),
              // Container(
              //   margin: EdgeInsets.only(right: 20.0),
              //   child: Material(
              //     elevation: 5.0,
              //     borderRadius: BorderRadius.circular(20),
              //     child: Container(
              //       padding: EdgeInsets.all(5),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Image.asset(
              //             "images/salad2.png",
              //             height: 120,
              //             width: 120,
              //             fit: BoxFit.cover,
              //           ),
              //           SizedBox(width: 20.0,),
              //           Column(children: [
              //             Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("Veggie Taco Hash", style: AppWidget.semiBoldTextFeildStyle(),)),
              //               SizedBox(height: 5.0,),
              //               Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("Honey goot cheese", style: AppWidget.LightTextFeildStyle(),)),
              //                 SizedBox(height: 5.0,),
              //               Container(
              //               width: MediaQuery.of(context).size.width/2,
              //               child: Text("\$28", style: AppWidget.semiBoldTextFeildStyle(),))
              //           ],)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Ice-cream");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: icecream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/ice-cream.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/pizza.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Salad");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/salad.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
            foodItemStream = await DatabaseMethods().getFoodItem("Burger");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burger ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/burger.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
