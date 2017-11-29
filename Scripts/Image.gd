
extends Node
const Convert = preload('res://Scripts/Convert.gd')


enum Dst { Top, Left, Right }

# @var  string
var path setget _setProtected

# @var  string
var name setget _setProtected

# @var  string
var format setget _setProtected

# @var  Image
var texture setget _setProtected

# @var  Dictionary
var dst = {
  'top': {
    'needToBeConverted': false,
    'isConverted': false,
    'texture': null
  },
  'left': {
    'needToBeConverted': false,
    'isConverted': false,
    'texture': null
  },
  'right': {
    'needToBeConverted': false,
    'isConverted': false,
    'texture': null
  }
}
signal textrureReady(type, image)


# @param  string  _path
# @param  Image  _texture
func _init(_path, _texture):
  path = _path

  # Get image name and format
  var rg = RegEx.new()
  rg.compile('\\/(\\w+)\\.(\\w+)$')
  var rgm = rg.search(_path)
  if rgm and rgm is RegExMatch:
    name = rgm.get_strings()[1]
    format = rgm.get_strings()[2]
  else:
    name = str(randi() % 100)
    format = null

  texture = _texture


# @param  Varian  value
func _setProtected(value):  # void
  pass


func convert():  # void
  var keys = dst.keys()

  for i in range(len(keys)):
    if !dst[keys[i]].isConverted:
      Convert.new(texture, i, self)


# @param  int  type
# @param  Image  image
func _convertionReady(type, image):  # void
  var saveName = name

  # Create texture from image
  var imgTexture = ImageTexture.new()
  imgTexture.create_from_image(image)

  # Record
  if type == Dst.Top:
    dst.top.needToBeConverted = false
    dst.top.isConverted = true
    dst.top.texture = imgTexture
    saveName += 'Top'
  elif type == Dst.Left:
    dst.left.needToBeConverted = false
    dst.left.isConverted = true
    dst.left.texture = imgTexture
    saveName += 'Left'
  elif type == Dst.Right:
    dst.right.needToBeConverted = false
    dst.right.isConverted = true
    dst.right.texture = imgTexture
    saveName += 'Right'

  # Save image
  var savePath = 'res://Dst/' + name + '/'

  ## Create dir if doesnt exists
  var dir = Directory.new()
  if !dir.dir_exists(savePath):
    dir.make_dir_recursive(savePath)

  image.save_png(savePath + saveName + '.png')

  # Display texture
  emit_signal('textrureReady', type, imgTexture)
