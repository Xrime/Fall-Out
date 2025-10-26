extends Node

var gravity = 980
var speed := 200
var jump_force := -400

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
var slow_motion = 0
var sheild = 0
var double_jump = 0

#mode specified
var Puzzle_mode = false
var Spining_mode =false
var space_mode  = false
var underwater_mode = false
var Exploding_platform = false
var is_oxygen = false


var oxygen = 100


func _ready() -> void:
	load_coins()
	load_power_ups()
	load_exp()
	if space_mode:
		gravity = -1
		

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
	
func use_power_up(power_name : String):
	if power_name in power_ups and power_ups[power_name] > 0:
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
	slow_motion = power_ups.get("slow_motion",0)
	sheild = power_ups.get("shield", 0)
	double_jump =power_ups.get("double_jump" ,0)
	
func save_power_ups():
	var file = FileAccess.open("user://power_up_data.save", FileAccess.WRITE)
	file.store_var(power_ups)
	file.close()
	
var win =false
var loss =false
var level = 0
var mode = ""
var exp
	
func  add_exp(amount :int):
	exp +=amount
	save_exp()
func save_exp():
	var file = FileAccess.open("user://exp_data.save" , FileAccess.WRITE)
	file.store_var(exp)
	file.close()
	
func load_exp():
	if FileAccess.file_exists("user://exp_data.save" ):
		var file = FileAccess.open("user://exp_data.save", FileAccess.READ)
		exp = file.get_var()
		file.close()
	else :
		exp =0
	
func _process(delta: float) -> void:
	if level==1 and mode=="puzzle" and win==true :
		add_exp(100)
		add_coin(10)
	elif level==2 and mode=="puzzle" and win ==true:
		add_exp(200)
		add_coin(20)
	elif level==1 and mode=="space" and win==true:
		add_exp(300)
		add_coin(30)
	elif  level == 2 and mode == "space" and win==true:
		add_exp(400)
		add_coin(40)
	elif  level == 1 and mode =="spinning" and win == true:
		add_exp(500)
		add_coin(50)
	elif level == 2 and mode =="spinning" and win == true:
		add_exp(600)
		add_coin(60)
	elif mode == "exploding" and win == false:
		add_exp(1000)
		add_coin(100)
	else:
		add_exp(50)
		add_coin(5)
	
	
	
	
	
