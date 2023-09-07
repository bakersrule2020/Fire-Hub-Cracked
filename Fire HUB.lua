local games = {
    ["DOORS"] = {
        [6516141723] = true;
        [6839171747] = true;
    },
}
print("Hello world!");
warn("Iceware by tornvrc and casualdev.")
warn("don't pay for skidded garbage, crack it instead!")
warn("team d00mblox was here")
warn("FIRE~HUB: EARLY LOADING PROCESS HAS BEGUN...")
warn("Getting place info...")
local id = game.PlaceId local name = game:GetService("MarketplaceService"):GetProductInfo(id).Name
warn("Searching script for game: "..tostring(id).." ("..name..")...")
function executeScript(gameName)
    warn("Found script for game: "..tostring(id).." ("..name..") - "..gameName)
    warn("FIRE~HUB: EARLY LOADING PROCESS HAS DONE!")
    warn("Converting ["..gameName.."] to ["..gameName..".lua]...")
    gameName = tostring(gameName)..".lua"
    warn("Converted!")
    warn("Executing "..gameName.."...")
    local func,errorMessage = loadstring(game:HttpGet("https://raw.githubusercontent.com/bakersrule2020/Fire-Hub-Cracked/"..gameName))
    local toReturn = "Fail"
    if func then
        func()
        warn(gameName.." has been successfuly executed!")
        toReturn = "Successful"
    else
        warn("Failed to execute "..gameName.." :(")
        warn("FIRE~HUB got an Luau error:".."\10"..errorMessage)
        toReturn = "Fail"
    end
    return toReturn
end
local toReturn = "Fail"
local foundGame = false
for gameName,ids in pairs(games) do
    for ID,bool in pairs(ids) do
        if ID == id and bool then
            foundGame = true
            executeScript(gameName)
        end
    end
end
if not foundGame then
    toReturn = "NoScripts"
end
if toReturn == "Fail" then
    warn("An error occured when loading FIRE~HUB")
    warn("FIRE~HUB: EARLY LOADING PROCESS HAS DONE!")
elseif toReturn == "NoScripts" then
    warn("No scripts was found for game: "..tostring(id).." ("..name..") :(")
elseif toReturn == "Successful" then
    warn("FIRE~HUB is successfully executed!")
    warn("FIRE~HUB: EARLY LOADING PROCESS HAS DONE!")
else
    warn("FATAL ERROR")
end
warn(toReturn)
return toReturn
