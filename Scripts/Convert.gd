
extends Node
const ImageClass = preload('res://Scripts/Image.gd')


# @var  Image
var _src

# @var  Vector2
var _srcSize

# @var  int
var _type

# @var  Varian
var _readyCallback

# @var  Thread
var _tr


# @param  Image  src
# @param  int  type
# @param  Varian  readyCallback
func _init(src, type, readyCallback):
  _src = src.get_data()
  _src.lock()
  _srcSize = src.get_size()
  _type = type
  _readyCallback = readyCallback

  _tr = Thread.new()
  _tr.start(self, '_convert')


func _convert(argv):  # void
  var xHalf = _srcSize.x / 2
  var yHalf = _srcSize.y / 2

  # Create image
  var dst = Image.new()
  if _type == ImageClass.Dst.Top:
    dst.create(_srcSize.y, xHalf, false, 5)

  elif _type == ImageClass.Dst.Left or _type == ImageClass.Dst.Right:
    dst.create(yHalf + 1, _srcSize.x * 0.75, false, 5)

  dst.lock()

  # Transform image
  var pixelPos
  for x in _srcSize.x:
    for y in _srcSize.y:
      if _type == ImageClass.Dst.Top:
        pixelPos = Vector2(yHalf - 1, yHalf - xHalf / 2) + _iso(x, y)

      elif _type == ImageClass.Dst.Left:
        pixelPos = Vector2(0, y / 2) + _iso(x, 0)

      elif _type == ImageClass.Dst.Right:
        pixelPos = Vector2(xHalf, y / 2) + _iso(_srcSize.x, x)

      dst.set_pixel(pixelPos.x, pixelPos.y, _src.get_pixel(x, y))

  # Return
  _readyCallback._convertionReady(_type, dst)


# @param  int|float  x
# @param  int|float  y
func _iso(x, y): return Vector2(0.5 * (_srcSize.x - x - y), 0.25 * (x - y))
