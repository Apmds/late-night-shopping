extends Node2D


var obtained_presents = []

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.points = 0
	$Points.text = "Presents wrapped: " + str(Global.points)
	Global.game_on = true
	for present in $Presents.get_children():
		present.connect("dropped", self, "_on_Present_dropped")
	$Timer.connect("Finished", self, "_on_Timer_finished")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Make the cart big or small depending on the mouse position
	if $Cart.rect_position.x <= get_global_mouse_position().x and $Cart.rect_position.x + $Cart.rect_size.x >= get_global_mouse_position().x and $Cart.rect_position.y <= get_global_mouse_position().y and $Cart.rect_position.y + $Cart.rect_size.y >= get_global_mouse_position().y and Global.game_on:
		$Tween.interpolate_property($Cart, "rect_scale", $Cart.rect_scale, Vector2(1.3, 1.3), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	else:
		$Tween.interpolate_property($Cart, "rect_scale", $Cart.rect_scale, Vector2(1, 1), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

# Checks if both arrays have the same content
func arrays_have_same_content(array1, array2):
	if array1.size() != array2.size():
		return false
	for item in array1:
		if !array2.has(item):
			return false
		if array1.count(item) != array2.count(item):
			return false
	return true

# Runs when any present is dropped
func _on_Present_dropped(x, y, cat, type):
	# Check if the present is inside the cart and adds it to the list
	if $Cart.rect_position.x <= x and $Cart.rect_position.x + $Cart.rect_size.x >= x and $Cart.rect_position.y <= y and $Cart.rect_position.y + $Cart.rect_size.y >= y:
		obtained_presents.append([cat, type])
		var sprite = Sprite.new()
		var texture = load("res://Assets/Items/Item_" + str(cat) + "_" + str(type) + ".png")
		sprite.texture = texture
		sprite.rotation_degrees = Global.RNG.randi_range(0, 360)
		sprite.position.x = Global.RNG.randi_range($Cart.rect_position.x, $Cart.rect_position.x + $Cart.rect_size.x)
		sprite.position.y = Global.RNG.randi_range($Cart.rect_position.y, $Cart.rect_position.y + $Cart.rect_size.y)
		$Cart_presents.add_child(sprite)
		
		# Present list has been completed
		if arrays_have_same_content(obtained_presents, Global.present_list):
			# Updates the points
			Global.points += 1
			$Points.text = "Presents wrapped: " + str(Global.points)
			
			# Deletes the presents in the cart and gets a new list
			_on_Reset_button_pressed()
			$Reset_sound.play()
			$Present_list.new_list()
			

# Stop the game when the time ends
func _on_Timer_finished():
	Global.game_on = false
	$End_sound.play()
	yield(get_tree().create_timer(1.5), "timeout")
	$Tween.interpolate_property($CanvasModulate, "color", Color(1, 1, 1), Color(0, 0, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($End_sound, "finished")
	get_tree().change_scene("res://Scenes/End_menu.tscn")

# Resets the presents
func _on_Reset_button_pressed():
	obtained_presents = []
	for present in $Cart_presents.get_children():
		present.queue_free()
