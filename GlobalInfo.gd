extends Node

var current_user_id

func _ready():
	pass # Replace with function body.

func set_current_user(id):
	current_user_id = id

func clear_current_user():
	current_user_id = null
