import 'package:flame/components.dart';

class ComboInfo {
  TextComponent description;
  List<SpriteComponent> buttons;

  ComboInfo(this.description, this.buttons) { }

  List<Component> AllUiElements() {
    var res = List<Component>.from(buttons);
    res.add(description);
    return res;
  }
}