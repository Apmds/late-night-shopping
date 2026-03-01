extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.points == 0:
		$Points.text = "You couldn't wrap any presents, but the elves made all of them for you!"
	else:
		$Points.text = "Congrats! You were able to wrap " + str(Global.points) + " presents!"

func _on_Back_button_pressed():
	$Button_sound.play()
	yield($Button_sound, "finished")
	get_tree().change_scene("res://Scenes/Main_menu.tscn")
