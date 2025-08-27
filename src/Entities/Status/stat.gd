class_name STAT
extends Node

enum STATUS_ENUM { REGEN_STATUS, ATTACK_SCALING_STATUS }

var STATUS: Dictionary[int, Callable] = {
	STATUS_ENUM.REGEN_STATUS:  RegenStatus.new,
	STATUS_ENUM.ATTACK_SCALING_STATUS: AttackScalingStatus.new
	}
