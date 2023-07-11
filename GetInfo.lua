local cant = false
coroutine.wrap(function()
	task.spawn(function()
		local http_request = syn and syn.request or request
		local body, decoded
		if http_request and not _G.hwid then
			body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body
			decoded = game:GetService('HttpService'):JSONDecode(body)
			for i, v in pairs(decoded.headers) do
				if string.match(string.lower(i), 'fingerprint') then _G.hwid = v end
			end
		elseif not http_request and not _G.hwid then
			cant = true
		end
		if _G.hwid then
			cant = false
		end
	end)
end)()
repeat task.wait(0) until _G.hwid or cant
print(cant, _G.hwid)
