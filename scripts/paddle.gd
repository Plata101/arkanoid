extends CharacterBody2D

@onready var playerPaddle = $AnimatedSprite2D

func _ready():
	playerPaddle.play("default")
