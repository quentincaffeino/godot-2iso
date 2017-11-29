
extends Control


# @var  FileDialog
onready var fileDialog = $FileDialog


func _selectImages():  # void
  fileDialog.popup()


# @param  string  path
func _onFileSelected( path ):  # void
  Images.add(path)


# @param  PoolStringArray|Array<string>  path
func _onFilesSelected( paths ):  # void
  for path in paths:
    Images.add(path)


func _convertImages():  # void
  Images.convert()
