
extends Node
const Image = preload('res://Scripts/Image.gd')


enum Action { ADD, REMOVE }


# @var  Array<Image>
var _images = []
signal changed(action, image)


# @param  string  imagePath
func _exists(imagePath):  # boolean
  for img in _images:
    if img.path == imagePath:
      return true
  return false


# @param  string  imagePath
func add(imagePath):  # void
  if _exists(imagePath):
    return

  var file = load(imagePath)

  if file != null && file is StreamTexture:
    var image = Image.new(imagePath, file)
    _images.append(image)
    emit_signal('changed', Action.ADD, image)
  else:
    print('[Error] Couldn\'t load image ' + imagePath)


func convert():  # void
  for image in _images:
    image.convert()
