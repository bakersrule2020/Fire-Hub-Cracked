--[[
DONT FORGET TO
PASTE FREAKING
"," @INFERNUS
]]--
local hwid
local cant = false
task.spawn(function()
    local http_request = syn and syn.request or request
    local body, decoded
    if http_request then
        body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body
        decoded = game:GetService('HttpService'):JSONDecode(body)
        for i, v in pairs(decoded.headers) do
            if string.find(i, 'Fingerprint') then hwid = v; break; end
        end
    else
        cant = true
    end
end)
if cant then
	warn"[ICEHOOK]: Failed to start! (Couldn't grab HWID for hooking)"
print("Returning fake user table...")
local whitelist = {
	[hwid] = "OWNER", --INFERNUS

	["823e87f5b06a3fb8d2249e715a1d3535"] = "yes", --titanzxd
	["92aba5b46a07a91970141be86464c96a"] = "da", --titanzxd's brother
	["fa600df48f8b8c2a9704e2089e6046d5"] = "конечно", --Yumos
	["eda0fb4c371062ca45b4e78ce3bf2515"] = "true", --Evanboi420
	["6b001bf6540004eac9a4b2cb3a26bf46"] = true, --тоха долбаёб
	["0c3ba589c12afdd998e476426d9dee3b"] = game, --wvpul
	["4a8ccb6cb27a70d81164436034a78197"] = "game:Shutdown()", --eshaanopn
	["a73485e263e1b1d95fc43d820c36486c"] = table, --idk
	["a8281b8c14a1d5bb30a47d9c3ae8cdb2"] = "да я люблю сосать член", --банановая кожурка
	["4716a3e01184ddc86cf494f8f56b6bbd"] = "ohhhh, sempai, deeper!", --пон
	["685393549a6cbd0817444827040e785c"] = "miNEcrAAAAAAAAAAAAAAAAAAAAAAAAAAft", --the piston
	["f201eac56fd543297a94b4de13e06a9f"] = "агент слоник", -- :)
	["d7d9219563275f7b5cb4411046c92dce"] = "no", --quagmire
	["45c8dcf06cbeb0c8d6a45768a8876776"] = "mega beatbox SKVRRRRR VR VR ptt vRRRvr VRVvr VR", --squirell
	["de74320031298b39b9e42e23966f5d02"] = 'this is different';
	["519040ebefabffbbea74ad3e786bad63"] = '""', --3EloHIyChay123123
	["9497460701cd126be3e49ad0ebee30bd"] = "''", --bryld
	["d446c5f1fcf3cb7a4614dc8365ef8588"] = type, --penguinl
}
local vip = {
  [hwid] = "OWNER", --INFERNUS
  
  ["fa600df48f8b8c2a9704e2089e6046d5"] = true, --Yumos
  ["0c3ba589c12afdd998e476426d9dee3b"] = "game", --wvpul
}
local owner = ""
print("Ice is quite cold. (Returned fake table)")
return whitelist,vip,owner
