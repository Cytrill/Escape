extends RigidBody2D

var hammertime = 0
var lifttime = 0
var fist_down = false

func _ready():
	add_to_group("death")	
	set_fixed_process(true)

func _fixed_process(delta):
	hammertime += delta

	if !fist_down:
		if hammertime > 5:
			fist_down = true
			set_linear_velocity(vec2(0, 800))
			hammertime = 0
			get_node("ParticlesSplash").set_emitting(true)
			get_node("ParticlesSplash1").set_emitting(true)
			get_node("ParticlesSplash2").set_emitting(true)

	if fist_down:
		lifttime += delta
		if lifttime > 1:
			fist_down = false
			set_linear_velocity(vec2(0, -100))
			lifttime = 0