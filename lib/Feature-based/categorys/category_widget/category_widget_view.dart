import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../app/configuration/themes/app_colors.dart';
import '../../../utils/Common_buttons&widgets/AppLoding_widget.dart';
import '../categorys_controller/categorys_controller.dart';
import 'category_basedOnproducts/category_basedon_controller.dart';
import 'category_basedOnproducts/properties_based_onCategory_screen.dart';
import 'html_icons_image.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoader());
        }

        return SizedBox(
          // height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];

              return GestureDetector(
                onTap: () {

                  if (!Get.isRegistered<CategoryBasedonController>()) {
                    Get.put(CategoryBasedonController());
                  }

                  Get.to(() => Category_Properties_listScreen(
                    categoryId: category.id ?? '',
                    title: 'Properties',
                    primaryColor: Get.arguments['primaryColor'],
                    accentColor: Get.arguments['accentColor'],
                    cardColor: Get.arguments['cardColor'],
                    secondaryTextColor: Get.arguments['secondaryTextColor'],
                  ), arguments: {
                    'primaryColor': Color(0xFFe4b201),
                    'accentColor':Color(0xFF757575) ,
                    'cardColor': Colors.white,
                    'secondaryTextColor': Color(0xFFe4b201),
                  });

                },
                child: Container(
                  width: 70,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2.0,
                          ),
                        ),
                        child: Icon(
                          getIconDataFromHtml(category.propertyCategoryicon),
                          color: AppColors.primary,
                          size: 28.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Text(
                      //   category.propertyCategoryTitle,
                      //   style: const TextStyle(
                      //     color: AppColors.secondaryTextColor,
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      //   textAlign: TextAlign.center,
                      //   maxLines: 2,
                      //   overflow: TextOverflow.ellipsis,
                      //   softWrap: true,
                      // ),

                      Text(
                        category.propertyCategoryTitle,
                        style: const TextStyle(
                          color: AppColors.secondaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),

                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
