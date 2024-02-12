import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/utils/responsive/Adapt.dart';
import 'package:frontend/widgets/header.dart';
import 'package:frontend/widgets/log_out.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ProductService productService = ProductService();

  List<Product>? data;

  @override
  void initState() {
    super.initState();
    // productService.getProducts().then((value) {
    //   setState(() {
    //     data = value;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        actions: [logOut(context, Colors.redAccent)],
      ),
      body: Container(
        padding: EdgeInsets.all(Adapt.px(10)),
        child: FutureBuilder(
            future: productService.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return Column(
                children: [
                  header('Productos', context),
                  if (snapshot.connectionState == ConnectionState.waiting)
                    Center(child: CircularProgressIndicator()),
                  if (snapshot.hasData)
                    Expanded(
                      child: ItemList(
                        list: snapshot.data as List<Product>,
                      ),
                    ),
                  if (!snapshot.hasData && !snapshot.hasError)
                    Center(child: Text('Cargando')),
                  if (snapshot.hasError)
                    Center(child: Text('Error: ${snapshot.error}')),
                ],
              );
            }),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<Product>? list;

  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: list == null ? 0 : list?.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            Container(
              width: 190,
              height: 190,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(5),
                elevation: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      Image.asset(
                        list![i].image.toString(),
                        height: 120,
                      ),
                      Text(list![i].name.toString(),
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black)),
                      Text('\$${list![i].price.toString()}',
                          style: TextStyle(fontSize: 20.0, color: Colors.black))
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
