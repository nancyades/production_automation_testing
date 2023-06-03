import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:production_automation_testing/Model/APIModel/templatemodel.dart';
import '../../Database/Curd_operation/HiveModel/productmodel.dart';


import '../../Helper/helper.dart';
import '../../Model/APIModel/productmodel.dart';
import '../../Provider/excelprovider.dart';
import '../../Provider/post_provider/product_provider.dart';
import 'addproduct.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

int? key;
ProductModel? data;
List<ProductModel>? datamodels;

Productmodel product = Productmodel();

class _ProductPageState extends ConsumerState<ProductPage> {
  bool _isShow = false;
  bool seen = true;

  bool all = true;
  bool active = false;
  bool inactive = false;
  int looping = 0;
  bool procount = true;

  bool search = true;

  List<Productmodel> glossarListOnSearch = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    ref.refresh(getProductNotifier);
  }



  var selectRole = "Verified";
  List<String> status = [
    'Rejected',
    'Approved',
    'Verified',
    'Created',
  ];

  @override
  Widget build(BuildContext context) {


    /* return ValueListenableBuilder<Box<ProductModel>>(
        valueListenable: Products.getProducts().listenable(),
      builder: (context, Box<ProductModel> items, _) {
        List<int> keys;
        keys = items.keys.cast<int>().toList();
        datamodels = items.values.toList().cast<ProductModel>();

        var activevalue = items.values
            .where((element) => element.flg == true)
            .toList();

        var inactivevalue = items.values
            .where((element) => element.flg == false)
            .toList();*/
    return ref.watch(getProductNotifier).when(data: (datum) {
      print(datum.length);
      print(datum);
          var activevalue = datum.where((element) => element.flg == 1).toList();
          var inactivevalue = datum.where((element) => element.flg == 0)
              .toList();
          return Row(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.63,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),

                               Helper.sharedRoleId == "Design User" ?
                            Visibility(
                              visible: seen,
                              child: MaterialButton(
                                padding: const EdgeInsets.all(15),
                                onPressed: () {
                                  setState(() {
                                    product.productId = 0;
                                    product.productCode = "";
                                    product.productName = "";
                                    product.quantity = 0;
                                    product.status = "Created";
                                    product.timeRequired = 0;
                                    product.description = "";
                                    product.remarks = "";
                                    Helper.product_id = null;
                                    AddProduct(product: product);
                                    _isShow = !_isShow;
                                    procount = !procount;
                                    search = !search;

                                  });

                                },
                                child: const Icon(
                                  Icons.open_in_browser_rounded,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            )
                               :  Helper.sharedRoleId == "Design Admin" || Helper.sharedRoleId == "Super Admin" ?
                               Visibility(
                                 visible: _isShow,
                                 child: MaterialButton(
                                   padding: const EdgeInsets.all(15),
                                   onPressed: () {
                                     setState(() {
                                       _isShow = false;
                                     });

                                   },
                                   child: const Icon(
                                     Icons.open_in_browser_rounded,
                                     size: 20,
                                     color: Colors.black,
                                   ),
                                 ),
                               )

                                :   Visibility(
                              visible: seen,
                              child: MaterialButton(
                                padding: const EdgeInsets.all(15),
                                onPressed: () {
                                  setState(() {
                                    product.productId = 0;
                                    product.productCode = "";
                                    product.productName = "";
                                    product.quantity = 0;
                                    product.status = "Created";
                                    product.timeRequired = 0;
                                    product.description = "";
                                    product.remarks = "";
                                    Helper.product_id = null;
                                    AddProduct(product: product);
                                    _isShow = !_isShow;
                                    procount = !procount;
                                    search = !search;
                                  });
                                },
                                child: const Icon(
                                  Icons.open_in_browser_rounded,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                      Consumer(
                          builder: (context, ref, child) {
                            return ref.watch(getProductCountNotifier).when(data: (count){
                              return Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  height: 218.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child:Row(
                                            children: [
                                              SizedBox(
                                                width: 30,
                                              ),
                                              SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child:Column(
                                                      children:[
                                                        Card(
                                                          elevation:12,
                                                          child: Container(
                                                            width:200,
                                                            height:100,
                                                            decoration: BoxDecoration(
                                                                boxShadow: [BoxShadow(color:Colors.white10,spreadRadius: 10,blurRadius: 12)],
                                                                border: Border.all(color: Colors.grey),
                                                                backgroundBlendMode: BlendMode.darken,
                                                                color: Colors.white,
                                                                shape: BoxShape.rectangle
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 15.0, top: 10),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child: Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Text("${count[0].created}%",  style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 15.0,
                                                                                    color:  Colors.black
                                                                                ))
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text("Created", style: TextStyle(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 10.0,
                                                                                    color:  Colors.black
                                                                                ))
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),

                                                                      ),
                                                                      Expanded(
                                                                        child: Column(
                                                                          children: [
                                                                            Icon(Icons.incomplete_circle, size: 20,)
                                                                          ],
                                                                        ),

                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),


                                                                SizedBox(
                                                                  height: 14,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width:198,
                                                                      height:36,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.green,
                                                                          shape: BoxShape.rectangle
                                                                      ),
                                                                      child:  Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text('% change'),
                                                                            Icon(Icons.call_made, size: 12,),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Card(
                                                          elevation:12,
                                                          child: Container(
                                                            width:200,
                                                            height:100,
                                                            decoration: BoxDecoration(
                                                                boxShadow: [BoxShadow(color:Colors.white10,spreadRadius: 10,blurRadius: 12)],
                                                                border: Border.all(color: Colors.grey),
                                                                backgroundBlendMode: BlendMode.darken,
                                                                color: Colors.white,
                                                                shape: BoxShape.rectangle
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 15.0, top: 10),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child: Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Text("${count[0].verified}%",  style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 15.0,
                                                                                    color:  Colors.black
                                                                                ))
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text("verified", style: TextStyle(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 9.0,
                                                                                    color:  Colors.black
                                                                                ))
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),

                                                                      ),
                                                                      Expanded(
                                                                        child: Column(
                                                                          children: [
                                                                            Icon(Icons.admin_panel_settings_outlined,size: 20,)
                                                                          ],
                                                                        ),

                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),


                                                                SizedBox(
                                                                  height: 16,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width:198,
                                                                      height:36,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.amber,
                                                                          shape: BoxShape.rectangle
                                                                      ),
                                                                      child:  Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text('% change'),
                                                                            Icon(Icons.call_made, size: 12,),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ])),
                                              Padding(padding: EdgeInsets.only(left: 50)),
                                              Column(
                                                  children:[
                                                    Card(
                                                      elevation:12,
                                                      child: Container(
                                                        width:200,
                                                        height:100,
                                                        decoration: BoxDecoration(
                                                            boxShadow: [BoxShadow(color:Colors.white10,spreadRadius: 10,blurRadius: 12)],
                                                            border: Border.all(color: Colors.grey),
                                                            backgroundBlendMode: BlendMode.darken,
                                                            color: Colors.white,
                                                            shape: BoxShape.rectangle
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 15.0, top: 10),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Text("${count[0].approved}%",  style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 15.0,
                                                                                color:  Colors.black
                                                                            ))
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("Approved", style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 10.0,
                                                                                color:  Colors.black
                                                                            ))
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),

                                                                  ),
                                                                  Expanded(
                                                                    child: Column(
                                                                      children: [
                                                                        Icon(Icons.task,size: 20,)
                                                                      ],
                                                                    ),

                                                                  ),
                                                                ],
                                                              ),
                                                            ),


                                                            SizedBox(
                                                              height: 14,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width:198,
                                                                  height:36,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.blue,
                                                                      shape: BoxShape.rectangle
                                                                  ),
                                                                  child:  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Text('% change'),
                                                                        Icon(Icons.call_made, size: 12,),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),

                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Card(
                                                      elevation:12,
                                                      child: Container(
                                                        width:200,
                                                        height:100,
                                                        decoration: BoxDecoration(
                                                            boxShadow: [BoxShadow(color:Colors.white10,spreadRadius: 10,blurRadius: 12)],
                                                            border: Border.all(color: Colors.grey),
                                                            backgroundBlendMode: BlendMode.darken,
                                                            color: Colors.white,
                                                            shape: BoxShape.rectangle
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 15.0, top: 10),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Text("${count[0].rejected}%",  style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 15.0,
                                                                                color:  Colors.black
                                                                            ))
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("Rejected", style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 10.0,
                                                                                color:  Colors.black
                                                                            ))
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),

                                                                  ),
                                                                  Expanded(
                                                                    child: Column(
                                                                      children: [
                                                                        Icon(Icons.account_circle_outlined,size: 20)
                                                                      ],
                                                                    ),

                                                                  ),
                                                                ],
                                                              ),
                                                            ),


                                                            SizedBox(
                                                              height: 14,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width:198,
                                                                  height:36,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.red,
                                                                      shape: BoxShape.rectangle
                                                                  ),
                                                                  child:  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Text('% change'),
                                                                        Icon(Icons.call_made, size: 12,),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),

                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                              Padding(
                                                  padding:EdgeInsets.only(left: 80.0)),
                                              Card(
                                                elevation: 10,
                                                child: Container(
                                                  width:402,
                                                  height:400,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [BoxShadow(color:Colors.white10,spreadRadius: 10,blurRadius: 12)],
                                                      border: Border.all(color: Colors.grey),
                                                      backgroundBlendMode: BlendMode.darken,
                                                      color: Colors.white,
                                                      shape: BoxShape.rectangle
                                                  ),
                                                  child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 15.0, top: 10),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text("${count[0].productCount}%",  style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 15.0,
                                                                          color:  Colors.black,
                                                                        ))
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text("Product", style: TextStyle(
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 10.0,
                                                                            color:  Colors.black
                                                                        ))
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),

                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  children: [
                                                                    Icon(Icons.bar_chart,size: 20,)
                                                                  ],
                                                                ),

                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: 70,
                                                        ),
                                                        // AnimatedContainer(duration: ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width:400,
                                                              height:90,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.blue,
                                                                  shape: BoxShape.rectangle
                                                              ),
                                                              child:  Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child:SingleChildScrollView(
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                            children:[
                                                                              Text(
                                                                    datum.length.toString(),  style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 15.0,
                                                                                color:  Colors.white,
                                                                              )),

                                                                              Text('All',
                                                                                  style:
                                                                                  TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                  color: Colors.white)),


                                                                            ]),
                                                                        Column(
                                                                            children:[
                                                                              Text(
                                                                            activevalue.length.toString(),  style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 15.0,
                                                                                  color:  Colors.white
                                                                              )),
                                                                              Text('Active',style: (TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))]),
                                                                        Column(
                                                                            children:[
                                                                              Text(
                                                                                  inactivevalue.length.toString(),  style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 15.0,
                                                                                  color:  Colors.white
                                                                              )),
                                                                              Text('InActive',style: (TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))]),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),

                                                          ],
                                                        )
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )],
                                  ),
                                );

                            }, error: (e,s){
                              return Text(e.toString());
                            }, loading: (){
                              return CircularProgressIndicator();
                            });

                          }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 32.0),
                        child: Row(
                          children: [
                            IconButton(
                                highlightColor: Colors.amberAccent,
                                onPressed: (){
                                  ref.refresh(getProductNotifier);

                                }, icon: Icon(Icons.refresh,)),
                            SizedBox(
                              width: 10.0,
                            ),
                            ElevatedButton(
                        child: Row(
                        children: [
                        Row(
                        children: [
                        Container(
                        width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFFAAA1E),
                          ),
                          child: Center(
                            child: Text(
                              datum.length.toString(),
                              style: TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("All".toUpperCase(),
                            style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff6C6CE5)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Color(0xff6C6CE5))))),
                                onPressed: () {
                                  setState(() {
                                    all = true;
                                    active = false;
                                    inactive = false;
                                  });
                                }),
                            SizedBox(
                              width: 15.0,
                            ),
                            ElevatedButton(
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffFFAAA1E),
                                          ),
                                          child: Center(
                                            child: Text(
                                              activevalue.length.toString(),
                                              style: TextStyle(color: Colors.black, fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text("ACTIVE".toUpperCase(),
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ],
                                ),
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff6C6CE5)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Color(0xff6C6CE5))))),
                                onPressed: () {
                                  /* ref.read(ActiveUser.notifier).state =
                              !ref.watch(ActiveUser);*/
                                  setState(() {
                                    all = false;
                                    active = true;
                                    inactive = false;
                                  });
                                }),
                            SizedBox(
                              width: 15.0,
                            ),
                            ElevatedButton(
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffFFAAA1E),
                                          ),
                                          child: Center(
                                            child: Text(
                                              inactivevalue.length.toString(),
                                              style: TextStyle(color: Colors.black, fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text("INACTIVE".toUpperCase(),
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ],
                                ),
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff6C6CE5)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Color(0xff6C6CE5))))),
                                onPressed: () {
                                  setState(() {
                                    all = false;
                                    active = false;
                                    inactive = true;
                                  });
                                }),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0),
                                        child: DropdownButton(

                                          icon: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 25.0),
                                            child: Icon(
                                                Icons.keyboard_arrow_down),
                                          ),
                                          items: status
                                              .map<DropdownMenuItem<String>>((
                                              String setlist) {
                                            return DropdownMenuItem<String>(
                                              value: setlist,

                                              child: Text(setlist.toString()),
                                            );
                                          }).toList(),
                                          value: selectRole,
                                          onChanged: (item) {
                                            setState(() {
                                              selectRole = item.toString();

                                              //List<FirstClass> emptylist = [];
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Visibility(
                                  visible: search,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      //MediaQuery.of(context).size.width * 0.25,
                                      height: 30,
                                      child: TextField(
                                          controller: _textEditingController,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.search),
                                            hintText: 'search',
                                            hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              glossarListOnSearch = datum
                                                  .where((element) => element.productName!
                                                  .toLowerCase()
                                                  .contains(
                                                  value.toLowerCase()))
                                                  .toList();
                                            });

                                          })
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Color(0xff333951),
                          //Colors.blueAccent,
                          elevation: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(' '),
                              Expanded(
                                child: Container(
                                  height: 20.0,
                                  width: 10.0,
                                  child: Center(child: Text("S.No",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15.0,
                                          color: Colors.white))),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 20.0,
                                  width: 10.0,
                                  child: Center(child: Text("Product Code",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white))),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 20.0,
                                  width: 10.0,
                                  child: Center(child: Text("Product",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white))),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 20.0,
                                  width: 10.0,
                                  child: Center(child: Text("Quantity",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white))),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 20.0,
                                  width: 10.0,
                                  child: Center(child: Text("Status",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white))),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 20.0,
                                  width: 10.0,
                                  child: Center(child: Text("Time Required",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white))),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 500,
                                color: Color(0xffcbdff2),

                                child:
                                _textEditingController
                                    .text.isNotEmpty &&
                                    glossarListOnSearch.isEmpty
                                    ? Column(
                                  children: [
                                    Align(
                                      alignment:
                                      Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets
                                            .fromLTRB(
                                            0, 50, 0, 0),
                                        child: Text(
                                          'No results',
                                          style: TextStyle(
                                              fontFamily:
                                              'Avenir',
                                              fontSize: 22,
                                              color: Color(
                                                  0xff848484)),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                                      : ListView.builder
                                        (
                                          itemCount: () {
                                            if (all == true) {
                                              return _textEditingController
                                                  .text.isNotEmpty
                                                  ? glossarListOnSearch
                                                  .length
                                                  : datum.length;
                                            } else if (active == true) {
                                              return _textEditingController
                                                  .text.isNotEmpty
                                                  ? glossarListOnSearch
                                                  .length
                                                  : activevalue.length;

                                            } else if (inactive == true) {
                                              return _textEditingController.text.isNotEmpty
                                                  ? glossarListOnSearch.length
                                                  : inactivevalue.length;
                                            } else {
                                              return 0;
                                            }
                                          }(),
                                          itemBuilder: (BuildContext ctxt,
                                              int index) {
                                            return () {
                                              if (all == true) {
                                                return getProduct(datum, index);
                                              } else if (active == true) {
                                                return getActiveItems(
                                                    datum, index);
                                              } else if (inactive == true) {
                                                return getInActiveItems(
                                                    datum, index);
                                              } else {
                                                return getProduct(datum, index);
                                              }
                                            }();
                                          }
                                      )

                              ),

                            ],
                          ),
                        ),
                      ),


                      Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('@copyright rax-tech International 2022',
                              style: TextStyle(fontWeight: FontWeight.w400,
                                  fontSize: 15.0,
                                  color: Colors.black)),
                        ],
                      )),

                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _isShow,
                child: Expanded(
                    flex: 5,
                    child: AddProduct(product: product,)),
              ),
            ],
          );
        }, error: (e, s) {
          print(e);
      return Text(e.toString());

    }, loading: () {
      return Center(child: CircularProgressIndicator());
    });

    // });
  }

  getProduct(List<Productmodel> items, int index) {
    return Visibility(
      visible: (){
        if(Helper.sharedRoleId == "Super Admin" && items[index].status.toString() == "Rejected"){
          return false;
        }else if(Helper.sharedRoleId == "Super Admin" && items[index].status.toString() == "Created"){
          return false;
        }else{
          return true;
        }
      }(),
      child: Card(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: items[index].flg == 1
                              ? Colors.green
                              : Colors.red,
                          shape: BoxShape.circle),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 20.0,
                      width: 10.0,
                      child: Center(child: Text((index + 1).toString(),
                          style: TextStyle(fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 20.0,
                      width: 10.0,
                      child: Center(child: Text(
                          _textEditingController.text.isNotEmpty
                              ? glossarListOnSearch[index].productCode!.toString()
                              :  items[index].productCode.toString(),

                          style: TextStyle(fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 20.0,
                      width: 10.0,
                      child: Center(child: Text(_textEditingController.text.isNotEmpty
                          ? glossarListOnSearch[index].productName!.toString()
                          :   items[index].productName.toString(),

                          style: TextStyle(fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 20.0,
                      width: 10.0,
                      child: Center(child: Text(
                          _textEditingController.text.isNotEmpty
                              ? glossarListOnSearch[index].quantity!.toString()
                              :   items[index].quantity.toString(),

                          style: TextStyle(fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 20.0,
                      width: 10.0,
                      child: Center(child: Text(_textEditingController.text.isNotEmpty
                          ? glossarListOnSearch[index].status!.toString()
                          :   items[index].status.toString(),

                          style: TextStyle(fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 20.0,
                      width: 10.0,
                      child: Center(child: Text(_textEditingController.text.isNotEmpty
                          ? glossarListOnSearch[index].timeRequired!.toString()
                          :   items[index].timeRequired.toString(),

                          style: TextStyle(fontWeight: FontWeight.w300,
                              fontSize: 13.0,
                              color: Colors.black))),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_textEditingController.text.isNotEmpty) {

                                      product.productId = int.parse(glossarListOnSearch[index].productId
                                          .toString());
                                      product.productCode = glossarListOnSearch[index].productCode
                                          .toString();
                                      product.productName = glossarListOnSearch[index].productName
                                          .toString();
                                      product.quantity = int.parse(glossarListOnSearch[index].quantity
                                          .toString());
                                      product.status = glossarListOnSearch[index].status.toString();
                                      product.timeRequired = int.parse(glossarListOnSearch[index]
                                          .timeRequired.toString());
                                      product.description = glossarListOnSearch[index].description.toString();
                                      product.remarks = glossarListOnSearch[index].remarks.toString();
                                      product.templateId = int.parse(glossarListOnSearch[index]
                                          .templateId.toString());
                                      product.flg = glossarListOnSearch[index].flg;
                                      List<Template> temp = [];

                                      for(int i = 0; i< glossarListOnSearch[index].template!.length; i++){
                                        if(product.productId == int.parse(glossarListOnSearch[index].template![i].productid.toString()) ){
                                          Template wlist = Template(
                                            templateId:glossarListOnSearch[index].template![i].templateId,
                                            templateName: glossarListOnSearch[index].template![i].templateName,
                                            filePath: glossarListOnSearch[index].template![i].filePath,
                                            createdBy: glossarListOnSearch[index].template![i].createdBy,
                                            updatedBy: glossarListOnSearch[index].template![i].updatedBy,
                                            createdDate: glossarListOnSearch[index].template![i].createdDate,
                                            updatedDate: glossarListOnSearch[index].template![i].updatedDate,
                                            flg: glossarListOnSearch[index].template![i].flg,
                                            remarks: glossarListOnSearch[index].template![i].remarks,
                                            productid: glossarListOnSearch[index].template![i].productid,

                                          );
                                          temp.add(wlist);
                                        }

                                      }
                                      product.template = temp;

                                    }else{
                                      product.productId = int.parse(items[index].productId
                                          .toString());
                                      product.productCode = items[index].productCode
                                          .toString();
                                      product.productName = items[index].productName
                                          .toString();
                                      product.quantity = int.parse(items[index].quantity
                                          .toString());
                                      product.status = items[index].status.toString();
                                      product.timeRequired = int.parse(items[index]
                                          .timeRequired.toString());
                                      product.description = items[index].description.toString();
                                      product.remarks = items[index].remarks.toString();
                                      product.templateId = int.parse(items[index]
                                          .templateId.toString());
                                      product.flg = items[index].flg;
                                      List<Template> temp = [];

                                      for(int i = 0; i< items[index].template!.length; i++){
                                        if(product.productId == int.parse(items[index].template![i].productid.toString()) ){
                                          Template wlist = Template(
                                            templateId:items[index].template![i].templateId,
                                            templateName: items[index].template![i].templateName,
                                            filePath: items[index].template![i].filePath,
                                            createdBy: items[index].template![i].createdBy,
                                            updatedBy: items[index].template![i].updatedBy,
                                            createdDate: items[index].template![i].createdDate,
                                            updatedDate: items[index].template![i].updatedDate,
                                            flg: items[index].template![i].flg,
                                            remarks: items[index].template![i].remarks,
                                            productid: items[index].template![i].productid,

                                          );
                                          temp.add(wlist);
                                        }

                                      }
                                      product.template = temp;
                                    }




                                    AddProduct(product: product);

                                    _isShow = true;
                                    procount = false;
                                    search = false;
                                   // seen = true;
                                    Helper.editvalue = "editedvalue";
                                  });
                                },
                                icon: Icon(Icons.edit)),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  ref.read(updateProductsNotifier.notifier).updatetProduct({
                                    "product_Id": items[index].productId,
                                    "product_name": items[index].productName.toString(),
                                    "product_code": items[index].productCode.toString(),
                                    "description": items[index].description.toString(),
                                    "template_id": 1,
                                    "quantity": items[index].quantity,
                                    "status": items[index].status.toString(),
                                    "updated_by": 1,
                                    "updated_date": null,
                                    "flg": 0,
                                    "remarks": items[index].remarks.toString(),
                                    "time_required": items[index].timeRequired ,
                                    "mac_address": null
                                  });
                                },
                                icon: Icon(Icons.delete)),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ],
          )),
    );
  }

  getActiveItems(List<Productmodel> items, int index) {
    var activevalue = items.where((element) => element.flg == 1).toList();
    return Visibility(
      visible: (){
        if(Helper.sharedRoleId == "Super Admin" && activevalue[index].status.toString() == "Rejected"){
          return false;
        }else if(Helper.sharedRoleId == "Super Admin" && activevalue[index].status.toString() == "Created"){
          return false;
        }else{
          return true;
        }
      }(),
      child: Card(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: activevalue[index].flg == 1
                          ? Colors.green
                          : Colors.red,
                      shape: BoxShape.circle),
                ),
              ),

              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(child: Text((index + 1).toString(),
                      style: TextStyle(fontWeight: FontWeight.w300,
                          fontSize: 13.0,
                          color: Colors.black))),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(child: Text(_textEditingController.text.isNotEmpty
                      ? glossarListOnSearch[index].productCode!.toString()
                      :    activevalue[index].productCode.toString(),
                      style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13.0,
                      color: Colors.black))),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(child: Text(_textEditingController.text.isNotEmpty
                      ? glossarListOnSearch[index].productName!.toString()
                      :    activevalue[index].productName.toString(),
                     style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13.0,
                      color: Colors.black))),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(child: Text(
                      _textEditingController.text.isNotEmpty
                          ? glossarListOnSearch[index].quantity!.toString()
                          :    activevalue[index].quantity.toString(),
                      style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13.0,
                      color: Colors.black))),
                ),
              ),
              Expanded(
                  child: Container(
                    height: 20.0,
                    width: 10.0,
                    child: Center(child: Text(
                        _textEditingController.text.isNotEmpty
                            ? glossarListOnSearch[index].status!.toString()
                            :    activevalue[index].status.toString(),
                         style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.black))),
                  )
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(child: Text(
                      _textEditingController.text.isNotEmpty
                          ? glossarListOnSearch[index].timeRequired!.toString()
                          :    activevalue[index].timeRequired.toString(),

                      style: TextStyle(fontWeight: FontWeight.w300,
                          fontSize: 13.0,
                          color: Colors.black))),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_textEditingController.text.isNotEmpty) {

                                product.productId = int.parse(glossarListOnSearch[index].productId
                                    .toString());
                                product.productCode = glossarListOnSearch[index].productCode
                                    .toString();
                                product.productName = glossarListOnSearch[index].productName
                                    .toString();
                                product.quantity = int.parse(glossarListOnSearch[index].quantity
                                    .toString());
                                product.status = glossarListOnSearch[index].status.toString();
                                product.timeRequired = int.parse(glossarListOnSearch[index]
                                    .timeRequired.toString());
                                product.description = glossarListOnSearch[index].description.toString();
                                product.remarks = glossarListOnSearch[index].remarks.toString();
                                product.templateId = int.parse(glossarListOnSearch[index]
                                    .templateId.toString());
                                product.flg = glossarListOnSearch[index].flg;
                                List<Template> temp = [];

                                for(int i = 0; i< glossarListOnSearch[index].template!.length; i++){
                                  if(product.productId == int.parse(glossarListOnSearch[index].template![i].productid.toString()) ){
                                    Template wlist = Template(
                                      templateId:glossarListOnSearch[index].template![i].templateId,
                                      templateName: glossarListOnSearch[index].template![i].templateName,
                                      filePath: glossarListOnSearch[index].template![i].filePath,
                                      createdBy: glossarListOnSearch[index].template![i].createdBy,
                                      updatedBy: glossarListOnSearch[index].template![i].updatedBy,
                                      createdDate: glossarListOnSearch[index].template![i].createdDate,
                                      updatedDate: glossarListOnSearch[index].template![i].updatedDate,
                                      flg: glossarListOnSearch[index].template![i].flg,
                                      remarks: glossarListOnSearch[index].template![i].remarks,
                                      productid: glossarListOnSearch[index].template![i].productid,

                                    );
                                    temp.add(wlist);
                                  }

                                }
                                product.template = temp;

                              }else{
                                product.productId = int.parse(activevalue[index]
                                    .productId.toString());
                                product.productCode = activevalue[index].productCode
                                    .toString();
                                product.productName = activevalue[index].productName
                                    .toString();
                                product.quantity = int.parse(activevalue[index]
                                    .quantity.toString());
                                product.status = activevalue[index].status
                                    .toString();
                                product.timeRequired = int.parse(activevalue[index]
                                    .timeRequired.toString());
                                product.description = activevalue[index].description
                                    .toString();
                                product.remarks = activevalue[index].remarks.toString();
                                product.templateId = int.parse(activevalue[index]
                                    .templateId.toString());
                                product.flg = activevalue[index].flg;

                                List<Template> temp = [];

                                for(int i = 0; i< activevalue[index].template!.length; i++){
                                  if(product.productId == int.parse(activevalue[index].template![i].productid.toString())){
                                    Template wlist = Template(
                                      templateId:activevalue[index].template![i].templateId,
                                      templateName: activevalue[index].template![i].templateName,
                                      filePath: activevalue[index].template![i].filePath,
                                      createdBy: activevalue[index].template![i].createdBy,
                                      updatedBy: activevalue[index].template![i].updatedBy,
                                      createdDate: activevalue[index].template![i].createdDate,
                                      updatedDate: activevalue[index].template![i].updatedDate,
                                      flg: activevalue[index].template![i].flg,
                                      remarks: activevalue[index].template![i].remarks,
                                      productid: activevalue[index].template![i].productid,

                                    );
                                    temp.add(wlist);
                                  }

                                }
                                product.template = temp;
                              }



                              AddProduct(product: product);

                              seen = true;
                              _isShow = true;
                              procount = false;
                              search = false;
                              Helper.editvalue = "editedvalue";
                            });
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            ref.read(updateProductsNotifier.notifier).updatetProduct({
                              "product_Id": activevalue[index].productId,
                              "product_name": activevalue[index].productName.toString(),
                              "product_code": activevalue[index].productCode.toString(),
                              "description": activevalue[index].description.toString(),
                              "template_id": 1,
                              "quantity": activevalue[index].quantity,
                              "status": activevalue[index].status.toString(),
                              "updated_by": 1,
                              "updated_date": null,
                              "flg": 0,
                              "remarks": activevalue[index].remarks.toString(),
                              "time_required": activevalue[index].timeRequired ,
                              "mac_address": null
                            });
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                ),
              ),

            ],
          )),
    );
  }

  getInActiveItems(List<Productmodel> items, int index) {
    var inactivevalue = items.where((element) => element.flg == 0).toList();
    return Visibility(
      visible: (){
        if(Helper.sharedRoleId == "Super Admin" && inactivevalue[index].status.toString() == "Rejected"){
          return false;
        }else if(Helper.sharedRoleId == "Super Admin" && inactivevalue[index].status.toString() == "Created"){
          return false;
        }else{
          return true;
        }
      }(),
      child: Card(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: inactivevalue[index].flg == 1
                          ? Colors.green
                          : Colors.red,
                      shape: BoxShape.circle),
                ),
              ),

              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(child: Text((index + 1).toString(),
                      style: TextStyle(fontWeight: FontWeight.w300,
                          fontSize: 13.0,
                          color: Colors.black))),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(child: Text( _textEditingController.text.isNotEmpty
                      ? glossarListOnSearch[index].productCode!.toString()
                      :    inactivevalue[index].productCode.toString(),

                      style: TextStyle(fontWeight: FontWeight.w300,
                          fontSize: 13.0,
                          color: Colors.black))),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(child: Text(_textEditingController.text.isNotEmpty
                      ? glossarListOnSearch[index].productName!.toString()
                      :    inactivevalue[index].productName.toString(),
                      style: TextStyle(fontWeight: FontWeight.w300,
                          fontSize: 13.0,
                          color: Colors.black))),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(child: Text(_textEditingController.text.isNotEmpty
                      ? glossarListOnSearch[index].quantity!.toString()
                      :    inactivevalue[index].quantity.toString(),
                     style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13.0,
                      color: Colors.black))),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(child: Text(
                      _textEditingController.text.isNotEmpty
                          ? glossarListOnSearch[index].status!.toString()
                          :    inactivevalue[index].status.toString(),
                      style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13.0,
                      color: Colors.black))),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10.0,
                  child: Center(child: Text(
                      _textEditingController.text.isNotEmpty
                          ? glossarListOnSearch[index].timeRequired!.toString()
                          :    inactivevalue[index].timeRequired.toString(),
                      style: TextStyle(fontWeight: FontWeight.w300,
                          fontSize: 13.0,
                          color: Colors.black))),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_textEditingController.text.isNotEmpty) {

                                product.productId = int.parse(glossarListOnSearch[index].productId
                                    .toString());
                                product.productCode = glossarListOnSearch[index].productCode
                                    .toString();
                                product.productName = glossarListOnSearch[index].productName
                                    .toString();
                                product.quantity = int.parse(glossarListOnSearch[index].quantity
                                    .toString());
                                product.status = glossarListOnSearch[index].status.toString();
                                product.timeRequired = int.parse(glossarListOnSearch[index]
                                    .timeRequired.toString());
                                product.description = glossarListOnSearch[index].description.toString();
                                product.remarks = glossarListOnSearch[index].remarks.toString();
                                product.templateId = int.parse(glossarListOnSearch[index]
                                    .templateId.toString());
                                product.flg = glossarListOnSearch[index].flg;
                                List<Template> temp = [];

                                for(int i = 0; i< glossarListOnSearch[index].template!.length; i++){
                                  if(product.productId == int.parse(glossarListOnSearch[index].template![i].productid.toString()) ){
                                    Template wlist = Template(
                                      templateId:glossarListOnSearch[index].template![i].templateId,
                                      templateName: glossarListOnSearch[index].template![i].templateName,
                                      filePath: glossarListOnSearch[index].template![i].filePath,
                                      createdBy: glossarListOnSearch[index].template![i].createdBy,
                                      updatedBy: glossarListOnSearch[index].template![i].updatedBy,
                                      createdDate: glossarListOnSearch[index].template![i].createdDate,
                                      updatedDate: glossarListOnSearch[index].template![i].updatedDate,
                                      flg: glossarListOnSearch[index].template![i].flg,
                                      remarks: glossarListOnSearch[index].template![i].remarks,
                                      productid: glossarListOnSearch[index].template![i].productid,

                                    );
                                    temp.add(wlist);
                                  }

                                }
                                product.template = temp;

                              }else{
                                product.productId = int.parse(inactivevalue[index]
                                    .productId.toString());
                                product.productCode = inactivevalue[index]
                                    .productCode.toString();
                                product.productName = inactivevalue[index]
                                    .productName.toString();
                                product.quantity = int.parse(inactivevalue[index]
                                    .quantity.toString());
                                product.status = inactivevalue[index].status
                                    .toString();
                                product.timeRequired = int.parse(
                                    inactivevalue[index].timeRequired.toString());
                                product.description = inactivevalue[index]
                                    .description.toString();
                                product.remarks = inactivevalue[index].remarks.toString();
                                product.templateId = int.parse(inactivevalue[index]
                                    .templateId.toString());
                                product.flg = inactivevalue[index].flg;

                                List<Template> temp = [];

                                for(int i = 0; i< inactivevalue[index].template!.length; i++){
                                  if(product.productId == int.parse(inactivevalue[index].template![i].productid.toString())){
                                    Template wlist = Template(
                                      templateId:inactivevalue[index].template![i].templateId,
                                      templateName: inactivevalue[index].template![i].templateName,
                                      filePath: inactivevalue[index].template![i].filePath,
                                      createdBy: inactivevalue[index].template![i].createdBy,
                                      updatedBy: inactivevalue[index].template![i].updatedBy,
                                      createdDate: inactivevalue[index].template![i].createdDate,
                                      updatedDate: inactivevalue[index].template![i].updatedDate,
                                      flg: inactivevalue[index].template![i].flg,
                                      remarks: inactivevalue[index].template![i].remarks,
                                      productid: inactivevalue[index].template![i].productid,

                                    );
                                    temp.add(wlist);
                                  }

                                }
                                product.template = temp;

                              }




                              AddProduct(product: product);
                              seen = true;
                              _isShow = true;
                              procount = false;
                              search = false;
                              Helper.editvalue = "editedvalue";
                            });
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            ref.read(updateProductsNotifier.notifier).updatetProduct({
                              "product_Id": inactivevalue[index].productId,
                              "product_name": inactivevalue[index].productName.toString(),
                              "product_code": inactivevalue[index].productCode.toString(),
                              "description": inactivevalue[index].description.toString(),
                              "template_id": 1,
                              "quantity": inactivevalue[index].quantity,
                              "status": inactivevalue[index].status.toString(),
                              "updated_by": 1,
                              "updated_date": null,
                              "flg": 0,
                              "remarks": inactivevalue[index].remarks.toString(),
                              "time_required": inactivevalue[index].timeRequired ,
                              "mac_address": null
                            });
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                ),
              ),

            ],
          )),
    );
  }
}

