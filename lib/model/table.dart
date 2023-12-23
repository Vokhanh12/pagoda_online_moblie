import 'package:flame/components.dart';

class TableModel extends SpriteComponent with HasGameRef{


  var screenWidth;
  var screenHeight;

  var background;

  TableModel(var this.screenWidth, var this.screenHeight,var this.background);


  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('caiban.png');

    this
      ..sprite = await gameRef.loadSprite('caiban.png')
      ..size = Vector2(screenWidth - 20, screenHeight/4)
      ..y = background.height;


  }




}