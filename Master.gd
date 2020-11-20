extends Control

var dark_mask
var exit_dialog

func _ready():
	dark_mask = Panel.new()
	dark_mask.set_size(Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y))
	dark_mask.modulate = Color(0, 0, 0, 0.5)
	add_child(dark_mask)
	dark_mask.hide()



func _on_ExitButton_pressed():

	dark_mask.show()
	exit_dialog = ConfirmationDialog.new()
	exit_dialog.dialog_text = "Are you sure you want to exit?\nUnsaved changes will be lost."
	add_child(exit_dialog)
	exit_dialog.popup_centered(Vector2(1, 1))
	exit_dialog.connect("confirmed", self, "on_confirmed_exit")
	exit_dialog.get_cancel().connect("pressed", self, "cancelled")
	exit_dialog.connect("popup_hide", self, "cancelled")
	
	
func on_confirmed_exit():
	GlobalInfo.clear_current_user()
	get_tree().quit()
	
func cancelled():
	dark_mask.hide()
	exit_dialog.queue_free()
	

# Doesn't want to work, if esc is pressed when exit dialog is up, it flashes and reappears again

#func _unhandled_key_input(event):
#	if event.scancode == KEY_ESCAPE:
#		if !exit_dialog && !dark_mask.visible:
#			_on_ExitButton_pressed()
