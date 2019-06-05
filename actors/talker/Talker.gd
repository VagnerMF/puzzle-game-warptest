class_name Talker extends KinematicBody2D

onready var spr_w = $Sprite.get_rect().size.x
onready var spr_h = $Sprite.get_rect().size.y

onready var label := $RichTextLabel
onready var label_rect : Rect2 = label.get_rect() # Cache the original pos

onready var timer := $TextTimer

#var dialog := [
#	"Trying to get this damn label to work though.",
#	"arblarblarblarblarblarblarblarblarblarblarblarblarblarblarblarblarblarblarbl",
#	"I'm doing ok."
#]
export (Array, String) var dialog
var page := 0


func _ready():
	print(spr_w, spr_h)
	label.set_use_bbcode(true)
	set_label(dialog[page])


func speak() -> void:
	if timer.is_stopped():
		timer.start()
	else:
		# If the dialog isn't finished typing, just reveal it all
		if label.get_visible_characters() < label.get_total_character_count():
			label.set_visible_characters(label.get_total_character_count())
		else:
			# Next page of dialog...
			if page < dialog.size()-1:
				page += 1
				set_label(dialog[page])
			elif page == dialog.size()-1 :
				timer.stop()
				page = 0
				set_label(dialog[page])


func set_label(s:String) -> void:
	label.set_bbcode("[center]%s[/center]" % s)
	label.set_visible_characters(0)
	reposition_label(s)


func reposition_label(text:String) -> void:
	var font:Font = label.get_font("normal_font")
	var letter_height:float = font.get_height()+1
	var string_size:= font.get_string_size(text)
	var lines_needed = ceil(string_size.x / label_rect.size.x)
	var top_offset = letter_height * (lines_needed+1)
	label.set_margin(MARGIN_TOP, MARGIN_BOTTOM-top_offset)
#	print("label_rect.position.y ", label_rect.position.y)
#	print("letter_height ", letter_height)
#	print("string_size ", string_size)
#	print("label_rect ", label_rect.size)
#	print("lines_needed ", lines_needed)
#	print("top_offset ", top_offset)


func _on_TextTimer_timeout():
	label.set_visible_characters(label.get_visible_characters()+1)
	#print(label.get_visible_characters())