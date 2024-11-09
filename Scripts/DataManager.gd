extends Node



func WriteData(key, value):
	WriteDataNormal(key, value)	
#	if OS.get_name() == "HTML5":
#		WriteDataHTML5(key, value)
#	else:
#		WriteDataNormal(key, value)	
	
func WriteDataNormal(key, value):
	var save_path = "user://" + key + " .save"
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(value)


func WriteDataHTML5(key, value):
	pass
	
func ReadData(key, default):
	return ReadDataNormal(key, default)
#	if OS.get_name() == "HTML5":
#		return ReadDataHTML5(key, default)
#	else:
#		return ReadDataNormal(key, default)

func ReadDataNormal(key, default):
	var save_path = "user://" + key + " .save"
	if FileAccess.file_exists(save_path) == false:
		return default
		
	var file = FileAccess.open(save_path, FileAccess.READ)
	
	return file.get_var()

func ReadDataHTML5(key, default):
	pass
