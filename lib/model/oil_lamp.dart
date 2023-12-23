import 'package:flame/components.dart';

class OliLampModel extends SpriteComponent with HasGameRef{

  final double SCREEN_WIDTH;
  final double SCREEN_HEIGTH;

  var table;

  late var width, height;

  double? x1,y1;
  double? x2,y2;


  OliLampModel(var this.SCREEN_WIDTH, var this.SCREEN_HEIGTH, var this.table){
    
    this.width = SCREEN_WIDTH/7;
    this.height = SCREEN_HEIGTH/15;

  }

  @override
  Future<void> onLoad() async {
    super.onLoad();


    this
    ..sprite = await gameRef.loadSprite('dendau.png')
    ..size = Vector2(width, height)

    ..x = SCREEN_WIDTH / 3.2 - width
    ..y = table.position.y - height + table.position.y / 14;

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