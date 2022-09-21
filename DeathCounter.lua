-- CODE BITCHES!


-- From what I can tell, this just tracks the Combat Event Log
local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
    self:COMBAT_LOG_EVENT_UNFILTERED(CombatLogGetCurrentEventInfo())
end)

-- Sets variables if they are not already set
if DeathPlayer == nil then DeathPlayer = "Freesia" end
if DeathCount == nil then DeathCount = 0 end
if FreesiaDeathCount == nil then FreesiaDeathCount = 0 end

-- Looks at the event log
-- If it's someone dying, it checks to see if they are the player tracked or Freesia and updates variable accordingly
function f:COMBAT_LOG_EVENT_UNFILTERED(...)
    local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
    if subevent == "UNIT_DIED" then
        if destName==DeathPlayer then 
            DeathCount = DeathCount+1
        end
        if destName=="Freesia" then
            FreesiaDeathCount = FreesiaDeathCount+1
        end
    end
end

-- Slash Command List
SlashCmdList["DC"] = function(msg)
    -- If we're to track Freesia, change the DeathCount to the global FreesiaDeathCount value
    if DeathPlayer == "Freesia" then DeathCount = FreesiaDeathCount end

    -- Say Channel
    if msg == "s" or msg == "say" then
        SendChatMessage(("I've witnessed %s died %s times now"):format(DeathPlayer, DeathCount), "SAY")
    -- Party Channel
    elseif msg == "p" or msg == "party" then
        SendChatMessage(("I've witnessed %s died %s times now"):format(DeathPlayer, DeathCount), "PARTY")
    -- Raid Channel
    elseif msg == "r" or msg == "raid" then
        SendChatMessage(("I've witnessed %s died %s times now"):format(DeathPlayer, DeathCount), "RAID")
    -- Raid Warning Channel
    elseif msg == "rw" or msg == "warning" then
        SendChatMessage(("I've witnessed %s died %s times now"):format(DeathPlayer, DeathCount), "RAID_WARNING")
    -- Reset counter to 0, does NOT reset Freesia global counter
    elseif msg == "reset" then
        DeathCount = 0
    -- Prints current amount
    elseif msg == "count" then
        print(("%s Death Count: %s"):format(DeathPlayer, DeathCount))
    -- Changes who you are tracking via your current target
    elseif msg == "track" then
        DeathPlayer = select(6, GetPlayerInfoByGUID(UnitGUID("target")))
        DeathCount = 0
    -- Help Menu
    elseif msg == "" or msg == "h" or msg == "help" or msg == "?" then
        print("\n|cfffe00f1XeroState's Custom Death Counter|r")
        print("\n")
        print("|cffe0d016/dc track|r -> Tracks the player currently targetted, also resets count to 0")
        print("       |cff32a852Freesia's death count will always be tracked in the background|r")
        print("|cffe0d016/dc reset|r -> Resets the DeathCount to 0")
        print("       |cff32a852Freesia's death count will not be reset|r")
        print("|cffe0d016/dc s|r -> Announces DeathCount to SAY")
        print("|cffe0d016/dc p|r -> Announces DeathCount to PARTY")
        print("|cffe0d016/dc r|r -> Announces DeathCount to RAID")
        print("|cffe0d016/dc rw|r -> announces DeathCount to RAID WARNING")
        print("|cffe0d016/dc count|r -> Prints current death count to console")
    end
end
-- Valid Slash Commands
SLASH_DC1 = "/dc";
SLASH_DC2 = "/deathcount";