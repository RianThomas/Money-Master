extends Node2D

var he  = 0 #Important for the chance that the chase object itself moves
var next = 0 #Important for the interactions with the characters
var next2 = 0
var next3 = 0
var next4 = 0
var money = 0 #Money System in the Game
var random = RandomNumberGenerator.new() #Important for randomness in the game
var seconds = 0 #Timer for Level 1
var bx = random.randi_range(25,2535) #Where the chase will land x pos
var by = random.randi_range(25,1300) #Where the chase will land y pos
var bxran = 0
var byran = 0
var map = random.randi_range(1,25) #Where the chase will be seen
var chase = 0 #For the chance variable to run
var chance = 0 #50% Chance that it will run
var map_x = 13 #What part of the map that the player starts on
var inter = 0 #To check if there was  an interaction between chracters
var chase_vis = 0
var level = 0
var timedoonce1 = 0
var timedoonce2 = 0
var timedoonce21 = 0
var timedoonce3 = 0
var timedoonce4 = 0
var move = true
var pause = 0
var something = 0
var bought = 0
var inter1 = 0
var ditime = Timer
var dildict = {
	1: "You need to buy food, becuase you are hungry. \n Cost: $100",
	2: "You need a place to sleep, becuase you need to sleep. \n Cost: $100",
	3: "You need to buy water, because you are thirsty \n Cost: $100"
}
@onready var level22 = load("res://Level2.gd")
@onready var level2 = get_node("Level2")

func movechase(): #Set bx and by to random variables
	bx = random.randi_range(-2600,5236)
	by = random.randi_range(-1600,3200)

func _ready(): # Called when the node enters the scene tree for the first time.
	get_tree().set_group("Startscreen", "visible", false)
	$back2.visible = false
	$Bob2.visible = false
	$Area2D2.monitoring = false
	$Boss.visible = false
	get_tree().set_group("Dilemma", "visible", false)
	$Node2D.visible = false
	$Node2D2.visible = false
	$Level1Quest.visible = false
	$Buy.visible = false
	$back.visible = false
	get_tree().set_group("ShopEnter", "visible", false)
	$Area2D_Shop.monitoring = false
	$Area2D_Quests.monitoring = false
	get_tree().set_group("Shop", "visible", false)
	#Chase visibility stuff vvvvvvvv
	$Chase.visible = false
	$Area2D_Chase.visible = false
	$Area2D_Chase/CollisionShape2D_Chase.visible = false
	#Black Talk Screen visiblity and position vvvvv
	$Talk_ColorRect.visible = false
	$Talk_ColorRect.position.y = 5000
	$l.position.y = 5600
	$Time.visible = false
	#Chase positon
	$Chase.position = Vector2(bx,by)
	$Area2D_Chase.position = Vector2(bx,by)
	$Coin.position.y = 500
	$Area2D_Coin.position.y = 500
	#The whole node moves up so that the start screen is seen
	self.position.y += 6400
	
	#Visibility things for interactions
	$l.visible = false
	$x.visible = false
func _on_start_pressed(): #When the start button is pressed
	
	while self.position.y != 0:
		self.position.y -= 25
		await get_tree().create_timer(0.0001).timeout # Replace with function body.
func _on_how_to_play_pressed():
	get_tree().set_group("Startscreen", "visible", true)
	if $TileMap2.position.x != 1600:
		while $TileMap2.position.x < 1600:
			get_tree().set_group("Buttons", "visible", false)
			$Credits_L.position.x += 10
			$Credits_La.position.x += 10
			$"How to Play L".position.x += 10
			$"How to Play L2".position.x += 10
			$TileMap2.position.x += 10
			await get_tree().create_timer(0.0001).timeout
	$Start.visible = false
	$"How to Play".visible = false
	$Credits.visible = false 
	$back2.visible = true
	pause = 1
