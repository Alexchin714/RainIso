extends KinematicBody2D

enum {
	IDLE,
	RUNS
}

var velocity = Vector2.ZERO
var state = RUNS

const ACCELERATION = 300
const MAX_SPEED = 50
const TOLERANCE = 4.0
