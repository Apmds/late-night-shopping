extends Node2D

export var time = 120
signal Finished

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = time
	$Timer.start()

func _process(delta):
	# Updates the text with 2 decimal places
	$Label.text = str("%.2f" % $Timer.time_left).replace(".", ":")

func _on_Timer_timeout():
	# Makes the text red and emits the "Finished" signal
	$Label.add_color_override("font_color", Color(1,0,0,1))
	emit_signal("Finished")