func _on_credits_pressed():
	get_tree().set_group("Startscreen", "visible", true)
	$back.visible = true
	$back.position = Vector2(0,0)
	if $TileMap2.position.x != -1600:
		while $TileMap2.position.x > -1600:
			get_tree().set_group("Buttons", "visible", false)
			$Credits_L.position.x -= 10
			$Credits_La.position.x -= 10
			$"How to Play L".position.x -= 10
			$"How to Play L2".position.x -= 10
			$TileMap2.position.x -= 10
			await get_tree().create_timer(0.0001).timeout
	$Start.visible = false
	$"How to Play".visible = false
	$Credits.visible = false 
	$back2.visible = true
	pause = 1
func _process(_delta): # Called every frame. 'delta' is the elapsed time since the previous frame.
	#Screen Movement vvvvvvvvvvvvvvv
	if $Player.position.y < -50 and map_x > 5: #Up
		$TileMap.position.y += 1600
		$Bob.position.y += 1600
		$MiniBoss.position.y += 1600
		$Boss.position.y += 1600
		$Area2D_MiniBoss2.position.y += 1600
		$Area2D.position.y += 1600
		$Area2D_MiniBoss.position.y += 1600
		#$Chase.position.y += 1600
		#$Area2D_Chase.position.y += 1600
		#$Area2D_Chase/CollisionShape2D_Chase.position.y += 1600
		$Player.position.y += 1400
		map_x -= 5
	if $Player.position.y < -50 and map_x < 5:
		$Player.position.y = -51
	if $Player.position.y > 1400 and map_x < 21: #Down
		$TileMap.position.y -= 1600
		$Bob.position.y -= 1600
		$MiniBoss.position.y -= 1600
		$Boss.position.y -= 1600
		$Area2D_MiniBoss2.position.y -= 1600
		$Area2D.position.y -= 1600
		$Area2D_MiniBoss.position.y -= 1600
		#$Chase.position.y -= 1600
		#$Area2D_Chase.position.y -= 1600
		#$Area2D_Chase/CollisionShape2D_Chase.position.y -= 1600
		$Player.position.y -= 1400
		map_x += 5
	if $Player.position.y > 1400 and map_x > 21:
		$Player.position.y = 1399
	if $Player.position.x < 0 and map_x % 5 != 1: #Left
		$TileMap.position.x += 2615
		$Bob.position.x += 2615
		$MiniBoss.position.x += 2615
		$Boss.position.x += 2615
		$Area2D_MiniBoss2.position.x += 2615
		$Area2D_MiniBoss.position.x += 2615
		$Area2D.position.x += 2615
		#$Chase.position.x += 2615
		#$Area2D_Chase.position.x += 2615
		#$Area2D_Chase/CollisionShape2D_Chase.position.x += 2615
		$Player.position.x += 2300
		map_x -= 1
	if $Player.position.x < 0 and map_x % 5 == 1:
		$Player.position.x = 1
	if $Player.position.x > 2400 and map_x % 5 != 0:
		$TileMap.position.x -= 2615
		$Bob.position.x -= 2615
		$MiniBoss.position.x -= 2615
		$Boss.position.x -= 2615
		$Area2D_MiniBoss2.position.y -= 2615
		$Area2D.position.x -= 2615
		$Area2D_MiniBoss.position.x -= 2615
		#$Chase.position.x -= 2615
		#$Area2D_Chase.position.x -= 2615
		#$Area2D_Chase/CollisionShape2D_Chase.position.x -= 2615
		$Player.position.x -= 2400
		map_x += 1
	if $Player.position.x > 2400 and map_x % 5 == 0:
		$Player.position.x = 2399
	################################################################
	if level == 1:
		if timedoonce1 == 0:
			$Timer.start(100)#For when Level 1 starts
			timedoonce1 += 1
		$Time.visible = true
	$Time.text = "Time Left: " + str(round($Timer.time_left))
	if Input.is_action_just_pressed("Start_Interaction") == true and inter == 2:
			$l2.visible = true
			$Talk_ColorRect.visible = true
			while $Talk_ColorRect.position.y != 0:
				$Talk_ColorRect.position.y -= 100
				await get_tree().create_timer(0.0001).timeout
			$x.visible = false
	if Input.is_action_just_pressed("next") == true and inter == 2:
		next2 += 1
		next = 0
	if next2 == 0:
		$l2.text = "Henchmam: Well, Well, Well"
	if next2 == 1:
		$l2.text = "Bob: Who are you?"
	if next2 == 2:
		$l2.text = "Henchman: You must be new around these parts of the kingdom. \nI am the henchman of the Money Master. \nI prepare the way for the Money Master."
	if next2 == 3:
		$l2.text = "Bob: Well, I guess I can't let you do that! \n\n\n\n Press space to fight with the Henchman"
	if next2 == 4:
		$Node2D.visible = true
		timedoonce2 += 1
	if global.level2comp == true:
		if timedoonce21 == 0:
			$Node2D.visible = false
		$Boss.visible = true
	if global.level3pos == true and level == 3:
		if Input.is_action_just_pressed("Start_Interaction") == true and inter == 3:
			$l3.visible = true
			$Talk_ColorRect.visible = true
			while $Talk_ColorRect.position.y != 0:
				$Talk_ColorRect.position.y -= 100
				await get_tree().create_timer(0.0001).timeout
			$l3.visible = true
			$x.visible = false
		if Input.is_action_just_pressed("next") == true and inter == 3:
			next3 += 1
			next = 0
			next2 = 0
		if next3 == 0:
			$l3.text = "Money Master: Hey! What do think that you are doing walking in the presence of the Money Master?!"
		if next3 == 1:
			$l3.text = "Bob: Me? Why should I care if you are the Money Master?"
		if next3 == 2:
			$l3.text = "Money Master: Who do you think you are?"
		if next3 == 3:
			$l3.text = "Bob: Me? Well, I'm about to save Money Kingdom by defeating you!"
		if next3 == 4:
			$l3.text = "Money Master: What could you possibly do to me?"
		if next3 == 5:
			$l3.text = "Bob: How about you ask your little henchman? \n\n\n\n Press space to continue to the fight"
		if next3 == 6:
			$Node2D2.visible = true
			timedoonce3 = 1
	if Input.is_action_just_pressed("Start_Interaction") == true and inter == 4:
			$Talk_ColorRect.visible = true
			while $Talk_ColorRect.position.y != 0:
				$Talk_ColorRect.position.y -= 100
				await get_tree().create_timer(0.0001).timeout
			$l4.visible = true
			$x.visible = false
	if Input.is_action_just_pressed("next") == true and inter == 4:
			next4 += 1
			next = 0
			next2 = 0
			next3 = 0
	if next4 == 0:
		$l4.text = "Shop Keeper: Hi, welcome to town. This is the Spell Shop, you can buy \nspells from here!"
	if next4 == 1:
		$l4.text = "Shop Keeper: Spells are important as they can be used against people with \nan evil aura (like the Money Master and his henchmen)"
	if next4 == 2:
		$l4.text = "For the Money Master himself, the amount of money you have is also \nimportant in the amount of damge you do to the Money Master!"
	if next4 == 3:
		$l4.text = "Good Luck!"
	if Input.is_action_just_pressed("quit") == true:
		get_tree().quit(0)
	if map_x == 12:
		get_tree().set_group(" Shop", "visible", true)
		$Bob2.visible = true
		$Area2D2.monitoring = true
		$Area2D_Shop.monitoring = true
	else:
		get_tree().set_group("Shop", "visible", false)
		$Bob2.visible = false
		$Area2D2.monitoring = false
		$Area2D_Shop.monitoring = false
	if map_x == 11:
		$Area2D_Quests.monitoring = true
	else:
		get_tree().set_group("Quests", "visible", false)
		$Area2D_Quests.monitoring = false
	#Player interacting with npc
	if inter == 1 and Input.is_action_just_pressed("Start_Interaction") == true:
		$l.visible = true
		$Talk_ColorRect.visible = true
		while $Talk_ColorRect.position.y != 0:
			$Talk_ColorRect.position.y -= 100
			$l.position.y -= 100
			await get_tree().create_timer(0.0001).timeout
		$x.visible = false
	if $l.visible and Input.is_action_just_pressed("next") == true:  
		next += 1
	if next == 0:
		$l.text = "Dr. Chan: \n Hello young traveler. My name is Dr. Chan and welcome to Money Kingdom \nand Cash Town! \n\n\n\n Press space to continue"
	if next == 1:
		$l.text = "Dr. Chan: Here you will find everything you need to continue your journey \nto become the ultimate Money Master!"
	if next == 2:
		$l.text = "You: Sorry, but what is a “Money Master”?"
	if next == 3:
		$l.text = "Dr. Chan: A Money Master is the most powerful person in the Money \nKingdom."
	if next == 4:
		$l.text = "Dr. Chan: Our previous Money Master became evil and took over most of \nMoney Kingdom. There are just days before he arrives to capture Cash Town. "
	if next == 5:
		$l.text = "Bob: Is there no way to defeat him?"
	if next == 6:
		$l.text = "Dr. Chan: Here in the Money Kingdom, money is both a form of currency\nand battle power. The more power that you have, the more powerful you are. \nThe Evil Money Master made it hard for anyone to make enough money to defeat \nhim."
	if next == 7:
		$l.text = "Dr. Chan: Only those who are the most talented can defeat the evil Money \nMaster and become the next Money Master!"
	if next == 8:
		$l.text = "Bob: Don’t worry Dr. Chan, I’m sure that someone will come and save Money \nKingdom and become the next Money Master. Thanks, for what you have done \nto enlighten me about the money system and history of Money Kingdom."
	if next == 9:
		$l.text = "Bob: I will be staying in Cash Town for a couple of days wandering around \n the town. Thanks, for everything!"
	if next == 10:
		$l.text = "Dr. Chan: Here is $100 dollars to start with. Use it wisely! \nGood Luck on your Journey! \n\n\n\n Move around to continue exploring!"
		if inter1 == 0:
			money += 100
			inter1 += 1
	################################################################
	$Label.text = "$" + str(money) #Money is updated for the label so it is seen on the screen
	if map == map_x and level == 1: #based on the map position of the screen, it checks whether or not the chase should be seen
		$Chase.visible = true
		$Area2D_Chase.visible = true
		$Area2D_Chase/CollisionShape2D_Chase.visible = true
		$Area2D_Chase.monitoring = true
		$Area2D_Chase.monitorable = true
	if map != map_x or level != 1:#If not, not visible
		$Chase.visible = false
		$Area2D_Chase.visible = false
		$Area2D_Chase/CollisionShape2D_Chase.visible = false
		$Area2D_Chase.monitoring = false
		$Area2D_Chase.monitorable = false
	#When the chance becomes 3 or 4 and is interactign with the player, it makes it move to a completly different part of the map
	if chase == 1:
		if he >= 0 and he <= 100:
			if chance == 3:
				if random.randi_range(1,2) == 1:
					$Chase.visible = true
					$Area2D_Chase.visible = true
					$Area2D_Chase/CollisionShape2D_Chase.visible = true
				else:
					$Chase.visible = false
					$Area2D_Chase.visible = false
					$Area2D_Chase/CollisionShape2D_Chase.visible = false
					$Area2D_Chase.monitoring = false
					$Area2D_Chase.monitorable = false
					chase_vis = round($Timer.time_left)
				bxran = random.randi_range(-1000,1000)
				bx += bxran
				if bx + int($Chase.position.x) > 2560 or bx + int($Chase.position.x) < 0:
					while bx + int($Chase.position.x) > 2560 or bx + int($Chase.position.x) < 0:
						bx -= bxran
						bxran = random.randi_range(-1000,1000)
						bx += bxran
				chance = 1
				he += 101
				chase = 2
			if chance == 4:
				if random.randi_range(2,2) == 1:
					$Chase.visible = true
					$Area2D_Chase.visible = true
					$Area2D_Chase/CollisionShape2D_Chase.visible = true
				else:
					$Chase.visible = false
					$Area2D_Chase.visible = false
					$Area2D_Chase/CollisionShape2D_Chase.visible = false
					$Area2D_Chase.monitoring = false
					$Area2D_Chase.monitorable = false
					chase_vis = int(round($Timer.time_left))
				byran = random.randi_range(-1000,1000)
				by += byran
				if by + int($Chase.position.y) > 1600 or by + int($Chase.position.y) < 0:
					while by + int($Chase.position.y) > 1600 or by + int($Chase.position.y) < 0:
						by -= byran
						byran = random.randi_range(-1000,1000)
						by += byran
				chance = 2
			$Chase.position = Vector2(bx, by)
			$Area2D_Chase.position = Vector2(bx, by)
		if chase_vis - int(round($Timer.time_left)) == 10:
			$Chase.visible = true
			$Area2D_Chase.visible = true
			$Area2D_Chase/CollisionShape2D_Chase.visible = true
			$Area2D_Chase.monitoring = true
			$Area2D_Chase.monitorable = true
	if round($Timer.time_left) == 0 and chase != 3 and level == 1:
		$Time.visible = false
		level = 0
		$Buy.text = "You Failed the Mission"
		$Buy.visible = true
		await get_tree().create_timer(1).timeout # Replace with function body.
		$Chase.visible = false
		$Chase.position.y = 10000
		$Area2D_Chase.visible = false
		$Area2D_Chase.position.y = 10000
		$Area2D_Chase/CollisionShape2D_Chase.visible = false
		$Area2D_Chase/CollisionShape2D_Chase.position.y = 10000
	global.money = money
	$Area2D_MiniBoss.monitoring = true
	if Input.is_action_just_pressed("restart") == true:
		$Player.position.y = 1000
		$Player.position.x = 1000
	#print($Chase.position," ", map," ", map_x," ", chase," ", chance, " ", $Chase.visible, " ", by + byran, " ", bx + bxran)
