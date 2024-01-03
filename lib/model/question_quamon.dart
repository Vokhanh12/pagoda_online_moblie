import 'package:flame/components.dart';

class QuestionQuaMonModel extends SpriteComponent with HasGameRef{


  var screenWidth;
  var screenHeight;


  QuestionQuaMonModel(var this.screenWidth, var this.screenHeight);


  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('question-quamon.png');

    this
      ..sprite = await gameRef.loadSprite('question-quamon.png')
      ..size = Vector2(screenWidth/1.5, screenHeight/4.5)
      ..x = screenWidth/8;

  }



}