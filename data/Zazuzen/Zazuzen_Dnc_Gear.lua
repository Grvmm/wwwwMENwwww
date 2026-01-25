-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','DTLite','PDT','MDT')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
	state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Aeneas','LowBuff')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWEarrings','DWMax'}

	
	gear.stp_jse_back = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.wsd_jse_back = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	


    -- Additional local binds
    send_command('bind @` gs c step')
	send_command('bind ^!@` gs c toggle usealtstep')
	send_command('bind ^@` gs c cycle mainstep')
	send_command('bind !@` gs c cycle altstep')
    send_command('bind ^` input /ja "Saber Dance" <me>')
    send_command('bind !` input /ja "Fan Dance" <me>')
	send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')
	send_command('bind !\\\\ input /ja "Spectral Jig" <me>')
	send_command('bind !backspace input /ja "Reverse Flourish" <me>')
	send_command('bind ^backspace input /ja "No Foot Rise" <me>')
	send_command('bind %~` gs c cycle SkillchainMode')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	
    -- Extra Melee sets.  Apply these on top of melee sets.
	-- sets.Suppa = {left_ear="Suppanomimi", right_ear="Sherida Earring"}
	-- sets.DWEarrings = {left_ear="Dudgeon Earring",right_ear="Heartseeker Earring"}
	-- sets.DWMax = {left_ear="Dudgeon Earring",right_ear="Heartseeker Earring",body="Adhemar Jacket +1",hands="Floral Gauntlets",waist="Shetal Stone"}
	
	-- Weapons sets
	sets.weapons.Aeneas = {
        main="Twashtar",
    	sub="Centovente",
    }
	sets.weapons.LowBuff = {
        main="Tauret",
    	sub="Centovente",
    }
	
    -- Precast Sets
    
    -- Precast sets to enhance JAs

    sets.precast.JA['No Foot Rise'] = {
        body="Horos Casaque +1",
    }

    sets.precast.JA['Trance'] = {} --head="Horos Tiara +1"
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
        head="Mummu Bonnet +2",neck="Unmoving Collar +1",left_ear="Enchntr. Earring +1",right_ear="Handler's Earring +1",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,left_ring="Defending Ring",right_ring="Valseur's Ring",
        back="Toetapper Mantle",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}
		
	sets.Self_Waltz = {head="Mummu Bonnet +2",body="Passion Jacket",left_ring="Asklepian Ring"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Samba = {back=gear.stp_jse_back} --head="Maxixi Tiara"

    sets.precast.Jig = {legs="Horos Tights +3"} -- feet="Maxixi Toe Shoes"

    sets.precast.Step = {ammo="C. Palug Stone",
        head="Dampening Tam",neck="Combatant's Torque",left_ear="Telos Earring",right_ear="Digni. Earring",
        body="Mummu Jacket +2",hands="Maculele bangles +3",left_ring="Ramuh Ring +1",right_ring="Ramuh Ring +1",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Meg. Chausses +2",feet="Malignance Boots"}
		
    sets.Enmity = {ammo="Paeapua",
        head="Genmei Kabuto",neck="Unmoving Collar +1",left_ear="Friomisi Earring",right_ear="Trux Earring",
        body="Emet Harness +1",hands="Malignance Gloves",left_ring="Petrov Ring",right_ring="Vengeful Ring",
        back="Solemnity Cape",waist="Goading Belt",legs=gear.herculean_dt_legs,feet="Malignance Boots"}
		
    sets.precast.JA.Provoke = sets.Enmity

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {ammo="C. Palug Stone",
        head="Dampening Tam",neck="Combatant's Torque",left_ear="Telos Earring",right_ear="Digni. Earring",
        body="Mummu Jacket +2",hands="Adhemar Wrist. +1",left_ring="Ramuh Ring +1",right_ring="Ramuh Ring +1",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Meg. Chausses +2",feet="Malignance Boots"}
		
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
		
    sets.precast.Flourish1['Desperate Flourish'] = {ammo="C. Palug Stone",
        head="Dampening Tam",neck="Combatant's Torque",left_ear="Telos Earring",right_ear="Digni. Earring",
        body="Mummu Jacket +2",hands="Adhemar Wrist. +1",left_ring="Ramuh Ring +1",right_ring="Ramuh Ring +1",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Meg. Chausses +2",feet="Malignance Boots"}

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {
        back="Toetapper Mantle",
        hands="Maculele bangles +3",
    }
    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body="Horos Casaque +3"}
    sets.precast.Flourish3['Climactic Flourish'] = {
        head="Maculele Tiara +3",
        hands="Maculele bangles +3",
        body="Horos Casaque +3"
    }

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",
		head=gear.herculean_fc_head,neck="Voltsurge Torque",left_ear="Enchntr. Earring +1",right_ear="Loquac. Earring",
		body="Dread Jupon",hands="Leyline Gloves",left_ring="Lebeche Ring",right_ring="Prolix Ring",
		legs="Rawhide Trousers"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
        neck={ name="Etoile Gorget +2", augments={'Path: A',}},
        -- Ears are probably also set by MaxTP sets below  (disabled since 1k slams are just more damage anyways)
        -- left_ear="Moonshade Earring",
        left_ear="Ishvara Earring",
        right_ear="Maculele Earring",
        body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        left_ring="Epaminondas's Ring",
        right_ring="Cornelia's Ring",
        back=gear.wsd_jse_back,
        waist="Sweordfaetels +1", -- "Grunfeld Rope",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}}
    }

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {
        ammo="Yamarang",
        left_ear="Telos Earring",
        waist="Eschan Stone",
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo="Yamarang",
        left_ear="Telos Earring",
        waist="Eschan Stone",
        legs="Maculele Tights +3",
        feet="Malignance Boots"
    })
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {
        ammo="Yamarang",
        left_ear="Telos Earring",
        body="Meg. Cuirie +2",
        waist="Eschan Stone",
        legs="Maculele Tights +3",
        feet="Malignance Boots",
        left_ring="Karieth Ring"
    })
	sets.precast.WS.Proc = set_combine(sets.precast.WS, {
        hands="Maculele bangles +3",
        legs="Maxixi Tights +3"
    })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",left_ear="Moonshade Earring",right_ear="Ishvara Earring",body=gear.herculean_wsd_body,legs=gear.herculean_wsd_legs})
    sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",left_ear="Moonshade Earring",body="Meg. Cuirie +2",legs=gear.herculean_wsd_legs})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {left_ear="Moonshade Earring",body="Meg. Cuirie +2"})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	
    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet +1",hands="Adhemar Wrist. +1",feet=gear.herculean_ta_feet})
    sets.precast.WS['Pyrrhic Kleos'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet +1",hands="Adhemar Wrist. +1",})
    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Pyrrhic Kleos'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Pyrrhic Kleos'].Fodder = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})

    sets.precast.WS['Aeolian Edge'] = {ammo="Seeth. Bomblet +1",
        head=gear.herculean_nuke_head,neck="Baetyl Pendant",left_ear="Friomisi Earring",right_ear="Crematio Earring",
        body="Samnuha Coat",hands="Leyline Gloves",left_ring="Metamor. Ring +1",right_ring="Shiva Ring +1",
        back=gear.wsd_jse_back,waist="Chaac Belt",legs=gear.herculean_wsd_legs,feet=gear.herculean_nuke_feet}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these instead of Moonshade if over 2k TP
	sets.MaxTP = {
        left_ear="Ishvara Earring",
        right_ear="Maculele Earring",
    }
	sets.AccMaxTP = {left_ear="Assuage Earring",right_ear="Telos Earring"}
	
    sets.Skillchain = set_combine(sets.precast.WS, {
        hands="Maculele bangles +3",
        legs="Maxixi Tights +3"
    })
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head=gear.herculean_fc_head,neck="Voltsurge Torque",left_ear="Enchntr. Earring +1",right_ear="Loquac. Earring",
        body="Dread Jupon",hands="Leyline Gloves",left_ring="Defending Ring",right_ring="Prolix Ring",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Rawhide Trousers",feet="Malignance Boots"}
        
    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    sets.ExtraRegen = {}
    

    -- Idle sets

	sets.idle = {
        head="Gleti's Mask",
        body="Malignance Tabard",
        hands="Gleti's Gauntlets",
        legs="Gleti's Breeches",
        feet="Gleti's Boots",
		neck="Elite Royal Collar",
		waist="Plat. Mog. Belt",
		left_ear="Telos Earring",
		right_ear="Infused Earring",
        left_ring="Moonlight Ring",
        right_ring="Moonlight Ring",
		back=gear.stp_jse_back
    }

    sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})
    
    -- Defense sets

	sets.defense.PDT = {
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
        back=gear.stp_jse_back
    }
    sets.defense.MDT = {
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
        back=gear.stp_jse_back
    }
	sets.defense.MEVA = set_combine(sets.precast.WS, {
        hands="Maculele bangles +3",
        legs="Maxixi Tights +3"
    })

    sets.Kiting = {feet="Skd. Jambeaux +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        main="Twashtar",
    	sub="Centovente",
        ammo="Aurgelmir Orb +1",
        head="Malignance chapeau",
        neck={ name="Etoile Gorget +2", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        body={ name="Herculean Vest", augments={'"Triple Atk."+4','Accuracy+10',}}, --"Malignance Tabard",
        hands="Malignance Gloves",
        left_ring="Moonlight Ring",
        right_ring="Moonlight Ring",
        back=gear.stp_jse_back,
        waist="Windbuffet Belt +1",
        legs="Malignance Tights",
        feet="Malignance Boots"
    }
    sets.engaged.DTLite = set_combine(sets.engaged, {})
    sets.engaged.SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.engaged.Acc = set_combine(sets.precast.WS.Acc, {})
    sets.engaged.FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.engaged.Fodder = set_combine(sets.engaged, {})
    sets.engaged.PDT = set_combine(sets.defense.PDT, {})
    sets.engaged.SomeAcc.PDT = set_combine(sets.defense.PDT, {})
    sets.engaged.Acc.PDT = set_combine(sets.defense.PDT, {})
    sets.engaged.FullAcc.PDT = set_combine(sets.defense.PDT, {})
    sets.engaged.Fodder.PDT = set_combine(sets.defense.PDT, {})

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = {legs="Horos Tights +3"}
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +3",ammo="Charis Feather",body="Meg. Cuirie +2"} --head="Charis Tiara +2"
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(2, 3)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'SAM' then
        set_macro_page(9, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(8, 1)
    else
        set_macro_page(10, 1)
    end
end