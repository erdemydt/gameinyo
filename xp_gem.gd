extends Area2D

var xp_value = 10

func _ready():
    body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    if body.is_in_group("player"):
        body.collect_xp(xp_value)
        queue_free()
