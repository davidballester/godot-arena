extends CanvasLayer
class_name BattleScreen

const COMBATANT_CONTROLLER_SCENE = preload(
	"res://controllers/combatant/combatant_controller.tscn"
)

@onready var _hud: BattleScreenHud = %HUD

func _ready() -> void:
	add_child(GameGlobals.battle.terrain)
	move_child(GameGlobals.battle.terrain, 0)
	GameGlobals.player_team.combatants.map(
		_create_add_combatant_to_ground(
			GameGlobals.player_team,
			_get_player_team_spawn_position
		)
	)
	GameGlobals.enemy_team.combatants.map(
		_create_add_combatant_to_ground(
			GameGlobals.enemy_team,
			_get_enemy_team_spawn_position
		)
	)
	_hud.combatant_bought.connect(func(c: Combatant):
		GameGlobals.player_team.add_combatant(c)
		GameGlobals.battle.add_combatant(c)
		_create_add_combatant_to_ground(
			GameGlobals.player_team, 
			_get_player_team_spawn_position
		).call(c)
	)

func _create_add_combatant_to_ground(t: Team, get_spawn_position: Callable):
	return func add_combatant_to_ground(c: Combatant) -> void:
		var combatant_controller: CombatantController = COMBATANT_CONTROLLER_SCENE.instantiate()
		combatant_controller.ready.connect(func():
			combatant_controller.initialize(c, t, true)
		)
		combatant_controller.position = get_spawn_position.call()
		GameGlobals.battle.terrain.combatants_container.add_child(combatant_controller)
	
func _get_player_team_spawn_position() -> Vector2:
	var random_y_wiggle = randf_range(
		-GameGlobals.VIEWPORT_HEIGHT / 8,
		GameGlobals.VIEWPORT_HEIGHT / 8
	)
	return Vector2(
		-20, 
		GameGlobals.VIEWPORT_HEIGHT / 2 + random_y_wiggle
	)
	
func _get_enemy_team_spawn_position() -> Vector2:
	var random_y_wiggle = randf_range(
		-GameGlobals.VIEWPORT_HEIGHT / 8,
		GameGlobals.VIEWPORT_HEIGHT / 8
	)
	return Vector2(
		GameGlobals.VIEWPORT_WIDTH + 20, 
		GameGlobals.VIEWPORT_HEIGHT / 2 + random_y_wiggle
	)
