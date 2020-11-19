extends Node

enum POPUP_POS {
	UP,
	DOWN
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
