extends Node
var fragile_tilemaps = []
var usetime = 3
var tile_position

var coins = 0

func _ready() -> void:
	load_coins()
	
func  add_coin(amount : int):
	coins+=amount
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
		
