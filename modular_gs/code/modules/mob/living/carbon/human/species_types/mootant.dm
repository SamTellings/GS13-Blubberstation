#define MUT_MSG_IMMEDIATE 1
#define MUT_MSG_EXTENDED 2
#define MUT_MSG_ABOUT2TURN 3

/// the current_cycle threshold / iterations needed before one can transform
#define CYCLES_TO_TURN 20
/// the cycle at which 'immediate' mutation text begins displaying
#define CYCLES_MSG_IMMEDIATE 6
/// the cycle at which 'extended' mutation text begins displaying
#define CYCLES_MSG_EXTENDED 16

#define COWCOLOUR "#FFFFFF"

/mob/living/carbon/human/species/mammal/mootant
	race = /datum/species/mootant

/datum/species/mootant //WIP species
	name = "Mootant"
	id = SPECIES_MOOTANT
	inherent_traits = list(
		TRAIT_CHUNKYFINGERS,
		TRAIT_VORACIOUS,
		TRAIT_LIPOLICIDE_TOLERANCE,
		TRAIT_PACIFISM,
		TRAIT_MILKY,
		TRAIT_HEAT
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BEAST
	mutant_bodyparts = list()
	mutanttongue = /obj/item/organ/tongue/mootant
	mutanteyes = /obj/item/organ/eyes
	meat = /obj/item/food/meat/slab/human
	changesource_flags = MIRROR_BADMIN | WABBAJACK
	examine_limb_id = SPECIES_MAMMAL
	bodypart_overrides = list(
	BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant,
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant,
	BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant,
	BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant,
	BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant,
	BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant,
	)

	/* So species are a bit different now it seems... LEaving it here as a ref
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,HAIR,HORNCOLOR,WINGCOLOR,HAS_FLESH,HAS_BONE)
	inherent_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_VORACIOUS, TRAIT_LIPOLICIDE_TOLERANCE, TRAIT_PACIFISM, TRAIT_MILKY, TRAIT_HEAT) //chunky fingers because hooves!
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BEAST
	mutant_bodyparts = list("mcolor" = "FFFFFF","mcolor2" = "FFFFFF","mcolor3" = "FFFFFF", "mam_snouts" = "Mootant ALT (Tertiary)", "mam_tail" = "Mootant", "mam_ears" = "Mootant ALT (Tertiary)", "deco_wings" = "None",
							"mam_body_markings" = list(), "taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")
	--attack_verb = "claw"
	--attack_sound = 'sound/weapons/slash.ogg'
	--miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/food/meat/slab/human/mutant/mammal
	// mutant_organs = list(/obj/item/organ/genital/breasts) //moo
	--liked_food = FRIED | DAIRY
	--disliked_food = TOXIC | MEAT

	--tail_type = "mam_tail"
	--wagging_type = "mam_waggingtail"
	--species_category = SPECIES_CATEGORY_FURRY

	allowed_limb_ids = list("mammal","aquatic","avian")*/

/obj/item/organ/tongue/mootant
	liked_foodtypes = FRIED | DAIRY
	disliked_foodtypes = MEAT
	toxic_foodtypes = TOXIC

/datum/species/mootant/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Mootant", TRUE),
		"snout" = list("Mootant", TRUE),
		"ears" = list("Mootant", TRUE),
		"legs" = list("Digitigrade Legs", FALSE),
		"mcolor" = COWCOLOUR,
		"mcolor2" = COWCOLOUR,
		"mcolor3" = COWCOLOUR,
	)

//mootant body parts
//maws
/datum/sprite_accessory/snouts/mammal/mootant
	name = "Mootant"
	icon = 'modular_gs/icons/mob/markings/mam_snouts.dmi'
	icon_state = "mootant"

//ears
/datum/sprite_accessory/ears/mootant
	name = "Mootant"
	icon_state = "mootant"
	icon = 'modular_gs/icons/mob/markings/mam_ears.dmi'

/datum/sprite_accessory/ears/human/mootant
	name = "Mootant"
	icon_state = "mootant"
	icon = 'modular_gs/icons/mob/markings/mam_ears.dmi'

//tails
/datum/sprite_accessory/tails/human/mootant
	name = "Mootant"
	icon_state = "mootant"
	icon = 'modular_gs/icons/mob/markings/mam_tails.dmi'

/datum/sprite_accessory/tails/mammal/mootant
	name = "Mootant"
	icon_state = "mootant"
	icon = 'modular_gs/icons/mob/markings/mam_tails.dmi'

//mutation toxin
/datum/reagent/mutationtoxin/mootant
	name = "Mootant Mutation Toxin"
	description = "A milk-colored toxin."
	color = "#ffffff"
	race = /datum/species/mootant
	mutationtexts = list( "You feel yourself to become more placid!" = MUT_MSG_IMMEDIATE,
							"I want to be a good cow..." = MUT_MSG_EXTENDED,
							"Mooo!" = MUT_MSG_ABOUT2TURN)
	var/produced_chem = /datum/reagent/consumable/milk

/obj/item/reagent_containers/cup/beaker/mutationmootant //preset for toxin
	list_reagents = list(/datum/reagent/mutationtoxin/mootant = 50)

/obj/item/reagent_containers/applicator/pill/mutationmootant //preset for pill, used in a lavalad ruin
	name = "mootant pill"
	desc = "A strange toxin of some sorts, made for altering one's body into a weird cow-person hybrid."
	icon_state = "pill17"
	list_reagents = list(/datum/reagent/mutationtoxin/mootant = 30)

