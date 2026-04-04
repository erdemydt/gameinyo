extends Node2D

@export var enemy_scene: PackedScene
var player: CharacterBody2D
var spawn_timer = 0.0
var spawn_interval = 0.5

func _process(delta):
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		_spawn_enemy()

func _spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.player = player
	var angle = randf() * TAU
	var distance = 400.0
	enemy.global_position = player.global_position + Vector2(cos(angle), sin(angle)) * distance
	get_parent().get_node("Enemies").add_child(enemy)
