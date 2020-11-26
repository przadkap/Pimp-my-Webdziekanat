extends VBoxContainer

var id_data = {}
onready var path = "res://info/" + str(GlobalInfo.current_user_id) + ".json"

#var month_days = {
#	"1": 31,
#	"2": 28,
#	"3": 31,
#	"4": 30,
#	"5": 31,
#	"6": 30,
#	"7": 31,
#	"8": 31,
#	"9": 30,
#	"10": 31,
#	"11": 30,
#	"12": 31
#}

var green_stylebox = preload("res://progressbar_green.tres")
var yellow_stylebox = preload("res://progressbar_yellow.tres")
var orange_stylebox = preload("res://progressbar_orange.tres")
var red_stylebox = preload("res://progressbar_red.tres")

var red_font = preload("res://font_invalid.tres")
var green_font = preload("res://font_valid.tres")

func _ready():
	var user_data = GlobalFunctions.json_file_to_dict(path)
	id_data = user_data["id_data"]
	var date_today = OS.get_date()
	var days_valid = GlobalFunctions.calculate_days_passed(date_today, id_data["valid_to"])
	
	var renewal_interval = GlobalFunctions.calculate_days_passed(id_data["last_renewed"], id_data["valid_to"])
	$ProgressBar.max_value = renewal_interval
	
	if days_valid >= 0:
		$StatusHBox/ValidInvalid.text = "VALID"
#		$StatusHBox/ValidInvalid.add_font_override("font", green_font)
		$StatusHBox/ValidInvalid.add_color_override("font_color", Color("30ee2e"))
		$ProgressBar.value = renewal_interval - days_valid
		$ProgressBar/Days.text = str(days_valid) + " Days"
		
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
		$StatusHBox/ValidInvalid.text = "EXPIRED"
#		$StatusHBox/ValidInvalid.add_font_override("font", red_font)
		$StatusHBox/ValidInvalid.add_color_override("font_color", Color("e00c12"))
		$ProgressBar.value = renewal_interval
		$ProgressBar/Days.text = "0 Days"
		$ProgressBar.add_stylebox_override("fg", red_stylebox)
		
	
	$RenewedLabel.text = "Last renewed: " + id_data["last_renewed"]["day"] + "." + id_data["last_renewed"]["month"] + "." + id_data["last_renewed"]["year"]
	$ValidUntilLabel.text = "Valid until: " + id_data["valid_to"]["day"] + "." + id_data["valid_to"]["month"] + "." + id_data["valid_to"]["year"]
	


#func calculate_days_valid(today, valid_to):
#	if int(today["year"]) == int(valid_to["year"]):
#		var days_to_today = 0
#		var days_to_expire = 0
#		for month in month_days.keys():
#			if int(month) < int(today["month"]):
#				days_to_today += month_days[month]
#			elif int(month) == int(today["month"]):
#				days_to_today += int(today["day"])
#
#			if int(month) < int(valid_to["month"]):
#				days_to_expire += month_days[month]
#			elif int(month) == int(valid_to["month"]):
#				days_to_expire += int(valid_to["day"])
#
#		return days_to_expire - days_to_today
#
#	elif int(today["year"]) < int(valid_to["year"]):
#		var days_valid = 0
#		for month in month_days.keys():
#			if int(month) == int(today["month"]):
#				days_valid += month_days[month] - int(today["day"])
#			elif int(month) > int(today["month"]):
#				days_valid += month_days[month] 
#			if int(month) < int(valid_to["month"]):
#				days_valid += month_days[month]
#			elif int(month) == int(valid_to["month"]):
#				days_valid += int(valid_to["day"])
#		return days_valid
#	else:
#		return -365

