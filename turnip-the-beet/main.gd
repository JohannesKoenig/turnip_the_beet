class_name Main extends Node2D

func _init():
	Model.initialize() 
	
func _ready():
	Model.daytime.start()

func _process(delta):
	Model.daytime.update()
