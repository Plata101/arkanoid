extends RigidBody2D

@export var speed = 400.0

@onready var ping_sound = $PingSound

func _ready():
	# Make sure Contact Monitor is on and Max Contacts Reported is > 0
	# in the Inspector if you need to detect collisions in the script.
	
	# Launch the ball in a random downward direction.
	linear_velocity = Vector2.DOWN.rotated(randf_range(-0.1, 0.1)) * speed

# That's it! No _physics_process is needed for movement.
# The physics engine handles all bouncing and motion.

func _on_body_entered(body):
	ping_sound.play()
	# Check if the body the ball hit is in the "bricks" group
	if body.is_in_group("bricks"):
		print("brick")
		body.take_damage()