func _on_area_2d_body_entered(body): #Checks whether the player is interactign with the player
	next = 0
	$x.visible = true
	inter = 1
func _on_area_2d_body_exited(body):#if the player is not interacting then everything disappears
	$x.visible = false
	inter = 0
	$Talk_ColorRect.visible = true
	while $Talk_ColorRect.position.y != 5000:
		$Talk_ColorRect.position.y += 100
		$l.position.y += 100 
		await get_tree().create_timer(0.0001).timeout # Replace with function body.
	$l.visible = false
	next = 0
func _on_area_2d_coin_body_entered(body): #When the Coin collides with the player
	money += 1
	$Coin.visible = false
	$Coin.position.y = 10000
	$Area2D_Coin.visible = false
	$Area2D_Coin.position.y = 10000
	$Area2D_Coin/CollisionShape2D_Coin.visible = false
	$Area2D_Coin/CollisionShape2D_Coin.position.y = 10000
func _on_area_2d_chase_body_entered(body):#When the player is colliding with the chase
	
	if chase == 2:
		chance = 1
	if chase == 0:
		chance = random.randi_range(1,4) #Change this to 1-4
	if chance == 1 or chance == 2:
		money += 1000 - (100- int(round($Timer.time_left)))*10
		$Timer.stop()
		$Time.text = " "
		$Time.position.y += 10000
		$Chase.visible = false
		$Chase.position.y = 10000
		$Area2D_Chase.visible = false
		$Area2D_Chase.position.y = 10000
		$Area2D_Chase/CollisionShape2D_Chase.visible = false
		$Area2D_Chase/CollisionShape2D_Chase.position.y = 10000
		chase = 3
	if chance == 3 or chance == 4:
		chase = 1
