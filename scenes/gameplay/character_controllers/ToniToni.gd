extends CharacterBody2D
@onready var node_2d : Node2D = $Node2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal dead

@export var sigma := 1.0
@export var interpolation_degrees := 1.0
@export var max_angle := 50.0
@export var min_angle := -50.0
@export var max_normalized_degrees := 1.7
@export var min_normalized_degrees := 0.1
@export var max_normalized_move := 1
@export var min_normalized_move := 0.1

var current_rotation = 0 :
	set(value):
		current_rotation = clamp(value, -max_angle, max_angle)
		if abs(current_rotation) >= max_angle:
			dead.emit()
			

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	current_rotation = node_2d.rotation_degrees
	var input_or = Input.get_axis("ui_left", "ui_right")
	if input_or:
		rotate_body_by_balance(input_or)
	else:
		rotate_and_move_body_by_gravity(delta)
	node_2d.rotation_degrees = current_rotation
	
	var interpolation_move = abs(((max_angle - abs(current_rotation) )/ (max_angle)) * (max_normalized_move-min_normalized_move) + min_normalized_move)
	if input_or:
		velocity.x = input_or * SPEED * interpolation_move
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	velocity.x = velocity.x 
	move_and_slide()

func rotate_and_move_body_by_gravity(delta):
	
	# Cada frame rotamos 1 grado en la direccopm en la qie nos mpvemos * el desbalanceo, en principio 1.ç
	interpolation_degrees = ((abs(current_rotation) )/ (max_angle)) * (max_normalized_degrees-min_normalized_degrees) + min_normalized_degrees
	if current_rotation > 0:
		current_rotation = current_rotation + interpolation_degrees * sigma
	elif current_rotation < 0:
		current_rotation = current_rotation - interpolation_degrees * sigma
		
func rotate_body_by_balance(input_or):
	
	interpolation_degrees = ((abs(current_rotation) )/ (max_angle)) * (max_normalized_degrees-min_normalized_degrees) + min_normalized_degrees
	current_rotation = current_rotation + input_or * interpolation_degrees
	
	
	
	
	
