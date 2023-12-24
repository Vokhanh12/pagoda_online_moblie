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
  var fireWidth = 50.0;
  var fireHeigth = 100.0;
  double? x1_fire,x2_fire;
  double? y1_fire,y2_fire;

  SpriteAnimationComponent fireAnimationOnIncense = SpriteAnimationComponent();
  bool _statusFireOnIncense = false;
  bool _fireAnimationOnIncenseAdded = false; 
  int quantity = 1;


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




    // handle fire animation

    
    var spriteSheet = await images.load('firesheet.png');
    final spriteSize = Vector2(fireWidth, fireHeigth);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
      amount: 4, stepTime: 0.5, textureSize: Vector2(395,2000.0));



    fireAnimation =
    SpriteAnimationComponent.fromFrameData(spriteSheet, spriteData)
    ..x = oliLampModel!.x 
    ..y = oliLampModel!.y - spriteSize.y/1.3
    ..size = spriteSize;

    await add(fireAnimation);

      // set X1,X2,Y1,Y2 fire 

      x1_fire = fireAnimation.position.x;
      y1_fire = fireAnimation.position.y;
      
      x2_fire = x1_fire! + fireWidth;
      y2_fire = y1_fire! + fireHeigth;



      // handle fire animation on incense

      if(_statusFireOnIncense){
        
         var spriteSheet = await images.load('firesheet.png');
         final spriteSize = Vector2(fireWidth, fireHeigth);
         SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
         amount: 4, stepTime: 0.5, textureSize: Vector2(395,2000.0));



        fireAnimationOnIncense =
        SpriteAnimationComponent.fromFrameData(spriteSheet, spriteData)
        ..x = incenseModel!.x 
        ..y = incenseModel!.y - spriteSize.y/1.3
        ..size = spriteSize;

        await add(fireAnimationOnIncense);

        print("run");

      }


    

  }

  @override
  void update(double dt) async{
    // TODO: implement update
    super.update(dt);


    if(x1_fire! < incenseModel!.x2! && incenseModel!.x1! < x2_fire!
    && y1_fire! < incenseModel!.y2! && incenseModel!.y1! < y2_fire! ){

      _statusFireOnIncense = true;

      print("true");

    }

    fireAnimationOnIncense.position.x = incenseModel!.x1! - incenseModel!.width/1.4;
    fireAnimationOnIncense.position.y = incenseModel!.y1! - incenseModel!.height - 20;


    if (!_statusFireOnIncense || _fireAnimationOnIncenseAdded) {
      return;
    }

    var spriteSheet = await images.load('firesheet.png');
    final spriteSize = Vector2(fireWidth, fireHeigth);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
      amount: 4, stepTime: 0.5, textureSize: Vector2(395, 2000.0),
    );

    fireAnimationOnIncense =
        SpriteAnimationComponent.fromFrameData(spriteSheet, spriteData)
          ..x = incenseModel!.x
          ..y = incenseModel!.y - spriteSize.y / 1.3
          ..size = spriteSize;

    await add(fireAnimationOnIncense);
    _fireAnimationOnIncenseAdded = true;

   



  }
  




  
 
  @override
  Color backgroundColor() => const Color(0xFFeeeeee);

}