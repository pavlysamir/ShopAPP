import 'package:flutter/material.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cashe_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login_Screen/Login_Screen.dart';

class BoardingModeling{
  String? image;
  String? title;
  String? messege;

  BoardingModeling({required this.image,required this.title,required this.messege});
}

List<BoardingModeling> modelBoarding=[
  BoardingModeling(image: 'assets/images/onboarding.gif', title: 'On Boarding no 1', messege: 'Hello 1'),
  BoardingModeling(image: 'assets/images/onboarding.gif', title: 'On Boarding no 2', messege: 'Hello 2'),
  BoardingModeling(image: 'assets/images/onboarding.gif', title: 'On Boarding no 3', messege: 'Hello 3'),
];

bool isLast =false;

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var BoardController = PageController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();
          }, child: const Text('Skip',
            style: TextStyle(color: Colors.blue,
              fontSize: 25
            ),
          ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context,index)=>buildBoardingItem(modelBoarding[index]),
              itemCount: modelBoarding.length,
                physics: BouncingScrollPhysics(),
                controller: BoardController,
                onPageChanged: (int index){
                  if(index== modelBoarding.length - 1 ){
                    setState(() {
                      print('last');
                      isLast = true;
                    });
                  }
                  else{
                    setState(() {
                      print('not last');
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
              SmoothPageIndicator(controller: BoardController,
                count: modelBoarding.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5
                ),
              ) ,
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {

                    if(isLast){
                      submit();
                    }
                    else{
                      BoardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModeling model) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image: AssetImage('${model.image}'),
          height: 250,
          width: double.infinity,
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        '${model.messege}',
        style: TextStyle(
          fontSize: 35,
        ),
      ),
      SizedBox(
        height: 20,
      ),

    ],
  );
  void submit(){
    CasheHelper.SaveData(key: 'onBoarding', value: true).then(
            (value) {
      NavigateAndFinish(
          context,
          LoginScreen()
      );
    });
  }
}

