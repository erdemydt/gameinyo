extends Node2D

@export var enemy_scene: PackedScene
@export var xp_gem_scene: PackedScene
var player: CharacterBody2D
var ui
var spawn_timer = 0.0
var spawn_interval = 0.5

func _ready():
	player = $Player
	ui = $UI
	player.ui = ui

func _process(delta):
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.player = player
	enemy.xp_gem_scene = xp_gem_scene
	var angle = randf() * TAU
	var distance = 400.0
	enemy.global_position = player.global_position + Vector2(cos(angle), sin(angle)) * distance
	$Enemies.add_child(enemy)
