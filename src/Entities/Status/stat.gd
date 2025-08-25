class_name STAT
extends Node

enum STATUS_ENUM { REGEN_STATUS }

var STATUS: Dictionary[int, Callable] = {
	STATUS_ENUM.REGEN_STATUS:  RegenStatus.new
	}
