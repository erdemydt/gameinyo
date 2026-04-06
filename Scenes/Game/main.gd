extends Node2D

var player: CharacterBody2D
var ui

func _ready():
    player = $Player
    ui = $UI
    player.ui = ui
    $Spawner.player = player
func _process(delta):
    GameManager.update_time(delta)
