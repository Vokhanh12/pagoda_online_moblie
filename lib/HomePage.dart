import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pagoda_tgu/model/incense.dart';



class HomePage extends FlameGame{


  SpriteComponent background = SpriteComponent();
  SpriteComponent table = SpriteComponent();
  SpriteComponent glassOfIncense = SpriteComponent();


  Incense incense = new Incense(500,500);


  @override
  Future<void> onLoad() async {
     super.onLoad();

    final screenWidth = size[0];
    final screenHeight = size[1];

    

    add(background
      ..sprite = await loadSprite('Congchua.png')
      ..size = Vector2(screenWidth,screenHeight/2));

    table
      ..sprite = await loadSprite('caiban.png')
      ..size = Vector2(screenWidth - 20, screenHeight/4)
      ..y = background.height;
    add(table);

    glassOfIncense
    ..sprite = await loadSprite('lyhuong.png')
    ..size = Vector2(screenWidth/5, screenHeight/10)
    ..x = screenWidth / 2 - screenWidth/10
    ..y = table.position.y - screenHeight/18;
    add(glassOfIncense);

    await add(incense);


    

  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    print("incense");
    print(incense.position.x);
    print(incense.position.y);
    print("glass of incense");
    print(glassOfIncense.position.x);
    print(glassOfIncense.position.y);

    if(incense.x == glassOfIncense.x && incense.y == glassOfIncense.y)
    print("Hello wrold");

  }
 
  @override
  Color backgroundColor() => const Color(0xFFeeeeee);

}