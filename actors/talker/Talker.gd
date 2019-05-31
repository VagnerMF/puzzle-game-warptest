class_name Talker extends KinematicBody2D

onready var text := $RichTextLabel
onready var timer := $TextTimer
onready var spr_w = $Sprite.get_rect().size.x
onready var spr_h = $Sprite.get_rect().size.y

var dialog := [
	"Hello!",
	"How are you?",
	"I'm doing ok.",
	"Trying to get this damn text to work though"
]
var page := 0
var speak := false

func _ready():
	
	print(spr_w, spr_h)
	#text.set_position(Vector2(self.get_position().x, self.get_position().y-(spr_h/2)))
	#text.set_anchor(Vector2(self.get_position().x, self.get_position().y))
	#print(text.get_position())
	
	text.set_use_bbcode(true)
	text.set_bbcode(dialog[page])
	text.set_visible_characters(0)

func speak():
	if timer.is_stopped():
		timer.start()
	else:
		if text.get_visible_characters() < text.get_total_character_count():
			text.set_visible_characters(text.get_total_character_count())
		else:
			# Cycle the text
			if page < dialog.size()-1:
				page += 1
				text.set_bbcode(dialog[page])
				text.set_visible_characters(0)
			elif page == dialog.size()-1 :
				timer.stop()
				page = 0
				text.set_bbcode(dialog[page])
				text.set_visible_characters(0)

func _on_TextTimer_timeout():
	text.set_visible_characters(text.get_visible_characters()+1)
	print(text.get_visible_characters())