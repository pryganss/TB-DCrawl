class_name STAT
extends Node

enum STATUS_ENUM { REGEN_STATUS, ATTACK_SCALING_STATUS, ARMOR_FROM_DAMAGE_STATUS }

var STATUS: Dictionary[int, Callable] = {
	STATUS_ENUM.REGEN_STATUS:  RegenStatus.new,
	STATUS_ENUM.ATTACK_SCALING_STATUS: AttackScalingStatus.new,
	STATUS_ENUM.ARMOR_FROM_DAMAGE_STATUS : ArmorFromDamageStatus.new,
	}
