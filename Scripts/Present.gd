extends Control

export var category = 0 # Goes from 0 to 4
export var type = 0 # Goes from 0 to 3(or 1)
export var initial_position = Vector2(0, 0) 
var selected = true
var mouse_hover = false
signal dropped(x, y, cat, type)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Changes the sprite and rect_size based on the category and type chosen
	var sprite = load("res://Assets/Items/Item_" + str(category) + "_" + str(type) + ".png")
	$Sprite.texture = sprite
	rect_size = Vector2($Sprite.texture.get_width(), $Sprite.texture.get_height())
	rect_position = initial_position

func _input(event):
	# Checks if is grabbable and moves accordingly
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(1) and mouse_hover and Global.game_on:
		rect_position = event.position - Vector2(rect_scale.x*rect_size.x/2, rect_scale.y*rect_size.y/2)
	# Checks if the mouse was released in order to drop the present
	if event is InputEventMouseButton and !event.is_pressed() and event.get_button_index() == 1:
		emit_signal("dropped", rect_position.x, rect_position.y, category, type)
		_on_Present_mouse_exited()

func _on_Present_mouse_entered():
	 # Goes in front of the other sprites
	 $Sprite.z_index = 1
	 mouse_hover = true

func _on_Present_mouse_exited():
	 # Return to the original position
	 $Sprite.z_index = 0
	 mouse_hover = false
	 rect_position = initial_position
	
