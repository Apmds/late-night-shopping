extends Node

var RNG = RandomNumberGenerator.new()
var names
var presents
var game_on = true
var points = 0
var present_list = [] # Contains the categories and types for all the presents

# Called when the node enters the scene tree for the first time.
func _ready():
	RNG.randomize()
	names = load_data("names", "res://")["names"]
	presents = load_data("presents", "res://")

func save_data(data, file, path = OS.get_user_data_dir()):
	## Create and open your file.
	var SAVE_PATH = path+file+'.json'
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	# Convert your data to a useable string-format.
	save_file.store_line(to_json(data))
	# Close file.
	save_file.close()

func load_data(file, path = OS.get_user_data_dir()):
	# Create your file
	var SAVE_PATH = path+file+".json"
	var save_file = File.new()
	# Return 'empty' if file doesn't exist
	if not save_file.file_exists(SAVE_PATH):
		return null
	# Open your file
	save_file.open(SAVE_PATH, File.READ)
	# Save data from file.
	var data = parse_json(save_file.get_as_text())
	# Close file 
	save_file.close()
	# Return data
	return data
