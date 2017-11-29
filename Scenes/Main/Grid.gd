
extends VBoxContainer
const ListElement = preload('res://Scenes/Element/Element.tscn')


func _ready():  # void
  Images.connect('changed', self, '_changed')


# @param  int  action
# @param  Image  image
func _changed(action, image):  # void
  if action == Images.Action.ADD:
    var listElement = ListElement.instance()
    add_child(listElement)
    listElement.setSrcImage(image)
