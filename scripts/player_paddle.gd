extends CharacterBody2D

const SPEED = 400.0
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	# 获取输入方向
	var direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	# 限制挡板在屏幕内
	position.y = clamp(position.y, 60, screen_size.y - 60) 