func onlyonce(): #This function runs only once
	while he == 5:
		movechase()
		$Chase.position = Vector2(bx,by)
		$Area2D_Chase.position = Vector2(bx,by)
		print($Chase.position, $Area2D_Chase.position, $Area2D_Chase/CollisionShape2D_Chase.position)
		he += 1
func _on_area_2d_shop_body_entered(body):
	get_tree().set_group("ShopEnter", "visible", true)
func _on_area_2d_shop_body_exited(body):
	get_tree().set_group("ShopEnter", "visible", false)

func _on_button_2_pressed():
		$Talk_ColorRect.visible = true
		while $Talk_ColorRect.position.y != 0:
			$Talk_ColorRect.position.y -= 100
			$l.position.y -= 100
			await get_tree().create_timer(0.0001).timeout
		$back.visible = true
		$Quit.visible = true
		$Button2.visible = false # Replace with function body.
		move = false
		pause = 0


func _on_back_pressed():
	if pause == 0:
		while $Talk_ColorRect.position.y != 5000:
			$Talk_ColorRect.position.y += 100
			$l.position.y += 100 
			await get_tree().create_timer(0.0001).timeout # Replace with function body.
		$Button2.visible = true
	if pause == 1:
		$Start.visible = true
		$"How to Play".visible = true
		$Credits.visible = true 
	get_tree().set_group("Startscreen", "visible", false)
	$back.visible = false
	$back2.visible = false
	$Quit.visible = false

