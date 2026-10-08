extends Node2D

@onready var player = $Player
@onready var level_generator = $LevelGenerator

var camera_scene = preload("res://scenes/game_camera.tscn")
var camera = null

func _ready():
	camera = camera_scene.instantiate()
	camera.setup_camera($Player)
	add_child(camera) #camera as child of game scene
	
	if player:
		level_generator.setup(player) # give the player to the level generator script
	
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit() # exit the game
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene() # reload current scene 
	


	




