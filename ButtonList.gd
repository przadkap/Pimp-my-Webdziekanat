extends VBoxContainer

signal content_changed
signal logout
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ReportCardButton_pressed():
	emit_signal("content_changed", "report_card")


func _on_LogOutButton_pressed():
	emit_signal("logout")


func _on_PersonalInfoButton_pressed():
	emit_signal("content_changed", "personal_info")


func _on_TimetableButton_pressed():
	emit_signal("content_changed", "timetable")


func _on_SurveysButton_pressed():
	emit_signal("content_changed", "surveys")
