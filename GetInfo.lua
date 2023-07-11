local hwid = _G.hwid or nil
local cant = false
task.spawn(function()
	local http_request = syn and syn.request or request
	local body, decoded
	if http_request and not hwid then
		body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body
		decoded = game:GetService('HttpService'):JSONDecode(body)
		for i, v in pairs(decoded.headers) do
			if string.find(i, 'Fingerprint') then hwid = v; _G.hwid = hwid break; end
		end
	elseif not http_request and not hwid then
		cant = true
	end
	if hwid then
		cant = false
	end
end)
repeat task.wait(0) until hwid or cant
return hwid
