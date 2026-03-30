extends CharacterBody2D

const SPEED = 80.0
var player = null
var health = 30.0
var damage = 10.0
var damage_timer = 0.0
var damage_interval = 0.5
@export var xp_gem_scene: PackedScene

func _ready():
    add_to_group("enemies")

func _physics_process(delta):
    if player == null:
        return
    var direction = (player.global_position - global_position).normalized()
    velocity = direction * SPEED
    move_and_slide()
    
    damage_timer += delta
    if damage_timer >= damage_interval:
        var distance = global_position.distance_to(player.global_position)
        if distance < 32:
            damage_timer = 0.0
            player.take_damage(damage)

func take_damage(amount):
    health -= amount
    if health <= 0:
        if xp_gem_scene:
            var gem = xp_gem_scene.instantiate()
            gem.global_position = global_position
            get_parent().add_child(gem)
        queue_free()
