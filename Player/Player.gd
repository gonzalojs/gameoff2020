extends Area2D

var plBullet := preload("res://Bullets/Bullet.tscn")

onready var firingPositions := $FiringPositions
onready var fireDelayTimer := $FireDelayTimer

export var speed: float = 100
export var fireDelay: float = 0.1
var vel := Vector2(0, 0)


func _physics_process(delta: float) -> void:
	inputs(delta)
	
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		
		for child in firingPositions.get_children():
			var bullet := plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)

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
