extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_button_pressed():
	$Button_sound.play()
	yield($Button_sound, "finished")
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Sound_toggle_toggled(button_pressed):
	$Button_sound.play()
	AudioServer.set_bus_mute(1, button_pressed)
	