func _on_spell_shop1_pressed():
	global.damage1 = randi_range(40,75)
	global.damage2 = randi_range(40,50)
	bought = 0
	if global.label1 == " " and money > 99 and bought == 0:
		global.label1 = "Light Beam\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 1
	if global.label1 != " " and global.label2 == " " and money > 99 and bought != 1:
		global.label2 = "Light Beam\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 2
	if global.label2 != " " and global.label3 == " " and money > 99 and bought != 1 and bought != 2:
		global.label3 = "Light Beam\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 3
func _on_spell_shop2_pressed():
	global.damage1 = randi_range(40,75)
	global.damage2 = randi_range(40,50)
	bought = 0
	if global.label1 == " " and money > 99 and bought == 0:
		global.label1 = "Fire Burst\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 1
	if global.label1 != " " and global.label2 == " " and money > 99 and bought != 1:
		global.label2 = "Fire Burst\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 2
	if global.label2 != " " and global.label3 == " " and money > 99 and bought != 1 and bought != 2:
		global.label3 = "Fire Burst\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 3
 # Replace with function body.
func _on_spell_shop3_pressed():
	global.damage1 = randi_range(40,75)
	global.damage2 = randi_range(40,50)
	bought = 0
	if global.label1 == " " and money > 99 and bought == 0:
		global.label1 = "Water Wave Beam\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 1
	if global.label1 != " " and global.label2 == " " and money > 99 and bought != 1:
		global.label2 = "Water Wave Beam\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 2
	if global.label2 != " " and global.label3 == " " and money > 99 and bought != 1 and bought != 2:
		global.label3 = "Water Wave Beam\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 3
