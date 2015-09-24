extends Node2D

export var rotation_direction = 100
var rotation_speed = 180

func _ready():
	set_fixed_process(true)
	add_to_group("death")

func _fixed_process(delta):
	rotate(deg2rad(rotation_speed*rotation_direction)*delta)
	get_node("Death").rotate(deg2rad(-rotation_speed*rotation_direction)*delta)
	get_node("Death1").rotate(deg2rad(-rotation_speed*rotation_direction)*delta)
	get_node("Death2").rotate(deg2rad(-rotation_speed*rotation_direction)*delta)
	get_node("Death3").rotate(deg2rad(-rotation_speed*rotation_direction)*delta)