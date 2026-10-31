extends Control


# ============================================================
# 可调整的参数
# ============================================================

# 每盏灯依次亮起的间隔，单位为秒。
const LIGHT_INTERVAL: float = 1.0

# 所有灯亮起后，随机等待的时间范围。
const MIN_WAIT: float = 0.2
const MAX_WAIT: float = 3.0

# 白色保留灯原本的颜色；较暗的颜色模拟熄灭。
const LIGHT_ON: Color = Color.WHITE
const LIGHT_OFF: Color = Color(0.1, 0.1, 0.1, 1.0)


# ============================================================
# 场景节点
# ============================================================

@onready var light_groups: HBoxContainer = $LightBox/Lights
@onready var start_button: Button = $StartButton

# 保存五个实际参与亮灭的红灯节点。
var lamps: Array[CanvasItem] = []


# ============================================================
# 游戏状态
# ============================================================

enum RoundState {
	IDLE,          # 初始界面，点击后开始
	LIGHTING,      # 灯正在依次亮起，点击会抢跑
	WAITING,       # 灯全亮，点击仍然会抢跑
	GO,            # 灯已熄灭，点击记录成绩
	FINISHED,      # 显示成绩，点击返回初始界面
	FALSE_START    # 显示抢跑，点击返回初始界面
}

var state: RoundState = RoundState.IDLE

# 灯熄灭时的时间，单位为微秒。
var lights_out_time_us: int = 0

# 用编号识别每次流程，防止抢跑或重置后，
# 旧计时器继续执行，影响当前界面。
var round_id: int = 0


# ============================================================
# 初始化
# ============================================================

func _ready() -> void:
	# 禁止按钮获得键盘焦点，避免空格触发按钮。
	start_button.focus_mode = Control.FOCUS_NONE

	# 寻找每组灯下面的 RealLight。
	for group in light_groups.get_children():
		var lamp := group.get_node_or_null("Light/RealLight") as CanvasItem

		if lamp == null:
			push_error(
				"Light node not found: "
				+ str(group.get_path())
				+ "/Light/RealLight"
			)
			start_button.text = "NODE ERROR"
			start_button.disabled = true
			return

		lamps.append(lamp)

	# 检查灯的数量。
	if lamps.size() != 5:
		push_error(
			"Expected 5 light groups. Found: "
			+ str(lamps.size())
		)
		start_button.text = "LIGHT COUNT ERROR"
		start_button.disabled = true
		return

	# 保留编辑器中已有的信号连接。
	# 如果还没连接，则通过代码补上。
	if not start_button.pressed.is_connected(_on_start_button_pressed):
		start_button.pressed.connect(_on_start_button_pressed)

	reset_to_start()


# ============================================================
# 同一个按钮，根据当前状态执行不同操作
# ============================================================

func _on_start_button_pressed() -> void:
	match state:
		RoundState.IDLE:
			# 初始界面：开始自动亮灯。
			start_round()

		RoundState.LIGHTING, RoundState.WAITING:
			# 红灯尚未熄灭：提前点击就是抢跑。
			false_start()

		RoundState.GO:
			# 红灯已经熄灭：记录反应时间。
			finish_round()

		RoundState.FINISHED, RoundState.FALSE_START:
			# 成绩或抢跑界面：只返回 START，不开始新一局。
			# 玩家需要再次点击 START 才会开始。
			reset_to_start()


# ============================================================
# 返回初始界面
# ============================================================

func reset_to_start() -> void:
	# 让旧的等待流程失效。
	round_id += 1

	state = RoundState.IDLE
	lights_out_time_us = 0
	set_lights(0)

	start_button.text = "🟢START"
	start_button.disabled = false


# ============================================================
# 设置亮灯数量
# ============================================================

func set_lights(lit_count: int) -> void:
	for index in range(lamps.size()):
		if index < lit_count:
			lamps[index].self_modulate = LIGHT_ON
		else:
			lamps[index].self_modulate = LIGHT_OFF


# ============================================================
# 自动亮灯与随机熄灯
# ============================================================

func start_round() -> void:
	round_id += 1
	var this_round: int = round_id

	state = RoundState.LIGHTING
	set_lights(0)

	# 整个过程中按钮保持可点击，才能检测抢跑。
	start_button.disabled = false
	start_button.text = "🔴WAIT FOR LIGHTS OUT"

	# 按顺序亮起第一盏到第五盏灯。
	for count in range(1, lamps.size() + 1):
		set_lights(count)

		# 只有后面还有灯需要亮起时，才等待亮灯间隔。
		# 第五盏亮起后，直接进入后面的随机等待。
		if count < lamps.size():
			await get_tree().create_timer(LIGHT_INTERVAL).timeout

			# 如果发生抢跑或重置，立即结束这个旧流程。
			if this_round != round_id:
				return

	# 全部亮起后，等待一个随机时间。
	state = RoundState.WAITING

	var wait_seconds: float = randf_range(MIN_WAIT, MAX_WAIT)
	await get_tree().create_timer(wait_seconds).timeout

	if this_round != round_id:
		return

	# 同时熄灭所有灯，并开始计算反应时间。
	set_lights(0)
	lights_out_time_us = Time.get_ticks_usec()

	state = RoundState.GO
	start_button.text = "🟢CLICK NOW"


# ============================================================
# 抢跑
# ============================================================

func false_start() -> void:
	# 取消尚未结束的自动亮灯或等待流程。
	round_id += 1

	state = RoundState.FALSE_START
	set_lights(0)

	start_button.text = "❌FALSE START | ↩️BACK"
	start_button.disabled = false

	print("False start. Wait until all lights go out.")


# ============================================================
# 计算成绩
# ============================================================

func finish_round() -> void:
	var elapsed_us: int = Time.get_ticks_usec() - lights_out_time_us
	var elapsed_seconds: float = float(elapsed_us) / 1_000_000.0

	state = RoundState.FINISHED

	# 显示成绩，点击后只返回初始界面。
	start_button.text = "🏁%.3f s | ↩️BACK" % elapsed_seconds
	start_button.disabled = false

	print("Reaction time: %.3f s" % elapsed_seconds)
