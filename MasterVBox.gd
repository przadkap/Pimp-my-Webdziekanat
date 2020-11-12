extends VBoxContainer

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
				else:
					$Login.clear_inputs(false)
					print("Invalid credentials.") # make popup
			
	else:
		$Login.clear_inputs()
		print("User does not exist") # make popup


func _on_ButtonList_logout():
	GlobalInfo.clear_current_user()
	toggle_login()
	

func toggle_login():
	$Login.visible = !$Login.visible
	$ContentContainer.visible = !$ContentContainer.visible
