extends Node

var gravity = 980
var speed := 200
var jump_force := -200

var fragile_tilemaps = []
var usetime = 3
var tile_position

var power_ups: Dictionary ={}
var in_game_power_up = []
var coins = 0
var in_game_coin_count = 0
var using_slow_power_up = false
var using_double_jump = false
var using_shield = false


func _ready() -> void:
	load_coins()
	load_power_ups()

func  add_coin(amount : int):
	coins+=amount
	in_game_coin_count+=amount
	save_coins()
	
func save_coins():
	var file = FileAccess.open("user://coin_data.save", FileAccess.WRITE)
	file.store_var(coins)
	file.close()
	
func load_coins():
	if FileAccess.file_exists("user://coin_data.save"):
		var file =FileAccess.open("user://coin_data.save", FileAccess.READ)
		coins = file.get_var()
		file.close()
	else :
		coins = 0
#
func add_power_ups(power_name : String , amount : int = 1):
	if power_name in power_ups:
		power_ups[power_name] += amount
	else :
		power_ups[power_name] = amount
	save_power_ups()
	
func use_power_uo(power_name : String):
	if power_name in power_ups and power_ups[power_ups] > 0:
		power_ups[power_name] -= 1
		save_power_ups()
		return true
	return false
	
func load_power_ups():
	if FileAccess.file_exists("user://power_up_data.save"):
		var file = FileAccess.open("user://power_up_data.save", FileAccess.READ)
		power_ups =file.get_var()
		file.close()
	else: 
		power_ups ={}
func save_power_ups():
	var file = FileAccess.open("user://power_up_data.save", FileAccess.WRITE)
	file.store_var(power_ups)
	file.close()
	
