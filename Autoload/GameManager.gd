extends Node

var score = 0
var high_score = 0
var session_time = 0.0
var current_level = 1

func reset():
	score = 0
	session_time = 0.0
	current_level = 1

func add_score(amount):
	score += amount
	if score > high_score:
		high_score = score
