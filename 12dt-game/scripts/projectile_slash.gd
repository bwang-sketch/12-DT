extends Area2D

var speed: float = 1300.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	move_local_x(speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage()
	
	if body.is_in_group("projectile_enemies"):
		body.take_damage()
		
