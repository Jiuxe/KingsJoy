extends CharacterBody2D

signal died

@onready var input_controller = $InputController
@onready var top = $Root/Body/Top

@onready var root = $Root
@onready var l_arm_collider = $Root/LArmCollider
@onready var r_arm_collider = $Root/RArmCollider

var desired_velocity: Vector2
@export var movement_speed:= 500.0
@export var angle: float = 0.0:
	set(value):
		angle = clamp(value, -90, 90)
		if abs(angle) >= death_angle:
			self.died.emit()

@export var fall_factor:= 300.0

@export var max_fall_speed := 1000.0
@export var fall_acceleration := 800.0
@export var jump_strength:= 500.0
@export var death_angle := 80

var normalized_angle = null:
	get:
		return angle / 90
	set(val):
		pass

func _ready():
	input_controller.actor = self
	input_controller.is_ready = true
	angle = 0

func _physics_process(delta):
	process_angle(delta)
	set_movement_from_angle()
	apply_gravity(delta)
	move_and_slide()

func process_angle(delta):
	angle += fall_factor * normalized_angle * delta
	root.rotation_degrees = angle

func apply_gravity(delta):
	if velocity.y >= max_fall_speed:
		return
	velocity.y = min(velocity.y + fall_acceleration * delta, max_fall_speed)

func set_movement_from_angle():
	if is_on_floor():
		velocity.x = movement_speed * normalized_angle

func jump(power := 1.0, force:= false):
	if is_on_floor() or force:
		self.velocity.y = -jump_strength * power

