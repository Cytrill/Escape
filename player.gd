extends RigidBody2D

#var gravity = 200
var move_accel = 800
var move_deaccel = 800
var max_move_speed = 200
var jump_force = 300

func _ready():
	set_fixed_process(true)

var velocity = Vector2()

func _integrate_forces(state):
	var lv = get_linear_velocity()

	if (Input.is_action_pressed("player01_left")):
		if lv.x > -max_move_speed:
			lv.x -= move_accel*state.get_step()
	elif (Input.is_action_pressed("player01_right")):
		if lv.x < max_move_speed:
			lv.x += move_accel*state.get_step()
	else:
			var xv = abs(lv.x)
			xv-=move_deaccel*state.get_step()
			if (xv<0):
				xv=0
			lv.x=sign(lv.x)*xv
	if (Input.is_action_pressed("player01_jump")):
		lv.y=-jump_force
	
	lv+=state.get_total_gravity()*state.get_step()
	state.set_linear_velocity(lv)