class ConfigManager {
  ConfigManager();

  Config get config {
    return (
      levels: [
        (
          parallax: [
            "background/level_1/1.png",
            "background/level_1/2.png",
            "background/level_1/3.png",
            "background/level_1/4.png"
          ]
        ),
        (
          parallax: [
            "background/level_2/1.png",
            "background/level_2/2.png",
            "background/level_2/3.png",
            "background/level_2/4.png",
            "background/level_2/5.png",
            "background/level_2/6.png",
            "background/level_2/7.png",
            "background/level_2/8.png",
            "background/level_2/9.png"
          ]
        )
      ]
    );
  }
}

typedef LevelConfig = ({
  List<String> parallax,
});

typedef Config = ({List<LevelConfig> levels});
