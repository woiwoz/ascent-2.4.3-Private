--[[ Based on BOSS - Serpentshrine Cavern - Lady Vashj.lua  
     DBE - Scripting project
	 ported from .gm by xenolf ]]

function Malacree_Shoot(pUnit, event)
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
	pUnit:FullCastSpellOnTarget(39079, plr)   -- not sure about the spell, but should be the right one... the biatch needs a ranged wep ...
	else
	end
end

function Malacree_MultiShot(pUnit, event)
	r = math.random(1, 2)
	if r == 1 then
	pUnit:SendChatMessage(12, 0, "Straight to the heart!")
	pUnit:PlaySoundToSet(11536)
	elseif r == 2 then
	pUnit:SendChatMessage(12, 0, "Seek your mark!")
	pUnit:PlaySoundToSet(11537)
	end
	
	local plr = pUnit:GetRandomPlayer(0)
	if plr then
		pUnit:FullCastSpellOnTarget(38310, plr)
	end
end

function Malacree_ShockBurst(pUnit, event)
	local plr = pUnit:GetMainTank()
	if plr then
		pUnit:FullCastSpellOnTarget(38509, plr)
	end
end

function Malacree_Entangle(pUnit, event)
	local plr = pUnit:GetRandomPlayer(2)
	if plr then
		pUnit:FullCastSpellOnTarget(38316, plr)
	end
end

function Malacree_StaticCharge(pUnit, event)
	local plr = pUnit:GetRandomPlayer()
	if plr then
		pUnit:FullCastSpellOnTarget(38280, plr)    --spell?!
	end
end
		
function Malacree_ForkedLightning(pUnit, event)
	pUnit:SendChatMessage(12, 0, "Victory to Lord Illidan!")
	pUnit:PlaySoundToSet(11533)
	local plr = pUnit:GetRandomPlayer(1)
	if plr then
		pUnit:FullCastSpellOnTarget(40088, plr)		
	end
end

function Malacree_SummonElementals(pUnit, event)
	local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	pUnit:SpawnCreature(22009, x, y, z, 90, 14, 0)
end

function Malacree_EliteAdds(pUnit, event)						-- isnt blizzlike, gonna enter sum coords in here later on
	local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	pUnit:SpawnCreature(22055, x, y, z, 90, 14, 0)
end

function Malacree_Striders(pUnit, event)						-- same as abothe
	local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	pUnit:SpawnCreature(22056, x, y, z, 90, 14, 0)
end

function Malacree_Phase1(pUnit, event)
	pUnit:SendChatMessage(12, 0, "I did not wish to lower myself by engaging your kind, but you leave me little choice!")
	pUnit:PlaySoundToSet(11538)
	pUnit:RegisterEvent("Malacree_Shoot", 10000, 0)
	pUnit:RegisterEvent("Malacree_MultiShot", 30000, 0)
	pUnit:RegisterEvent("Malacree_StaticCharge", 20000, 0)
	pUnit:RegisterEvent("Malacree_ShockBurst", 25000, 0)       -- placeholder
end

function Malacree_Phase2(pUnit, event)
	if (pUnit:GetHealthPct()) <= 70 then
		pUnit:SendChatMessage(12, 0, "The time is now! Leave none standing!")
		pUnit:PlaySoundToSet(11539)
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Malacree_EliteAdds", 50000, 0)
		pUnit:RegisterEvent("Malacree_Striders", 60000, 0)
		pUnit:RegisterEvent("Malacree_SummonElementals", 120000, 0)    -- i know... isnt blizzlike
		-- pUnit:RegisterEvent("LadyVashj_Shoot", 10000, 0)          -- still in phase 2? dunno
		-- pUnit:RegisterEvent("LadyVashj_MultiShot", 30000, 0)
	end
end
		
function Malacree_Phase3(pUnit, event)
	if (pUnit:GetHealthPct()) <= 50 then
		pUnit:SendChatMessage(12, 0, "You may want to take cover")
		pUnit:PlaySoundToSet(11540)
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Malacree_Shoot", 10000, 0)
		pUnit:RegisterEvent("Malacree_MultiShot", 30000)
		pUnit:RegisterEvent("Malacree_StaticCharge", 20000, 0)
		pUnit:RegisterEvent("Malacree_ShockBurst", 25000, 0)
		--[[ pUnit:RegisterEvent("LadyVashj_SporeBats", 0000, 0) 			-- need to look into that a bit more]]
	end
end

function Malacree_OnEnterCombat(pUnit, event)
	local say = math.random(1, 4)
	if say == 1 then
		pUnit:SendChatMessage(12, 0, "I'll split you from stem to stern!")
		pUnit:PlaySoundToSet(11532)
	elseif say == 2 then
		pUnit:SendChatMessage(12, 0, "Victory to Lord Illidan!")
		pUnit:PlaySoundToSet(11533)
	elseif say == 3 then
		pUnit:SendChatMessage(12, 0, "I spit on you, surface filth!")
		pUnit:PlaySoundToSet(11534)
	elseif say == 4 then
		pUnit:SendChatMessage(12, 0, "Death to the outsiders!")
		pUnit:PlaySoundToSet(11535)
	end
	
	pUnit:RegisterEvent("Malacree_Phase1", 1000, 1)			-- we just need that to run once ^^
	pUnit:RegisterEvent("Malacree_Phase2", 1000, 0)
	pUnit:RegisterEvent("Malacree_Phase3", 1000, 0)
end

RegisterUnitEvent(230050, 1, "Malacree_OnEnterCombat")

function LadyVashj_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(230050, 2, "Malacree_OnLeaveCombat")

function LadyVashj_OnKill(pUnit, event)
	pUnit:SendChatMessage(12, 0, "Lord Illidan, I... I am... sorry.")
	pUnit:PlaySoundToSet(11544)
	pUnit:RemoveEvents()
end

function Add_Despawn(pUnit, event)
	pUnit:Despawn(1000, 0)
end

RegisterUnitEvent(22055, 4, "Add_Despawn")
RegisterUnitEvent(22056, 4, "Add_Despawn")
RegisterUnitEvent(22009, 4, "Add_Despawn")

RegisterUnitEvent(230050, 4, "Malacree_OnKill")

function Malacree_OnPlayerKill(pUnit, event)
	local msg = math.random(1, 2)
	if msg == 1 then
		pUnit:SendChatMessage(12, 0, "Your time ends now!")
		pUnit:PlaySoundToSet(11541)	
	elseif msg == 2 then
		pUnit:SendChatMessage(12, 0, "You have failed!")
		pUnit:PlaySoundToSet(11542)
	end
end

 -- RegisterUnitEvent(230050, 3, "Malacree_OnPlayerKill")     --just in case this is goin to work somedays -.-

function Malacree_OnEnterRange(pUnit, event)
	pUnit:SendChatMessage(12, 0, "Water is life. It has become a rare commodity here in Outland. A commodity that we alone shall control. We are the Highborne, and the time has come at last for us to retake our rightful place in the world!")
	pUnit:PlaySoundToSet(11531)
end

-- RegisterUnitEvent(230050, 10, "Malacree_OnEnterRange")
