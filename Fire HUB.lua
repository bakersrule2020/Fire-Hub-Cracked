warn("FIRE~HUB: EARLY LOADING PROCESS HAS BEGUN...")
warn("Getting place info...")
local id = game.PlaceId local name = game:GetService("MarketplaceService"):GetProductInfo(id).Name
warn("Searching script for game: "..tostring(id).." ("..name..")...")
function executeScript(gameName)gameName = tostring(gameName).."lua" warn("Found script for game: "..tostring(id).." ("..name..") - "..gameName)warn("Executing "..gameName.."...")loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Fire-Hub/main/"..gameName))()warn(gameName.." has been successfuly executed!")end
if id == 6516141723 or id == 6839171747 then
    executeScript("DOORS")return
end
warn("No scripts found for game: "..tostring(id))
return
