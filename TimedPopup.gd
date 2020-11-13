extends Popup

class_name TimedPopup

var lifetime

func _ready():
	$LifeTimer.start(lifetime)

func init(text, is_good, custom_lifetime = 2.5):
	lifetime = custom_lifetime
	if is_good:
		$PopupPanel/PopupHBox/TextureContainer/PopupIcon.texture = load("res://success1.png")
	else:
		$PopupPanel/PopupHBox/TextureContainer/PopupIcon.texture = load("res://failure.png")
	$PopupPanel/PopupHBox/PopupInfoLabel.text = text

func _on_LifeTimer_timeout():
	queue_free()
