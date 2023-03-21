import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:production_automation_testing/DashBoard/src/tabs.dart';
import 'package:production_automation_testing/Database/Curd_operation/boxes.dart';

import '../../DashBoard/src/ProjectCardOverview.dart';
import '../../DashBoard/src/cardcount/productcount.dart';
import '../../Database/Curd_operation/HiveModel/productmodel.dart';
import '../../Database/Curd_operation/HiveModel/usermodel.dart';
import '../../Database/Curd_operation/database.dart';
import '../../Model/APIModel/productmodel.dart';
import '../../Provider/excelprovider.dart';
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

  bool all = true;
  bool active = false;
  bool inactive = false;
  int looping = 0;
  bool procount = true;

  @override
  void initState() {
    ref.refresh(getProductNotifier);
  }

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
    return ref.watch(getProductNotifier).when(
        data: (datum) {
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
                            MaterialButton(
                              padding: const EdgeInsets.all(15),
                              onPressed: () {
                                setState(() {
                                  product.productId = 0;
                                  product.productCode = "";
                                  product.productName = "";
                                  product.quantity = 0;
                                  product.status = "";
                                  product.timeRequired = 0;
                                  product.description = "";

                                  AddProduct(product: product);
                                  _isShow = !_isShow;
                                  procount = !procount;
                                });
                              },
                              child: const Icon(
                                Icons.open_in_browser_rounded,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),

                          ],
                        ),
                      ),
                      Consumer(
                          builder: (context, ref, child) {
                            return ref.watch(getProductCountNotifier).when(
                                data: (count){
                                  return Container(
                                    margin: EdgeInsets.only(top: 5.0),
                                    height: 200.0,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),
                                            ProductCountView(
                                                color: Color(0xffFF4C60),
                                                projectName: 'Product Count',
                                                percentComplete: '${count[0].productCount}%',
                                                peopleCount: count[0].productCount,
                                                progressIndicatorColor: Colors.redAccent[100],
                                                icon: Feather.credit_card,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            ProductCountView(
                                                color: Color(0xff6C6CE5),
                                                projectName: 'Created',
                                                percentComplete: '${count[0].created}%',
                                                peopleCount: count[0].created,
                                                progressIndicatorColor: Colors.blue[200],
                                                icon: Feather.book_open,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            ProductCountView(
                                                color: Color(0xffFAAA1E),
                                                projectName: 'Verified',
                                                percentComplete: '${count[0].verified}%',
                                                peopleCount: count[0].verified,
                                                progressIndicatorColor: Colors.amber[200],
                                                icon: Icons.verified
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                            visible: procount,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                ProductCountView(
                                                    color: Color(0xff2d6666),
                                                    projectName: 'Approved',
                                                    peopleCount: count[0].approved,
                                                    percentComplete: '${count[0].approved}%',
                                                    progressIndicatorColor: Colors
                                                        .tealAccent[200],
                                                    icon: Icons.fmd_good_outlined),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                ProductCountView(
                                                    color: Color(0xff4c2d66),
                                                    projectName: 'Rejected',
                                                    peopleCount: count[0].rejected,
                                                    percentComplete: '${count[0].rejected}%',
                                                    progressIndicatorColor: Colors
                                                        .deepPurpleAccent[200],
                                                    icon: Icons.fmd_bad),
                                              ],
                                            ))

                                      ],
                                    ),
                                  );
                                }, error: (e,s){
                                  return Text((e.toString()));
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
                            ElevatedButton(
                                child: Text("All".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.black)))),
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
                                child: Text("Active".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.black)))),
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
                                child: Text("In Active".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.black)))),
                                onPressed: () {
                                  setState(() {
                                    all = false;
                                    active = false;
                                    inactive = true;
                                  });
                                }),
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
                          color: Color(0xff8fcceb),
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
                                          color: Colors.black))),
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
                                          color: Colors.black))),
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
                                          color: Colors.black))),
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
                                          color: Colors.black))),
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
                                          color: Colors.black))),
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
                                          color: Colors.black))),
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
                                color: Color(0xFFd9d8d7),

                                child: ValueListenableBuilder<
                                    Box<ProductModel>>(
                                    valueListenable: Products.getProducts()
                                        .listenable(),
                                    builder: (context, Box<ProductModel> items,
                                        _) {
                                      List<int> keys;
                                      keys = items.keys.cast<int>().toList();
                                      datamodels = items.values.toList().cast<
                                          ProductModel>();
                                      return ListView.builder
                                        (
                                          itemCount: () {
                                            if (all == true) {
                                              return datum.length;
                                            } else if (active == true) {
                                              return activevalue.length;
                                            } else if (inactive == true) {
                                              return inactivevalue.length;
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
                                      );
                                    }
                                ),
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
      return Text(e.toString());
    }, loading: () {
      return CircularProgressIndicator();
    });

    // });
  }

  getProduct(List<Productmodel> items, int index) {
    return Card(
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
                child: Center(child: Text(items[index].productCode.toString(),
                    style: TextStyle(fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.black))),
              ),
            ),
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(items[index].productName.toString(),
                    style: TextStyle(fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.black))),
              ),
            ),
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(items[index].quantity.toString(),
                    style: TextStyle(fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.black))),
              ),
            ),
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(items[index].status.toString(),
                    style: TextStyle(fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.black))),
              ),
            ),
            Expanded(
              child: Container(
                height: 20.0,
                width: 10.0,
                child: Center(child: Text(items[index].timeRequired.toString(),
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
                            product.description = items[index].description
                                .toString();
                            product.templateId = int.parse(items[index]
                                .templateId.toString());
                            product.flg = items[index].flg;

                            AddProduct(product: product);

                            _isShow = true;
                            procount = false;
                          });
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          // Product().deleteProduct(datamodels[index]);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ),
            ),

          ],
        ));
  }

  getActiveItems(List<Productmodel> items, int index) {
    var activevalue = items.where((element) => element.flg == 1).toList();
    return Card(
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
                child: Center(child: Text(
                    activevalue[index].productCode.toString(), style: TextStyle(
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
                    activevalue[index].productName.toString(), style: TextStyle(
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
                    activevalue[index].quantity.toString(), style: TextStyle(
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
                      activevalue[index].status.toString(), style: TextStyle(
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
                    activevalue[index].timeRequired.toString(),
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
                            product.templateId = int.parse(activevalue[index]
                                .templateId.toString());
                            product.flg = activevalue[index].flg;

                            AddProduct(product: product);


                            _isShow = true;
                            procount = false;
                          });
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          //  Product().deleteProduct(activevalue[index]);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ),
            ),

          ],
        ));
  }

  getInActiveItems(List<Productmodel> items, int index) {
    var inactivevalue = items.where((element) => element.flg == 0).toList();
    return Card(
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
                child: Center(child: Text(
                    inactivevalue[index].productCode.toString(),
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
                    inactivevalue[index].productName.toString(),
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
                    inactivevalue[index].quantity.toString(), style: TextStyle(
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
                    inactivevalue[index].status.toString(), style: TextStyle(
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
                    inactivevalue[index].timeRequired.toString(),
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
                            product.templateId = int.parse(inactivevalue[index]
                                .templateId.toString());
                            product.flg = inactivevalue[index].flg;


                            AddProduct(product: product);
                            _isShow = true;
                            procount = false;
                          });
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          // Product().deleteProduct(inactivevalue[index]);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ),
            ),

          ],
        ));
  }
}

