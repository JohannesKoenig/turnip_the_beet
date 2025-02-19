extends Node

var inventory: Inventory
var daytime: Daytime
var garden: Garden

func initialize(): 
	inventory = Inventory.constructor()
	daytime = Daytime.constructor()
	garden = Garden.constructor()

func load_from_save(): 
	pass

func store_to_save():
	pass
	
