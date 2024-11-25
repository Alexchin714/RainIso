extends Node2D

export (int) var width
export (int) var height
export (int) var xStart
export (int) var yStart
export (int) var offset

var firstMove = Vector2(0,0)
var finalMove = Vector2(0,0)
var allPieces = []
var controlling = false

var possiblePieces = [
	preload("res://RainIsoMainContents/Scenes/MatchObject1.tscn"),
	preload("res://RainIsoMainContents/Scenes/MatchObject2.tscn"),
	preload("res://RainIsoMainContents/Scenes/MatchObject3.tscn"),
	preload("res://RainIsoMainContents/Scenes/MatchObject4.tscn"),
]

func _ready():
	randomize()
	allPieces = make2DArray()
	addPiece()
	
func make2DArray():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array

func addPiece():
	for i in width:
		for j in height:
			var rand = floor(rand_range(0, possiblePieces.size()))
			var piece = possiblePieces[rand].instance()
			var loops = 0
			while(matchFound(i, j, piece.objects)&&loops<100):
				rand = floor(rand_range(0,possiblePieces.size()))
				loops += 1
				piece = possiblePieces[rand].instance()
			add_child(piece)
			piece.position = GridPixels(i,j)
			allPieces[i][j] = piece
			
func matchFound(i, j, objects):
	if i > 1:
		if allPieces[i - 1][j] != null && allPieces[i - 2][j] != null:
			if allPieces[i - 1][j].objects == objects && allPieces[i - 2][j].objects:
				return true
	if j > 1:
		if allPieces[i][j-1]!=null && allPieces[i - 2][j]!=null:
			if allPieces[i - 1][j].objects == objects && allPieces[i - 2][j].objects:
				return true
				
func GridPixels(column, row):
	var newX = xStart + offset * column
	var newY = yStart + -offset * row
	return Vector2(newX,newY)

func PixelGrids(pixelX, pixelY):
	var newX = (pixelX - xStart) / offset
	var newY = (pixelY - yStart) / -offset
	return Vector2(newX,newY)
	
func touchInput():
	if Input.is_action_just_pressed("mb_left"):
		firstMove = get_global_mouse_position()
		var gridPos = PixelGrids(firstMove.x, firstMove.y)
		if isInGrid(gridPos.x, gridPos.y):
			controlling = true
	if Input.is_action_just_released("mb_left"):
		finalMove = get_global_mouse_position()
		var gridPos = PixelGrids(finalMove.x, finalMove.y)
		if isInGrid(gridPos.x, gridPos.y) and controlling:
			touchDiffer(PixelGrids(firstMove.x, firstMove.y), gridPos)
			
func isInGrid(column, row):
	if column >= 0 && column < width:
		if row >= 0 && row < height:
			return true
	return false
	
func swapPiece(column, row, direction):
	var firstPiece = allPieces[column][row]
	var otherPiece = allPieces[column + direction.x][row + direction.y]
	allPieces[column][row] = otherPiece
	allPieces[column + direction.x][row + direction.y] = firstPiece
	firstPiece.position = GridPixels(column + direction.x, row + direction.y)
	otherPiece.position = GridPixels(column, row)
	
func touchDiffer(Grid1 , Grid2):
	var differ = Grid2 - Grid1
	if abs(differ.x) > abs(differ.y):
		if differ.x > 0:
			swapPiece(Grid1.x,Grid1.y,Vector2(1,0))
		elif differ.x < 0:
			swapPiece(Grid1.x,Grid1.y,Vector2(-1,0))
	elif abs(differ.y) > abs(differ.x):
		if differ.y > 0:
			swapPiece(Grid1.x,Grid1.y,Vector2(0,1))
		elif differ.y < 0:
			swapPiece(Grid1.x,Grid1.y,Vector2(0,1))
			
func _process(delta):
	touchInput()
