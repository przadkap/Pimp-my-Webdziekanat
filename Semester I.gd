extends VBoxContainer

# TODO make subject container a separate scene

var user = "223971"

var grade_data = {}

var semester_number = 1

func _ready():
	var file = File.new()
	file.open("res://grades.json", file.READ)
	var content = file.get_as_text()
	var content_json = JSON.parse(content)
	grade_data = content_json.result
#	print(grade_data)
	for semester in grade_data[user]:
		if semester["semester_no"] != semester_number:
			continue
		for subject in semester["subjects"]:
			var subject_container = HBoxContainer.new()
			self.add_child(subject_container)
#			subject_container.size_flags_horizontal(SIZE_EXPAND_FILL)
			var subject_name = Label.new()
#			subject_name.size_flags_horizontal(SIZE_EXPAND_FILL)
			subject_name.text = subject["name"]
			subject_container.add_child(subject_name)
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
