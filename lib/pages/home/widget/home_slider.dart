import 'package:appbanhang/provider/silder_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  late Future listSlider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    listSlider = Provider.of<SliderProvider>(context).getSlider();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FutureBuilder(
        future: listSlider,
        initialData: const [],
        builder: (context, snapshot) {
          var dataSlider = [];
          if (snapshot.hasData) {
            dataSlider = snapshot.data! as List;
          } else {
            print(snapshot.error);
            return Container(
              child: const Text('Error'),
            );
          }
          return snapshot.hasData
              ? CarouselSlider(
                  options: CarouselOptions(
                    height: 180.0,
                  ),
                  items: dataSlider.map((slider) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(slider.image),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              : Container(
                  child: const Text('No data'),
                );
        },
      ),
    );
  }
}
