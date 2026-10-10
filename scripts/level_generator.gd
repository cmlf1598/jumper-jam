extends Node2D

# This will hold all platforms
@onready var platform_parent = $PlatformParent

var platform_scene = preload("res://scenes/platform.tscn")

var start_platform_y # first platform, based on viewport size
var y_distance_between_platforms = 100
var level_size = 50
var viewport_size
var generated_platform_count = 0

var player: Player = null

# we need to give the player to this script
func setup(_player: Player):
	if _player:
		player = _player

func _ready():
	viewport_size = get_viewport_rect().size
	generated_platform_count = 0
	start_platform_y = viewport_size.y - (y_distance_between_platforms * 2)
	generate_level(start_platform_y, true)
	
func _process(_delta):
	# if player is a valid object
	if player:
		var py = player.global_position.y
		var end_of_level_pos = start_platform_y - (generated_platform_count * y_distance_between_platforms)
		var threshold = end_of_level_pos + (y_distance_between_platforms * 6)
		if py <= threshold:
			generate_level(end_of_level_pos, false)


func generate_level(start_y: float, generate_ground: bool):
	
	var platform_width = 136
	
	if generate_ground == true:
		# Generate the ground
		var ground_layer_platform_count = (viewport_size.x / platform_width) +1
		
		var ground_layer_y_offset = 62
		for i in range(ground_layer_platform_count):
			var ground_location = Vector2(i * platform_width, viewport_size.y - ground_layer_y_offset)
			create_platform(ground_location)	
			
	# Generate the rest of the level
	for i in range(level_size):
		var max_x_position = viewport_size.x - platform_width
		var random_x = randf_range(0.0, max_x_position)
		
		var location: Vector2 = Vector2.ZERO
		location.x = random_x
		location.y = start_y - (y_distance_between_platforms * i)
		create_platform(location)
		generated_platform_count += 1
		
		
# Instantiate a platform, set its position, add it as child, and return it
func create_platform(location: Vector2):
	var platform = platform_scene.instantiate()
	platform.global_position = location
	platform_parent.add_child(platform) # add child
	return platform 
	
