import 'package:appbanhang/pages/auth/login.dart';
import 'package:appbanhang/pages/card/cart.dart';
import 'package:appbanhang/pages/home/widget/home_category.dart';
import 'package:appbanhang/pages/home/widget/home_slider.dart';
import 'package:appbanhang/pages/home/widget/list_product_special.dart';
import 'package:appbanhang/pages/order/order.dart';
import 'package:appbanhang/provider/auth_provider.dart';
import 'package:appbanhang/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return auth.isAuth
            ? const Home()
            : FutureBuilder(
                future: auth.autoLogin(),
                initialData: false,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData && snapshot.data!) {
                      return const Home();
                    } else {
                      return const LoginPage();
                    }
                  }
                },
              );
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<AuthProvider>(context).checkTimeExpires();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('Hải Nguyễn'),
              accountEmail: Text('your_email@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://static1.xdaimages.com/wordpress/wp-content/uploads/2018/02/Flutter-Framework-Feature-Image-Background-Colour.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // TODO: Implement home navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('List Cart'),
              onTap: () {
                // TODO: Implement home navigation
                Navigator.popAndPushNamed(context, Order.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // TODO: Implement logout functionality
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('APP'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: Consumer<CartProvider>(
              builder: (context, value, child) {
                return badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -13),
                  showBadge: true,
                  ignorePointer: false,
                  onTap: () {},
                  badgeContent: Text(value.items.length.toString()),
                  badgeAnimation: const badges.BadgeAnimation.rotation(
                    animationDuration: Duration(seconds: 1),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CartPage.routeName);
                      },
                      child: const Icon(
                        Icons.shopping_cart,
                        size: 25,
                      )),
                );
              },
            ),
          )
        ],
      ),
      body: const Column(
        children: [
          HomeSlider(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Danh mục sản phẩm',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  'Tất cả (4)',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          HomeCategory(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sản phẩm nổi bật',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text('Tất cả (4)'),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListProductSpecial(),
        ],
      ),
    );
  }
}
