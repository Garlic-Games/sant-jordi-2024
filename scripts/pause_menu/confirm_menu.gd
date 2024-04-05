class_name ConfirmMenu;
extends MarginContainer

signal selection(choice: bool);
signal opened;
signal closed;

func _ready() -> void:
	hide();

func open() -> void:
	opened.emit();
	show();

func close():
	closed.emit();
	hide();

func _on_yes_pressed():
	selection.emit(true);

func _on_no_pressed():
	selection.emit(false);
