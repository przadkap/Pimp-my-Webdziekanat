extends VBoxContainer

var survey_data = {}
onready var path = "res://surveys/" + str(GlobalInfo.current_user_id) + ".json"
var survey_stylebox = preload("res://survey.tres")

func _ready():
	survey_data = GlobalFunctions.json_file_to_dict(path)
	for survey in survey_data:
		var master_container = PanelContainer.new()
		master_container.size_flags_horizontal = SIZE_EXPAND_FILL
		master_container.add_stylebox_override("panel", survey_stylebox)
#		master_container.size_flags_vertical = SIZE_EXPAND_FILL
		
		var survey_container = HBoxContainer.new()
		var icon = TextureRect.new()
		
		if survey["status"] == "done":
			icon.texture = load("res://success1.png")
		else:
			icon.texture = load("res://failure.png")
			
		survey_container.add_child(icon)
		
		var subject_label = Label.new()
		subject_label.text = survey["subject"]
		center_and_expand_label(subject_label)
		survey_container.add_child(subject_label)
		
		var tutor_label = Label.new()
		tutor_label.text = survey["tutor"]
		center_and_expand_label(tutor_label)
		survey_container.add_child(tutor_label)
		
		var submit_containter = VBoxContainer.new()
		var status_label = Label.new()
		status_label.text = "Status: " + survey["status"]
		center_and_expand_label(status_label)
		
		submit_containter.add_child(status_label)
		
		var submit_button = Button.new()
		submit_button.align = Button.ALIGN_CENTER
		
		if survey["status"] == "pending":
			submit_button.text = "Fill in!"
		else:
			submit_button.text = "Completed"
			submit_button.disabled = true
		
		submit_button.size_flags_vertical = SIZE_EXPAND_FILL
		
		submit_button.connect("pressed", self, "display_notification")
		
		submit_containter.add_child(submit_button)
		
		
		survey_container.add_child(submit_containter)
		
		master_container.add_child(survey_container)
		add_child(master_container)

func center_and_expand_label(new_label):
		new_label.align = Label.ALIGN_CENTER
		new_label.valign = Label.VALIGN_CENTER
		new_label.size_flags_horizontal = SIZE_EXPAND_FILL
		new_label.size_flags_vertical = SIZE_EXPAND_FILL

func display_notification():
	GlobalFunctions.show_popup("Survey is not available at this time.", false, GlobalFunctions.POPUP_POS.DOWN)
