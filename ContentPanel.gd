extends PanelContainer


var report_card_scene = preload("ReportCard.tscn")
var scenes = {"report_card": report_card_scene}
var current_scene


func _ready():
	pass



func _on_ButtonList_content_changed(new_content):
	if current_scene != null:
		current_scene.queue_free()
	current_scene = scenes[new_content].instance()
	add_child(current_scene)
