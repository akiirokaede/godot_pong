extends Node2D

var player_score = 0
var ai_score = 0
var max_score = 10

@onready var ball = $Ball
@onready var player_score_label = $PlayerScore
@onready var ai_score_label = $AIScore
@onready var start_timer = $StartTimer

func _ready():
	reset_game()

func reset_game():
	player_score = 0
	ai_score = 0
	update_score_display()
	reset_ball()

func reset_ball():
	ball.position = Vector2(576, 324)
	ball.velocity = Vector2.ZERO
	start_timer.start()

func _on_start_timer_timeout():
	# 随机选择初始方向
	var direction = Vector2.RIGHT if randf() > 0.5 else Vector2.LEFT
	direction.y = [-0.8, -0.6, -0.4, -0.2, 0.2, 0.4, 0.6, 0.8].pick_random()
	ball.start_ball(direction)

func _on_left_goal_body_entered(body):
	if body == ball:
		ai_score += 1
		update_score_display()
		check_game_over()
		reset_ball()

func _on_right_goal_body_entered(body):
	if body == ball:
		player_score += 1
		update_score_display()
		check_game_over()
		reset_ball()

func update_score_display():
	player_score_label.text = str(player_score)
	ai_score_label.text = str(ai_score)

func check_game_over():
	if player_score >= max_score or ai_score >= max_score:
		await get_tree().create_timer(1.0).timeout
		reset_game() 