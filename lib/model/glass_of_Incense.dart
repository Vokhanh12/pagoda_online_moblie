import 'package:flame/components.dart';

class GlassOfIncenseModel extends SpriteComponent with HasGameRef{

  final double SCREEN_WIDTH;
  final double SCREEN_HEIGTH;

  var table;

  late var width, height;


  double? x1,y1;
  double? x2,y2;


  GlassOfIncenseModel(var this.SCREEN_WIDTH, var this.SCREEN_HEIGTH, var this.table){
    
    this.width = SCREEN_WIDTH/5;
    this.height = SCREEN_HEIGTH/10;

  }

  @override
  Future<void> onLoad() async {
    super.onLoad();


    this
    ..sprite = await gameRef.loadSprite('lyhuong.png')
    ..size = Vector2(width, height)

    ..x = SCREEN_WIDTH / 2 - SCREEN_WIDTH/10
    ..y = table.position.y - SCREEN_HEIGTH/18;

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