/datum/reagent/mutationtoxin/mootant/on_mob_life(mob/living/carbon/human/victim)
	..()

	if(!victim?.client?.prefs?.read_preference(/datum/preference/toggle/transformation))
		to_chat(victim, span_warning("It seems like [victim] resisted the effects of the mutation toxin."))
		victim.reagents.del_reagent(type)
		return FALSE

	if(victim.dna.species.type == /datum/species/mootant)
		victim.reagents.del_reagent(type)
		return FALSE

	/*switch(current_cycle)
		if(2)
			victim.visible_message("<span class='warning'>[victim]'s features start to subtly shift!</span>", "<span class='danger'>You feel yourself to become more placid!</span>")
		if(4)
			if(victim.dna.mutant_bodyparts[FEATURE_SNOUT] == "None" )
				victim.visible_message("<span class='warning'>[victim]'s nose slowly starts to morph into a cow's snout!</span>", "<span class='danger'>You feel your nose grow and stretch into a snout!</span>")
			else
				victim.visible_message("<span class='warning'>[victim]'s snout slowly starts to morph into a cow's snout!</span>", "<span class='danger'>You feel your snout morph and stretch into a short stubby snout!</span>")
			victim.dna.mutant_bodyparts[FEATURE_SNOUT] = list(MUTANT_INDEX_NAME = "Mootant", MUTANT_INDEX_COLOR_LIST = list(COWCOLOUR, COWCOLOUR, COWCOLOUR))
			victim.update_body(TRUE)
		if(6)
			victim.visible_message("<span class='warning'>[victim]'s chest slowly starts undulating!</span>", "<span class='danger'>You feel a warm tingly feeling spread over your chest!</span>")
		if(8)
			victim.visible_message("<span class='warning'>[victim]'s chest slowly starts expanding!</span>", "<span class='danger'>You feel your chest surge out as a feeling of tightness overwhelms you!</span>")
			victim.try_lewd_autoemote("moan")
			victim.reagents.add_reagent(/datum/reagent/drug/aphrodisiac/succubus_milk, 19) //instead of adding breasts as a mutant organ, let's just make them grow some
			playsound(victim.loc, 'modular_gs/sound/effects/inflation/creaking/Creak3.ogg', 45, 1, 1, 1.2, ignore_walls = FALSE)
		if(10)
			victim.visible_message("<span class='warning'>[victim]'s stomach gurgles loudly!</span>", "<span class='danger'>You feel your thoughts dull as all you can think about is grazing...</span>")
		if(12)
			victim.visible_message("<span class='warning'>[victim]'s body starts rapidly swelling with newfound plush!</span>", "<span class='danger'>You feel yourself getting heavier as your body expands with newfound flab!</span>")
			victim.try_lewd_autoemote("gurgle")
			victim.adjust_fatness(400, FATTENING_TYPE_CHEM)
		if(14)
			victim.visible_message("<span class='warning'>[victim]'s breasts start to leak small droplets of milk!</span>", "<span class='danger'>You feel a fullness in your breasts.</span>")
			victim.dna.features["breasts_lactation"] = TRUE
			victim.dna.features["breast_produce"] = /datum/reagent/consumable/milk
			victim.updateappearance(victim.updateappearance(TRUE,TRUE,TRUE))
		if(16)
			victim.visible_message("<span class='warning'>[victim]'s hands turn into hooves!</span>", "<span class='danger'>You feel your hands change and become less agile</span>")
		if(18)
			victim.visible_message("<span class='warning'>[victim]'s ears turn large and floppy like a cow's!</span>", "<span class='danger'>You feel your ears change, but it doesn't seem to bother you too much...</span>")
			victim.dna.mutant_bodyparts[FEATURE_EARS] = list(MUTANT_INDEX_NAME = "Mootant", MUTANT_INDEX_COLOR_LIST = list(COWCOLOUR, COWCOLOUR, COWCOLOUR))
			victim.updateappearance(victim.updateappearance(TRUE,TRUE,TRUE))
		if(19)
			victim.visible_message("<span class='warning'>[victim] sprouts a cow tail!</span>", "<span class='danger'>I just want to graze! I need to get milked! Mooooooo!</span>")
			victim.dna.mutant_bodyparts[FEATURE_TAIL] = list(MUTANT_INDEX_NAME = "Mootant", MUTANT_INDEX_COLOR_LIST = list(COWCOLOUR, COWCOLOUR, COWCOLOUR))
			victim.try_lewd_autoemote("moo")
			victim.updateappearance(victim.updateappearance(TRUE,TRUE,TRUE))*/

	victim.dna.mutant_bodyparts[FEATURE_TAIL_GENERIC] = list(MUTANT_INDEX_NAME = "Mootant", MUTANT_INDEX_COLOR_LIST = list(COWCOLOUR, COWCOLOUR, COWCOLOUR))
	victim.dna.mutant_bodyparts[FEATURE_SNOUT] = list(MUTANT_INDEX_NAME = "Mootant", MUTANT_INDEX_COLOR_LIST = list(COWCOLOUR, COWCOLOUR, COWCOLOUR))
	victim.dna.mutant_bodyparts[FEATURE_EARS] = list(MUTANT_INDEX_NAME = "Mootant", MUTANT_INDEX_COLOR_LIST = list(COWCOLOUR, COWCOLOUR, COWCOLOUR))
	victim.dna.species.regenerate_organs(victim, victim.dna.species)

	victim.set_species(/datum/species/mootant)

	return

#undef MUT_MSG_IMMEDIATE
#undef MUT_MSG_EXTENDED
#undef MUT_MSG_ABOUT2TURN

#undef CYCLES_TO_TURN
#undef CYCLES_MSG_IMMEDIATE
#undef CYCLES_MSG_EXTENDED
#undef COWCOLOUR
