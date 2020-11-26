extends VBoxContainer

var insurance_data = {}
onready var path = "res://info/" + str(GlobalInfo.current_user_id) + ".json"

var green_stylebox = preload("res://progressbar_green.tres")
var yellow_stylebox = preload("res://progressbar_yellow.tres")
var orange_stylebox = preload("res://progressbar_orange.tres")
var red_stylebox = preload("res://progressbar_red.tres")

var red_font = preload("res://font_invalid.tres")
var green_font = preload("res://font_valid.tres")

func _ready():
	var user_data = GlobalFunctions.json_file_to_dict(path)
	insurance_data = user_data["insurance_data"]
	var date_today = OS.get_date()
	var days_valid = GlobalFunctions.calculate_days_passed(date_today, insurance_data["valid_to"])
	
	var renewal_interval = GlobalFunctions.calculate_days_passed(insurance_data["last_renewed"], insurance_data["valid_to"])
	$ProgressBar.max_value = renewal_interval
	
	if days_valid >= 0:
#		$StatusLabel.text = "Status: VALID"
		$ProgressBar.value = renewal_interval - days_valid
		$ProgressBar/Days.text = str(days_valid) + " Days"
		
		$StatusHBox/ValidInvalid.text = "VALID"
#		$StatusHBox/ValidInvalid.add_font_override("font", green_font)
		$StatusHBox/ValidInvalid.add_color_override("font_color", Color("30ee2e"))
		
		var percentage = float(renewal_interval - days_valid) / float(renewal_interval)
		if percentage <= 0.75:
			$ProgressBar.add_stylebox_override("fg", green_stylebox)
		elif percentage <= 0.85:
			$ProgressBar.add_stylebox_override("fg", yellow_stylebox)
		elif percentage <= 0.95:
			$ProgressBar.add_stylebox_override("fg", orange_stylebox)
		else:
			$ProgressBar.add_stylebox_override("fg", red_stylebox)
		
	else:
#		$StatusLabel.text = "Status: "
		$StatusHBox/ValidInvalid.text = "EXPIRED"
#		$StatusHBox/ValidInvalid.add_font_override("font", red_font)
		$StatusHBox/ValidInvalid.add_color_override("font_color", Color("e00c12"))
		$ProgressBar.value = renewal_interval
		$ProgressBar/Days.text = "0 Days"
		$ProgressBar.add_stylebox_override("fg", red_stylebox)
		
	
	$RenewedLabel.text = "Last renewed: " + insurance_data["last_renewed"]["day"] + "." + insurance_data["last_renewed"]["month"] + "." + insurance_data["last_renewed"]["year"]
	$ValidUntilLabel.text = "Valid until: " + insurance_data["valid_to"]["day"] + "." + insurance_data["valid_to"]["month"] + "." + insurance_data["valid_to"]["year"]
	
