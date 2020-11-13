extends Control

var dark_mask
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	dark_mask = Panel.new()
	dark_mask.set_size(Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y))
	dark_mask.modulate = Color(0, 0, 0, 0.5)
	add_child(dark_mask)
	dark_mask.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ExitButton_pressed():
	dark_mask = Panel.new()
	dark_mask.set_size(Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y))
	dark_mask.modulate = Color(0, 0, 0, 0.5)
	add_child(dark_mask)
	var exit_dialog = ConfirmationDialog.new()
	exit_dialog.dialog_text = "Are you sure you want to exit?\nChanges you made will be saved."
	add_child(exit_dialog)
	exit_dialog.popup_centered(Vector2(1, 1))
	exit_dialog.connect("confirmed", self, "on_confirmed_exit")
	exit_dialog.get_cancel().connect("pressed", self, "cancelled")
	exit_dialog.connect("popup_hide", self, "cancelled")
#	exit_dialog.connect("cancelled", self, "on_cancelled_exit")
	
	
func on_confirmed_exit():
	GlobalInfo.clear_current_user()
	get_tree().quit()
	
func cancelled():
	dark_mask.hide()
