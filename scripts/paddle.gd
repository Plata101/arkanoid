extends RigidBody2D

@export var speed = 300.0 # You can change this speed in the Inspector
@onready var playerPaddle = $AnimatedSprite2D

var lock_position

func _ready():
	playerPaddle.play("default")
	lock_position = position.y

func _physics_process(delta):
	# Get the player's input direction
	var direction = Input.get_axis("moveLeft", "moveRight")
	
	# Create a velocity vector for this frame
	var velocity = Vector2.ZERO
	velocity.x = direction * speed
	
	# The key change:
	# Move the kinematic body by the desired amount for this frame.
	# We multiply by 'delta' here to make the movement frame-rate independent.
	move_and_collide(velocity * delta)
	position.y = lock_position
	
