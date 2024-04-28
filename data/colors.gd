extends Node
class_name ColorsData

static var _colors: Array = [
	"#f77622",
	"#2ce8f5",
	"#ff0044",
	"#0095e9",
	"#ead4aa",
	"#fee761",
	"#181425"
].map(func(hex_color): return Color.from_string(hex_color, Color.BLACK))

static func get_color(id: String) -> Color:
	var color_index = id.hash() % _colors.size()
	return _colors[color_index]
