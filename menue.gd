extends CanvasLayer


var sheep_score = 0
var dead_wolves  = 0
var dead_bears   = 0
var dead_lions   = 0
var foes_slain =  0
var last_run     = 0
var aberrant_sheep = 0
var health = 10
var score  = 0
var help = false


@onready var player = get_node("/root/game/player/")

func _ready():
	load_game()
	$PanelContainer/Panel/sheep_score.text= "sheep saved:"+str(sheep_score)
	$PanelContainer/Panel/foes_slain.text = "foes slain:"+str(foes_slain)
	$PanelContainer/Panel/last_run.text = "last run:"+str(last_run)
	$"PanelContainer/Panel/abberent sheep".text="aberrant sheep"+str(aberrant_sheep)
	$"PanelContainer/Panel/health".text="health:"+str(health)
	$"PanelContainer/Panel/score".text = "Score"+str(score)

func update():
	$PanelContainer/Panel/sheep_score.text= "sheep saved:"+str(sheep_score)
	$PanelContainer/Panel/foes_slain.text = "foes slain:"+str(foes_slain)
	$PanelContainer/Panel/last_run.text = "last run:"+str(last_run)
	$"PanelContainer/Panel/abberent sheep".text="aberrant sheep"+str(aberrant_sheep)
	$"PanelContainer/Panel/health".text="health:"+str(health)
	$"PanelContainer/Panel/score".text = "Score"+str(score)
	
func _on_quit_pressed():
	get_tree().quit()


func _on_restart_pressed():
	save()
	get_tree().reload_current_scene()
	print(last_run)
	update()


func _on_save_pressed():
	save_game()

	
func save():
	var file = FileAccess.open("user://saves.txt",FileAccess.WRITE)
	file.store_string(str(score))
	print("save")

		
func load_game():
	var file = FileAccess.open("user://saves.txt",FileAccess.READ)
	last_run = file.get_as_text(true).to_int()
	update()
		
signal player_save

func save_game():
	var file1 = FileAccess.open("user://health.txt",FileAccess.WRITE)
	file1.store_string(str(health))
	emit_signal("player_save")

signal player_load

func load_game2():
	var player_position = Vector2.ZERO
	var file1 = FileAccess.open("user://health.txt",FileAccess.READ)
	health = file1.get_as_text(true).to_int()
	emit_signal("player_load",health)

func _on_goal_area_entered(area):
	sheep_score = sheep_score +1
	update()

func on_menue_wolf_died():
	dead_wolves = dead_wolves + 1
	foes_slain = foes_slain + 1
	score = score + 20
	update()

func on_menue_bear_died():
	foes_slain = foes_slain + 1
	dead_bears = dead_bears + 1 
	score = score + 40
	update()
	
func on_menue_lion_died():
	dead_lions = dead_lions + 1
	foes_slain = foes_slain + 1
	score = score + 60
	update()
	
func on_menue_sheep_type(type):
	if type >50:
		aberrant_sheep=aberrant_sheep+1
		score = score + 600
	else:
		score = score + 300
	update()


func _on_shepherd_plus_health(health1):
	health = min(health + 1,10)
	update()

func _on_shepherd_minus_health(health1):
		health = health - 1 
		update()


func _on_help_pressed():
	$Timer.start()
	$PanelContainer/Panel/message.text = "Herd sheep to the goal.
	Arrow keys to move. Z, X, and Space move the crook."
	await get_tree().create_timer(2.5).timeout
	$PanelContainer/Panel/message.text = ""

func last_score():
	print("test")

func _on_shepherd_game_over():
	save()
	get_tree().reload_current_scene()
	$PanelContainer/Panel/message.text = "A good shepherd laid down his life for his sheep"
	$PanelContainer/Panel/message/Timer3.start()
	await $PanelContainer/Panel/message/Timer3.is_stopped()
	$PanelContainer/Panel/message.text = ""


func _on_load_pressed():
	load_game2()
