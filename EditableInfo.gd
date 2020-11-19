extends VBoxContainer

var user_details

onready var path = "res://correspondence/" + str(GlobalInfo.current_user_id) + ".json"

func _ready():
	
	user_details = GlobalFunctions.json_file_to_dict(path)
	
	load_details()
	
#	$StreetVBox/InputHBox/StreetEdit.text = user_details["street"]
#	$BuildingVBox/InputHBox/BuildingEdit.text = user_details["building"]
#	$TownVBox/InputHBox/TownEdit.text = user_details["town"]
#	$VoivodeshipVBox/InputHBox/VoivodeshipEdit.selected = user_details["voivodeship"]
#	$PostalCodeVBox/InputHBox/PostalCodeEdit1.text = str(user_details["postal_1"])
#	$PostalCodeVBox/InputHBox/PostalCodeEdit2.text = str(user_details["postal_2"])

	
func load_details():
	$StreetVBox/InputHBox/StreetEdit.text = user_details["street"]
	$BuildingVBox/InputHBox/BuildingEdit.text = user_details["building"]
	$TownVBox/InputHBox/TownEdit.text = user_details["town"]
	$VoivodeshipVBox/InputHBox/VoivodeshipEdit.selected = user_details["voivodeship"]
	$PostalCodeVBox/InputHBox/PostalCodeEdit1.text = str(user_details["postal_1"])
	$PostalCodeVBox/InputHBox/PostalCodeEdit2.text = str(user_details["postal_2"])


func _on_EnableEditButton_pressed():
	toggle_edit_mode()

func _on_DiscardChangesButton_pressed():
	load_details()
	toggle_edit_mode()
	GlobalFunctions.show_popup("Your changes were reverted.", true, GlobalFunctions.POPUP_POS.DOWN)
	

func toggle_edit_mode():
	$StreetVBox/InputHBox/StreetEdit.editable = !$StreetVBox/InputHBox/StreetEdit.editable
	$BuildingVBox/InputHBox/BuildingEdit.editable = !$BuildingVBox/InputHBox/BuildingEdit.editable
	$TownVBox/InputHBox/TownEdit.editable = !$TownVBox/InputHBox/TownEdit.editable
	$VoivodeshipVBox/InputHBox/VoivodeshipEdit.disabled = !$VoivodeshipVBox/InputHBox/VoivodeshipEdit.disabled
	$PostalCodeVBox/InputHBox/PostalCodeEdit1.editable = !$PostalCodeVBox/InputHBox/PostalCodeEdit1.editable
	$PostalCodeVBox/InputHBox/PostalCodeEdit2.editable = !$PostalCodeVBox/InputHBox/PostalCodeEdit2.editable

	$Buttons/DiscardChangesButton.disabled = !$Buttons/DiscardChangesButton.disabled
	$Buttons/SaveChangesButton.disabled = !$Buttons/SaveChangesButton.disabled
	$Buttons/EnableEditButton.disabled = !$Buttons/EnableEditButton.disabled


func _on_SaveChangesButton_pressed():
	user_details["street"] = $StreetVBox/InputHBox/StreetEdit.text
	user_details["building"] = $BuildingVBox/InputHBox/BuildingEdit.text
	user_details["town"] = $TownVBox/InputHBox/TownEdit.text
	user_details["voivodeship"] = $VoivodeshipVBox/InputHBox/VoivodeshipEdit.selected
	user_details["postal_1"] = int($PostalCodeVBox/InputHBox/PostalCodeEdit1.text)
	user_details["postal_2"] = int($PostalCodeVBox/InputHBox/PostalCodeEdit2.text)
	GlobalFunctions.dict_to_json_file(user_details, path)
	toggle_edit_mode()
	GlobalFunctions.show_popup("Your changes were save successfully.", true, GlobalFunctions.POPUP_POS.DOWN)
	
	
