extends Node

@onready var game = $Game
@onready var screens = $Screens

func _ready():
	screens.start_game.connect(_on_screens_start_game) #signal from "screens" scene

func _on_screens_start_game():
	game.new_game()

