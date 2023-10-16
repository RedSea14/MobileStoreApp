import 'package:appbanhang/pages/product/product.dart';
import 'package:appbanhang/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategodyBody extends StatefulWidget {
  const CategodyBody({super.key});

  @override
  State<CategodyBody> createState() => _CategodyBodyState();
}

class _CategodyBodyState extends State<CategodyBody> {
  late Future listProductinCategory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    listProductinCategory =
        Provider.of<CategoryProvider>(context).getProductCategory(data['id']);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: FutureBuilder(
          future: listProductinCategory,
          initialData: const [],
          builder: (context, snapshot) {
            var dataProductCategory = [];
            if (snapshot.hasData) {
              dataProductCategory = snapshot.data! as List;
            } else {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? GridView.builder(
                    itemCount: dataProductCategory.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 3.5,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, ProductPage.routerName,
                              arguments: {"data": dataProductCategory[index]});
                        },
                        child: GridTile(
                            footer: GridTileBar(
                              title: Text(
                                dataProductCategory[index].name,
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    dataProductCategory[index].summary,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    dataProductCategory[index].price.toString(),
                                    style: const TextStyle(
                                        color: Colors.yellow, fontSize: 15),
                                  ),
                                ],
                              ),
                              trailing: const Icon(Icons.ac_unit_outlined),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          dataProductCategory[index].image),
                                      fit: BoxFit.cover)),
                            )),
                      );
                    },
                  )
                : Container(
                    child: const Center(
                      child: Text('No Data'),
                    ),
                  );
          },
        ));
  }
}
