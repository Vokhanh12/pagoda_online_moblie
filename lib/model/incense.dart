import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';


class Incense extends SpriteComponent with DragCallbacks, HasGameRef {

  var screenWidth;
  var screenHeigth;

  var status = false;
  
  Incense(var screenWidth, var screenHeigth){
      this.screenWidth = screenWidth;
      this.screenHeigth = screenHeigth;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();


    this
    ..sprite = await gameRef.loadSprite('caynhan.png')
    ..size = Vector2(screenWidth/18, screenHeigth/5)
    
    ..x = screenWidth/2
    ..y = screenHeigth/2;


    this.anchor = Anchor.bottomCenter;
  }

  @override
  void onDragStart(DragStartEvent event) {
    // TODO: implement onDragStart
    
    print("Hello");
  }


   @override
  void onDragUpdate(DragUpdateEvent event) {
    // TODO: implement onDragUpdate
     // Cập nhật vị trí của đối tượng dựa trên sự kiện kéo
    this.x += event.localDelta.x;
    this.y += event.localDelta.y;
  }

   @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Vẽ hình ảnh hoặc sprite bình thường ở đây

    //renderDebug(canvas); // Gọi hàm renderDebug để vẽ khung va chạm
  }


  @override
  void renderDebug(Canvas canvas) {
    Rect hitbox = Rect.fromLTWH(0, 0, screenWidth/18, screenHeigth/5);

    final paint = Paint()
      ..color = Colors.red // Màu sắc của khung va chạm
      ..style = PaintingStyle.stroke // Chế độ vẽ khung
      ..strokeWidth = 2.0; // Độ dày của đường viền

    canvas.drawRect(hitbox, paint);
  }


}