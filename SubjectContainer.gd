extends HBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var subject_name
#var grade
#var tutor
#var ects

var subject_name_label
var grade_label
var tutor_label
var ects_label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(subject):
#	self.subject_name = subject_name
#	self.tutor = tutor
#	self.grade = grade
#	self.ects = ects
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
	
	

