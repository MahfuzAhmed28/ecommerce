import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/core/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/features/common/controllers/home_slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({
    super.key,
  });

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  int _selectedSlider=0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSliderController>(
      builder: (homeSliderController){
        return Visibility(
          visible: homeSliderController.getSliderInProgress==false,
          replacement: SizedBox(
            height: 200,
            child: CenteredCircularProgressIndicator(),
          ),
          child: Visibility(
            visible: homeSliderController.sliders.isNotEmpty,
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                      height: 200.0,
                      viewportFraction: 0.90,
                      onPageChanged: (index,reason){
                        _selectedSlider=index;
                        setState(() {});
                      }
                  ),
                  items: homeSliderController.sliders.map((slider) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              color: AppColors.themeColor,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(image: NetworkImage(slider.photoUrl),
                                fit: BoxFit.cover
                              )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '${slider.description}',
                                style: TextStyle(fontSize: 16.0,color: Colors.grey),
                              ),
                            )
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(int i=0;i<homeSliderController.sliders.length;i++)
                      Container(
                        width: 16,
                        height: 16,
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                          color: _selectedSlider==i ? AppColors.themeColor : Colors.white,
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        );
      },

    );
  }
}