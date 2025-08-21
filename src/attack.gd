class_name Attack
extends Object

func _init():
	assert(false)

static func to_hit(level_diff: int) -> bool:
	return randf() < 0.5 * (tanh((level_diff * 0.25) + 0.3) + 1)

static func damage(dice: Array[String], mod: int) -> int:
	var result: int = mod

	for d in dice:
		var die = d.split('d', false, 1)
		var dmax = int(die[1])
		for roll in int(die[0]): result += randi_range(1, dmax)

	return result
