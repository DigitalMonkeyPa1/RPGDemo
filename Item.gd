extends Area2D

var name = "Cash"
onready var icon = get_node("Sprite").get_texture()

func _ready():
	
	return

func on_pickup():
	print("You picked up ", name, ".")
	queue_free()
	return
