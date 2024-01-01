import 'package:flame/components.dart';

class BuddhaModel extends SpriteComponent with HasGameRef{


  var screenWidth;
  var screenHeight;


  BuddhaModel(var this.screenWidth, var this.screenHeight);


  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('phat.png');

    this
      ..sprite = await gameRef.loadSprite('phat.png')
      ..size = Vector2(screenWidth/2, screenHeight/4)
      ..x = -screenWidth/6;

  }



}