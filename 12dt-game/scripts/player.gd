extends CharacterBody2D

var speed: float = 300.0
var can_attack: bool = true
var can_slash: bool = true
var health: int = 10
var current_energy: int = 6
var slash_energy: int = 2

@export var health_ui: ProgressBar
@export var energy_ui: HBoxContainer
@export var melee_atk_scene: PackedScene
@export var melee_atk_spawn: Marker2D
@export var projectile_slash_scene: PackedScene
@export var projectile_slash_spawn: Marker2D
@export var pivot: Node2D
@export var timer: Timer
@export var timer2: Timer
@export var label: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not timer2.time_left == 0:
		label.text = str("%0.1f" % timer2.time_left)
	
	#Sets starting vector values to 0.0 in direction variable and movement inputs to x and y axis
	var direction: Vector2 = Vector2(0.0, 0.0)
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")

	#Sets vector length to 1, multiplies by speed which allows for same movement speed in all directions stored in a velocity variablee
	velocity = speed * direction.normalized()
	
	pivot.look_at(get_global_mouse_position())
	
	#Takes "ui_accept" input, if true then runs _attack() function
	if Input.is_action_pressed("ui_accept") and can_attack:
		_attack()
		
	if Input.is_action_pressed("slash") and can_slash:
		_slash()
		
	move_and_slide()


#Spawns melee_scene and positions it from the player, facing the direction of the cursor
func _attack() -> void:
	var melee_atk = melee_atk_scene.instantiate()
	melee_atk.rotation = pivot.rotation
	melee_atk.global_position = melee_atk_spawn.global_position
	add_sibling(melee_atk)
	#Activates melee atk cooldown
	can_attack = false 
	timer.start()

#Spawns projectile_slash spawn facing the direction of the cursor
func _slash() -> void:
	#Checks available_energy func value
	if available_energy() < 2:
		return
		
	var projectile_slash = projectile_slash_scene.instantiate()
	projectile_slash.rotation = pivot.rotation
	projectile_slash.global_position = projectile_slash_spawn.global_position
	add_sibling(projectile_slash)
	can_slash = false
	use_energy(2)
	timer2.start()


#melee atk cooldowns and projectile slash cooldowns if true then = output
func _melee_atk_cooldown() -> void:
	can_attack = true

func projectile_slash_cooldown() -> void:
	can_slash = true
	#If the player cannot slash then timer 2 runs for the cooldown set to 10s
	if can_slash == false:
		timer2 = get_node("projectile_slash_cooldown")

#Player takes 1 damage if health is greater than 0, if health is less than 0 then scene reload
func take_damage() -> void:
	if health > 0:
		health -= 1
		health_ui.value = health
	else:
		get_tree().call_deferred("reload_current_scene")

#Checks the amount of used energy bars and returns value to slash function
func available_energy() -> int:
	var amount: int = 0
	for bar in energy_ui.get_children():
		if bar.value == 0.0: 
			amount += 1
	return amount

#Stores energy bars in an array from bar 6 - 5 - 4 etc. Adjusts bar value according to amount of energy used in projectile slash functionn
func use_energy(cost: int) -> void:
	var used_energy: int = 0
	var energy_bars: Array[Node] = energy_ui.get_children()
	energy_bars.reverse()
	for bar in energy_bars:
		if bar.value == 0.0 and used_energy < cost: 
			bar.value = 100
			used_energy += 1
			
