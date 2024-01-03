import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';


class HandModel extends SpriteComponent with DragCallbacks, HasGameRef {

  final double SCREEN_WIDTH;
  final double SCREEN_HEIGTH;

  late var width, height;

  var status_fire = false;

  var status_rotate = false;

  double? x1,y1;
  double? x2,y2;

  SpriteAnimationComponent fireAnimation = SpriteAnimationComponent();
  
  HandModel(var this.SCREEN_WIDTH, var this.SCREEN_HEIGTH){
    this.width = SCREEN_WIDTH/5;
    this.height = SCREEN_HEIGTH/6;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();


    this
    ..sprite = await gameRef.loadSprite('tay.png')
    ..size = Vector2(width, height)
    //set posistion in center table
    ..x = SCREEN_WIDTH/3.5
    ..y = SCREEN_HEIGTH - height - 50;

  }


  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    // update x1,y1 x2,y2

    x1 = this.position.x;
    y1 = this.position.y;
    x2 = this.position.x + width;
    y2 = this.position.y + height;







  }
 

  @override
  void onDragStart(DragStartEvent event) {
    // TODO: implement onDragStart
    
    print("click in");

    status_rotate = true;


  }

  @override
  void onDragEnd(DragEndEvent event) {

    print("click out");

    status_rotate = false;

  }

   @override
  void onDragUpdate(DragUpdateEvent event) {

   x += event.localDelta.x;
   y += event.localDelta.y;





    




  // Đảm bảo đối tượng ở trong giới hạn màn hình
  if (x < 0) x = 0;
  if (y < 0) y = 0;
  if (x + width > SCREEN_WIDTH) x = SCREEN_WIDTH - width;
  if (y + height > SCREEN_HEIGTH) y = SCREEN_HEIGTH - height;
  }

   @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Vẽ hình ảnh hoặc sprite bình thường ở đây

    //renderDebug(canvas); // Gọi hàm renderDebug để vẽ khung va chạm
  }


  @override
  void renderDebug(Canvas canvas) {
    Rect hitbox = Rect.fromLTWH(0, 0, SCREEN_WIDTH/18, SCREEN_HEIGTH/5);

    final paint = Paint()
      ..color = Colors.red // Màu sắc của khung va chạm
      ..style = PaintingStyle.stroke // Chế độ vẽ khung
      ..strokeWidth = 2.0; // Độ dày của đường viền

    canvas.drawRect(hitbox, paint);
  }


}