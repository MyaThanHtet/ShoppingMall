import 'package:flutter/material.dart';
import 'package:shopping_mall/model/ProductModel.dart';
import 'package:shopping_mall/network/ApiControl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteProductScreen extends StatefulWidget {
  const FavouriteProductScreen({Key? key}) : super(key: key);

  @override
  _FavouriteProductScreenState createState() => _FavouriteProductScreenState();
}

class _FavouriteProductScreenState extends State<FavouriteProductScreen> {
  List<int> articalIdList = [2];

  late int _articalId = 0;
  @override
  void initState() {
    productID();
    super.initState();
  }

  void productID() async {
    var preferences = await SharedPreferences.getInstance();
    _articalId = preferences.getInt("id")!;
    print("ID ${_articalId}");
  }

  // void getArticalID() async {
  //   var preferences = await SharedPreferences.getInstance();

  //   for (int i = 1; i <= 10; i++) {
  //     articalIdList.add(preferences.getInt("${i}id")!);
  //   }
  // }

  // void getProductId() {
  //   setState(() {
  //     for (int i = 0; i < articalIdList.length; i++) {
  //       _articalId = articalIdList[i];
  //     }
  //   });

  //   // new Future.delayed(new Duration(microseconds: 1000), () async {
  //   //   getProductId();
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Product>(
        future: ApiControl.fetchArticleByID(_articalId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                ListView.builder(
                  itemBuilder: (BuildContext, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data!.image!),
                        ),
                        title: Text(snapshot.data!.title.toString()),
                        subtitle: Text(
                          '\$' + snapshot.data!.price.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 253, 104, 104),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                  itemCount: articalIdList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                ),
              ],
            );
          } else {
            return const Text(
              "Empty",
              textAlign: TextAlign.center,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            productID();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
