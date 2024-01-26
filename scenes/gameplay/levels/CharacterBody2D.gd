extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, "fff")

func jump():
	self.velocity.y = JUMP_VELOCITY
