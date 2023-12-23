import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pagoda_tgu/model/glass_of_Incense.dart';
import 'package:pagoda_tgu/model/incense.dart';
import 'package:pagoda_tgu/model/oil_lamp.dart';
import 'package:pagoda_tgu/model/table.dart';



class HomePage extends FlameGame{
  
  SpriteComponent background = new SpriteComponent();
  SpriteAnimationComponent fireAnimation = SpriteAnimationComponent();

  IncenseModel? incenseModel;

  TableModel? tableModel;

  GlassOfIncenseModel? glassOfIncenseModel;

  OliLampModel? oliLampModel;



  @override
  Future<void> onLoad() async {
     super.onLoad();

    final screenWidth = size[0];
    final screenHeight = size[1];

     add(background
      ..sprite = await loadSprite('Congchua.png')
      ..size = Vector2(screenWidth,screenHeight/2));

    incenseModel = IncenseModel(screenWidth, screenHeight);

    tableModel = TableModel(screenWidth, screenHeight, background);

    glassOfIncenseModel = GlassOfIncenseModel(screenWidth, screenHeight, tableModel);

    oliLampModel = OliLampModel(screenWidth, screenHeight, tableModel);


    await add(tableModel!);

    await add(oliLampModel!);

    await add(glassOfIncenseModel!);

    await add(incenseModel!);



    var spriteSheet = await images.load('firesheet.png');
    final spriteSize = Vector2(50, 100);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
      amount: 4, stepTime: 0.5, textureSize: Vector2(395,2000.0));



    fireAnimation =
    SpriteAnimationComponent.fromFrameData(spriteSheet, spriteData)
    ..x = oliLampModel!.x 
    ..y = oliLampModel!.y - spriteSize.y/1.3
    ..size = spriteSize;

    await add(fireAnimation);
    

  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);



    if(glassOfIncenseModel!.x1! < incenseModel!.x2! && incenseModel!.x1! < glassOfIncenseModel!.x2!
     && glassOfIncenseModel!.y1! < incenseModel!.y2! && incenseModel!.y1! < glassOfIncenseModel!.y2! ){

      print("hello world");

     }



  }
 
  @override
  Color backgroundColor() => const Color(0xFFeeeeee);

}