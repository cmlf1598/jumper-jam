extends Node

signal unlock_new_skin

# if player buys the skin or has purchased the skin

func purchase_skin():
	unlock_new_skin.emit()
