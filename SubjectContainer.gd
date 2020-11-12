extends HBoxContainer

var subject_name_label
var grade_label
var tutor_label
var ects_label

func _ready():
	pass

func _init(subject):

	subject_name_label = Label.new()
	subject_name_label.text = subject["name"]
	
	grade_label = Label.new()
	grade_label.text = str(subject["grade"])
	
	tutor_label = Label.new()
	tutor_label.text = subject["tutor"]
	
	ects_label = Label.new()
	ects_label.text = str(subject["ects"])
	
	add_child(subject_name_label)
	add_child(grade_label)
	add_child(tutor_label)
	add_child(ects_label)
	
	subject_name_label.size_flags_stretch_ratio = 1.5
	tutor_label.size_flags_stretch_ratio = 1.5
	
	for child in self.get_children():
		child.size_flags_horizontal = SIZE_EXPAND_FILL
		child.align = ALIGN_CENTER
	
	

