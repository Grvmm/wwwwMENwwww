function user_job_setup()

	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant','AoE')
    state.IdleMode:options('Normal','NoRefresh','DT')
	state.Weapons:options('None','Aeneas','DualWeapons','DualNaegling','DualTauret','DualNukeWeapons')

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Miracle Cheer'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 0
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')

	select_default_macro_book()

end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Aeneas = {
		main="Naegling",
		sub="Culminus",
	}
	sets.weapons.DualWeapons = {main={ name="Carnwenhan", augments={'Path: A',}},sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}}
	sets.weapons.DualNaegling = {
		main="Naegling",
		sub="Centovente",
	}
	sets.weapons.DualTauret = {main={ name="Carnwenhan", augments={'Path: A',}},sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}}
	sets.weapons.DualNukeWeapons = {main={ name="Carnwenhan", augments={'Path: A',}},sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}}

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	-- TODO: Update with actual FC gear, also weapons don't seem to change
	sets.precast.FC = {
		main={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}, -- { name="Nibiru Knife", augments={'MP+50','Mag. Evasion+20','"Fast Cast"+5',}},
		sub="Ammurapi Shield",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body="Zendik Robe",
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Song spellcasting time -5%',}},
		legs="Aya. Cosciales +2",
		feet="Navon Crackows",
		neck="Rep. Plat. Medal",
		waist="Embla Sash",
		left_ear="Halasz Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		head="Kaykaus Mitra +1", 
		body="Kaykaus Bliaut +1",
  		hands="Kaykaus Cuffs +1",
		legs="Gyve Trousers",
  		feet="Kaykaus Boots +1",
    	neck="Deviant Necklace",
 		waist="Luminary Sash",
	    right_ear="Mendi. Earring",
	    left_ring="Defending Ring",
		right_ring="Kishar Ring",
	})
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})
	sets.precast.FC.BardSong = {
		main={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
		sub="Ammurapi Shield",
		head="Fili Calot +2",
		body="Zendik Robe",
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Song spellcasting time -5%',}},
		legs="Aya. Cosciales +2",
		feet={ name="Telchine Pigaches", augments={'Song spellcasting time -7%',}},
		neck="Aoidos' Matinee",
		waist="Embla Sash",
		left_ear="Halasz Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	-- TODO: Update with CHA gear
	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	-- TODO: Update DW or Shield based on class using elseif
	sets.precast.FC.Lullaby =  {
		main={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
		sub="Ammurapi Shield",
		range="Blurred harp +1",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}, -- Replace with Brioso Roundlet +3 When I get them for magic Acc, also see if this or "Fili Calot +2" is better
		body="Fili Hongreline +2",
		hands="Brioso Cuffs +3",
		legs="Fili Rhingrave +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Embla Sash", 
		left_ear="Halasz Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Defending Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	sets.precast.FC.Lullaby.Resistant = set_combine(sets.precast.Lullaby, {range="Gjallarhorn"})
	sets.precast.FC['Horde Lullaby'] = set_combine(sets.precast.Lullaby, {range="Daurdabla"})
	sets.precast.FC['Horde Lullaby'].Resistant = set_combine(sets.precast.Lullaby, {range="Gjallarhorn"})
	sets.precast.FC['Horde Lullaby'].AoE = set_combine(sets.precast.Lullaby, {range="Daurdabla"})
	sets.precast.FC['Horde Lullaby II'] = set_combine(sets.precast.Lullaby, {
		main={ name="Carnwenhan", augments={'Path: A',}},
		range="Daurdabla",
		head="Fili Calot +2", -- Replace with Brioso Roundlet +3 When I get them for string skill
		feet="Brioso Slippers +3", -- Replace with Bihu slippers +3 when I get them for string skill
		waist="Embla Sash", -- Replace with Harfner's Stash when I get them for string skill
		right_ear="Enchntr. Earring +1",  -- Replace with gersemi Earring when I get them for string skill
	})

	sets.precast.FC['Horde Lullaby II'].Resistant = set_combine(sets.precast.Lullaby, {
		range="Gjallarhorn",
	})
	sets.precast.FC['Horde Lullaby II'].AoE = set_combine(sets.precast.Lullaby, {
		main={ name="Carnwenhan", augments={'Path: A',}},
		range="Daurdabla",
		head="Fili Calot +2", -- Replace with Brioso Roundlet +3 When I get them for string skill
		feet="Brioso Slippers +3", -- Replace with Bihu slippers +3 when I get them for string skill
		waist="Embla Sash", -- Replace with Harfner's Stash when I get them for string skill
		right_ear="Enchntr. Earring +1",  -- Replace with gersemi Earring when I get them for string skill
	})
	-- Don't want to have Mazurka Last too long unless specifically wanted	
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{
		feet="Fili Cothurnes +2",
	})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	--- SongPlaceholder Gear, idk why it's like this
	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	
	-- Precast sets to enhance JAs
	
    sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
    sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +3"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

	-- Waltz set (chr and vit) TODO: Set these
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		range={ name="Linos", augments={'Attack+15','Weapon skill damage +3%','STR+6 DEX+6',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	sets.precast.WS['Mordant Rime'] ={
		main={ name="Carnwenhan", augments={'Path: A',}},
		range={ name="Linos", augments={'Attack+15','Weapon skill damage +3%','STR+6 DEX+6',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Artful Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	sets.precast.WS['Rudra\'s Storm'] = {
		main={ name="Twashar", augments={'Path: A',}},
		range={ name="Linos", augments={'Attack+15','Weapon skill damage +3%','STR+6 DEX+6',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Kentarch Belt +1",
		left_ear="Domin. Earring +1",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cornelia's Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	sets.precast.WS['Savage Blade'] ={
		main="Naegling",
		range={ name="Linos", augments={'Attack+15','Weapon skill damage +3%','STR+6 DEX+6',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Cornelia's Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	-- Swap to these on Moonshade using WS if less than 2k TP
	sets.MaxTP = {
		left_ear="Ishvara Earring",
		right_ear="Telos Earring",
	}
	sets.AccMaxTP = {left_ear="Mache Earring +1",right_ear="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times. No clue what this is for
	sets.midcast.FastRecast = {}

	-- Gear to enhance certain classes of songs	-- I'm using this for dummy songs instead of the stupid mode as you'll never use a paeon for real
    sets.midcast.Paeon = {
		range="Daurdabla",
		main="Barfawc",
		sub="Culminus"
	}
	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
		main={ name="Carnwenhan", augments={'Path: A',}},
		sub=gear.subclass,
		head="Fili Calot +2",
		body="Fili Hongreline +2",
		hands="Fili Manchettes +2",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Halasz Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	-- For song defbuffs
	-- Stack Cha then Magic Accuracy
	sets.midcast.SongDebuff = {
		main={ name="Carnwenhan", augments={'Path: A',}},
		sub=gear.subclass,
		head="Fili Calot +2", -- Briso Roundlet +3 when I get them
		body="Fili Hongreline +2",
		hands="Fili Manchettes +2",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Enchntr. Earring +1",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	sets.midcast.SongDebuff.DW = {}
	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = set_combine(sets.midcast.SongDebuff, {legs="Brioso Cannions +3"})
	sets.midcast.SongDebuff.DW = {}
    sets.midcast.Lullaby = {
		main={ name="Carnwenhan", augments={'Path: A',}},
		sub=gear.subclass,
		range="Gjallarhorn", 
    	head="Fili Calot +2",
		body="Fili Hongreline +2",
		hands="Brioso Cuffs +3", -- TODO: look at either of these are better { name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Song spellcasting time -5%',}},
    	legs="Fili Rhingrave +2",
		feet="Brioso Slippers +3",
    	neck="Mnbw. Whistle +1",
    	waist="Luminary Sash",
		left_ear="Halasz Earring",
    	right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	sets.midcast.Lullaby.Resistant = set_combine(sets.midcast.Lullaby, {range="Gjallarhorn",})
	sets.midcast['Horde Lullaby'] = set_combine(sets.midcast.Lullaby, {range="Daurdabla",})
	sets.midcast['Horde Lullaby'].Resistant = set_combine(sets.midcast.Lullaby, {range="Gjallarhorn",})
	sets.midcast['Horde Lullaby'].AoE = set_combine(sets.midcast.Lullaby, {range="Daurdabla",})
	sets.midcast['Horde Lullaby II'] = set_combine(sets.midcast.Lullaby, {
		main={ name="Carnwenhan", augments={'Path: A',}},
		range="Daurdabla",
		head="Fili Calot +2", -- Replace with Brioso Roundlet +3 When I get them for string skill
		feet="Brioso Slippers +3", -- Replace with Bihu slippers +3 when I get them for string skill
		waist="Embla Sash", -- Replace with Harfner's Stash when I get them for string skill
		right_ear="Enchntr. Earring +1",  -- Replace with gersemi Earring when I get them for string skill
	})
	sets.midcast['Horde Lullaby II'].Resistant = set_combine(sets.midcast.Lullaby, {range="Gjallarhorn",})
	sets.midcast['Horde Lullaby II'].AoE = set_combine(sets.midcast.Lullaby, {
		main={ name="Carnwenhan", augments={'Path: A',}},
		range="Daurdabla",
		head="Fili Calot +2", -- Replace with Brioso Roundlet +3 When I get them for string skill
		feet="Brioso Slippers +3", -- Replace with Bihu slippers +3 when I get them for string skill
		waist="Embla Sash", -- Replace with Harfner's Stash when I get them for string skill
		right_ear="Enchntr. Earring +1",  -- Replace with gersemi Earring when I get them for string skill
	})
    sets.midcast.Elegy = {range="Gjallarhorn"}
	sets.midcast.Ballad = {legs="Fili Rhingrave +2",range="Gjallarhorn"}
    sets.midcast.Requiem = {range="Gjallarhorn"}
    sets.midcast.Madrigal = {head="Fili Calot +2",range="Gjallarhorn"}
    sets.midcast.March = {hands="Fili Manchettes +2",range="Gjallarhorn"}
    sets.midcast.Minne = {legs="Mou. Seraweels +1",range="Gjallarhorn"}
    sets.midcast.Minuet = {body="Fili Hongreline +2",range="Gjallarhorn"}
    sets.midcast.Mambo = {feet="Mou. Crackows",range="Gjallarhorn"}
    sets.midcast.Threnody = {body="Mousai Manteel +1",range="Gjallarhorn"}
    sets.midcast['Adventurer\'s Dirge'] = {range="Gjallarhorn",}
    sets.midcast['Foe Sirvente'] = {range="Gjallarhorn"}
    sets.midcast['Magic Finale'] = set_combine(sets.midcast.SongDebuff,{legs="Fili Rhingrave +2",range="Gjallarhorn"})
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +2"}
    sets.midcast["Aria of Passion"] = {range="Loughnashade"}
	sets.midcast['Honor March'] = {range="Marsyas"}
	-- Don't want to have Mazurka Last too long unless specifically wanted	
	-- sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Miracle Cheer"})	
	sets.midcast.SongEffect.DW = {}


	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}
	-- Song-specific recast reduction to help with overwriting by using bad gear on purpose
	sets.midcast.SongRecast = {}
	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite by putting bad gear in on purpose
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	-- TODO: Repalce this with a actual staff you own, also just get healing gear
	sets.midcast.Cure = {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Kaykaus Mitra +1",
		body="Kaykaus Bliaut +1",
		hands="Kaykaus Cuffs +1",
		legs="Gyve Trousers",
		feet="Kaykaus Boots +1",
		neck="Deviant Necklace",
		waist="Luminary Sash",
		left_ear="Mendi. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'"Cure" potency +10%',}},
	}
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast['Enhancing Magic'] = {
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}},
		hands={ name="Telchine Gloves", augments={'Song spellcasting time -7%','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Song spellcasting time -7%','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Song spellcasting time -7%','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Andoaa Earring",
		right_ear="Crep. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2"})
    sets.midcast.Haste = sets.midcast['Enhancing Magic']
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget", waist="Siegel Sash"})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {waist="Emphatikos Rope"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",right_ear="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	-- TODO: Need magic gear
	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		head="C. Palug Crown",neck="Sanctity Necklace",left_ear="Friomisi Earring",right_ear="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		head="C. Palug Crown",neck="Sanctity Necklace",left_ear="Friomisi Earring",right_ear="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",left_ring="Haoma's Ring",right_ring="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})
    sets.midcast['Enfeebling Magic'] = sets.midcast.SongDebuff
    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

	-- Resting sets
	--sets.resting = {main="Chatoyant Staff",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
	--	head=empty,neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Ethereal Earring",
	--	body="Respite Cloak",hands=gear.chironic_refresh_hands,left_ring="Defending Ring",right_ring="Dark Ring",
	--	back="Umbra Cape",waist="Flume Belt +1",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}
	
	sets.idle = {
		head="Fili Calot +2",
		body="Ashera Harness",
		hands="Fili Manchettes +2",
		legs="Fili Rhingrave +2",
		feet="Fili Cothurnes +2",
		neck="Elite Royal Collar",
		waist="Plat. Mog. Belt",
		left_ear="Telos Earring",
		right_ear="Infused Earring",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	--sets.idle.NoRefresh = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
	--	head="Aya. Zucchetto +2",neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Sanare Earring",
	--	body="Ayanmo Corazza +2",hands="Volte Gloves",left_ring="Defending Ring",right_ring="Shadow Ring",
	--	back="Moonlight Cape",waist="Carrier's Sash",legs="Aya. Cosciales +2",feet="Fili Cothurnes +1"}
	sets.idle.DT = {
		range={ name="Linos", augments={'Evasion+15','Phys. dmg. taken -4%','AGI+8',}},
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Raetic Bangles",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Fili Cothurnes +2",
		neck="Elite Royal Collar",
		waist="Plat. Mog. Belt",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Evasion+15',}},
	}

	-- Defense sets
	sets.defense.PDT = {
		-- main="Barfawc",
		range={ name="Linos", augments={'Evasion+15','Phys. dmg. taken -4%','AGI+8',}},
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Raetic Bangles",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Nyame Sollerets",
		neck="Elite Royal Collar",
		waist="Plat. Mog. Belt",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Intarabus's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Evasion+15',}},
	}
	sets.defense.MDT = {
		-- main="Barfawc",
		range={ name="Linos", augments={'Evasion+15','Phys. dmg. taken -4%','AGI+8',}},
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Raetic Bangles",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Nyame Sollerets",
		neck="Elite Royal Collar",
		waist="Plat. Mog. Belt",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Intarabus's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Evasion+15',}},
	}

	-- sets.Kiting = {right_ring="Warp Ring"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	--sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	-- TODO: Check how to manage gear based on TP and HASTE levels, EX: Max store TP until 1k unless AM3 is down then until 3k and swap to White after 1k
	
	sets.engaged = {
		main="Twashtar",
    	sub="Centovente",
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Ashera Harness",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Balder Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	sets.engaged.Acc = {
		main="Twashtar",
    	sub="Centovente",
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Ashera Harness",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Balder Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	sets.engaged.DW = {
		main="Twashtar",
    	sub="Centovente",
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Ashera Harness",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Balder Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	sets.engaged.DW.Acc = {
		main="Twashtar",
    	sub="Centovente",
		range={ name="Linos", augments={'Accuracy+15','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Ashera Harness",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Balder Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
end

-- Select default macro book on initial load or subjob change.
-- Select sub wepon based on subjob so I don't have to remember to hit a button to dual wield
function select_default_macro_book()
	-- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 2)
		gear.subclass = { name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}
    elseif player.sub_job == 'WHM' then
        set_macro_page(2, 1)
		gear.subclass = { name="Ammurapi Shield"} --{ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}} --{ name="Ammurapi Shield"}
    else
        set_macro_page(2, 2)
		gear.subclass = { name="Ammurapi Shield"} --{ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}} --{ name="Ammurapi Shield"}
    end
end