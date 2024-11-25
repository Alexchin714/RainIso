extends Node2D

export var k = 0.015
export var d = 0.03
export var spread = 0.0002
export var distancebetweensprings = 30
export var springnumber = 6
export var depth = 1000
export var border_thickness = 1.1

var target_height = global_position.y
var water_lenght = distancebetweensprings * springnumber
var bottom = target_height + depth
var springs = []
var passes = 8

onready var collisionShape = $WaterBodyArea/CollisionShape2D
onready var waterBodyArea = $WaterBodyArea
onready var water_polygon = $WaterPolygon
onready var water_border = $WaterBorder
onready var water_spring = preload("res://RainIsoMainContents/Scenes/WaterJoints.tscn")

func _ready():
	water_border.width = border_thickness
	spread = spread / 1000
	for i in range(springnumber):
		var x_position = distancebetweensprings * i
		var w = water_spring.instance()
		
		add_child(w)
		springs.append(w)
		w.initialize(x_position, i)
		w.setCollisionWidth(distancebetweensprings)
		w.connect("splash", self, "splash")
		
	splash(2,5)
	
	var totalLength = distancebetweensprings * (springnumber - 1)
	var rectangle = RectangleShape2D.new().duplicate()
	var rectPos = Vector2(totalLength / 2, depth / 2)
	
func _physics_process(delta):
	for i in springs:
		i.water_update(k,d)
		
	var left_deltas = []
	var right_deltas = []
	
	for i in range (springs.size()):
		left_deltas.append(0)
		right_deltas.append(0)
		pass
	
	for j in range(passes):
		for i in range(springs.size()):
			if i > 0:
				left_deltas[i] = spread * (springs[i].height - springs[i-1].height)
				springs[i-1].velocity += left_deltas[i]
			if i < springs.size()-1:
				right_deltas[i] = spread * (springs[i].height - springs[i+1].height)
	
	newBorder()
	drawWaterBody()
	
func splash(index, speed):
	if index >= 0 and index < springs.size():
		springs[index].velocity += speed
	pass

func drawWaterBody():
	var curve = water_border.curve
	var points = Array(curve.get_baked_points())
	
	var surfacePoints = []
	
	for i in range (springs.size()):
		surfacePoints.append(springs[i].position)
	
	var firstIndex = 0
	var lastIndex = surfacePoints.size()-1
	var waterPolygonPoints = surfacePoints
	
	waterPolygonPoints.append(Vector2(surfacePoints[lastIndex].x, bottom))
	waterPolygonPoints.append(Vector2(surfacePoints[firstIndex].x, bottom))
	waterPolygonPoints = PoolVector2Array(waterPolygonPoints)
	water_polygon.set_polygon(waterPolygonPoints)
	water_polygon.set_uv(waterPolygonPoints)
	
func newBorder():
	var curve = Curve2D.new().duplicate()
	var surfacePoints = []
	for i in range(springs.size()):
		surfacePoints.append(springs[i].position)
		
	for i in range(surfacePoints.size()):
		curve.add_point(surfacePoints[i])
		
	water_border.curve = curve
	water_border.smooth(true)
	water_border.update()
	pass
