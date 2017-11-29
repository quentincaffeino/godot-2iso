
extends Control
const Image = preload('res://Scripts/Image.gd')


# @var  TextureRect
onready var _srcEl = $HBoxContainer/MarginContainer1/SrcTexture

# @var  Dictionary
onready var _dstEl = {
  'top': $HBoxContainer/MarginContainer2/DstTop,
  'left': $HBoxContainer/MarginContainer3/DstLeft,
  'right': $HBoxContainer/MarginContainer4/DstRight
}


# @param  Image
func setSrcImage(_srcImage):  # void
  if !_srcEl.texture:
    _srcImage.connect('textrureReady', self, '_showTexture')
    _srcEl.texture = _srcImage.texture


# @param  int  type
# @param  ImageTexture  image
func _showTexture(type, image):  # void
  if type == Image.Dst.Top:
    _dstEl.top.texture = image
  elif type == Image.Dst.Left:
    _dstEl.left.texture = image
  elif type == Image.Dst.Right:
    _dstEl.right.texture = image
