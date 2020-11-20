extends PanelContainer


var home_scene = preload("Home.tscn")
var report_card_scene = preload("ReportCard.tscn")
var personal_info_scene = preload("PersonalInfo.tscn")
var timetable_scene = preload("Timetable.tscn")
var surveys_scene = preload("Surveys.tscn")

var scenes = {
	"report_card": report_card_scene,
	"personal_info": personal_info_scene,
	"timetable": timetable_scene,
	"surveys": surveys_scene,
	"home": home_scene
	}

var current_scene


func _ready():
	pass


func _on_ButtonList_content_changed(new_content):
	if current_scene != null:
		current_scene.queue_free()
	current_scene = scenes[new_content].instance()
	add_child(current_scene)


func _on_MasterVBox_login_successful():
	current_scene = scenes["home"].instance()
	add_child(current_scene)


func _on_HomeButton_pressed():
	if GlobalInfo.current_user_id:
		if current_scene != null:
			current_scene.queue_free()
		current_scene = scenes["home"].instance()
		add_child(current_scene)
