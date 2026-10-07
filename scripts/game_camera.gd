extends Camera2D

# this var can only be a player. 
# The class_name "Player" is inside player scene. 
var player: Player = null 

func _ready():
	global_position.x = get_viewport_rect().size.x / 2 # centers camera on x axis


func _process(delta):
	pass

# func only accepts the player
func setup_camera(_player: Player):
	if _player != null:
		player = _player

func _physics_process(delta):	
	if player != null:
		global_position.y = player.global_position.y
