import 'package:flame/components.dart';

class TableModel extends SpriteComponent with HasGameRef{


  var screenWidth;
  var screenHeight;

  var background;

  double? x1,y1;
  double? x2,y2;

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




}