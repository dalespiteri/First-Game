extends Node

@onready var score_hud = $CanvasLayer/ScoreHUD
@onready var health_hud = $CanvasLayer/HealthHUD
@onready var game_over = $CanvasLayer/GameOver
@onready var timer = $Timer
@onready var player = $"../Player"
@onready var slime = $"../Slime"

var score = 0

func add_score(points: int):
	score += points
	score_hud.text = "Score: " + str(score)

func update_health(hp):
	health_hud.text = "Health: " + str(hp)

func display_game_over():
	slime.get_node("Killzone").queue_free()
	health_hud.text = "You're fucking dead bro..."
	game_over.visible = true
	Engine.time_scale = 0.4
	timer.start()

func _on_timer_timeout():
	game_over.visible = false
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
