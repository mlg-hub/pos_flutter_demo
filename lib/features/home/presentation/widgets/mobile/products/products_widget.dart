import 'package:flutter/material.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:google_fonts/google_fonts.dart';

import 'product_item_widget.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget(
      {Key? key, required this.products, required this.onTapProduct})
      : super(key: key);

  final List<Product> products;
  final Function(Product product) onTapProduct;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (cttx, contrains) {
        // print(MediaQuery.of(cttx).size.height);
        return SizedBox(
          height: MediaQuery.of(cttx).size.height,
          child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (cttx, idx) {
                final Product singleProduct = products[idx];
                return Card(
                  child: ListTile(
                    onTap: () {
                      onTapProduct(singleProduct);
                    },
                    title: Text(singleProduct.name),
                    trailing: SizedBox(
                      height: 100,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            singleProduct.salePrice != null &&
                                    singleProduct.salePrice! > 0
                                ? '${singleProduct.salePrice?.toStringAsFixed(2)}'
                                : singleProduct.price.toStringAsFixed(2),
                            style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'BIF',
                            style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
      // padding: const EdgeInsets.all(16.0),
      // child: Expanded(
      // )

      // GridView.count(
      //   shrinkWrap: true,
      //   physics: const NeverScrollableScrollPhysics(),
      //   padding: EdgeInsets.zero,
      //   crossAxisCount: 1,
      //   mainAxisSpacing: 6,
      //   crossAxisSpacing: 8,
      //   children: products
      //       .map(
      //         (Product product) => GestureDetector(
      //           onTap:
      //           child: ProductItemWidget(
      //             productName: product.name,
      //             productImage: faker.image.loremPicsum.image(),
      //             productPrice: product.price,
      //             productSalePrice: product.salePrice,
      //             product: product,
      //           ),
      //         ),
      //       )
      //       .toList(),
      // ),
    );
  }
}
