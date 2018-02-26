extends Panel

var statements = null
var options = null
var stmnt_ptr = null
var optns_ptr = null

onready var statement_label = get_node("StatementLabel")
onready var then_button = get_node("ThenButton")
onready var option_buttons = get_node("OptionButtons")
onready var player_tex = get_node("PlayerTexture")
onready var character_tex = get_node("CharacterTexture")

#var no_of_options = 0
var player_icon = null
var character_icon = null

const STRING = 0
const OPTIONS_LIST = 1
const STATEMENT_ID = 1

signal DialogueComplete

export (NodePath) var player

func _ready():
	#no_of_options = option_buttons.get_child_count()
	return

func start():
	self.show()
	optns_ptr = statements[stmnt_ptr][OPTIONS_LIST]
	player_tex.set_texture(player_icon)
	character_tex.set_texture(character_icon)
	show_current_statement()
	return

func show_current_statement():
	if stmnt_ptr == "":
		print("Dialogue over")
		emit_signal("DialogueComplete")
		self.hide()
		return
	option_buttons.hide()
	player_tex.hide()
	statement_label.show()
	then_button.show()
	character_tex.show()
	statement_label.set_text(statements[stmnt_ptr][STRING])
	return

func show_current_options():
	if optns_ptr.size() < 1:
		print("Options Over")
		emit_signal("DialogueComplete")
		self.hide()
		return
	statement_label.hide()
	then_button.hide()
	character_tex.hide()
	player_tex.show()
	option_buttons.show()
	for option in option_buttons.get_children():
		option.set_text("")
		option.hide()
		
	for i in range(optns_ptr.size()):
		option_buttons.get_child(i).set_text(options[optns_ptr[i]][STRING])
		option_buttons.get_child(i).show()
		
	return

func _on_ThenButton_pressed():
	print("Button Then pressed")
	optns_ptr = statements[stmnt_ptr][OPTIONS_LIST]
	show_current_options()
	return

func _on_option_button_pressed(number):
	print("Option button ",number," is pressed.")
	stmnt_ptr = options[optns_ptr[number]][STATEMENT_ID]
	show_current_statement()
	return
