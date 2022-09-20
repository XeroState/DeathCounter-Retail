
local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
    self:COMBAT_LOG_EVENT_UNFILTERED(CombatLogGetCurrentEventInfo())
end)

if DeathCount == nil then DeathCount = 0 end

function f:COMBAT_LOG_EVENT_UNFILTERED(...)
    local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
    if subevent == "UNIT_DIED" then
        if destName=="Ootan" then 
            DeathCount = DeathCount+1
        end
    end
end


local function ANNOUNCE(type)
    if type == "s" then SendChatMessage(("I've witnessed Ootan die %s times now"):format(DeathCount), "SAY") end
    if type == "p" then SendChatMessage(("I've witnessed Ootan die %s times now"):format(DeathCount), "PARTY") end
    if type == "r" then SendChatMessage(("I've witnessed Ootan die %s times now"):format(DeathCount), "RAID") end
    if type == "rw" then SendChatMessage(("I've witnessed Ootan die %s times now"):format(DeathCount), "RAID_WARNING") end
end

SLASH_DC1 = '/dc'
SlashCmdList["DC"] = ANNOUNCE
