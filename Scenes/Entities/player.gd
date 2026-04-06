extends CharacterBody2D

const SPEED = 200.0
var attack_timer = 0.0
var attack_interval = 1.8
var attack_damage = 30.0
var xp = 0
var xp_to_level = 50
var level = 1
var health = 30.0
var max_health = 300.0
var invincible_timer = 0.0
var invincible_duration = 0.1  # seconds of invincibility after hit
var ui = null
var slash_line: Line2D

func _ready():
    slash_line = Line2D.new()
    slash_line.width = 3.0
    slash_line.default_color = Color(1, 1, 1, 0.8)
    var points = []
    var startP = [20,10]
    var totalPoints = 40
    for i in range(40):
        var angle = deg_to_rad(-45 + i * 2.5)  # 90° arc
        points.append(Vector2(cos(angle), sin(angle)) * 60*i/totalPoints + Vector2(startP[0],startP[1]))  # 80 = visual radius
    slash_line.points = points
    slash_line.visible = false
    add_child(slash_line)
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
    slash_line.visible = true
    slash_line.modulate = Color(1.0, 1.0, 1.0, 1.0)
    var tween = create_tween()
    tween.tween_property(slash_line, "rotation", slash_line.rotation + deg_to_rad(270), 0.25)
    tween.parallel().tween_property(slash_line, "modulate:a", 0.0, 0.25)
    tween.tween_callback(func(): slash_line.visible = false)
func take_damage(amount):
    if invincible_timer > 0:
        return
    var sprite = $Sprite2D
    sprite.modulate = Color(0, .5, 1, 1)  # flash white
    var tween = create_tween()
    tween.tween_property(sprite, "modulate", Color(1, 1, 1, 1), 0.1)  # back to red
    
    health -= amount
    invincible_timer = invincible_duration
    if ui:
        ui.update_health(health, max_health)
    if health <= 0:
        get_tree().change_scene_to_file("res://Scenes/Game/GameOver.tscn")

func collect_xp(amount):
    xp += amount
    GameManager.add_score(amount)
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
