extends Node

@onready var spawnTimer: Timer = get_node("Timer")
@onready var Crab01Instance = preload("res://Scenes/Enemies/Crab01.tscn")
@onready var Crab02Instance = preload("res://Scenes/Enemies/Crab02.tscn")
@onready var Fish01Instance = preload("res://Scenes/Enemies/Fish01.tscn")
@onready var Fish02Instance = preload("res://Scenes/Enemies/Fish02.tscn")
@onready var Fish03Instance = preload("res://Scenes/Enemies/Fish03.tscn")
@onready var Fish04Instance = preload("res://Scenes/Enemies/Fish04.tscn")
@onready var Jellyfish01Instance = preload("res://Scenes/Enemies/Jellyfish01.tscn")
@onready var Jellyfish02Instance = preload("res://Scenes/Enemies/Jellyfish02.tscn")
@onready var Jellyfish03Instance = preload("res://Scenes/Enemies/Jellyfish03.tscn")
@onready var Shark01Instance = preload("res://Scenes/Enemies/Shark01.tscn")
@onready var Shark02Instance = preload("res://Scenes/Enemies/Shark02.tscn")

# width = 1024
# height = 576
# Layer 00 z = -25
# Layer 01 z = -20
# Layer 02 z = -15
# Layer 03 z = -10
# Layer 04 z = 0
# Treasurer Chest z = 5
# Layer 05 z = 10

# Crab Heigh: 204 / Center is 102 = 
# Crab Width 401 / Center is 200 
var maxSpanData = { "crab": 1, "fish": 10, "jellyfish": 4, "shark": 2 }

var CrabSpawnData = [
	{"x": -205, "y": 516, "xvar": 0, "yvar": 50, "xdir":  1, "ydir": 0, "xscale": .5, "yscale": .5, "zindex" : 7 },
	{"x": 1229, "y": 516, "xvar": 0, "yvar": 50, "xdir": -1, "ydir": 0, "xscale": .5, "yscale": .5, "zindex" : 7 },
]

var FishSpawnData = [
	{"x": -205, "y": 144, "xvar": 0, "yvar": 80, "xdir":  1, "ydir": 0, "xscale": .25, "yscale": .25, "zindex" : -17 },
	{"x": 1229, "y": 144, "xvar": 0, "yvar": 80, "xdir": -1, "ydir": 0, "xscale": .25, "yscale": .25, "zindex" : -17 },
	{"x": -205, "y": 204, "xvar": 0, "yvar": 80, "xdir":  1, "ydir": 0, "xscale": .5, "yscale": .5, "zindex" : -13 },
	{"x": 1229, "y": 204, "xvar": 0, "yvar": 80, "xdir": -1, "ydir": 0, "xscale": .5, "yscale": .5, "zindex" : -13 },
]

var JellyfishSpawnData = [
	{"x": 0,   "y": -200,  "xvar": 300, "yvar": 0,  "xdir":  0, "ydir": 1,  "xscale": .5, "yscale": .5, "zindex" : 8 },
	{"x": 600, "y": -200,  "xvar": 400, "yvar": 0,  "xdir":  0, "ydir": 1,  "xscale": .5, "yscale": .5, "zindex" : 8 },
	{"x": 0,   "y":  767,  "xvar": 300, "yvar": 0,  "xdir":  0, "ydir": -1, "xscale": .5, "yscale": .5, "zindex" : 8 },
	{"x": 600, "y":  767,  "xvar": 400, "yvar": 0,  "xdir":  0, "ydir": -1, "xscale": .5, "yscale": .5, "zindex" : 8 },
]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnTimer.wait_time = 2

func _on_timer_timeout() -> void:
	_pick_an_enemy()

func _pick_an_enemy():
	var indexRange = 15
	var index = (randi_range(0, indexRange*4) + 1) % indexRange
	# print_debug(index)
	match index:
		1: 
			_create_crab01()
			return
		2:
			_create_crab02()
			return
		3:
			_create_fish01()
			return
		4:
			_create_fish02()
			return
		5:
			_create_fish03()
			return
		6:
			_create_fish04()
			return
		7:
			_create_jellyfish01()
			return
		8:
			_create_jellyfish02()
			return
		9:
			_create_jellyfish03()
			return
		10:
			_create_shark01()
			return
		11:
			_create_shark02()
			return
		_ :
			pass
	pass


