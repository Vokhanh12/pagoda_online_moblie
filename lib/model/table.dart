import 'package:flame/components.dart';

class Table extends SpriteComponent with HasGameRef{

  final double characterSize = 200;



  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('caiban.png');
    size = Vector2(characterSize + 100, characterSize);


  }




}