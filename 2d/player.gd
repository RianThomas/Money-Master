extends CharacterBody2D

var speed = 1000.0
signal interaction
func _ready():
	$Sprite2D.frame=0 

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1.0
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1.0
	if Input.is_action_pressed("ui_up"):
		velocity.y -=1.0
	if Input.is_action_pressed("ui_down"):
		velocity.y +=1.0
	
	velocity = velocity.normalized()
	
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Walk/blend_position", velocity)
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		velocity = velocity * speed
		move_and_slide()
		
		
