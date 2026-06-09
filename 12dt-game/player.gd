extends CharacterBody2D

var speed: float = 300.0
var health: int = 10

@export var health_ui: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction: Vector2 = Vector2(0.0, 0.0)
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")

	velocity = speed * direction.normalized()
	move_and_slide()
