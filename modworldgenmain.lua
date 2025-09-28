
----delete seasons overrides----
--- We do not want any map to override seasons, that may cause the mod to crash

local function DeleteOverrides(levelsOverride)

	for i,o in ipairs(levelsOverride) do
		print (o.id)
		for k, v in pairs(o.overrides) do
		
			local name = v[1]
			local value = v[2]
		
			if( name == "autumn") or (name == "winter") or (name == "spring") or (name == "summer") or (name == "mild") or (name == "wet") or (name == "green") or (name == "dry") or (name == "temperate") or (name == "humid") or (name == "lush") then
				v[1] = "none"
				v[2] = "none"	
				print("eliminando override")
			end
		end
	end

end

local levels = GLOBAL.require("map/levels")

DeleteOverrides(levels.sandbox_levels)
DeleteOverrides(levels.cave_levels)
DeleteOverrides(levels.custom_levels)
DeleteOverrides(levels.volcano_levels)
DeleteOverrides(levels.shipwrecked_levels)
DeleteOverrides(levels.porkland_levels)

--------------------
GLOBAL.require("map/terrain")


local rooms = GLOBAL.terrain.rooms

local makeBramblesTags =  GetModConfigData("BRAMBLES_EVERYWHERE") or 0

if(makeBramblesTags == 1) then
	for k, v in pairs(rooms) do
			for l, b in pairs(v) do
				if( l == "tags") then	
					 table.insert(b, "Bramble")	 --Insert Bramble tag to all biomes	
					break
				end
			end

	end
end