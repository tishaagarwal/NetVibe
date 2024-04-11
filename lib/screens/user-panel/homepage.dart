import 'package:ecommerce/widgets/banner-widget.dart';
import 'package:ecommerce/widgets/categories-widget.dart';
import 'package:ecommerce/widgets/custom-drawer-widget.dart';
import 'package:ecommerce/widgets/heading-widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app-constent.dart';
import '../../widgets/all-products-widget.dart';
import '../../widgets/flash-sale-widget.dart';
import 'all-categories-screen.dart';
import 'all-flash-sale-product.dart';
import 'all-products-screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConst.appTextColor1),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConst.appMainColor,
        title: Text('NetVibe', style: TextStyle(color: AppConst.appTextColor1)),
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: Get.height/90,),
              BannerWidget(),
              HeadingWidget(headingTitle: "Categories", headingSubTitle: "According to your budget", onTap: () => Get.to(() => AllCategoriesScreen()), buttonText: "See More >"),
              CategoriesWidget(),
              HeadingWidget(headingTitle: "Flash Sale", headingSubTitle: "According to your budget", onTap: () => Get.to(() => AllFlashSaleProductScreen()), buttonText: "See More >"),
              FlashSaleWidget(),
              HeadingWidget(headingTitle: "All Products", headingSubTitle: "According to your budget", onTap: () => Get.to(() => AllProductsScreen()), buttonText: "See More >"),
              AllProductsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}