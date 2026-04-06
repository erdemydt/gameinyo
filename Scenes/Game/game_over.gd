extends CanvasLayer

func _ready():
    $ScoreLabel.text = "Score: " + str(GameManager.score)
    $TimeLabel.text = "Time: " + str(snapped(GameManager.session_time, 0.1)) + "s"
    $HighScoreLabel.text = "Best: " + str(GameManager.high_score)
    $RestartButton.pressed.connect(_on_restart)

func _on_restart():
    GameManager.reset()
    get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")
