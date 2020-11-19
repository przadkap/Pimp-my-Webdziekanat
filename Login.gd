extends Control

var id_text
var password_text

signal attempt_login

func _ready():
	pass # Replace with function body.

func _on_LoginButton_pressed():
	update_field_text()
	emit_signal("attempt_login", id_text, password_text)

func clear_inputs(clear_login = true):
	if clear_login:
		$MasterPanel/MarginContainer/MasterVBox/IDVBox/IDInput.text = ''
	$MasterPanel/MarginContainer/MasterVBox/PasswordVBox/PasswordInput.text = ''

func update_field_text():
	id_text = $MasterPanel/MarginContainer/MasterVBox/IDVBox/IDInput.text
	password_text = $MasterPanel/MarginContainer/MasterVBox/PasswordVBox/PasswordInput.text

func _unhandled_key_input(event):
	if self.visible:
		if event.scancode == KEY_ENTER:
			update_field_text()
			emit_signal("attempt_login", id_text, password_text)
	
