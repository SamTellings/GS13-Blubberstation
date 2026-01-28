/mob/living/carbon/human/species/mammal/mootant
	race = /datum/species/mammal/mootant

/datum/species/mammal/mootant //WIP species
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
	mutant_bodyparts = list("mcolor" = "FFFFFF","mcolor2" = "FFFFFF","mcolor3" = "FFFFFF", "mam_snouts" = "Mootant ALT (Tertiary)", "mam_tail" = "Mootant", "mam_ears" = "Mootant ALT (Tertiary)", "deco_wings" = "None",
							"mam_body_markings" = list(), "taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")
	meat = /obj/item/food/meat/slab/human
	/* So species are a bit different now it seems...
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,HAIR,HORNCOLOR,WINGCOLOR,HAS_FLESH,HAS_BONE)
	inherent_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_VORACIOUS, TRAIT_LIPOLICIDE_TOLERANCE, TRAIT_PACIFISM, TRAIT_MILKY, TRAIT_HEAT) //chunky fingers because hooves!
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BEAST
	mutant_bodyparts = list("mcolor" = "FFFFFF","mcolor2" = "FFFFFF","mcolor3" = "FFFFFF", "mam_snouts" = "Mootant ALT (Tertiary)", "mam_tail" = "Mootant", "mam_ears" = "Mootant ALT (Tertiary)", "deco_wings" = "None",
							"mam_body_markings" = list(), "taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")
	attack_verb = "claw"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/food/meat/slab/human/mutant/mammal
	// mutant_organs = list(/obj/item/organ/genital/breasts) //moo
	liked_food = FRIED | DAIRY
	disliked_food = TOXIC | MEAT

	tail_type = "mam_tail"
	wagging_type = "mam_waggingtail"
	species_category = SPECIES_CATEGORY_FURRY

	allowed_limb_ids = list("mammal","aquatic","avian")*/


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
	race = /datum/species/mammal/mootant
	mutationtexts = list( "I want to be a good cow..." = MUT_MSG_IMMEDIATE)
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

	if(victim.dna.species.type == /datum/species/mammal/mootant)
		to_chat(victim, span_warning("It seems like [victim] resisted the effects of the mutation toxin."))
		victim.reagents.del_reagent(type)
		return FALSE

	switch(current_cycle)
		if(1 to 4)
			if(prob(10))
				victim.visible_message("<span class='warning'>[victim]'s features start to subtly shift!</span>", "<span class='danger'>You feel yourself to become more placid!</span>")
		if(5)
			if(victim.dna.features[FEATURE_SNOUT] == "None" )
				victim.visible_message("<span class='warning'>[victim]'s nose slowly starts to morph into a cow's snout!</span>", "<span class='danger'>You feel your nose grow and stretch into a snout!</span>")
			else
				victim.visible_message("<span class='warning'>[victim]'s snout slowly starts to morph into a cow's snout!</span>", "<span class='danger'>You feel your snout morph and stretch into a short stubby snout!</span>")
			victim.dna.features[FEATURE_SNOUT] = "Mootant ALT (Tertiary)"
			victim.update_body()
		if(6 to 9)
			if(prob(10))
				victim.visible_message("<span class='warning'>[victim]'s chest slowly starts undulating!</span>", "<span class='danger'>You feel a warm tingly feeling spread over your chest!</span>")
		if(10)
			victim.visible_message("<span class='warning'>[victim]'s chest slowly starts expanding!</span>", "<span class='danger'>You feel your chest surge out as a feeling of tightness overwhelms you!</span>")
			victim.try_lewd_autoemote("moan")
			victim.reagents.add_reagent(/datum/reagent/drug/aphrodisiac/succubus_milk, 19) //instead of adding breasts as a mutant organ, let's just make them grow some
			playsound(victim.loc, 'modular_gs/sound/effects/inflation/creaking/Creak3.ogg', 45, 1, 1, 1.2, ignore_walls = FALSE)
		if(11 to 14)
			if(prob(10))
				victim.visible_message("<span class='warning'>[victim]'s stomach gurgles loudly!</span>", "<span class='danger'>You feel your thoughts dull as all you can think about is grazing...</span>")
		if(15)
			victim.visible_message("<span class='warning'>[victim]'s body starts rapidly swelling with newfound plush!</span>", "<span class='danger'>You feel yourself getting heavier as your body expands with newfound flab!</span>")
			victim.try_lewd_autoemote("gurgle")
			victim.adjust_fatness(400, FATTENING_TYPE_CHEM)
		if(17)
			victim.visible_message("<span class='warning'>[victim]'s breasts start to leak small droplets of milk!</span>", "<span class='danger'>You feel a fullness in your breasts.</span>")
			victim.dna.features["breasts_lactation"] = TRUE
			victim.dna.features["breast_produce"] = /datum/reagent/consumable/milk
			victim.update_body()
		if(18)
			victim.visible_message("<span class='warning'>[victim]'s hands turn into hooves!</span>", "<span class='danger'>You feel your hands change and become less agile</span>")
		if(20)
			victim.visible_message("<span class='warning'>[victim]'s ears turn large and floppy like a cow's!</span>", "<span class='danger'>You feel your ears change, but it doesn't seem to bother you too much...</span>")
			victim.dna.features[FEATURE_SNOUT] = "Mootant ALT (Tertiary)"
			victim.update_body()
		if(21 to 24)
			if(prob(10))
				victim.visible_message("<span class='warning'>You see something growing on [victim]'s lower back!</span>", "<span class='danger'>I NEED to be a good cow...</span>")
		if(25 to INFINITY)
			victim.visible_message("<span class='warning'>[victim] sprouts a cow tail!</span>", "<span class='danger'>I just want to graze! I need to get milked! Mooooooo!</span>")
			victim.dna.features[FEATURE_TAIL] = "Mootant"
			victim.try_lewd_autoemote("moo")
			victim.update_body()
			var/species_type = /datum/species/mammal/mootant
			victim.set_species(species_type)
			victim.reagents.del_reagent(type)
			to_chat(victim, mutationtexts)
	return