func _Apply_Spawn_data(object: CharacterBody2D, SpawnData):
	object.position.x = SpawnData.x
	object.position.y = SpawnData.y
	object.x_direction = SpawnData.xdir
	object.y_direction = SpawnData.ydir
	object.scale.x = SpawnData.xscale
	object.scale.y = SpawnData.yscale
	object.z_index = SpawnData.zindex
	
	if SpawnData.xvar > 0:
		var xvar = randi_range(0, SpawnData.xvar * 100) % SpawnData.xvar
		object.position.x += xvar
		
	if SpawnData.yvar > 0:
		var yvar = randi_range(0, SpawnData.yvar * 100) % SpawnData.yvar
		object.position.y += yvar

func _spawn_enemy(object: CharacterBody2D, spawnData, enemyName: String):
	var SpawnIndex: int = randi_range(0, len(spawnData) * 100) % len(spawnData)
	var SpawnData = spawnData[SpawnIndex]	
	# print_debug("Spawned " + enemyName)
	# print_debug(SpawnData)
	_Apply_Spawn_data(object, SpawnData)
	add_child(object)	
	pass

func _count_children_nodes(groupname: String):
	var children = get_children()
	var itemCount: int = 0
	for c in children:
		if c.is_in_group(groupname):
			itemCount = itemCount + 1
	return itemCount

func _create_crab01():
	var itemCount = _count_children_nodes("Crab") # Only 1 crab at a time.
	if itemCount >= maxSpanData.crab: return
	
	var x: CharacterBody2D = Crab01Instance.instantiate()
	_spawn_enemy(x, CrabSpawnData, "Crab 01")
	return
	
func _create_crab02():
	var itemCount = _count_children_nodes("Crab") 	# Only 1 crab at a time.
	if itemCount >= maxSpanData.crab: return

	var x: CharacterBody2D = Crab02Instance.instantiate()
	_spawn_enemy(x, CrabSpawnData, "Crab 02")	
	return

func _create_fish01():
	var itemCount = _count_children_nodes("Fish")  	# Only 10 Fish at a time.
	if itemCount >= maxSpanData.fish: return
		
	var x: CharacterBody2D = Fish01Instance.instantiate()
	_spawn_enemy(x, FishSpawnData, "Fish 01")	
	return	

func _create_fish02():
	var itemCount = _count_children_nodes("Fish")  	# Only 10 Fish at a time.
	if itemCount >= maxSpanData.fish: return
	
	var x: CharacterBody2D = Fish02Instance.instantiate()
	_spawn_enemy(x, FishSpawnData, "Fish 02")	
	return
	
func _create_fish03():
	var itemCount = _count_children_nodes("Fish")  	# Only 10 Fish at a time.
	if itemCount >= maxSpanData.fish: return
	
	var x: CharacterBody2D = Fish03Instance.instantiate()
	_spawn_enemy(x, FishSpawnData, "Fish 03")	
	return
	
func _create_fish04():
	var itemCount = _count_children_nodes("Fish")  	# Only 10 Fish at a time.
	if itemCount >= maxSpanData.fish: return
	
	var x: CharacterBody2D = Fish04Instance.instantiate()
	_spawn_enemy(x, FishSpawnData, "Fish 04")	
	return

func _create_jellyfish01():
	var itemCount = _count_children_nodes("Jellyfish")  	# Only 10 Fish at a time.
	if itemCount >= maxSpanData.jellyfish: return
	
	var x: CharacterBody2D = Jellyfish01Instance.instantiate()
	_spawn_enemy(x, JellyfishSpawnData, "Fish 04")		
	return
	
func _create_jellyfish02():
	var itemCount = _count_children_nodes("Jellyfish")  	# Only 10 Fish at a time.
	if itemCount >= maxSpanData.jellyfish: return
	
	var x: CharacterBody2D = Jellyfish02Instance.instantiate()
	_spawn_enemy(x, JellyfishSpawnData, "Jellyfish 02")
	return
	
func _create_jellyfish03():
	var itemCount = _count_children_nodes("Jellyfish")  	# Only 10 Fish at a time.
	if itemCount >= maxSpanData.jellyfish: return
	
	var x: CharacterBody2D = Jellyfish03Instance.instantiate()
	_spawn_enemy(x, JellyfishSpawnData, "Jellyfish 03")
	return
	
func _create_shark01():
	var itemCount = _count_children_nodes("Shark")  	# Only 10 Fish at a time.
	if itemCount >= maxSpanData.shark: return
	
	var x: CharacterBody2D = Shark01Instance.instantiate()
	_spawn_enemy(x, FishSpawnData, "Shark 01")	
	return
	
func _create_shark02():
	var itemCount = _count_children_nodes("Shark")  	# Only 10 Fish at a time.
	if itemCount >= maxSpanData.shark: return
	
	var x: CharacterBody2D = Shark02Instance.instantiate()
	_spawn_enemy(x, FishSpawnData, "Shark 02")
	pass		
