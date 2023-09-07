print("[ICEHOOK]: Hooking firehub's authentication...")
hookfunction(game:GetService("RbxAnalyticsService").GetClientId, function()
	return "91f1e364c09e0e2b42b43bcd78d76f79"
end)
hookfunction(getfenv().http_request, function(site)
	print(site)
    if string.find(site, "discord.com") then
		print("Attempted to request a blocked site: " .. site)
      fakeresponse = {
		["Headers"] = "",
		["Body"] = "404 not found"
	  }
	  return game:GetService("HttpService"):JSONEncode(fakeresponse)
    else return game:HttpGet(site)
		
end end)
print("[ICEHOOK]: hooked")
