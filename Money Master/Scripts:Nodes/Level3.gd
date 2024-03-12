extends Node2D

var health_player = 500
var health_boss = 1500
var damage = 0
var turn = 0
@onready var hi = 0
# Called when the node enters the scene 0tree for the first time.
func _ready():
	$Projectile.visible = false # Replace with function body.
	$Projectile2.visible = false
	$Sucess.visible = false
	$Projectile2.position.y = 200
	$Miss.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HealthPlayer.text = "Health: " + str(health_player)
	$HealthMiniBoss.text = "Health: " + str(health_boss)
	if health_boss <= 0:
		health_boss = 0
		$Sucess.visible = true
		$Sucess.text = "Success!"
		await get_tree().create_timer(1000).timeout
	if health_player <= 0:
		health_player = 0
		$Sucess.visible = true
		$Sucess.text = "Failed. :("
		get_tree().reload_current_scene()
		global.level2comp = true
	$Spell1.text = global.label1
	$Spell2.text = global.label2
	$Spell3.text = global.label3
	if $Spell3.text == " ":
		$Spell3.disabled = true
	if $Spell2.text == " ":
		$Spell2.disabled = true
func damages(num):
	damage = damage + (num-num)
	print(damage)
func _on_spell_1_pressed():
		print("hi")
		get_tree().set_group("Spell", "disabled", true)
		$Projectile.color = Color(1,0,0,1)
		damage = global.damage1
		$Projectile.visible = true
		if $Projectile.position.y > 200:
			while $Projectile.position.y > 200:
				$Projectile.position.y -=10
				await get_tree().create_timer(0.0001).timeout
		$DamagePlayer.playing = true
		$Projectile.visible = false
		if randi_range(1,10) != 1:
			health_boss = health_boss - damage # Replace with function body.
			print("hit")
		else:
			$Miss.visible = true
			await get_tree().create_timer(2).timeout
			$Miss.visible = false
		$Projectile.color = Color(randi_range(0,1),randi_range(0,1),randi_range(0,1),1)
		await get_tree().create_timer(1).timeout
		$Projectile.visible = true
		damage = global.damage2 - 20
		while $Projectile.position.y < 1232:
				$Projectile.position.y += 10
				await get_tree().create_timer(0.0001).timeout
		$DamagePlayer.playing = true
		$Projectile.visible = false
		if randi_range(1,10) != 1:
			health_player = health_player - damage
			print("hit")
		else:
			$Miss.visible = true
			await get_tree().create_timer(2).timeout
			$Miss.visible = false
		get_tree().set_group("Spell", "disabled", false)
func _on_spell_2_pressed():
	get_tree().set_group("Spell", "disabled", true)
	if turn % 2 == 0:
		$Projectile.color = Color(0,1,0,1)
		damage = global.damage1
		$Projectile.visible = true  
		if $Projectile.position.y > 200:
			while $Projectile.position.y > 200:
				$Projectile.position.y -=10
				await get_tree().create_timer(0.0001).timeout
		$DamagePlayer.playing = true
		$Projectile.visible = false
		if randi_range(1,10) != 1:
			health_boss = health_boss - damage * int(round((global.money/10))) # Replace with function body.
			print("hit")
		else:
			$Miss.visible = true
			await get_tree().create_timer(2).timeout
			$Miss.visible = false # Replace with function body.
		$Projectile.color = Color(randi_range(0,1),randi_range(0,1),randi_range(0,1),1)
		await get_tree().create_timer(1).timeout
		damage = global.damage2 - 20
		$Projectile.visible = true
		if $Projectile.position.y < 1232:
			while $Projectile.position.y < 1232:
				$Projectile.position.y += 10
				await get_tree().create_timer(0.0001).timeout
		$DamagePlayer.playing = true
		$Projectile.visible = false
		if randi_range(1,10) != 1:
			health_player = health_player - damage
		else:
			$Miss.visible = true
			await get_tree().create_timer(2).timeout
			$Miss.visible = false
	get_tree().set_group("Spell", "disabled", false)

func _on_spell_3_pressed():
	get_tree().set_group("Spell", "disabled", true)
	if turn % 2 == 0:
		$Projectile.color = Color(0,0,1,1)
		damage = global.damage1
		$Projectile.visible = true
		if $Projectile.position.y > 200:
			while $Projectile.position.y > 200:
				$Projectile.position.y -=10
				await get_tree().create_timer(0.0001).timeout
		$DamagePlayer.playing = true
		$Projectile.visible = false
		if randi_range(1,10) != 1:
			health_boss = health_boss - damage * int(round((global.money/10))) # Replace with function body.
			print("hit")
		else:
			$Miss.visible = true
			await get_tree().create_timer(2).timeout
			$Miss.visible = false
		$Projectile.color = Color(randi_range(0,1),randi_range(0,1),randi_range(0,1),1)
		await get_tree().create_timer(1).timeout

		damage = global.damage2 - 20
		$Projectile.visible = true
		if $Projectile.position.y < 1232:
			while $Projectile.position.y < 1232:
				$Projectile.position.y += 10
				await get_tree().create_timer(0.0001).timeout
		$DamagePlayer.playing = true
		$Projectile.visible = false
		if randi_range(1,10) != 1:
			health_player = health_player - damage # Replace with function body.
			print("hit")
		else:
			$Miss.visible = true
			await get_tree().create_timer(2).timeout
			$Miss.visible = false
	get_tree().set_group("Spell", "disabled", false)



