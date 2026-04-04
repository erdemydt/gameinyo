extends CanvasLayer

func update_health(current, maximum):
    $HealthBar.max_value = maximum
    $HealthBar.value = current

func update_xp(current, maximum):
    $XPBar.max_value = maximum
    $XPBar.value = current

func update_level(level):
    $LevelLabel.text = "Level: " + str(level)
