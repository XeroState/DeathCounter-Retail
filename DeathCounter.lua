
local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
    self:COMBAT_LOG_EVENT_UNFILTERED(CombatLogGetCurrentEventInfo())
end)

if DeathPlyaer == nil then DeathPlayer = "Ootan" end
if DeathCount == nil then DeathCount = 0 end

function f:COMBAT_LOG_EVENT_UNFILTERED(...)
    local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
    if subevent == "UNIT_DIED" then
        if destName=="Ootan" then 
            DeathCount = DeathCount+1
        end
    end
end

SlashCmdList["DC"] = function(msg)
    if msg == "s" then
        SendChatMessage(("I've witnessed %s died %s times now"):format(DeathPlayer, DeathCount), "SAY")
    elseif msg == "p" then
        SendChatMessage(("I've witnessed %s died %s times now"):format(DeathPlayer, DeathCount), "PARTY")
    elseif msg == "r" then
        SendChatMessage(("I've witnessed %s died %s times now"):format(DeathPlayer, DeathCount), "RAID")
    elseif msg == "rw" then
        SendChatMessage(("I've witnessed %s died %s times now"):format(DeathPlayer, DeathCount), "RAID_WARNING")
    elseif msg == "reset" then
        DeathCount = 0
    elseif msg == "count" then
        print(m2:format(DeathCount))
    elseif msg == "" or msg == "h" or msg == "help" or msg == "?" then
        print("\nXEROSTATE'S CUSTOM DEATH COUNTER")
        print("\n\n/dc track PLAYER -> Configures which player to death track, also resets count to 0")
        print("\n/dc reset -> Resets the DeathCount to 0")
        print("\n\n/dc s -> Announces DeathCount to SAY")
        print("\n/dc p -> Announces DeathCount to PARTY")
        print("\n/dc r -> Announces DeathCount to RAID")
        print("\n/dc rw -> announces DeathCount to RAID WARNING")
        print("\n/dc count -> Prints current death count to console/n ")
    end
end
SLASH_DC1 = "/dc";
SLASH_DC2 = "/deathcount";
