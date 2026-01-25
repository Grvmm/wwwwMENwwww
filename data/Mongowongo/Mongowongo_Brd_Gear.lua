function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant','AoE')
    state.IdleMode:options('Normal','NoRefresh','DT')
	state.Weapons:options('None','Aeneas','DualWeapons','DualNaegling','DualTauret','DualNukeWeapons')

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
	
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
	sets.weapons.Aeneas = {main="Aeneas",sub="Genmei Shield"}
	sets.weapons.DualWeapons = {main={ name="Blurred harp +1", augments={'Path: A',}},sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}}
	sets.weapons.DualNaegling = {main="Naegling",sub="Blurred Knife +1"}
	sets.weapons.DualTauret = {main="Tauret",sub="Blurred Knife +1"}
	sets.weapons.DualNukeWeapons = {main="Malevolence",sub="Malevolence"}

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	-- TODO: Update with actual FC gear, I did midcast by mistake here
	sets.precast.FC = {
		main={ name="Kali", augments={'Mag Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		range={ name="Linos", augments={'HP+20','Mag. Evasion+15','"Fast Cast"+6%',}},
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body="Inyanga Jubbah +2",
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Song spellcasting time -5%',}},
		legs="Doyen Pants",
		feet="Vanya Clogs",
		neck="Baetyl Pendant",
		waist="Embla Sash",
		left_ear="Crep. Earring",
		right_ear="Etiolation Earring",
		left_ring="Menelaus's Ring",
		right_ring="Haoma's Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
    }
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body={ name="Kaykaus Bliaut +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc+20',}},
	})
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})
	sets.precast.FC.BardSong = {
		main={ name="Kali", augments={'Mag Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		range={ name="Linos", augments={'HP+20','Mag. Evasion+15','"Fast Cast"+6%',}},
		head="Fili Calot +2",
		body="Inyanga Jubbah +2",
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Song spellcasting time -5%',}},
		legs="Aya. Cosciales +2",
		feet={ name="Telchine Pigaches", augments={'Song spellcasting time -7%',}},
		neck="Aoidos' Matinee",
		waist="Embla Sash",
		left_ear="Halasz Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
	}
	-- TODO: Update with CHA gear
	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Blurred harp +1"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Blurred harp +1"})
	-- TODO: Update DW or Shield based on class using elseif
	sets.precast.FC.Lullaby =  {
		main={ name="Blurred harp +1", augments={'Path: A',}},
		sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
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
		left_ring="Stikini Ring +1",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	sets.precast.FC.Lullaby.Resistant = set_combine(sets.precast.Lullaby, {range="Blurred harp +1"})
	sets.precast.FC['Horde Lullaby'] = set_combine(sets.precast.Lullaby, {range="Daurdabla"})
	sets.precast.FC['Horde Lullaby'].Resistant = set_combine(sets.precast.Lullaby, {range="Blurred harp +1"})
	sets.precast.FC['Horde Lullaby'].AoE = set_combine(sets.precast.Lullaby, {range="Daurdabla"})
	sets.precast.FC['Horde Lullaby II'] = set_combine(sets.precast.Lullaby, {
		main={ name="Blurred harp +1", augments={'Path: A',}},
		sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}, -- Change Aug to String skill if needed
		range="Daurdabla",
		head="Fili Calot +2", -- Replace with Brioso Roundlet +3 When I get them for string skill
		feet="Brioso Slippers +3", -- Replace with Bihu slippers +3 when I get them for string skill
		waist="Embla Sash", -- Replace with Harfner's Stash when I get them for string skill
		right_ear="Enchntr. Earring +1",  -- Replace with gersemi Earring when I get them for string skill
	})

	sets.precast.FC['Horde Lullaby II'].Resistant = set_combine(sets.precast.Lullaby, {
		range="Blurred harp +1",
	})
	sets.precast.FC['Horde Lullaby II'].AoE = set_combine(sets.precast.Lullaby, {
		main={ name="Blurred harp +1", augments={'Path: A',}},
		sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}, -- Change Aug to String skill if needed
		range="Daurdabla",
		head="Fili Calot +2", -- Replace with Brioso Roundlet +3 When I get them for string skill
		feet="Brioso Slippers +3", -- Replace with Bihu slippers +3 when I get them for string skill
		waist="Embla Sash", -- Replace with Harfner's Stash when I get them for string skill
		right_ear="Enchntr. Earring +1",  -- Replace with gersemi Earring when I get them for string skill
	})
	-- Don't want to have Mazurka Last too long unless specifically wanted	
	-- sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Miracle Cheer"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	--- SongPlaceholder Gear, idk why it's like this
	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
	
	-- Precast sets to enhance JAs
	
    sets.precast.JA.Nightingale = {feet="Bihu Slippers +2"}
    sets.precast.JA.Troubadour = {body="Bihu Jstcorps."}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions"}

	-- Waltz set (chr and vit) TODO: Set these
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		range={ name="Linos", augments={'Evasion+15','Weapon skill damage +3%','STR+8',}},
		head={ name="Chironic Hat", augments={'Mag. Acc.+21','Weapon skill damage +3%','Accuracy+10 Attack+10','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		body="Bihu Jstcorps. +2",
		hands={ name="Chironic Gloves", augments={'Attack+5','Weapon skill damage +2%','Accuracy+11 Attack+11',}},
		legs={ name="Chironic Hose", augments={'STR+5','INT+4','Weapon skill damage +4%','Accuracy+19 Attack+19','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		feet={ name="Chironic Slippers", augments={'Weapon skill damage +3%','Pet: Attack+2 Pet: Rng.Atk.+2',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Caudata Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	sets.precast.WS['Mordant Rime'] ={
		range={ name="Linos", augments={'Evasion+15','Weapon skill damage +3%','STR+8',}},
		head={ name="Chironic Hat", augments={'Mag. Acc.+21','Weapon skill damage +3%','Accuracy+10 Attack+10','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		body="Bihu Jstcorps. +2",
		hands={ name="Chironic Gloves", augments={'Attack+5','Weapon skill damage +2%','Accuracy+11 Attack+11',}},
		legs={ name="Chironic Hose", augments={'STR+5','INT+4','Weapon skill damage +4%','Accuracy+19 Attack+19','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		feet={ name="Chironic Slippers", augments={'Weapon skill damage +3%','Pet: Attack+2 Pet: Rng.Atk.+2',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Caudata Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	sets.precast.WS['Rudra\'s Storm'] = {
		range={ name="Linos", augments={'Evasion+15','Weapon skill damage +3%','STR+8',}},
		head={ name="Chironic Hat", augments={'Mag. Acc.+21','Weapon skill damage +3%','Accuracy+10 Attack+10','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		body="Bihu Jstcorps. +2",
		hands={ name="Chironic Gloves", augments={'Attack+5','Weapon skill damage +2%','Accuracy+11 Attack+11',}},
		legs={ name="Chironic Hose", augments={'STR+5','INT+4','Weapon skill damage +4%','Accuracy+19 Attack+19','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		feet={ name="Chironic Slippers", augments={'Weapon skill damage +3%','Pet: Attack+2 Pet: Rng.Atk.+2',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Caudata Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	sets.precast.WS['Savage Blade'] ={
		range={ name="Linos", augments={'Evasion+15','Weapon skill damage +3%','STR+8',}},
		head={ name="Chironic Hat", augments={'Mag. Acc.+21','Weapon skill damage +3%','Accuracy+10 Attack+10','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		body="Bihu Jstcorps. +2",
		hands={ name="Chironic Gloves", augments={'Attack+5','Weapon skill damage +2%','Accuracy+11 Attack+11',}},
		legs={ name="Chironic Hose", augments={'STR+5','INT+4','Weapon skill damage +4%','Accuracy+19 Attack+19','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		feet={ name="Chironic Slippers", augments={'Weapon skill damage +3%','Pet: Attack+2 Pet: Rng.Atk.+2',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Caudata Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	-- TODO: Test these, Need to understand when and if it uses/swaps Moonshade and how to set it to only use if it's useful
	sets.MaxTP = {left_ear="Ishvara Earring",right_ear="Telos Earring",}
	sets.AccMaxTP = {left_ear="Mache Earring +1",right_ear="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {legs="Fili Rhingrave +2",range="Gjallarhorn"} 
    sets.midcast.Lullaby = {
		main={ name="Kali", augments={'Mag Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		range="Daurdabla",
		head="Fili Calot +2",
		body="Brioso Justau. +2",
		hands="Brioso Cuffs +2",
		legs="Fili Rhingrave",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Halasz Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
	}
	sets.midcast.Lullaby.Resistant = set_combine(sets.midcast.Lullaby, {range="Blurred harp +1",})
	sets.midcast['Horde Lullaby'] = set_combine(sets.midcast.Lullaby, {range="Daurdabla",})
	sets.midcast['Horde Lullaby'].Resistant = set_combine(sets.midcast.Lullaby, {range="Blurred harp +1",})
	sets.midcast['Horde Lullaby'].AoE = set_combine(sets.midcast.Lullaby, {range="Daurdabla",})
	sets.midcast['Horde Lullaby II'] = set_combine(sets.midcast.Lullaby, {
		main={ name="Blurred harp +1", augments={'Path: A',}},
		sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}, -- Change Aug to String skill if needed
		range="Daurdabla",
		head="Fili Calot +2", -- Replace with Brioso Roundlet +3 When I get them for string skill
		feet="Brioso Slippers +3", -- Replace with Bihu slippers +3 when I get them for string skill
		waist="Embla Sash", -- Replace with Harfner's Stash when I get them for string skill
		right_ear="Enchntr. Earring +1",  -- Replace with gersemi Earring when I get them for string skill
	})
	sets.midcast['Horde Lullaby II'].Resistant = set_combine(sets.midcast.Lullaby, {range="Blurred harp +1",})
	sets.midcast['Horde Lullaby II'].AoE = set_combine(sets.midcast.Lullaby, {
		main={ name="Blurred harp +1", augments={'Path: A',}},
		sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}, -- Change Aug to String skill if needed
		range="Daurdabla",
		head="Fili Calot +2", -- Replace with Brioso Roundlet +3 When I get them for string skill
		feet="Brioso Slippers +3", -- Replace with Bihu slippers +3 when I get them for string skill
		waist="Embla Sash", -- Replace with Harfner's Stash when I get them for string skill
		right_ear="Enchntr. Earring +1",  -- Replace with gersemi Earring when I get them for string skill
	})
    sets.midcast.Elegy = {range="Gjallarhorn"}
    sets.midcast.Requiem = {range="Gjallarhorn"}
    sets.midcast.Madrigal = {head="Fili Calot +2",range="Gjallarhorn"}
    sets.midcast.March = {hands="Fili Manchettes +2",range="Gjallarhorn"}
    sets.midcast.Minne = {legs="Mou. Seraweels +1",range="Gjallarhorn"}
    sets.midcast.Minuet = {body="Brioso Justau. +2",range="Gjallarhorn"}
	-- I'm using this for dummy songs instead of the stupid mode as you'll never use a paeon for real
    sets.midcast.Paeon = {
		range="Daurdabla",
		main="Barawc",
		sub="Culminus"
	}
    sets.midcast.Mambo = {feet="Mou. Crackows",range="Gjallarhorn"}
    sets.midcast.Threnody = set_combine(sets.midcast.SongEffect,{
		body="Mousai Manteel +1",range="Gjallarhorn"
	})
	
	
    sets.midcast['Adventurer\'s Dirge'] = {range="Gjallarhorn",}
    sets.midcast['Foe Sirvente'] = {range="Gjallarhorn"}
    sets.midcast['Magic Finale'] = {legs="Fili Rhingrave",range="Gjallarhorn"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +2"}
    sets.midcast["Aria of Passion"] = {range="Loughnashade"}
	sets.midcast['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	-- Don't want to have Mazurka Last too long unless specifically wanted	
	-- sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Miracle Cheer"})	

	-- For song buffs (duration and AF3 set bonus)
	-- IDK what this is so I'm treating it as all non-enfeebling songs default just in case
	sets.midcast.SongEffect = {
		main={ name="Kali", augments={'Mag Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		head="Fili Calot +2",
		body="Brioso Justau. +2",
		hands="Fili Manchettes +2",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +1",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Halasz Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
	}
	sets.midcast.SongEffect.DW = {main={ name="Blurred harp +1", augments={'Path: A',}},sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}}

	-- For song defbuffs
	-- Stack Cha then Magic Acc
	sets.midcast.SongDebuff = {
		main={ name="Kali", augments={'Mag Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		head="Fili Calot +2",
		body="Brioso Justau. +2",
		hands="Fili Manchettes +2",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Halasz Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
	}
	sets.midcast.SongDebuff.DW = {main={ name="Blurred harp +1", augments={'Path: A',}},sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = set_combine(sets.midcast.SongDebuff, {legs="Brioso Cannions +3"})
	sets.midcast.SongDebuff.DW = {main={ name="Blurred harp +1", augments={'Path: A',}},sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}}

	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}
	-- Song-specific recast reduction to help with overwriting by using bad gear on purpose
	sets.midcast.SongRecast = {}
	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite by putting bad gear in on purpose
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	-- TODO: Repalce this with a actual staff you own, also just get healing gear
	sets.midcast.Cure = {
		main={ name="Kali", augments={'Mag Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body={ name="Kaykaus Bliaut +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc+20',}},
		legs="Gyve Trousers",
		feet="Vanya Clogs",
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Crep. Earring",
		right_ear="Etiolation Earring",
		left_ring="Menelaus's Ring",
		right_ring="Haoma's Ring",
		back="Solemnity Cape",
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
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
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
	sets.resting = {main="Chatoyant Staff",sub="Oneiros Grip",ammo="Staunch Tathlum +1",
		head=empty,neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Ethereal Earring",
		body="Respite Cloak",hands=gear.chironic_refresh_hands,left_ring="Defending Ring",right_ring="Dark Ring",
		back="Umbra Cape",waist="Flume Belt +1",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}
	
	sets.idle = {
		head="Fili Calot +2",
		body="Ashera Harness",
		hands="Fili Manchettes +2",
		legs="Fili Rhingrave",
		feet="Aoidos' Cothrn. +1",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Infused Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
	}
	--sets.idle.NoRefresh = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
	--	head="Aya. Zucchetto +2",neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Sanare Earring",
	--	body="Ayanmo Corazza +2",hands="Volte Gloves",left_ring="Defending Ring",right_ring="Shadow Ring",
	--	back="Moonlight Cape",waist="Carrier's Sash",legs="Aya. Cosciales +2",feet="Fili Cothurnes +1"}

	sets.idle.DT = {
		main={ name="Nibiru Knife", augments={'Accuracy+20','Attack+15','Evasion+20',}},
		sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','"Cure" spellcasting time -6%','MP+25',}},
		range={ name="Linos", augments={'Evasion+15','Phys. dmg. taken -4%','AGI+8',}},
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Raetic Bangles",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Nyame Sollerets",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Svelt. Gouriz +1",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Intarabus's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Evasion+15',}},
	}

	-- Defense sets
	sets.defense.PDT = {
		main={ name="Nibiru Knife", augments={'Accuracy+20','Attack+15','Evasion+20',}},
		sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','"Cure" spellcasting time -6%','MP+25',}},
		range={ name="Linos", augments={'Evasion+15','Phys. dmg. taken -4%','AGI+8',}},
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Raetic Bangles",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Nyame Sollerets",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Svelt. Gouriz +1",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Intarabus's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Evasion+15',}},
	}
	sets.defense.MDT = {
		main={ name="Nibiru Knife", augments={'Accuracy+20','Attack+15','Evasion+20',}},
		sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','"Cure" spellcasting time -6%','MP+25',}},
		range={ name="Linos", augments={'Evasion+15','Phys. dmg. taken -4%','AGI+8',}},
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Raetic Bangles",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Nyame Sollerets",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Svelt. Gouriz +1",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back={ name="Intarabus's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Evasion+15',}},
	}

	sets.Kiting = {feet="Fili Cothurnes +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	-- TODO: Check how to manage gear based on TP and HASTE levels, EX: Max store TP until 1k unless AM3 is down then until 3k and swap to White after 1k
	
	sets.engaged = {
		main="Naegling",
		sub="Fusetto +2",
		range={ name="Linos", augments={'Evasion+15','Weapon skill damage +3%','STR+8',}},
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Moonlight Ring",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},
	}
	sets.engaged.Acc = {
		main="Naegling",
		sub="Fusetto +2",
		range={ name="Linos", augments={'Evasion+15','Weapon skill damage +3%','STR+8',}},
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Moonlight Ring",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},
	}
	sets.engaged.DW = {
		main="Naegling",
		sub="Fusetto +2",
		range={ name="Linos", augments={'Evasion+15','Weapon skill damage +3%','STR+8',}},
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Moonlight Ring",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},
	}
	sets.engaged.DW.Acc = {
		main="Naegling",
		sub="Fusetto +2",
		range={ name="Linos", augments={'Evasion+15','Weapon skill damage +3%','STR+8',}},
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Moonlight Ring",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},
	}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(2, 1)
end