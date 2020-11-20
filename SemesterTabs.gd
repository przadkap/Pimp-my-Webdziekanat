extends TabContainer

#var user = "223971"
var user
var grade_data = {}
var subject_header_data = {"name": "Name", "grade": "Grade", "tutor": "Tutor", "ects": "ECTS"}

#var total_GPA = 5.00
var total_ECTS = 0

var user_GPA = 0
var user_ECTS = 0

const SubjectContainer = preload("SubjectContainer.gd")

func _ready():
	
	user = GlobalInfo.current_user_id
	
	grade_data = GlobalFunctions.json_file_to_dict("res://grades.json")
	
	var grade_points = 0
	
	for semester in grade_data[user]:
		
		total_ECTS += 30
		
		var semester_container = VBoxContainer.new()
		
		semester_container.name = "Semester " + arabic_to_roman(int(semester["semester_no"]))
		semester_container.size_flags_horizontal = SIZE_EXPAND
		add_child(semester_container)
		
		var subject_header = SubjectContainer.new(subject_header_data)
		subject_header.set_custom_minimum_size(Vector2(0, 50))
		semester_container.add_child(subject_header)
		
		for subject in semester["subjects"]:
			
			user_ECTS += subject["ects"]
			
			if str(subject["grade"]) != "passed" and str(subject["grade"]) != "failed":
				grade_points += (subject["grade"] * subject["ects"])
			
			var subject_container = SubjectContainer.new(subject)
			subject_container.set_custom_minimum_size(Vector2(0, 50))
			semester_container.add_child(subject_container)
			
	var grade_average = grade_points / total_ECTS
	grade_average = stepify(grade_average, 0.01)

	get_parent().get_node("ExtrasVBox/TotalECTS").text = "Total ECTS: " + str(user_ECTS) + "/" + str(total_ECTS)
	get_parent().get_node("ExtrasVBox/TotalGPA").text = "Total GPA: " + str(grade_average) + "/" + "5.00"



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

func process_GPA():
	pass

func process_ECTS():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
