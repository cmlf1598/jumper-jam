extends TextureButton
class_name ScreenButton

signal clicked(button) 

# signal is emitted when the texture button is pressed
func _on_pressed():
	# self to refer to the object that the script is attached to 
	clicked.emit(self)
