extends CanvasLayer

@onready var console = $Debug/ConsoleLog

@onready var title_screen = $TitleScreen
@onready var pause_screen = $PauseScreen
@onready var game_over_screen = $GameOverScreen

var current_screen = null 

func _ready():
	console.visible = false 
	
	register_buttons()
	change_screen(title_screen)

func register_buttons():
	#all buttons belong to the same group. We get them here.
	var buttons = get_tree().get_nodes_in_group("buttons")
	if buttons.size() > 0:
		for button in buttons:
			if button is ScreenButton:
				button.clicked.connect(_on_button_pressed)

# When there clicked signal is emitted, this function is called
func _on_button_pressed(button):
	match button.name:
		"TitlePlay":
			print("Play button is pressed")
			change_screen(pause_screen)
		"PauseRetry":
			change_screen(game_over_screen)
			print("Pause retry")
		"PauseBack":
			print("Pause back")
		"PauseClose":
			print("Pause close")
		"GameOverRetry":
			change_screen(title_screen)
			print("Game over retry")
		"GameOverBack":
			print("Game over back")
	
func _process(delta):
	pass


func _on_toggle_console_pressed():
	console.visible = !console.visible

# changes from current screen to new screen
func change_screen(new_screen):
	# game shows, no active screen (screen is null)
	if current_screen != null:
		var disappear_tween = current_screen.disappear()
		await(disappear_tween.finished) # wait for animation to finish
		current_screen.visible = false
	current_screen = new_screen
	if current_screen != null:
		current_screen.appear()
		var appear_tween = current_screen.appear()
		await(appear_tween.finished)
		get_tree().call_group("buttons", "set_disabled", false)
		
