extends CharacterBody2D

@export var speed = 300.0 # You can change this speed in the Inspector
@onready var playerPaddle = $AnimatedSprite2D
@export var paddle_width: float = 110.0

var lock_position_y: float


func _ready():
	playerPaddle.play("default")
	# Save the initial Y position
	lock_position_y = self.position.y

func _physics_process(delta):
	# Get the player's input direction
	var direction = Input.get_axis("moveLeft", "moveRight")
	velocity.x = direction * speed
	
	# Let Godot handle the movement and collisions
	move_and_slide()
	
	# Forcefully correct any unwanted vertical movement
	self.position.y = lock_position_y
	
