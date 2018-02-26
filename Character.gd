extends Sprite

#statements syntax
#{
#	 "Id1" : ["String", ["option1", "option2", ...]]
#	 "Id2" : ["String", ["option1", "option2", ...]]
#	 ...
#}
# empty options list [], means it's an end_point.
var statements = {
	"1" : ["Hello!", ["a", "b"]],
	"2" : ["What do you want?", ["c", "d", "e"]],
	"3" : ["Shut off", []],
	"4" : ["John the NPC.", ["f", "g"]],
	"5" : ["I don't know.", ["f", "g"]],
	"6" : ["Did you found any money lying around?", ["h", "e"]],
	"7" : ["Thank you very much!", ["g"]],
	"8" : ["See you later.", []]
}
#options syntax
#{
#	 "Id1" : ["String", "statement ID"]
#	 "Id2" : ["String", "statement ID"]
#	 ...
#}
# empty statement id "", means it's an end_point.
var options = {
	"a" : ["Hai!", "2"],
	"b" : ["Shut UP!!!", "3"],
	"c" : ["Your name", "4"],
	"d" : ["A place to rest", "5"],
	"e" : ["Ah Nothing", "8"],
	"f" : ["Thank you!", "6"],
	"g" : ["Bye", ""],
	"h" : ["Yes", "7"]
}

var start_stmnt = "1"

const STRING = 0
const OPTIONS_LIST = 1
const STATEMENT_ID = 1

var icon = load("res://icon.png")

func _ready():
	#print("S = 1 : ", statements[1]) # doesn't work
	
	print("S = '1' : ", statements["1"])
	print("S = '1' -> [0] : ", statements["1"][0])
	print("S = '1' -> [1] : ", statements["1"][1])
	print("S = '1' -> [1][1] : ", statements["1"][1][1])
	print("Option -> ", options["c"])
	#print("Option -> ", options[statements["2"][1]])# gives all options, but we need one
	print("Option -> ", options[statements["2"][1][2]])
	print("Option string -> ", options[ statements["2"] [1] [2] ] [0] )
	print("Option stmnt id -> ", options[ statements["2"] [1] [2] ] [1] )
	print("Option Stmnt Id length -> ", options[ statements["1"] [1] [1] ] [1].length() )
	print("S = '1' -> [options list] size ", statements["3"][1].size())
	
	
	print("S = '1' : ", statements["1"])
	print("S = '1' -> [0] : ", statements["1"][STRING])
	print("S = '1' -> [1] : ", statements["1"][OPTIONS_LIST])
	print("S = '1' -> [1][1] : ", statements["1"][OPTIONS_LIST][1])#check length before using number
	print("Option -> ", options["c"])
	#print("Option -> ", options[statements["2"][OPTIONS_LIST]])# gives all options, but we need one
	print("Option -> ", options[statements["2"][OPTIONS_LIST][2]])
	print("Option string -> ", options[ statements["2"] [OPTIONS_LIST] [2] ] [STRING] )
	print("Option stmnt id -> ", options[ statements["2"] [OPTIONS_LIST] [2] ] [STATEMENT_ID] )
	print("Option Stmnt Id length -> ", options[ statements["1"] [OPTIONS_LIST] [1] ] [STATEMENT_ID].length() )
	print("S = '1' -> [options list] size ", statements["3"][OPTIONS_LIST].size())
	return
