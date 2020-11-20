extends Node

enum POPUP_POS {
	UP,
	DOWN
}


var month_days = {
	"1": 31,
	"2": 28,
	"3": 31,
	"4": 30,
	"5": 31,
	"6": 30,
	"7": 31,
	"8": 31,
	"9": 30,
	"10": 31,
	"11": 30,
	"12": 31
}

func _ready():
	pass # Replace with function body.

func json_file_to_dict(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	var content_json = JSON.parse(content)
	file.close()
	return content_json.result


func dict_to_json_file(dict, path):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(dict))
	file.close()

func show_popup(text, is_good, position):
	var timed_popup = preload("res://TimedPopup.tscn").instance()
	timed_popup.init(text, is_good)
	get_parent().add_child(timed_popup)
#	timed_popup.popup(Rect2((get_viewport_rect().size.x / 2) - 150, (get_viewport_rect().size.y / 2) - 300, 1, 1))
#	timed_popup.focus_mode = Control.FOCUS_NONE
	if position == POPUP_POS.UP:
		timed_popup.set_position(Vector2((get_viewport().size.x / 2) - 150, (get_viewport().size.y / 2) - 300))
	elif position == POPUP_POS.DOWN:
		timed_popup.set_position(Vector2((get_viewport().size.x / 2) - 150, (get_viewport().size.y / 2) + 300))
	timed_popup.show()


func calculate_days_passed(today, valid_to):
	if int(today["year"]) == int(valid_to["year"]):
		var days_to_today = 0
		var days_to_expire = 0
		for month in month_days.keys():
			if int(month) < int(today["month"]):
				days_to_today += month_days[month]
			elif int(month) == int(today["month"]):
				days_to_today += int(today["day"])
				
			if int(month) < int(valid_to["month"]):
				days_to_expire += month_days[month]
			elif int(month) == int(valid_to["month"]):
				days_to_expire += int(valid_to["day"])
		
		return days_to_expire - days_to_today
	
	elif int(today["year"]) < int(valid_to["year"]):
		var days_valid = 0
		for month in month_days.keys():
			if int(month) == int(today["month"]):
				days_valid += month_days[month] - int(today["day"])
			elif int(month) > int(today["month"]):
				days_valid += month_days[month] 
			if int(month) < int(valid_to["month"]):
				days_valid += month_days[month]
			elif int(month) == int(valid_to["month"]):
				days_valid += int(valid_to["day"])
		return days_valid
	else:
		return -365
