extends VBoxContainer

var insurance_data = {}
onready var path = "res://info/" + str(GlobalInfo.current_user_id) + ".json"

func _ready():
	var user_data = GlobalFunctions.json_file_to_dict(path)
	insurance_data = user_data["insurance_data"]
	var date_today = OS.get_date()
	var days_valid = GlobalFunctions.calculate_days_passed(date_today, insurance_data["valid_to"])
	
	var renewal_interval = GlobalFunctions.calculate_days_passed(insurance_data["last_renewed"], insurance_data["valid_to"])
	$ProgressBar.max_value = renewal_interval
	
	if days_valid >= 0:
		$StatusLabel.text = "Status: VALID"
		$ProgressBar.value = renewal_interval - days_valid
		$ProgressBar/Days.text = str(days_valid) + " Days"
		
	else:
		$StatusLabel.text = "Status: EXPIRED"
		$ProgressBar.value = renewal_interval
		$ProgressBar/Days.text = "0 Days"
		
	
	$RenewedLabel.text = "Last renewed: " + insurance_data["last_renewed"]["day"] + "." + insurance_data["last_renewed"]["month"] + "." + insurance_data["last_renewed"]["year"]
	$ValidUntilLabel.text = "Valid until: " + insurance_data["valid_to"]["day"] + "." + insurance_data["valid_to"]["month"] + "." + insurance_data["valid_to"]["year"]
	
