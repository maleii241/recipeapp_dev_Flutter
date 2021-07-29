import 'package:flutter/material.dart';
import 'constants.dart';
import 'shared.dart';


import 'data.dart';

class Detail extends StatelessWidget {

  final Recipe recipe;

  Detail({@required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
          leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,

          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.favorite_border,

            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  buildTextTitleVariation1(recipe.title),

                  buildTextSubTitleVariation1(recipe.description),

                ],
              ),
            ),

            SizedBox(
              height: 16,
            ),

            Container(
              height: 310,
              padding: EdgeInsets.only(left: 16),
              child: Stack(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      buildTextTitleVariation2('Питание', true),

                      SizedBox(
                        height: 16,
                      ),

                      buildNutrition(recipe.calories, "Calories", "Kcal"),

                      SizedBox(
                        height: 16,
                      ),

                      buildNutrition(recipe.carbo, "Carbo", "g"),

                      SizedBox(
                        height: 16,
                      ),

                      buildNutrition(recipe.protein, "Protein", "g"),

                    ],
                  ),

                  Positioned(
                    right: -80,
                    child: Hero(
                      tag: recipe.image,
                      child: Container(
                        height: 310,
                        width: 310,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(recipe.image),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  buildTextTitleVariation2('Ингредиенты', true),

                  buildTextSubTitleVariation1("Мясо  — 1 кг."),
                  buildTextSubTitleVariation1("Грибы  — 1 кг."),
                  buildTextSubTitleVariation1("Лук  — 3-4 шт. "),
                  buildTextSubTitleVariation1("Чеснок  — 4 Зубчика"),
                  buildTextSubTitleVariation1("Сметана  — 200 гр."),
                  buildTextSubTitleVariation1("Соль, перец  — По вкусу"),

                  SizedBox(height: 16,),

                  buildTextTitleVariation2('Приготовление рецепта', true),

                  buildTextSubTitleVariation1("Шаг 1"),
                  buildTextSubTitleVariation1("Мясо промойте и порежьте кусочками, мелкими кусочками. Лук порежьте полукольцами. Грибы пускай проварятся минут 5."),

                  buildTextSubTitleVariation1("Шаг 2"),
                  buildTextSubTitleVariation1("Обжариваем в масле сначала лук, потом к нему добавляем грибы. Когда лучок станет золотистым, выкладываем на сковороду мясо. Следите, чтобы предварительно из грибов вся влага прожарилась, не было жидкости. "),

                  buildTextSubTitleVariation1("Шаг 3"),
                  buildTextSubTitleVariation1("Хорошо перемешайте, накройте крышкой, пускай мясо томится в собственном соку. Спустя 10 минут крышку снимаем, солим и перчим, ждем, пока испарится вся жидкость. Потом добавьте сметану и выдавленный чеснок. Жарим минут 5. Наше жареное мясо с грибами готово! Подавать можно с картофелем или овощами. Приятного аппетита!"),

                ],
              ),
            ),

          ],
        ),
      ),

    );
  }

  Widget buildNutrition(int value, String title, String subTitle){
    return Container(
      height: 60,
      width: 150,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
       // boxShadow: [kBoxShadow],
      ),
      child: Row(
        children: [

          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(

              shape: BoxShape.circle,
             // boxShadow: [kBoxShadow],
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(
            width: 20,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,

                ),
              ),

            ],
          ),

        ],
      ),
    );
  }

}