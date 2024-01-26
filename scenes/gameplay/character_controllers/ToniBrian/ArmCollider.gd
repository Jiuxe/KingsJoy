extends Area2D

var execution_unix

func _ready():
	monitoring = false
	self.body_entered.connect(_on_body_entered)

func activate():
	execution_unix = Time.get_unix_time_from_system()
	var ex = execution_unix
	monitoring = true
	await get_tree().create_timer(0.12).timeout
	if ex == execution_unix:
		monitoring = false

func _on_body_entered(body: PhysicsBody2D):
	print("ball?")
	if "jump" in body:
		body.jump()
