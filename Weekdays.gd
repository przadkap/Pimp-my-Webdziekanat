extends VBoxContainer

var timetable = {}
onready var path = "res://timetables/" + str(GlobalInfo.current_user_id) + ".json"

var lecture_stylebox = preload("res://lecture.tres")
var laboratory_stylebox = preload("res://laboratory.tres")

func _ready():
	timetable = GlobalFunctions.json_file_to_dict(path)
	for weekday in timetable.keys():
		if weekday == "Saturday" or weekday == "Sunday":
			continue
		var weekday_container = HBoxContainer.new()
		weekday_container.size_flags_horizontal = SIZE_EXPAND_FILL
		weekday_container.size_flags_vertical = SIZE_EXPAND_FILL
		add_child(weekday_container)
		
		var weekday_label = Label.new()

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
				subject_node = PanelContainer.new()
				var subject_name = RichTextLabel.new()
				subject_name.bbcode_enabled = true
				subject_name.push_align(RichTextLabel.ALIGN_CENTER)
				
				if subject["length"] > 1:
					subject_name.append_bbcode("\n")
				
				subject_name.append_bbcode(subject["name"])
				subject_name.append_bbcode("\n")
				subject_name.push_color("#848991")
				subject_name.append_bbcode(subject["hours"])
				subject_name.scroll_active = false
				subject_node.add_child(subject_name)
				
				
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
			
			

