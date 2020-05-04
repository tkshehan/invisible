extends Control

func no_cloak():
	$Cloak.text = "Cloak Unavailable"
	$Cloak.add_color_override("font_color", Color(0.6, 0.3, 0.3))
	
