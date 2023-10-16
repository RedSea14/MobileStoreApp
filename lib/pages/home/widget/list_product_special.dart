import 'package:appbanhang/provider/cart_provider.dart';
import 'package:appbanhang/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class ListProductSpecial extends StatefulWidget {
  const ListProductSpecial({super.key});

  @override
  State<ListProductSpecial> createState() => _ListProductSpecialState();
}

class _ListProductSpecialState extends State<ListProductSpecial> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: FutureBuilder(
          future: Provider.of<ProductProvider>(context).getProductSpecial(),
          initialData: const [],
          builder: (context, snapshot) {
            var dataProductSpecial = [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              dataProductSpecial = snapshot.data as List;
            } else {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image(
                          image: NetworkImage(dataProductSpecial[index].image),
                          fit: BoxFit.fill,
                        ),
                        title: Text(
                          dataProductSpecial[index].name,
                          maxLines: 2,
                        ),
                        subtitle: Text(intl.NumberFormat.simpleCurrency(
                                locale: 'vi', decimalDigits: 0)
                            .format(dataProductSpecial[index].price)),
                        trailing: InkWell(
                          onTap: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .addCart(
                              dataProductSpecial[index].id,
                              dataProductSpecial[index].image,
                              dataProductSpecial[index].name,
                              dataProductSpecial[index].price,
                            );
                          },
                          child: const Icon(Icons.shopping_cart),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 5,
                      );
                    },
                    itemCount: dataProductSpecial.length)
                : const Center(
                    child: Text('No Data'),
                  );
          },
        ));
  }
}
