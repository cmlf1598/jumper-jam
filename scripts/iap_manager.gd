extends Node

signal unlock_new_skin

var google_payment = null

func _ready():
	# if it exists, let's use it 
	if Engine.has_singleton("GodotGooglePlayBilling"):
		google_payment = Engine.get_singleton("GodotGooglePlayBilling")
		MyUtility.add_log_msg("Android IAP support is enabled.")
		
		google_payment.connected.connect(_on_connected)
		google_payment.connect_error.connect(_on_connect_error)
		google_payment.disconnected.connect(_on_disconnected)
		
		google_payment.startConnection() #initiate connection (takes time)
		
	else: 
		MyUtility.add_log_msg("Android IAP support is not available.")
	
# if player buys the skin or has purchased the skin
func purchase_skin():
	unlock_new_skin.emit()

# When we get the Google response
func _on_connected():
	MyUtility.add_log_msg("Connected")

# When we get an error
func _on_connect_error(response_id, debug_msg):
	MyUtility.add_log_msg("Connect error, response id: " + str(response_id) + " debug msg: " + debug_msg)

# When disconnected from the Google servers	
func _on_disconnected():
	MyUtility.add_log_msg("Disconnected")
