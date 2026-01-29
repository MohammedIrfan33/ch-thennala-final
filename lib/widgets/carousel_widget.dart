import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class CarousalWidget extends StatefulWidget {
  const CarousalWidget({super.key});

  @override
  State<CarousalWidget> createState() => _CarousalWidgetState();
}

class _CarousalWidgetState extends State<CarousalWidget> {
   final List<Widget> carouselImages = [
    Container(
      width: double.infinity,
      child: ClipRRect(
         borderRadius: BorderRadius.circular(10),
          child: Image.asset("assets/banner/Scrolling 1.jpg", fit: BoxFit.fill)),
    ),
    Container(
      width: double.infinity,
      child: ClipRRect(
         borderRadius: BorderRadius.circular(10),
          child: Image.asset("assets/banner/Scrolling 2.jpg",fit: BoxFit.fill)),
    ),
    Container(
      width: double.infinity,
      child: ClipRRect(

        borderRadius: BorderRadius.circular(10),
          child: Image.asset("assets/banner/Scrolling 3.jpg",fit: BoxFit.fill)),
    ),
     Container(
       width: double.infinity,
       child: ClipRRect(

           borderRadius: BorderRadius.circular(10),
           child: Image.asset("assets/banner/Scrolling 4.jpg",fit: BoxFit.fill)),
     ),
     
  ];

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return  Stack(
            children: [
              CarouselSlider(
                items: carouselImages,
                options: CarouselOptions(
                height: 160,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  viewportFraction: Platform.isIOS ? 0.88 : 0.89,
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
              ),
              Positioned(
                bottom:
                    10, // Adjust this value to control the vertical position
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    carouselImages.length,
                    (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: _currentPage == index ? 12 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.transparent),
                          color: _currentPage == index
                              ? Colors.white
                              : const Color.fromARGB(118, 189, 189, 189),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}