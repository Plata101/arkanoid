extends RigidBody2D

@export var speed = 400.0
@export var max_paddle_angle = 1.2
# This new variable controls how much the paddle's movement affects the ball.
# A value of 0.3 means 30% of the paddle's speed is transferred.
@export var paddle_influence = 0.3
@onready var ping_sound = $PingSound
# Add this new variable. It's the minimum angle from horizontal (in degrees).
# 15 is a good starting value.
@export var min_bounce_angle_degrees = 15.0


func _ready():
	# Make sure Contact Monitor is on and Max Contacts Reported is > 0
	# in the Inspector if you need to detect collisions in the script.
	
	# Launch the ball in a random downward direction.
	linear_velocity = Vector2.DOWN.rotated(randf_range(-0.1, 0.1)) * speed

# That's it! No _physics_process is needed for movement.
# The physics engine handles all bouncing and motion.

func _on_body_entered(body):
	ping_sound.play()
	
	if body.is_in_group("paddle"):
		# 1. Calculate base velocity from hit location and paddle movement
		var ball_pos_x = self.global_position.x
		var paddle_pos_x = body.global_position.x
		var paddle_width = body.paddle_width
		var influence = (ball_pos_x - paddle_pos_x) / (paddle_width / 2.0)
		var new_velocity = Vector2.UP.rotated(influence * max_paddle_angle)
		new_velocity.x += body.velocity.x * paddle_influence
		
		# --- ANGLE CLAMPING LOGIC ---
		
		# 2. Convert the minimum angle from degrees to radians for calculations
		var min_bounce_angle_rad = deg_to_rad(min_bounce_angle_degrees)
		
		# 3. Get the final direction's angle (in radians)
		var angle = new_velocity.angle()
		
		# 4. Clamp the angle to ensure it's not too horizontal
		# The range from -PI/2 is straight up. We clamp it to be within our min angle.
		if abs(angle + PI / 2) > max_paddle_angle:
			angle = -PI / 2 + sign(angle) * max_paddle_angle
		
		# Ensure the ball doesn't go too horizontal
		if angle > -min_bounce_angle_rad: # Too close to the right horizontal
			angle = -min_bounce_angle_rad
		elif angle < -PI + min_bounce_angle_rad: # Too close to the left horizontal
			angle = -PI + min_bounce_angle_rad
			
		# 5. Apply the corrected direction and speed
		self.linear_velocity = Vector2.from_angle(angle) * speed
	
	# Check if the body the ball hit is in the "bricks" group
	if body.is_in_group("bricks"):
		print("brick")
		body.take_damage()
