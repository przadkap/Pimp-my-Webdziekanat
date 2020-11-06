extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var report_card_scene = preload("ReportCard.tscn")
var current_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# warning-ignore:unused_argument
func _on_ButtonList_content_changed(new_content):
	if current_scene != null:
		current_scene.queue_free()
	current_scene = report_card_scene.instance()
	add_child(current_scene)
