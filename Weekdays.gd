extends VBoxContainer

var timetable = {}
onready var path = "res://timetables/" + str(GlobalInfo.current_user_id) + ".json"
#onready var path = "res://timetables/223971.json"

var lecture_stylebox = preload("res://lecture.tres")
var laboratory_stylebox = preload("res://laboratory.tres")

func _ready():
	timetable = GlobalFunctions.json_file_to_dict(path)
	for weekday in timetable.keys():
		var weekday_container = HBoxContainer.new()
		weekday_container.size_flags_horizontal = SIZE_EXPAND_FILL
		weekday_container.size_flags_vertical = SIZE_EXPAND_FILL
		add_child(weekday_container)
		
		var weekday_label = Label.new()
#		weekday_label.size_flags_horizontal = SIZE_EXPAND_FILL
#		weekday_label.size_flags_vertical = SIZE_EXPAND_FILL
#		weekday_label.size_flags_stretch_ratio = 1
		weekday_label.align = Label.ALIGN_CENTER
		weekday_label.valign = Label.VALIGN_CENTER
		weekday_label.text = weekday
		
		weekday_label.rect_min_size.x = 100
		
		weekday_container.add_child(weekday_label)
		
		var separator = VSeparator.new()
		weekday_container.add_child(separator)
		
		for subject in timetable[weekday]:
			var subject_node
			if subject.type == "free":
				subject_node = Control.new()
			else:
#				 subject.type == "lecture":
				subject_node = PanelContainer.new()
				var subject_name = Label.new()
				subject_name.text = subject["name"]
#				subject_name.size_flags_horizontal = SIZE_EXPAND_FILL
				subject_name.size_flags_vertical = SIZE_EXPAND_FILL
				subject_name.align = Label.ALIGN_CENTER
				subject_name.valign = Label.VALIGN_TOP
				subject_node.add_child(subject_name)
				
				var subject_hours = Label.new()
				subject_hours.text = subject["hours"]
#				subject_hours.size_flags_horizontal = SIZE_EXPAND_FILL
				subject_hours.size_flags_vertical = SIZE_EXPAND_FILL
				subject_hours.align = Label.ALIGN_CENTER
				subject_hours.valign = Label.VALIGN_BOTTOM
				subject_node.add_child(subject_hours)
				
				if subject["type"] == "lecture":
					subject_node.add_stylebox_override("panel", lecture_stylebox)
				elif subject["type"] == "laboratory":
					subject_node.add_stylebox_override("panel", laboratory_stylebox)
				
				
			subject_node.rect_min_size.x = 100 * subject["length"]
			subject_node.size_flags_horizontal = SIZE_EXPAND_FILL
			subject_node.size_flags_vertical = SIZE_EXPAND_FILL
			subject_node.size_flags_stretch_ratio = subject["length"]
			weekday_container.add_child(subject_node)
		if weekday != "Sunday":
			var weekday_separator = HSeparator.new()
			weekday_separator.size_flags_horizontal = SIZE_EXPAND_FILL
			add_child(weekday_separator)
			
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
