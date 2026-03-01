extends Node2D

var names
var presents
var current_name

# Called when the node enters the scene tree for the first time.
func _ready():
	names = Global.names
	presents = Global.presents
	new_list()

# Generates a new list
func new_list():
	# Sets a new name
	current_name = names[Global.RNG.randi_range(0, len(names)-1)]
	$Kid_name.text = "Name: " + current_name
	
	# Makes a new present list
	Global.present_list = []
	var present_category = 0
	var present_type = 0
	for _i in range(Global.RNG.randi_range(2, 4)):
		present_category = Global.RNG.randi_range(0, len(presents["presents"]) - 1)
		present_type = Global.RNG.randi_range(0, len(presents[presents["presents"][present_category]]) - 1)
		Global.present_list.append([present_category, present_type])
	
	# Deletes the equal items in the present list
	Global.present_list = delete_duplicates(Global.present_list)
	
	# Set the label's text
	$Presents.text = ""
	for pr in Global.present_list:
		var present_category_name = presents["presents"][pr[0]]
		var present_name = presents[present_category_name][pr[1]] + " " + present_category_name
		$Presents.text += "- " + present_name + "\n"
	
	# Animation
	$Tween.interpolate_property(self, "scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

# Deletes the duplicate items of an array
func delete_duplicates(arr):
	var new_arr = []
	for item in arr:
		if not new_arr.has(item):
			new_arr.append(item)
	return new_arr
