import 'package:appbanhang/pages/category/category.dart';
import 'package:appbanhang/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({
    super.key,
  });

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  late Future listCategory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    listCategory = Provider.of<CategoryProvider>(context).getCategory();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          initialData: const [],
          future: listCategory,
          builder: (context, snapshot) {
            var dataCategory = [];
            if (snapshot.hasData) {
              dataCategory = snapshot.data! as List;
            } else {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? SizedBox(
                    height: 80,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, CategoryPage.routename,
                                      arguments: {
                                        'id': dataCategory[index].id,
                                        'name': dataCategory[index].name
                                      });
                                },
                                child: Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          dataCategory[index].image),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(dataCategory[index].name),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: dataCategory.length),
                  )
                : Container(
                    child: const Text('Nodata'),
                  );
          },
        ));
  }
}
