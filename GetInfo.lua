local cant = false
local hwid = ""
pcall(function()
	coroutine.wrap(function()
		task.spawn(function()
			local http_request = syn and syn.request or request
			local body, decoded
			if http_request and not hwid then
				body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body
				decoded = game:GetService('HttpService'):JSONDecode(body)
				for i, v in pairs(decoded.headers) do
					if string.match(string.lower(i), 'fingerprint') then hwid = v break end
				end
			elseif not http_request and not hwid then
				cant = true
			end
		end)
	end)()
end)
repeat task.wait(0) until hwid or cant
return hwid
