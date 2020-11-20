extends TabContainer

var user = "223971"
var grade_data = {}
var subject_header_data = {"name": "Name", "grade": "Grade", "tutor": "Tutor", "ects": "ECTS"}

const SubjectContainer = preload("SubjectContainer.gd")

func _ready():

	grade_data = GlobalFunctions.json_file_to_dict("res://grades.json")
	for semester in grade_data[user]:
		
		var semester_container = VBoxContainer.new()
		
		semester_container.name = "Semester " + arabic_to_roman(int(semester["semester_no"]))
		semester_container.size_flags_horizontal = SIZE_EXPAND
		add_child(semester_container)
		
		var subject_header = SubjectContainer.new(subject_header_data)
		subject_header.set_custom_minimum_size(Vector2(0, 50))
		semester_container.add_child(subject_header)
		
		for subject in semester["subjects"]:
			var subject_container = SubjectContainer.new(subject)
			subject_container.set_custom_minimum_size(Vector2(0, 50))
			semester_container.add_child(subject_container)

func arabic_to_roman(arabic_number):
	if arabic_number == 1:
		return "I"
	elif arabic_number == 2:
		return "II"
	elif arabic_number == 3:
		return "III"
	elif arabic_number == 4:
		return "IV"
	elif arabic_number == 5:
		return "V"
	elif arabic_number == 6:
		return "VI"
	elif arabic_number == 7:
		return "VII"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
