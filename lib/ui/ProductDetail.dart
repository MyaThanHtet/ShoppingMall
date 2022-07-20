import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_mall/model/ProductModel.dart';
import 'package:shopping_mall/network/ApiControl.dart';

class ProductDetailScreen extends StatefulWidget {
  final int articalID;

  const ProductDetailScreen({Key? key, required this.articalID})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreen(articalID);
}

class _ProductDetailScreen extends State<ProductDetailScreen> {
  int articalID;
  _ProductDetailScreen(this.articalID);

  late bool isFav = false;

  @override
  void initState() {
    _restoreFavPreferences();
    super.initState();
  }

  void _restoreFavPreferences() async {
    var preferences = await SharedPreferences.getInstance();
    var isFav = preferences.getBool(articalID.toString());
    setState(() => this.isFav = isFav!);
  }

  void _saveFavPreferences() async {
    setState(() => isFav = !isFav);
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool(articalID.toString(), isFav);

    // preferences.setInt(articalID.toString(), articalID);
  }

  void _saveFavItem() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setInt("id", articalID);
  }

  void _removeFavItem() async {
    setState(() => isFav = !isFav);
    var preferences = await SharedPreferences.getInstance();
    await preferences.remove("id");
    await preferences.setBool(articalID.toString(), isFav);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder<Product>(
        future: ApiControl.fetchArticleByID(articalID),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data!.image!),
                                  fit: BoxFit.contain)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!.category!.toString(),
                                style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 202, 184, 20),
                                  ),
                                  Text(
                                    snapshot.data!.rating!.rate.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '(' +
                                        snapshot.data!.rating!.count
                                            .toString() +
                                        ' Reviews)',
                                    style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Information',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data!.description!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                            style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$ ' + snapshot.data!.price!.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w800),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  enableFeedback: false,
                                  onPressed: () {
                                    setState(() {
                                      if (!isFav) {
                                        _saveFavPreferences();
                                        _saveFavItem();
                                      } else {
                                        _removeFavItem();
                                      }
                                    });
                                  },
                                  icon: isFav
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.pink,
                                          size: 35,
                                        )
                                      : const Icon(
                                          Icons.favorite_outline,
                                          color: Colors.pink,
                                          size: 35,
                                        ),
                                ),
                              )
                            ]),
                      ),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
