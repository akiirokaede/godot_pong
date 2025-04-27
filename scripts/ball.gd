extends CharacterBody2D

var speed = 400.0
var max_speed = 800.0
var speed_increment = 50.0
var direction = Vector2.ZERO

func _physics_process(delta):
	if velocity.length() > 0:
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			var collider = collision.get_collider()
			
			# 如果碰到挡板，根据挡板的移动改变反弹角度
			if collider is CharacterBody2D:
				var paddle_velocity = collider.velocity
				
				# 基础反弹
				velocity = velocity.bounce(collision.get_normal())
				
				# 从挡板获取一些垂直速度
				velocity.y += paddle_velocity.y * 0.2
				
				# 每次碰撞增加速度
				speed += speed_increment
				speed = min(speed, max_speed)
				
				# 保持速度一致
				velocity = velocity.normalized() * speed
			else:
				# 碰到墙壁的普通反弹
				velocity = velocity.bounce(collision.get_normal())

func start_ball(new_direction):
	direction = new_direction.normalized()
	velocity = direction * speed 