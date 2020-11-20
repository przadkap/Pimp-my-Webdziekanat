extends VBoxContainer

signal login_successful

func _ready():
	if(GlobalInfo.current_user_id == null):
		toggle_login()


func _on_Login_attempt_login(id, password):
	var credentials = GlobalFunctions.json_file_to_dict("res://credentials.json")
	var credential_list = []
	for user in credentials:
		credential_list.append(user["id"])
	if id in credential_list:
		for user in credentials:
			if user["id"] == id:
				if user["password"] == password:
					GlobalInfo.set_current_user(id)
					toggle_login()
					$Login.clear_inputs(false)
					show_popup("Login successful.", true)
					emit_signal("login_successful")
				else:
					$Login.clear_inputs(false)
					show_popup("Invalid credentials.", false)
			
	else:
		$Login.clear_inputs()
		show_popup("There is no user associated with that ID.", false)


func _on_ButtonList_logout():
	GlobalInfo.clear_current_user()
	toggle_login()
	show_popup("Successfully logged out.", true)
	

func toggle_login():
	$Login.visible = !$Login.visible
	$ContentContainer.visible = !$ContentContainer.visible
	
func show_popup(text, is_good):
	var timed_popup = preload("res://TimedPopup.tscn").instance()
	timed_popup.init(text, is_good)
	get_parent().add_child(timed_popup)
#	timed_popup.popup(Rect2((get_viewport_rect().size.x / 2) - 150, (get_viewport_rect().size.y / 2) - 300, 1, 1))
#	timed_popup.focus_mode = Control.FOCUS_NONE
	timed_popup.set_position(Vector2((get_viewport_rect().size.x / 2) - 150, (get_viewport_rect().size.y / 2) - 300))
	timed_popup.show()
