extends Camera2D

@onready var destroyer = $Destroyer
@onready var destroyer_shape = $Destroyer/CollisionShape2D

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
	
	# Platform destroyer init
	destroyer.position.y = viewport_size.y #relative position to the camera
	
	var rect_shape = RectangleShape2D.new()
	var rect_shape_size = Vector2(viewport_size.x, 200)
	rect_shape.set_size(rect_shape_size)
	destroyer_shape.shape = rect_shape
	
func _process(_delta):
	
	# camera limit is updated when player position changes
	if player != null:
		var limit_distance = 420
		if limit_bottom > player.global_position.y + limit_distance:
			limit_bottom = int(player.global_position.y + limit_distance)
	
	# Destroy platforms 
	var overlapping_areas = destroyer.get_overlapping_areas()
	if overlapping_areas.size() > 0:
		for area in overlapping_areas:
			if area is Platform: # this is the class name of the platform 
				area.queue_free()
				
# func only accepts the player
func setup_camera(_player: Player):
	if _player != null:
		player = _player

func _physics_process(_delta):	
	if player != null:
		global_position.y = player.global_position.y
