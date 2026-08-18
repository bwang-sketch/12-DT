extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#When button is pressed, changes scene to node_2d scene
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/node_2d.tscn")

#When button is pressed, stops project
func _on_button_2_pressed() -> void:
	get_tree().quit()
