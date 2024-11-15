local isPluginDisabled = false
local wasBombsiteBlocked = false
local disabledBombsite = nil

local messageTimer = nil

local DisableBombsite_t = {
    Random = 0,
    A = 1,
    B = 2
}


AddEventHandler("OnMapLoad", function (event,mapName)
    NextTick(function ()
        local bombsiteInstances = FindEntitiesByClassname("func_bomb_target")

        if  #bombsiteInstances ~= 2 then
            isPluginDisabled = true
            print(config:Fetch("bombsite-restrict.prefix") .. "The Bombsite Restrict plugin is disabled, because there are no bomb plants on this map.")
        end        
    end)
    return EventResult.Continue
end)

AddEventHandler("OnMapUnload", function(event --[[ Event ]], map --[[ string ]])
    if isPluginDisabled then return end
    if messageTimer then
        StopTimer(messageTimer)
        messageTimer = nil
    end
    return EventResult.Continue
end)


AddEventHandler("OnRoundStart", function(event --[[ Event ]])

    if isPluginDisabled then return EventResult.Continue end

    if GetCCSGameRules().WarmupPeriod then return EventResult.Continue end

    if playermanager:GetPlayerCount() > tonumber(config:Fetch("bombsite-restrict.minimum_players")) then return EventResult.Continue end

    disabledBombsite = tonumber(config:Fetch("bombsite-restrict.disabled_bombsite"))

    DisableBombsite()

    return EventResult.Continue
end)

AddEventHandler("OnRoundEnd", function(event)
    if isPluginDisabled then return EventResult.Continue end

    if GetCCSGameRules().WarmupPeriod then return EventResult.Continue end

    if not wasBombsiteBlocked then return EventResult.Continue end

    EnabledBombsites()

    return EventResult.Continue
end)


function DisableBombsite()

    if disabledBombsite == DisableBombsite_t.Random then
        disabledBombsite = math.random(DisableBombsite_t.A, DisableBombsite_t.B)
    end

    local bombsitesInstance = FindEntitiesByClassname("func_bomb_target")

    for i = 1, #bombsitesInstance do
        local bombsiteTarget = CBombTarget(bombsitesInstance[i]:ToPtr())

        local blockBombsite = DisableBombsite_t.A

        if bombsiteTarget.IsBombSiteB then
            blockBombsite = DisableBombsite_t.B
        end

        if blockBombsite == disabledBombsite and not wasBombsiteBlocked then
            local bombsiteEntity = CBaseEntity(bombsitesInstance[i]:ToPtr())
            if bombsiteEntity:IsValid() then
                bombsiteEntity:AcceptInput("Disable", CEntityInstance("0x0"), CEntityInstance("0x0"), "", 0)
                wasBombsiteBlocked = true

                if tonumber(config:Fetch("bombsite-restrict.message_repeated_time")) > 0 then
                    messageTimer = SetTimer(tonumber(config:Fetch("bombsite-restrict.message_repeated_time")) * 1000, SendBombsiteMessage )
                    break
                end
                SendBombsiteMessage()
                break
            end
        end
    end
end

function EnabledBombsites()
    local bombsitesInstance = FindEntitiesByClassname("func_bomb_target")
    for i = 1, #bombsitesInstance do
        local bombsiteEntity = CBaseEntity(bombsitesInstance[i]:ToPtr())
        if bombsiteEntity and bombsiteEntity:IsValid() then
            bombsiteEntity:AcceptInput("Enable", CEntityInstance("0x0"), CEntityInstance("0x0"), "", 0)
        end
    end
    wasBombsiteBlocked = false
    if messageTimer then
        StopTimer(messageTimer)
        messageTimer = nil
    end
end


function SendBombsiteMessage()

    local bombsiteString = "B"
    if disabledBombsite == DisableBombsite_t.B then
        bombsiteString = "A"
    end

    for i = 0, playermanager:GetPlayerCap() - 1, 1 do
        local player = GetPlayer(i)
        if not player then goto continue end
        if not player:IsValid() then goto continue end
        player:SendMsg(MessageType.Center, FetchTranslation("bombsite-restrict.only", i):gsub("{BOMBSITE}", bombsiteString))
        ::continue::
    end
end
