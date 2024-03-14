extends CharacterBody2D

var hit_points = 5
var min_speed = 2.82 
var collision
var friction = .99
var type    =  0

@onready var shepherd = get_node("/root/game/shepherd/")
@onready var crook = get_node("/root/game/shepherd/crook/")
@onready var timer = $Timer

func _ready():
	velocity.x=-1
	velocity.y=1
	velocity = velocity * min_speed
	type = randi_range(0,120)
	type = type % 130
	_prepare_type(type)
	
func _prepare_type(param):
	if( param >0 && param < 50):#white sheep
		$WhiteSheep.visible = true
		$OrgangeSheep.visible = false
		$PinkSheep.visible = false
		$RedSheep.visible = false
		$PurpleSheep.visible = false
		$YellowSheep.visible = false
		$BlueSheep.visible =  false
		$GreenSheep.visible = false
	if( param >=50 && param < 60):
		$WhiteSheep.visible = false
		$OrgangeSheep.visible = false
		$PinkSheep.visible = false
		$RedSheep.visible = true
		$PurpleSheep.visible = false
		$YellowSheep.visible = false
		$BlueSheep.visible = false
		$GreenSheep.visible = false
	if( param >=60 && param < 70):
		$WhiteSheep.visible = false
		$OrgangeSheep.visible = true
		$PinkSheep.visible = false
		$RedSheep.visible = false
		$PurpleSheep.visible = false
		$YellowSheep.visible = false
		$BlueSheep.visible = false
		$GreenSheep.visible = false
	if( param >=60 && param < 70):
		$WhiteSheep.visible = false
		$OrgangeSheep.visible = false
		$PinkSheep.visible = true
		$RedSheep.visible = false
		$PurpleSheep.visible = false
		$YellowSheep.visible = false
		$BlueSheep.visible = false
		$GreenSheep.visible = false
	if( param >=80 && param < 95):
		$WhiteSheep.visible = false
		$OrgangeSheep.visible = false
		$PinkSheep.visible = false
		$RedSheep.visible = false
		$PurpleSheep.visible = false
		$YellowSheep.visible = false
		$BlueSheep.visible = true
		$GreenSheep.visible = false
	if( param >=100 && param < 110):
		$WhiteSheep.visible = false
		$OrgangeSheep.visible = false
		$PinkSheep.visible = false
		$RedSheep.visible = false
		$PurpleSheep.visible = false
		$YellowSheep.visible = true
		$BlueSheep.visible =  false
		$GreenSheep.visible = false
	if( param >=110 && param < 120):
		$WhiteSheep.visible = false
		$OrgangeSheep.visible = false
		$PinkSheep.visible = false
		$RedSheep.visible = false
		$PurpleSheep.visible = false
		$YellowSheep.visible = false
		$BlueSheep.visible =  false
		$GreenSheep.visible = true
	if( param >=120 && param < 130):
		$WhiteSheep.visible = false
		$OrgangeSheep.visible = false
		$PinkSheep.visible = false
		$RedSheep.visible = false
		$PurpleSheep.visible = true
		$YellowSheep.visible = false
		$BlueSheep.visible =  false
		$GreenSheep.visible = false
	
func _physics_process(delta):
	collision = move_and_collide(velocity)
	if collision && timer.is_stopped():
		velocity = velocity.bounce(collision.get_normal())

signal sheep_type 
signal new_sheep

func _on_area_2d_area_entered(area):
	if area.is_in_group("crook"):
		timer.start()
	if area.is_in_group("goal"):
		emit_signal("new_sheep")
		emit_signal("sheep_type",type)
		self.queue_free()
	if area.is_in_group("wolf"):   
		hit_points = hit_points - 1
	if(hit_points <=0):
		emit_signal("new_sheep")
		self.queue_free()
	if area.is_in_group("lion"):
		hit_points = hit_points - 1
	if(hit_points <=0):
		emit_signal("new_sheep")
		self.queue_free()
	if area.is_in_group("bear"):
		emit_signal("new_sheep")
		hit_points = hit_points - 1
	if(hit_points <=0):
		emit_signal("new_sheep")
		self.queue_free()
		