func _on_spell_shop4_pressed():
	global.damage1 = randi_range(40,75)
	global.damage2 = randi_range(40,50)
	bought = 0
	if global.label1 == " " and money > 99 and bought == 0:
		global.label1 = "Wind Gust\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 1
	if global.label1 != " " and global.label2 == " " and money > 99 and bought != 1 and bought != 2:
		global.label2 = "Wind Gust\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 2
	if global.label2 != " " and global.label3 == " " and money > 99 and bought != 1 and bought != 2:
		global.label3 = "Wind Gust\nLevel 1\nDamage:40-75"
		money -= 100
		bought = 3

func _on_spell_shop5_pressed():
	global.damage1 = randi_range(120,155)
	global.damage2 = randi_range(120,130)
	bought = 0
	if global.label1 == " " and money > 499 and bought == 0:
		global.label1 = "Wind Gust\nLevel 2\nDamage:120-155"
		money -= 500
		bought = 1
	if global.label1 != " " and global.label2 == " " and money > 499 and bought != 1:
		global.label2 = "Wind Gust\nLevel 2\nDamage:120-155"
		money -= 500
		bought = 2
	if global.label2 != " " and global.label3 == " " and money > 499 and bought != 1 and bought != 2:
		global.label3 = "Wind Gust\nLevel 2\nDamage:120-155"
		money -= 500 # Replace with function body.
		bought = 3

func _on_spell_shop6_pressed():
	global.damage1 = randi_range(120,155)
	global.damage2 = randi_range(120,130)
	bought = 0
	if global.label1 == " " and money > 499 and bought == 0:
		global.label1 = "Water Wave Beam\nLevel 2\nDamage:120-155"
		money -= 500
		bought = 1
	if global.label1 != " " and global.label2 == " " and money > 499 and bought != 1 :
		global.label2 = "Water Wave Beam\nLevel 2\nDamage:120-155"
		money -= 500
		bought = 2
	if global.label2 != " " and global.label3 == " " and money > 499 and bought != 1 and bought != 2:
		global.label3 = "Water Wave Beam\nLevel 2\nDamage:120-155"
		money -= 500 # Replace with function body.
		bought = 3

