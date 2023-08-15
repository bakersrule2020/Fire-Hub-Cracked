print("Hooking firehub's authentication...")
hookfunction(getfenv().http_request, function(site)
  if site == "https://raw.githubusercontent.com/InfernusScripts/Fire-Hub/main/UserData.lua" then
      return game:HttpGet("https://raw.githubusercontent.com/bakersrule2020/Fire-Hub-Cracked/main/UserData.lua")
    elseif site == "https://raw.githubusercontent.com/InfernusScripts/Fire-Hub/main/GetHWID.lua" then
      return game:HttpGet("https://raw.githubusercontent.com/bakersrule2020/Fire-Hub-Cracked/main/GetHWID.lua")
    else return game:HttpGet(site)
end)
print("hooked")
