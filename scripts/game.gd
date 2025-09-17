extends Node2D

# Corrected paths: "Ball" is capitalized and the path to the sound is direct.
@onready var ball = $ball
@onready var deathZone = $DeathZone
@onready var lifeLostSound = $DeathZone/lifeLostSound

func _on_death_zone_body_entered(body):
	if body == ball:
		lifeLostSound.play()
		print("entered the death zone")
