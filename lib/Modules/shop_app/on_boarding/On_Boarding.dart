
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Modules/shop_app/Login/Login_Screen.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/Network/local/Cache_Helper.dart';
import 'package:shop_app/Shared/Style/color/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingModel
{
  final String image;
  final String title;
  final String body;

  OnBoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatelessWidget {
  var Page_Controller = PageController();
   bool IsLast = false;


  List<OnBoardingModel> modelOn =
  [
    OnBoardingModel(image : 'assets/Images/Shopping.png',title: 'Shopping 1',body: 'body 1'),
    OnBoardingModel(image : 'assets/Images/Shopping.png',title: 'Shopping 2',body: 'body 2'),
    OnBoardingModel(image : 'assets/Images/Shopping.png',title: 'Shopping 3',body: 'body 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()
            {
              cache_helper.SaveData(key: 'OnBoarding', value: true).then((value) {
                if(value)
                {
                  NavigatetoFinish(context, login_screen());
                }
              });
            },
              child: Text("Skip"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.00),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                  controller: Page_Controller,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (index)
                  {
                    if(index == modelOn.length-1) { IsLast = true; print("Last");}
                    else {IsLast = false; print("Not Last");}
                  },
                  itemBuilder: (context,index) => BuildItem(modelOn[index]) ,
                  itemCount: modelOn.length,
                )),
            SizedBox(height: 40.00,),
            Row(
              children : [
                SmoothPageIndicator(
                    controller: Page_Controller,
                    count: modelOn.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultcolor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.00,
                    )
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(IsLast)
                      {
                        cache_helper.SaveData(key: 'OnBoarding', value: true).then((value) {
                          if(value)
                          {
                            NavigatetoFinish(context, login_screen());
                          }
                        });
                      }
                    else Page_Controller.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn,);
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined),
                )
            ]
            )
          ],
        ),
      ),
    );
  }
}
Widget BuildItem(OnBoardingModel model) => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(child: Image(image: AssetImage('${model.image}')),),
    SizedBox(height: 20.00),
    Text("${model.title}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.00),),
    SizedBox(height: 20.00),
    Text("${model.body}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.00),),


  ],
  
);

