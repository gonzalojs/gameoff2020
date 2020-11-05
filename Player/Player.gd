extends Area2D


export var speed: float = 100

var vel := Vector2(0, 0)

func _physics_process(delta: float) -> void:
	inputs(delta)

	
	# Make sure we are in  the screen
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, 0, viewRect.size.x)
	position.y = clamp(position.y, 0, viewRect.size.y)

func inputs(delta: float):
	var dirVec := Vector2(0, 0)
	
	dirVec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	dirVec.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	vel = dirVec.normalized() * speed
	position += vel * delta