func _on_spell_shop7_pressed():
	global.damage1 = randi_range(120,155)
	global.damage2 = randi_range(120,130)
	bought = 0
	if global.label1 == " " and money > 499 and bought == 0:
		global.label1 = "Fire Burst\nLevel 2\nDamage:120-155"
		money -= 500
		bought = 1
	if global.label1 != " " and global.label2 == " " and money > 499 and bought != 1:
		global.label2 = "Fire Burst\nLevel 2\nDamage:120-155"
		money -= 500
		bought = 2
	if global.label2 != " " and global.label3 == " " and money > 499 and bought != 1 and bought != 2:
		global.label3 = "Fire Burst\nLevel 2\nDamage:120-155"
		money -= 500 # Replace with function body.
		bought = 3

func _on_spell_shop8_pressed():
	global.damage1 = randi_range(120,155)
	global.damage2 = randi_range(120,130)
	bought = 0
	if global.label1 == " " and money > 499 and bought == 0:
		global.label1 = "Light Beam\nLevel 2\nDamage:120-155"
		money -= 500
		bought = 1
	if global.label1 != " " and global.label2 == " " and money > 499 and bought != 1:
		global.label2 = "Light Beam\nLevel 2\nDamage:120-155"
		money -= 500
		bought = 2
	if global.label2 != " " and global.label3 == " " and money > 499 and bought != 1 and bought != 2:
		global.label3 = "Light Beam\nLevel 2\nDamage:120-155"
		money -= 500 # Replace with function body.
		bought = 3

func _on_area_2d_mini_boss_body_entered(body):
	if global.label1 != " ":
		level = 2 # Replace with function body.
	else:
		$Buy.text = "Buy Something From the Shop!"
		$Buy.visible = true
	$x.visible = true
	
	inter = 2

func _on_area_2d_mini_boss_body_exited(body):
	$Buy.visible = false # Replace with function body.
	inter = 0
	$Talk_ColorRect.visible = false
	$l2.visible = false
	$x.visible = false
func _on_area_2d_quest_body_entered(body):
	$ShopRect.visible = true # Replace with function body.
	$Level1Quest.visible = true

func _on_area_2d_quest_body_exited(body):
	$ShopRect.visible = false # Replace with function body.
	$Level1Quest.visible = false

func _on_level_1_quest_pressed():
	$ShopRect.visible = false # Replace with function body.
	$Level1Quest.visible = false # Replace with function body.
	level = 1 


func _on_area_2d_boss_body_entered(body):
	if global.label1 != " ":
		level = 3 # Replace with function body.
		inter = 3
		
		$x.visible = true
	else:
		$Buy.text = "Buy Something From the Shop!"
		$Buy.visible = true # Replace with function body.
		$Talk_ColorRect.visible = false
		$l3.visible = false
		$x.visible = false

func _on_area_2d_boss_body_exited(body):
	$Buy.visible = false # Replace with function body.
	inter = 0
	$x.visible = true
func dilemna():
	$WHATISIT.text = dildict[randi_range(1,3)]
	get_tree().set_group("Dilemma", "visible", true)
func _on_timer_2_timeout():
	dilemna() # Replace with function body.

func _on_yes_pressed():
	if money >= 100:
		money -= 100 # Replace with function body.
	get_tree().set_group("Dilemma", "visible", false)
func _on_no_pressed():
	if randi_range(1,100) == 50:
		money -= 200
		$DILLEMMA.text = "HEHE GET TRICKED"
	await get_tree().create_timer(2).timeout
	get_tree().set_group("Dilemma", "visible", false) # Replace with function body.


	 # Replace with function body.


func _on_quit_pressed():
	get_tree().quit(0) # Replace with function body.


func _on_area_2d_body_vender_entered(body):
	inter = 4 # Replace with function body.
	$x.visible = true

func _on_area_2d_body_vender_exited(body):
	inter = 0 # Replace with function body.
	$x.visible = false
	$Talk_ColorRect.visible = false
	$l4.visible = false
	$x.visible = false
