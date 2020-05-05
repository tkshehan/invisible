extends Control

func no_cloak():
	$Cloak.text = "Cloak Unavailable"
	$Cloak.add_color_override("font_color", Color(0.8, 0.4, 0))
	
