extends Control
class_name TraitsView

var _trait_views: Array = []

func _ready() -> void:
	for child in get_children():
		if not child is TraitView:
			continue
		_trait_views.append(child)
		
func initialize(traits: Array) -> void:
	for i in range(_trait_views.size()):
		var traitt_view: TraitView = _trait_views[i]
		var traitt = traits[i] if i < traits.size() else null
		if traitt:
			traitt_view.show()
			traitt_view.initialize(traitt)
		else:
			traitt_view.hide()
