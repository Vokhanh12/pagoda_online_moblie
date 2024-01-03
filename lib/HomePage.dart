import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:pagoda_tgu/model/buddha.dart';
import 'package:pagoda_tgu/model/chickenOfferings.dart';
import 'package:pagoda_tgu/model/glass_of_Incense.dart';
import 'package:pagoda_tgu/model/hand.dart';
import 'package:pagoda_tgu/model/incense.dart';
import 'package:pagoda_tgu/model/oil_lamp.dart';
import 'package:pagoda_tgu/model/question_quamon.dart';
import 'package:pagoda_tgu/model/question_rotmon.dart';
import 'package:pagoda_tgu/model/table.dart';
import 'package:pagoda_tgu/provider/ListenerProvider.dart';



class HomePage extends FlameGame{

  ListenerProvider? listenerProvider;
  
  SpriteComponent background = new SpriteComponent();

  SpriteAnimationComponent fireAnimation = SpriteAnimationComponent();
  var fireWidth = 50.0;
  var fireHeigth = 100.0;

  var smokeWidth = 40.0;
  var smokeHeigth = 340.0;

  double? x1_fire,x2_fire;
  double? y1_fire,y2_fire;

  bool isPickIncenseInGlass = false;
  bool isPickChickenInTable = false;

  SpriteAnimationComponent fireAnimationOnIncense = SpriteAnimationComponent();
  SpriteAnimationComponent smokeAnimationOnIncense = SpriteAnimationComponent();

  bool _statusFireOnIncense = false;
  bool _statusSmokeOnIncense = false;
  bool _statusChickenOnTable = false;

  bool _fireAnimationOnIncenseAdded = false; 
  bool _smokeAnimationOnIncenseAdded = false;

  bool _isQuestionQuaMonModelAdded = false;
  bool _isQuestionRotMonModelAdded = false;

  bool _isHandModelAdded = false;

  int quantity = 1;


  IncenseModel? incenseModel;

  TableModel? tableModel;

  GlassOfIncenseModel? glassOfIncenseModel;

  OliLampModel? oliLampModel;

  BuddhaModel? buddhaModel;

  ChickenOfferingsModel? chickenOfferingsModel;

  QuestionQuaMonModel? questionQuaMonModel;

  QuestionRotMonModel? questionRotMonModel;
  
  HandModel? handModel;


  // Contructor
  HomePage(this.listenerProvider);


  @override
  Future<void> onLoad() async {
     super.onLoad();

    final screenWidth = size[0];
    final screenHeight = size[1];

     // Load and play background music
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('sound.mp4');


     add(background
      ..sprite = await loadSprite('Congchua.png')
      ..size = Vector2(screenWidth,screenHeight/2));

    incenseModel = IncenseModel(screenWidth, screenHeight);

    tableModel = TableModel(screenWidth, screenHeight, background);

    glassOfIncenseModel = GlassOfIncenseModel(screenWidth, screenHeight, tableModel);

    oliLampModel = OliLampModel(screenWidth, screenHeight, tableModel);

    buddhaModel = BuddhaModel(screenWidth, screenHeight);

    chickenOfferingsModel = ChickenOfferingsModel(screenWidth, screenHeight);

    questionQuaMonModel = QuestionQuaMonModel(screenWidth, screenHeight);

    handModel = HandModel(screenWidth, screenHeight);

    questionRotMonModel = QuestionRotMonModel(screenWidth, screenHeight);


    await add(tableModel!);

    await add(oliLampModel!);

    await add(incenseModel!);

    await add(glassOfIncenseModel!);


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



      }

    

  }

  @override
  void update(double dt) async{
    // TODO: implement update
    super.update(dt);

    if(listenerProvider!.isShowQuestion!){

      if(listenerProvider!.ramdomSelect! % 2 == 0){

          if(!_isQuestionQuaMonModelAdded){
             await add(questionQuaMonModel!);
            _isQuestionQuaMonModelAdded = true;
            remove(questionRotMonModel!);
            _isQuestionRotMonModelAdded = false;
          }

      } else{

         if(!_isQuestionRotMonModelAdded){
            await add(questionRotMonModel!);
            _isQuestionRotMonModelAdded = true;
            remove(questionQuaMonModel!);
            _isQuestionQuaMonModelAdded = false;
          }

      }


    }  


       if (!_isHandModelAdded && isPickIncenseInGlass) {
      await add(handModel!);
      _isHandModelAdded = true;
    }


    if(x1_fire! < incenseModel!.x2! && incenseModel!.x1! < x2_fire!
    && y1_fire! < incenseModel!.y2! && incenseModel!.y1! < y2_fire! ){

      _statusFireOnIncense = true;


    }


      if(glassOfIncenseModel!.x1! < incenseModel!.x2! && incenseModel!.x1! < glassOfIncenseModel!.x2!
    && glassOfIncenseModel!.y1! < incenseModel!.y2! && incenseModel!.y1! < glassOfIncenseModel!.y2!
     && _fireAnimationOnIncenseAdded == true && _smokeAnimationOnIncenseAdded == true ){

     isPickIncenseInGlass = true;

    }

      if(chickenOfferingsModel!.x1! < tableModel!.x2! && tableModel!.x1! < chickenOfferingsModel!.x2!
    && chickenOfferingsModel!.y1! < tableModel!.y2! && tableModel!.y1! < chickenOfferingsModel!.y2!
     && _fireAnimationOnIncenseAdded == true && _smokeAnimationOnIncenseAdded == true ){

      isPickChickenInTable = true;

      listenerProvider!.isPickChickenInTable = true;

    }

    PickIncenseInGlass();
    PickChickenInTable();


    fireAnimationOnIncense.position.x = incenseModel!.x1! - incenseModel!.width/1.4;
    fireAnimationOnIncense.position.y = incenseModel!.y1! - incenseModel!.height/1.5;


    smokeAnimationOnIncense.position.x = incenseModel!.x1! - incenseModel!.width/1.5;
    if(isPickIncenseInGlass == false)
    smokeAnimationOnIncense.position.y = incenseModel!.y1! - incenseModel!.height/1.5;


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
    await add(buddhaModel!);


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



  void PickIncenseInGlass(){
    
    
    if(isPickIncenseInGlass){
    incenseModel!.width = size[0]/28;
    incenseModel!.height = size[1]/14;
    incenseModel!.size =  Vector2(size[0]/28,  size[1]/14);

    smokeAnimationOnIncense!.position.y = incenseModel!.position.y - incenseModel!.height;

    incenseModel!.position.x = glassOfIncenseModel!.position.x + incenseModel!.width + incenseModel!.height/2.9 ;
    incenseModel!.position.y = glassOfIncenseModel!.position.y - incenseModel!.height + incenseModel!.height/2.6;

    }


  }

  void PickChickenInTable(){

    if(isPickChickenInTable){

    chickenOfferingsModel!.width = size[0]/4;
    chickenOfferingsModel!.height = size[1]/10;

    chickenOfferingsModel!.size = Vector2(size[0]/4,size[1]/10);

    chickenOfferingsModel!.position.x = tableModel!.position.x + tableModel!.width - chickenOfferingsModel!.width*1.2;
    chickenOfferingsModel!.position.y = tableModel!.position.y - chickenOfferingsModel!.height/1.8 ;

    }



  }


}