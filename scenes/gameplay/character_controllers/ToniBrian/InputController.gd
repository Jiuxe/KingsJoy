extends Node

var actor: CharacterBody2D

@onready var r_arm = $"../Root/Body/Top/RArm1/RArm2"
@onready var l_arm = $"../Root/Body/Top/LArm1/LArm2"

var arm_rotation := 125.0

var bending_l:= false
var bending_r:= false

var is_ready = false
var rotation_speed = 150

func _physics_process(delta):
	if not is_ready:
		return
	
	balance_movement(delta)
	normal_movement(delta)
	
	if Input.is_action_just_pressed("left_arm"):
		actor.l_arm_collider.activate()
	
	if Input.is_action_just_pressed("right_arm"):
		actor.r_arm_collider.activate()
	
	if Input.is_action_just_pressed("ui_accept"):
		actor.jump()

func normal_movement(delta):
	var h_input := Input.get_axis("ui_left", "ui_right")
	actor.angle += h_input * rotation_speed * delta

func balance_movement(delta):
	if Input.is_action_pressed("left_arm"):
		l_arm.rotation_degrees = lerp(l_arm.rotation_degrees, arm_rotation, 0.8)
		bending_l = true
	else:
		l_arm.rotation_degrees = lerp(l_arm.rotation_degrees, 0.0, 0.8)
		bending_l = false
	
	if Input.is_action_pressed("right_arm"):
		r_arm.rotation_degrees = lerp(r_arm.rotation_degrees, -arm_rotation, 0.8)
		bending_r = true
	else:
		r_arm.rotation_degrees = lerp(r_arm.rotation_degrees, 0.0, 0.8)
		bending_r = false

	
