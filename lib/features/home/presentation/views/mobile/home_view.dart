import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thepos/features/carts/presentation/controllers/carts_controller.dart';
import 'package:thepos/features/home/presentation/controllers/home_controller.dart';
import 'package:thepos/routes/mobile_app_pages.dart';

import '../../widgets/mobile/cart_floating_action_button.dart';
import '../../widgets/mobile/categories_widget.dart';
import '../../widgets/mobile/home_silver_app_bar.dart';
import '../../widgets/mobile/products/products_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final CartsController cartsController = Get.put(CartsController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController = Get.find<HomeController>();

    return Obx(
      () => Scaffold(
        floatingActionButton: CartFloatingActionButton(
          numberOfOpenedCart: cartsController.listCarts.length,
          onPressed: _navigateToCartView,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          slivers: <Widget>[
            HomeSilverAppBar(
              appBartitle: 'Invoice List',
              onSearchTextChanged: (String value) {
                homeController.onSearch(value);
              },
              onBarCodeButtonPressed: () {
                homeController.modalBottomSheetMenu4();
              },
            ),
            // _buildBody(),
            // _buildHome(),
            _buildInvoiceList(),
          ],
        ),
      ),
    );
  }

  final List homeViewList = [
    "Invoice list",
    "Create invoice",
    "Products",
    "Categories",
    "Profile"
  ];

  final List invoiceList = ["rt009", "rt008", "rt006"];

  SliverPadding _buildInvoiceList() {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverGrid.count(
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        childAspectRatio: 2,
        children: invoiceList
            .map(
              (e) => Card(
                child: ListTile(
                  title: Text("Invoice #" + e),
                  subtitle:
                      Text(DateTime.now().toIso8601String().split("T")[0]),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  SliverPadding _buildHome() {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverGrid.count(
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 3,
        children: homeViewList
            .map(
              (e) => Card(
                child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.green[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.person,
                              size: 40,
                            )),
                        Align(
                            alignment: Alignment.bottomCenter, child: Text(e)),
                      ],
                    )),
              ),
            )
            .toList(),
      ),
    );
  }

  SliverList _buildBody() {
    return SliverList(
        delegate: SliverChildListDelegate(
      <Widget>[
        CategoriesWidget(
          categories: homeController.listCategory,
          selectedCategory: homeController.selectedCategory,
          selectCategory: homeController.changeCategory,
        ),
        if (homeController.loadingHome.value)
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else
          ProductsWidget(
            products: homeController.listHomeProduct,
            onTapProduct: cartsController.addProduct,
          )
      ],
    ));
  }

  void _navigateToCartView() {
    Get.toNamed(MobileRoutes.CART);
  }
}
