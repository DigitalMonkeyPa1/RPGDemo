extends KinematicBody2D#AnimatedSprite

enum Directions { Up, Left, Down, Right}
var direction = Down
var last_direction = Down
var direction_str = "Down"
var speed = 80

enum States {Idle, Walking, Talking}
var state = Idle
var last_state = Idle

export (NodePath) var character_path# = get_parent().get_node("Character")
onready var character = get_node(character_path)
export (NodePath) var dialogue_box_path
onready var dialogue_box = get_node(dialogue_box_path)
onready var anim_sprite = get_node("AnimSprite")
var icon = load("res://lidia/19.png")

var inventory_list = []

export (NodePath) var inventory_path
onready var inventory = get_node(inventory_path)

func _ready():
	change_animation()
	set_process(true)
	set_process_input(true)
	
	dialogue_box.connect("DialogueComplete", self, "on_dialogue_complete")
	return

func _input(event):
	if state == Talking:
		return # no inputs are accepted while talking
	if Input.is_action_pressed("ui_up"):
		direction = Up
		direction_str = "Up"
		state = Walking
	elif Input.is_action_pressed("ui_left"):
		direction = Left
		direction_str = "Left"
		state = Walking
	elif Input.is_action_pressed("ui_down"):
		direction = Down
		direction_str = "Down"
		state = Walking
	elif Input.is_action_pressed("ui_right"):
		direction = Right
		direction_str = "Right"
		state = Walking
	else:
		state = Idle
		#print("I")
	
	if Input.is_action_pressed("ui_accept"):
		talk_to(character)
		state = Talking
		# hides the inventory while talking
		if inventory.is_visible():
			inventory.hide()
		
	
	if Input.is_action_pressed("ui_select"):
		if inventory.is_visible():
			inventory.hide()
		else:
			inventory.show()
		
	
	return

func _process(delta):
	if last_state != state:
		print("Changing Animation")
		change_animation()
		last_state = state
	
	if state == Idle:
		
		pass
	
	if state == Talking:
		
		pass
	
	if state == Walking:
		if last_direction != direction:
			print("Changing direction")
			change_animation()
			last_direction = direction
			
		else:
			if direction == Up:
				move(Vector2(0, -speed*delta))
			elif direction == Left:
				move(Vector2(-speed*delta, 0))
			elif direction == Down:
				move(Vector2(0, speed*delta))
			elif direction == Right:
				move(Vector2(speed*delta, 0))
			else:
				pass
	
	return

func change_animation():
	if state == Idle:
		print("Idle anim")
		anim_sprite.set_animation("Idle" + direction_str)
		
	elif state == Walking:
		anim_sprite.set_animation("Walk" + direction_str)
		
	elif state == Talking:
		
		pass
		
	else:
		pass
	
	return

func talk_to(char):
	dialogue_box.statements = char.statements
	dialogue_box.options = char.options
	dialogue_box.stmnt_ptr = char.start_stmnt
	dialogue_box.optns_ptr = null
	dialogue_box.player_icon = self.icon
	dialogue_box.character_icon = char.icon
	dialogue_box.start()
	return

func on_dialogue_complete():
	print("Talk Over!")
	state = Idle
	return

func _on_Radar_area_enter( area ):
	if area.is_in_group("Region"):
		print("You entered the region : ", area.get_name())
	
	if area.is_in_group("Room"):
		print("You entered the room : ", area.get_name())
	
	if area.is_in_group("Item"):
		print("You picked the item : ", area.get_name())
		#inventory.append(area.get_name())
		inventory.add_item(area.name, area.icon, true)
		area.on_pickup()
	
	return

func _on_Radar_body_enter( body ):
	
	return

