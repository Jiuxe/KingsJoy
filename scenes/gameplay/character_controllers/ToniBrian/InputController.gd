extends Node

var actor: CharacterBody2D

@onready var r_arm = $"../Root/Body/Top/RArm1/RArm2"
@onready var l_arm = $"../Root/Body/Top/LArm1/LArm2"

var bending_l:= false
var bending_r:= false

var is_ready = false
var rotation_speed = 80

func _physics_process(delta):
	if not is_ready:
		return
	
	balance_movement(delta)
	
	if Input.is_action_just_pressed("ui_left"):
		actor.l_arm_collider.activate()
	
	if Input.is_action_just_pressed("ui_right"):
		actor.r_arm_collider.activate()
	
	if Input.is_action_just_pressed("ui_accept"):
		actor.jump()
	
	if Input.is_action_just_pressed("ui_cancel"):
		Game.restart_scene()

func control_arm(arm, action, inverted:=false):
	var inversion = -1 if inverted else 1
	if Input.is_action_pressed(action):
		arm.rotation_degrees = lerp(arm.rotation_degrees, 140.0 * inversion, 0.8)
	else:
		arm.rotation_degrees = lerp(arm.rotation_degrees, 0.0, 0.8)

func normal_movement(delta):
	var h_input := Input.get_axis("ui_left", "ui_right")
	actor.angle += h_input * rotation_speed * delta

func balance_movement(delta):
	if Input.is_action_pressed("ui_left"):
		l_arm.rotation_degrees = lerp(l_arm.rotation_degrees, 140.0, 0.9)
		bending_l = true
	else:
		l_arm.rotation_degrees = lerp(l_arm.rotation_degrees, 0.0, 0.9)
		bending_l = false
	
	if Input.is_action_pressed("ui_right"):
		r_arm.rotation_degrees = lerp(r_arm.rotation_degrees, -140.0, 0.8)
		bending_r = true
	else:
		r_arm.rotation_degrees = lerp(r_arm.rotation_degrees, 0.0, 0.8)
		bending_r = false
	
	control_arm(r_arm, "ui_right", true)

	var h_input = 0
	if bending_l:
		h_input += 1
	if bending_r:
		h_input -= 1
	actor.angle += h_input * rotation_speed * delta
