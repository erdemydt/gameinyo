extends CharacterBody2D

const SPEED = 200.0
var attack_timer = 0.0
var attack_interval = 0.8
var attack_damage = 10.0
var xp = 0
var xp_to_level = 50
var level = 1
var health = 100.0
var max_health = 100.0
var invincible_timer = 0.0
var invincible_duration = 0.5  # seconds of invincibility after hit
var ui = null


func _ready():
    add_to_group("player")
func _physics_process(delta: float) -> void:
    var direction = Vector2.ZERO
    
    if Input.is_action_pressed("ui_left"):
        direction.x -= 1
    if Input.is_action_pressed("ui_right"):
        direction.x += 1
    if Input.is_action_pressed("ui_up"):
        direction.y -= 1
    if Input.is_action_pressed("ui_down"):
        direction.y += 1
    
    if direction.length() > 0:
        direction = direction.normalized()
    
    velocity = direction * SPEED
    move_and_slide()
    
    attack_timer += delta
    if attack_timer >= attack_interval:
        attack_timer = 0.0
        attack()
    
    if invincible_timer > 0:
        invincible_timer -= delta

func attack():
    var area = $AttackArea
    var bodies = area.get_overlapping_bodies()
    for body in bodies:
        if body.is_in_group("enemies"):
            body.take_damage(attack_damage)

func take_damage(amount):
    if invincible_timer > 0:
        return
    health -= amount
    invincible_timer = invincible_duration
    if ui:
        ui.update_health(health, max_health)
    if health <= 0:
        get_tree().quit()

func collect_xp(amount):
    xp += amount
    if ui:
        ui.update_xp(xp, xp_to_level)
    if xp >= xp_to_level:
        level_up()

func level_up():
    level += 1
    xp = 0
    xp_to_level = int(xp_to_level * 1.4)
    if ui:
        ui.update_level(level)
        ui.update_xp(xp, xp_to_level)
