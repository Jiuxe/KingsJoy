extends CharacterBody2D
class_name Ball

@onready var collision_shape_2d = $CollisionShape2D
const JUMP_VELOCITY = -800.0

@export var horizonal_acceleration = 0.8
@export var color: Color = Color("fff"):
	set(value):
		color = value
		queue_redraw()
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = lerp(velocity.x, 0.0, horizonal_acceleration*delta)
	move_and_slide()

func _draw():
	draw_circle(Vector2.ZERO, collision_shape_2d.shape.radius, color)

func jump(arm_rotation: float, force_multiplier:= 0.8):
	self.velocity = Vector2(0, JUMP_VELOCITY*force_multiplier).rotated(arm_rotation)
