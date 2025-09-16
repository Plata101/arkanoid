extends StaticBody2D

# This signal will be used to tell the main game to add points.
signal destroyed(points)

# Create slots in the Inspector to drag your textures into.
@export var solid_texture: Texture2D
@export var damaged_texture: Texture2D

var health = 2
const POINTS = 100

@onready var sprite = $Sprite2D

func _ready():
	# Start by showing the solid brick texture.
	sprite.texture = solid_texture
	
func take_damage():
	health -= 1
	print("health:", health)
	if health == 1:
		# if health is 1, it's damaged
		sprite.texture = damaged_texture
		# TODO: add crack sound
	elif health <= 0:
		destroyed.emit(POINTS) # Emit the signal with the point value.
		queue_free() # Remove the brick from the game
