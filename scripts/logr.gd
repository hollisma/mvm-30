extends Node

enum Level { DEBUG, INFO, WARNING, ERROR }

var min_level := Level.DEBUG

func debug(message: String, tag: String = ""): 
	_log(tag, message, Level.DEBUG)

func info(message: String, tag: String = ""): 
	_log(tag, message, Level.INFO)

func warning(message: String, tag: String = ""): 
	_log(tag, message, Level.WARNING)

func error(message: String, tag: String = ""): 
	_log(tag, message, Level.ERROR)

func _log(message: String, tag: String, level: Level): 
	if level < min_level: return
	
	var prefix := "[%s]" % Level.keys()[level]
	var output = "%s[%s] %s" % [prefix, tag, message]
	
	match level: 
		Level.DEBUG, Level.INFO: 
			print(output)
		Level.WARNING: 
			push_warning(output)
		Level.ERROR: 
			push_error(output)
