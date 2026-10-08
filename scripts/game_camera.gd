extends Camera2D

# this var can only be a player. 
# The class_name "Player" is inside player scene. 
var player: Player = null 

var viewport_size

func _ready():
	viewport_size = get_viewport_rect().size
	global_position.x = viewport_size.x / 2 # centers camera on x axis
	
	# Limits
	limit_bottom = viewport_size.y
	limit_left = 0
	limit_right = viewport_size.x
	
	


func _process(delta):
	
	# camera limit is updated when player position changes
	if player != null:
		var limit_distance = 420
		if limit_bottom > player.global_position.y + limit_distance:
			limit_bottom = player.global_position.y + limit_distance
			
# func only accepts the player
func setup_camera(_player: Player):
	if _player != null:
		player = _player

func _physics_process(delta):	
	if player != null:
		global_position.y = player.global_position.y
