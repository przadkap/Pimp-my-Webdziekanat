extends VBoxContainer

var user_details

func _ready():
	
	var users_details = GlobalFunctions.json_file_to_dict("res://user_details.json")
	user_details = users_details[GlobalInfo.current_user_id]
	
	$FirstNameVBox/InputHBox/FirstNameEdit.text = user_details["firstname"]
	$LastNameVBox/InputHBox/LastNameEdit.text = user_details["lastname"]
	$IndexVBox/InputHBox/IndexEdit.text = user_details["id"]
	$BirthDateVBox/InputHBox/BirthDateEdit.text = user_details["birthdate"]
	$PESELVBox/InputHBox/PESELEdit.text = user_details["PESEL"]

