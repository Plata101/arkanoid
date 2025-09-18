# level_builder.gd
extends Node2D

@export var brick_scene: PackedScene
@onready var tile_map_layer = $TileMapLayer

func _ready():
	generate_level()

func generate_level():
	# Get a list of all painted tiles from the TileMapLayer (with no argument).
	var used_cells = tile_map_layer.get_used_cells()
	var tile_set = tile_map_layer.tile_set
	
	for cell in used_cells:
		var new_brick = brick_scene.instantiate()
		
		var tile_size = tile_set.tile_size
		new_brick.global_position = tile_map_layer.map_to_local(cell) + tile_size / 2.0
		
		add_child(new_brick)
	
	tile_map_layer.clear()
