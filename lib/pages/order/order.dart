import 'package:appbanhang/model/product_model.dart';
import 'package:appbanhang/provider/order_provider.dart';
import 'package:appbanhang/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  const Order({super.key});
  static const routeName = '/order';

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách đơn hàng'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrderProvider>(context, listen: false)
            .getListOrderCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data as List;
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var dataitems = data[index]['order_items'];
                    return ExpansionTile(
                        title: Text('Mã đơn hàng : ${data[index]['code']}'),
                        subtitle: Text(DateFormat('kk:mm - dd-MM-yyyy ')
                            .format(DateTime.parse(data[index]['created_at']))),
                        children: [
                          ListView.builder(
                            itemCount: dataitems.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                future: Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .getProductById(
                                        dataitems[index]['product_id']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  var item = snapshot.data as ProductModel;
                                  return ListTile(
                                    leading: Image.network(item.image),
                                    title: Text(item.name),
                                  );
                                },
                              );
                            },
                          )
                        ]);
                  },
                )
              : Container(
                  child: const Center(
                    child: Text('no data'),
                  ),
                );
        },
      ),
    );
  }
}
