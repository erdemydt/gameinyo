extends Node2D

var player: CharacterBody2D
var ui

func _ready():
	player = $Player
	ui = $UI
	player.ui = ui
	$Spawner.player = player
