extends Control

func _ready():
	visible = false
	modulate.a = 0.0
	
	# all the nodes of the group, and disable all buttons
	get_tree().call_group("buttons", "set_disabled", true)

var fade_dur = 0.5

func appear():
	visible = true
	
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS) # needed due to get_tree().paused
	# self refers to the title screen control node 
	tween.tween_property(self, "modulate:a", 1.0, fade_dur)
	return tween
	
	
func disappear():
	get_tree().call_group("buttons", "set_disabled", true)
	
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	return tween
