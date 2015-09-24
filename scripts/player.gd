extends RigidBody2D

#var gravity = 200
var move_accel = 800
var move_deaccel = 800
var max_move_speed = 200
var jump_force = 200
var alive = true
var jumping = false
var velocity = Vector2()

func _ready():
	get_node("RayCastDown").add_exception(self)  

func _integrate_forces(state):
	if alive:
		var lv = get_linear_velocity()
		
		if get_node("RayCastDown").is_colliding():
			jumping = false
		
		if (state.get_contact_count() > 0):
			for x in range(state.get_contact_count()):
				var o = state.get_contact_collider_object(x)
				if ("death" in o.get_groups()):
					alive = false
					clear_shapes()
					get_node("DeathParticles").set_emitting(true)
					get_node("Sprite").rotate(deg2rad(90))
	
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
		if (Input.is_action_pressed("player01_jump") && !jumping):
			lv.y=-jump_force
			jumping = true
		
		rotate(0)
		lv+=state.get_total_gravity()*state.get_step()
		state.set_linear_velocity(lv)