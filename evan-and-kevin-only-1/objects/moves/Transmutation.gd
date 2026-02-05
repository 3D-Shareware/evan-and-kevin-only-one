class_name TransmutationMove extends BaseMove

func _init() -> void:
	damage = 0
	action_speed = 130
	accuracy = 100
	element_id = elements["plague"]
	deals_damage = false
	kills_user = false
	move_name = "Transmutation"
	move_animation = "Grow"
	descr = "User transforms into a random creature with +2 levels."

func on_hit(user: BaseCreature, target: BaseCreature, battle_properties: Array, _talismans: Array) -> String:
	if battle_properties[user.team].size() > 0:
		for i in range(battle_properties[user.team].size() - 1, -1, -1):
			if !battle_properties[user.team][i].is_terrain:
				battle_properties[user.team].pop_at(i)
	var all_creatures = [BamboldCreature, BlubbitCreature, BrinotaurCreature, CaongCreature, DiamondflyCreature,
	FamaneCreature, FeyereCreature, FlamengoCreature, GardeanCreature, GouroborosCreature, IceopodCreature,
	JellfireCreature, KitsauroraCreature, PaladogCreature, PeepsicleCreature, QuakenCreature, ResentanaCreature,
	RockstrichCreature, ScubalusCreature, ShinosaurCreature, ShrikadeeCreature, SmeltynxCreature,
	SnowtankCreature, SturglockCreature, SuperNovaCreature, TimboarCreature, WatchearthCreature]
	var transformed_creature = all_creatures[randi_range(0, all_creatures.size() - 1)].new()
	user.get_parent().add_child(transformed_creature)
	transformed_creature.team = user.team
	if user.team:
		transformed_creature.sprite.flip_h = true
	if user.bound_talisman:
		user.bound_talisman.level += 2
		transformed_creature.bound_talisman = user.bound_talisman
		transformed_creature.level_up(transformed_creature.bound_talisman.level)
		transformed_creature.bound_talisman.play_talisman(transformed_creature, target, battle_properties)
	else:
		transformed_creature.level_up(user.level + 2)
	transformed_creature.position = user.position
	transformed_creature.animate_move("Grow")
	user.get_parent().clear_immune_ailments(transformed_creature)
	user.get_parent().teams[user.team].pop_at(0)
	user.get_parent().teams[user.team].push_front(transformed_creature)
	user.hide()
	return user.display_name + " turned into " + transformed_creature.display_name + "!"

func ai_priority(user: BaseCreature, _target: BaseCreature, _battle_properties: Array) -> int:
	if !user.armor and user.health <= 0.3 * user.max_health:
		return 6
	return 0
