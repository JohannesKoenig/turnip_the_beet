extends Node

var inventory: Inventory
var daytime: Daytime
var garden: Garden
var store: Store
var item_display: ItemDisplay
var money: Money

func initialize(): 
	inventory = Inventory.constructor()
	daytime = Daytime.constructor()
	garden = Garden.constructor()
	store = Store.constructor()
	item_display = ItemDisplay.constructor()
	money = Money.constructor(1000)

func load_from_save(): 
	pass

func store_to_save():
	pass
	
