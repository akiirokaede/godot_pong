extends CharacterBody2D

const SPEED = 350.0
var screen_size
var difficulty = 0.8  # 难度系数: 0-1.0，1.0为最难

@onready var ball = $"../Ball"

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	# 只有当球向AI移动时才主动追球
	if ball.velocity.x > 0:
		# 根据难度，有时会做出不完美的预测
		var target_y
		if randf() < difficulty:
			target_y = ball.position.y
		else:
			# 随机偏移
			target_y = ball.position.y + randf_range(-100, 100)
		
		# 移动到目标位置
		if abs(position.y - target_y) > 10:
			velocity.y = SPEED * sign(target_y - position.y)
		else:
			velocity.y = 0
	else:
		# 球不向AI移动时，缓慢回到中心位置
		if abs(position.y - screen_size.y/2) > 50:
			velocity.y = SPEED * 0.5 * sign(screen_size.y/2 - position.y)
		else:
			velocity.y = 0
	
	move_and_slide()
	
	# 限制挡板在屏幕内
	position.y = clamp(position.y, 60, screen_size.y - 60) 