import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pagoda_tgu/model/buddha.dart';
import 'package:pagoda_tgu/model/chickenOfferings.dart';
import 'package:pagoda_tgu/model/glass_of_Incense.dart';
import 'package:pagoda_tgu/model/incense.dart';
import 'package:pagoda_tgu/model/oil_lamp.dart';
import 'package:pagoda_tgu/model/table.dart';



class HomePage extends FlameGame{
  
  SpriteComponent background = new SpriteComponent();

  SpriteAnimationComponent fireAnimation = SpriteAnimationComponent();
  var fireWidth = 50.0;
  var fireHeigth = 100.0;

  var smokeWidth = 40.0;
  var smokeHeigth = 350.0;

  double? x1_fire,x2_fire;
  double? y1_fire,y2_fire;

  bool isPickGlass = false;

  SpriteAnimationComponent fireAnimationOnIncense = SpriteAnimationComponent();
  SpriteAnimationComponent smokeAnimationOnIncense = SpriteAnimationComponent();
  bool _statusFireOnIncense = false;
  bool _statusSmokeOnIncense = false;
  bool _fireAnimationOnIncenseAdded = false; 
  bool _smokeAnimationOnIncenseAdded = false; 
  int quantity = 1;


  IncenseModel? incenseModel;

  TableModel? tableModel;

  GlassOfIncenseModel? glassOfIncenseModel;

  OliLampModel? oliLampModel;

  BuddhaModel? buddhaModel;

  ChickenOfferingsModel? chickenOfferingsModel;



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

    buddhaModel = BuddhaModel(screenWidth, screenHeight);

    chickenOfferingsModel = ChickenOfferingsModel(screenWidth, screenHeight);


    await add(tableModel!);

    await add(oliLampModel!);

    await add(incenseModel!);

    await add(glassOfIncenseModel!);

    await add(buddhaModel!);

    await add(chickenOfferingsModel!);

    





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
         final spriteSize = Vector2(smokeWidth, screenHeight);
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


      if(glassOfIncenseModel!.x1! < incenseModel!.x2! && incenseModel!.x1! < glassOfIncenseModel!.x2!
    && glassOfIncenseModel!.y1! < incenseModel!.y2! && incenseModel!.y1! < glassOfIncenseModel!.y2! && _fireAnimationOnIncenseAdded == true && _smokeAnimationOnIncenseAdded == true ){



      isPickGlass = true;

    }

    pickIncenseInGlass();
   

    fireAnimationOnIncense.position.x = incenseModel!.x1! - incenseModel!.width/1.4;
    fireAnimationOnIncense.position.y = incenseModel!.y1! - incenseModel!.height/1.7;


    smokeAnimationOnIncense.position.x = incenseModel!.x1! - incenseModel!.width/1.5;
    if(isPickGlass == false)
    smokeAnimationOnIncense.position.y = incenseModel!.y1! - incenseModel!.height/1.7;


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


     // Remove after 4 seconds
  Future.delayed(Duration(seconds: 4), () async{
    remove(fireAnimationOnIncense);
    print("remove");

    var spriteSheet = await images.load('smoke_spritesheet.png');
    final spriteSize = Vector2(smokeWidth, smokeHeigth);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
      amount: 3, stepTime: 0.5, textureSize: Vector2(151, 1000.0),
    );

    smokeAnimationOnIncense =
        SpriteAnimationComponent.fromFrameData(spriteSheet, spriteData)
          ..x = incenseModel!.x
          ..y = incenseModel!.y - spriteSize.y / 1.3
          ..size = spriteSize;

    await add(smokeAnimationOnIncense);
    _smokeAnimationOnIncenseAdded = true;


  });

    



  }
  
 
  @override
  Color backgroundColor() => const Color(0xFFeeeeee);



  void pickIncenseInGlass(){
    


    
    if(isPickGlass){
    incenseModel!.width = size[0]/28;
    incenseModel!.height = size[1]/14;
    incenseModel!.size =  Vector2(size[0]/28,  size[1]/14);

    smokeAnimationOnIncense!.position.y = incenseModel!.position.y - incenseModel!.height;

    incenseModel!.position.x = glassOfIncenseModel!.position.x + incenseModel!.width + incenseModel!.height/2.9 ;
    incenseModel!.position.y = glassOfIncenseModel!.position.y - incenseModel!.height + incenseModel!.height/2.6;

    }


  }
}