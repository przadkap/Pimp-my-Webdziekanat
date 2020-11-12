extends Control

var id_text
var password_text

signal attempt_login

func _ready():
	pass # Replace with function body.

func _on_LoginButton_pressed():
	id_text = get_node("MasterPanel/MarginContainer/MasterVBox/IDVBox/IDInput").text
	password_text = get_node("MasterPanel/MarginContainer/MasterVBox/PasswordVBox/PasswordInput").text
#	print(id_text)
#	print(password_text)
	emit_signal("attempt_login", id_text, password_text)

func clear_inputs(clear_login = true):
	if clear_login:
		$MasterPanel/MarginContainer/MasterVBox/IDVBox/IDInput.text = ''
	$MasterPanel/MarginContainer/MasterVBox/PasswordVBox/PasswordInput.text = ''
