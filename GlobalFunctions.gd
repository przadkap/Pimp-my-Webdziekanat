extends Node

func _ready():
	pass # Replace with function body.

func json_file_to_dict(path):
	var file = File.new()
	file.open(path, file.READ)
	var content = file.get_as_text()
	var content_json = JSON.parse(content)
	return content_json.result
