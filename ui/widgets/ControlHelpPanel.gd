extends Panel

## 操作指引面板
## 显示游戏的所有键盘操作说明

@onready var container = $VBoxContainer
@onready var close_button = $VBoxContainer/CloseButton

var is_visible = false

func _ready() -> void:
	visible = false
	_setup_controls()
	if close_button:
		close_button.pressed.connect(_on_close_button_pressed)

func _on_close_button_pressed():
	hide_panel()

func _setup_controls():
	# 清空容器（但保留CloseButton）
	for child in container.get_children():
		if child.name != "CloseButton":
			child.queue_free()
	
	# 定义操作列表：操作名称，按键显示，描述
	var controls = [
		["移动", "WASD / 方向键", "移动角色"],
		["射击", "鼠标左键", "开火射击"],
		["换弹", "R", "重新装填弹药"],
		["冲刺", "Shift", "快速冲刺移动"],
		["背包", "Tab", "打开/关闭背包"],
		["交互", "E", "与物品/NPC交互"],
		["武器切换", "1-7", "切换武器槽位"],
	]
	
	# 创建标题
	var title = Label.new()
	title.text = "操作指引"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 12)
	container.add_child(title)
	
	# 创建分隔线
	var separator = HSeparator.new()
	container.add_child(separator)
	
	# 创建每个操作项
	for control in controls:
		var hbox = HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 10)
		
		# 操作名称
		var name_label = Label.new()
		name_label.text = control[0] + ":"
		name_label.add_theme_font_size_override("font_size", 8)
		name_label.custom_minimum_size.x = 60
		hbox.add_child(name_label)
		
		# 按键显示（带背景的标签）
		var key_panel = Panel.new()
		key_panel.custom_minimum_size = Vector2(90, 18)
		# 设置按键面板样式
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.2, 0.2, 0.2, 0.8)
		style.border_color = Color(0.5, 0.5, 0.5, 1.0)
		style.border_width_left = 1
		style.border_width_right = 1
		style.border_width_top = 1
		style.border_width_bottom = 1
		style.corner_radius_top_left = 2
		style.corner_radius_top_right = 2
		style.corner_radius_bottom_left = 2
		style.corner_radius_bottom_right = 2
		key_panel.add_theme_stylebox_override("panel", style)
		
		var key_label = Label.new()
		key_label.text = control[1]
		key_label.layout_mode = 1
		key_label.anchors_preset = 15
		key_label.anchor_right = 1.0
		key_label.anchor_bottom = 1.0
		key_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		key_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		key_label.add_theme_font_size_override("font_size", 7)
		key_panel.add_child(key_label)
		hbox.add_child(key_panel)
		
		# 描述
		var desc_label = Label.new()
		desc_label.text = control[2]
		desc_label.add_theme_font_size_override("font_size", 8)
		hbox.add_child(desc_label)
		
		container.add_child(hbox)

func toggle():
	is_visible = !is_visible
	visible = is_visible

func show_panel():
	is_visible = true
	visible = true

func hide_panel():
	is_visible = false
	visible = false

