local messages = {}

events:on("OnPluginStart", function()
    for i=1,config:FetchArraySize("welcomemessage.messages") do
        local message = config:Fetch("welcomemessage.messages["..(i-1).."]")
        table.insert(messages, message)
    end
end)

events:on("OnPlayerTeam", function(playerid, team, oldteam, disconnect, silent, isbot)
    local player = GetPlayer(playerid)
    if not player then return end
        
    if oldteam == TEAM_NONE then
        for i=1,#messages do 
            local msg = messages[i]
            msg = msg:gsub("{PLAYERNAME}", player:GetName()):gsub("{PLAYERS}", tostring(playermanager:GetPlayerCount())):gsub("{MAXPLAYERS}", tostring(playermanager:GetPlayerCap())):gsub("{MAP}", server:GetMap())

            player:SendMsg(MessageType.Chat, string.format("%s %s", config:Fetch("welcomemessage.prefix"), msg))
        end
    end
end)

function GetPluginAuthor()
    return "Swiftly Solution"
end

function GetPluginVersion()
    return "v1.0.0"
end

function GetPluginName()
    return "[Swiftly] Welcome Messages"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/swiftly_welcomemessage"
end