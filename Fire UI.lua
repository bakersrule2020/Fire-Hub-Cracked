local canSave = readfile ~= nil and writefile ~= nil
local function LUAtoJSON(lua)
	return game.HttpService:JSONEncode(lua)
end
local function JSONtoLUA(json)
	return game.HttpService:JSONDecode(json)
end
local save = writefile
local read = readfile
loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Fire-Hub/main/FixJSON.lua"))()
if canSave then
	local haveConfiguration = false
	pcall(function()
		haveConfiguration = read(tostring(game.PlaceId)..".Fire") ~= nil
	end)
	if haveConfiguration then
		configTABLE = JSONtoLUA(read(tostring(game.PlaceId)..".Fire"))
	else
		configTABLE = {}
	end
else
	configTABLE = {}
end

local Font = Enum.Font.Oswald
local name = "Fire UI"
local ver = "2.0.3"
local fullName = name.." ["..ver.."]"
_G.fullName = _G.fullName or fullName
_G.actualName = _G.actualName or name
_G.logoImage = _G.logoImage or "http://www.roblox.com/asset/?id=124133244"
local parent = game.Players.LocalPlayer.PlayerGui
local screenGui = Instance.new("ScreenGui",parent)
screenGui.DisplayOrder = 25000
local clickSound = Instance.new("Sound",screenGui)
clickSound.SoundId = "rbxassetid://558993260"
local mainFrame = Instance.new("Frame",screenGui)
mainFrame.Size = UDim2.fromScale(0,0.4)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
mainFrame.Position = UDim2.fromScale(0.5,0.5)
mainFrame.Visible = false
local invisTopFrame = Instance.new("TextButton",screenGui)
local topFrame = Instance.new("Frame",mainFrame)
topFrame.BorderSizePixel = 0
topFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
topFrame.Size = UDim2.fromScale(1,0.1)
invisTopFrame.Text = ""
invisTopFrame.BackgroundTransparency = 1
invisTopFrame.AnchorPoint = Vector2.new(0.5,0.5)
invisTopFrame.Draggable = true
invisTopFrame.Changed:Connect(function(state)
	if state ~= "Position" then return end
	mainFrame.Position = invisTopFrame.Position
	mainFrame.Position = UDim2.new(mainFrame.Position.X.Scale,mainFrame.Position.X.Offset,0.5,mainFrame.Position.Y.Offset)
end)
invisTopFrame.Position = UDim2.fromScale(0.5,0.32)
invisTopFrame.Size = UDim2.fromScale(0.3,0.04)
local title = Instance.new("TextLabel",topFrame)
title.BackgroundTransparency = 1
title.Text = _G.fullName
title.TextColor3 = Color3.fromRGB(0,0,0)
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Font
local stroke = Instance.new("UIStroke",title)
stroke.Thickness = 1
title.Size = UDim2.fromScale(0.3,1)
title.Position = UDim2.fromScale(0.075,0)
stroke.Color = Color3.fromRGB(75,0,0)
local logo = Instance.new("ImageLabel",topFrame)
logo.BackgroundTransparency = 1
logo.Size = UDim2.fromScale(0.1,0.8)
logo.Position = UDim2.fromScale(0.01,0.1)
logo.Image = _G.logoImage
local as = Instance.new("UIAspectRatioConstraint",logo)
as.AspectRatio = 1
local corner = Instance.new("UICorner",logo)
corner.CornerRadius = UDim.new(1,0)
local mainStroke = stroke
local stroke = stroke:Clone()
stroke.Parent = logo
stroke.Color = Color3.fromRGB(0,0,0)
stroke.Thickness = 2
local stroke = stroke:Clone()
stroke.Parent = mainFrame
stroke.Thickness = 3
local close = Instance.new("TextButton",topFrame)
close.Size = UDim2.fromScale(0.1,0.8)
close.Position = UDim2.fromScale(0.89,0.1)
close.Text = "X"
close.TextScaled = true
close.BackgroundColor3 = Color3.fromRGB(255,0,0)
close.TextColor3 = Color3.fromRGB(255,255,255)
close.Font = Font
close.BorderSizePixel = 0
close.ZIndex = 2
close.AutoButtonColor = false
close.MouseEnter:Connect(function()
	game.TweenService:Create(close,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(255,255,0)}):Play()
end)
close.MouseLeave:Connect(function()
	game.TweenService:Create(close,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(255,0,0)}):Play()
end)
close.MouseButton1Click:Connect(function()
	if closed then return end
	closed = true
	clickSound:Play()
	game.TweenService:Create(close,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(255,75,0)}):Play()
	game.TweenService:Create(mainFrame,TweenInfo.new(2,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(0,0)}):Play()
	task.wait(2)
	wait(0)
	screenGui:Destroy()
end)
local minimize = close:Clone()
minimize.Parent = close.Parent
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(75,75,75)
minimize.Position = UDim2.fromScale(0.78,0.1)
local minimized = false
local oldpos = invisTopFrame.Position
local maximize = Instance.new("TextButton",screenGui)
maximize.BorderSizePixel = 3
maximize.BorderColor3 = Color3.fromRGB(0,0,0)
maximize.Text = "+"
maximize.AnchorPoint = Vector2.new(0.5,0.5)
maximize.TextColor3 = Color3.fromRGB(0,0,0)
maximize.Position = UDim2.fromScale(1.2,0.5)
maximize.Size = UDim2.fromScale(0.05,0.2)
maximize.BackgroundColor3 = minimize.BackgroundColor3
maximize.TextScaled = true
maximize.MouseButton1Click:Connect(function()
	if not minimized or closed then return end
	clickSound:Play()
	minimized = false
	mainFrame.Visible = true
	game.TweenService:Create(maximize,TweenInfo.new(1,Enum.EasingStyle.Exponential),{Position = UDim2.fromScale(1.2,0.5)}):Play()
	game.TweenService:Create(mainFrame,TweenInfo.new(2,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(0.3,0.4)}):Play()
	wait(1)
	mainFrame.Visible = true
	wait(1)
	mainFrame.Visible = true
end)
minimize.MouseButton1Click:Connect(function()
	if minimized or closed then return end
	minimized = true
	clickSound:Play()
	game.TweenService:Create(mainFrame,TweenInfo.new(2,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(0,0)}):Play()
	game.TweenService:Create(maximize,TweenInfo.new(1,Enum.EasingStyle.Exponential),{Position = UDim2.fromScale(1,0.5)}):Play()
	task.wait(1.8)
	mainFrame.Visible = false
end)
local pagelist = Instance.new("ScrollingFrame",mainFrame)
pagelist.Size = UDim2.fromScale(0.2,0.9)
pagelist.Position = UDim2.fromScale(0,0.1)
pagelist.BackgroundColor3 = topFrame.BackgroundColor3
pagelist.BorderSizePixel = 0
pagelist.CanvasSize = UDim2.fromScale(0,0)
pagelist.ChildAdded:Connect(function()
	pagelist.CanvasSize = UDim2.fromOffset(0,(#pagelist:GetChildren()-1)*55)
end)
pagelist.ChildRemoved:Connect(function()
	pagelist.CanvasSize = UDim2.fromOffset(0,(#pagelist:GetChildren()-1)*55)
end)
local grid = Instance.new("UIGridLayout",pagelist)
grid.CellPadding = UDim2.fromOffset(0,5)
grid.CellSize = UDim2.new(1,0,0,50)
grid.SortOrder = Enum.SortOrder.LayoutOrder
local uis = game.UserInputService
uis.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		m1Down = true
	end
end)
uis.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		m1Down = false
	end
end)
local pagesFolder = Instance.new("Folder",mainFrame)
local pageList = {}
function pageList.AddPage(pageName)
	if not table.find(configTABLE,pageName) then
		configTABLE[pageName] = {}
	end

	local btn = Instance.new("TextButton",pagelist)
	btn.Text = pageName
	btn.TextScaled = true
	btn.TextColor3 = Color3.fromRGB(255,200,100)
	btn.Font = Font 
	btn.BackgroundColor3 = pagelist.BackgroundColor3
	btn.BorderSizePixel = 0
	local frame = Instance.new("ScrollingFrame",pagesFolder)
	frame.Size = UDim2.fromScale(0.8,0.9)
	frame.BackgroundColor3 = mainFrame.BackgroundColor3
	frame.Position = UDim2.fromScale(0.2,0.1)
	frame.BorderSizePixel = 0
	frame.CanvasSize = UDim2.fromScale(0,0)
	frame.ChildAdded:Connect(function()
		frame.CanvasSize = UDim2.fromOffset(0,(#frame:GetChildren()-1)*55)
	end)
	frame.ChildRemoved:Connect(function()
		frame.CanvasSize = UDim2.fromOffset(0,(#frame:GetChildren()-1)*55)
	end)
	frame.Visible = false
	btn.MouseButton1Click:Connect(function()
		clickSound:Play()
		for i,v in pairs(pagesFolder:GetChildren()) do
			v.Visible = false
		end
		frame.Visible = true
	end)
	local grid = Instance.new("UIGridLayout",frame)
	grid.CellPadding = UDim2.fromOffset(0,5)
	grid.CellSize = UDim2.new(1,0,0,50)
	grid.SortOrder = Enum.SortOrder.LayoutOrder
	local funcs = {}
	function funcs.CreateLabel(text)
		local label = Instance.new("TextLabel",frame)
		label.Text = text
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,60,45)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,200,100)
		label.TextXAlignment = Enum.TextXAlignment.Left
		return label
	end
	function funcs.CreateDropdown(text,objects,func)
		local label = Instance.new("TextButton",frame)
		label.Text = text
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,60,45)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,200,100)
		label.TextXAlignment = Enum.TextXAlignment.Left
		local scrollingFrame = Instance.new("ScrollingFrame",label)
		scrollingFrame.BorderSizePixel = 0
		scrollingFrame.Size = UDim2.fromScale(1,0)
		scrollingFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
		scrollingFrame.ZIndex = 3
		local arrow = Instance.new("TextLabel",label)
		arrow.Text = "V"
		arrow.Size = UDim2.fromScale(0.1,0.9)
		arrow.BackgroundTransparency = 1
		arrow.Position = UDim2.fromScale(0.8,0.5)
		arrow.AnchorPoint = Vector2.new(0,0.5)
		arrow.Font = Font
		arrow.TextColor3 = Color3.fromRGB(255,255,255)
		arrow.TextScaled = true
		local aspectRatio = Instance.new("UIAspectRatioConstraint",arrow)
		aspectRatio.AspectRatio = 1
		local opened = false
		local openSpeed = 0.5
		label.MouseButton1Click:Connect(function()
			if not opened then
				arrow.Rotation = 180
				scrollingFrame.Size = UDim2.fromScale(1,1)
				scrollingFrame.Position = UDim2.fromScale(0,1)
			else
				arrow.Rotation = 0
				scrollingFrame.Size = UDim2.fromScale(1,1.5)
				scrollingFrame.Position = UDim2.fromScale(0,1)
			end
			opened = not opened
		end)
		local UIGrid = Instance.new("UIGridLayout",scrollingFrame)
		UIGrid.SortOrder = Enum.SortOrder.LayoutOrder
		UIGrid.CellSize = UDim2.new(1,0,0,25)
		UIGrid.CellPadding = UDim2.fromOffset(0,1)
		for i,v in pairs(objects) do
			local selectionButton = Instance.new("TextButton",scrollingFrame)
			selectionButton.Text = i
			selectionButton.BorderSizePixel = 0
			selectionButton.Font = Font
			selectionButton.TextColor3 = Color3.fromRGB(255,150,0)
		end
		coroutine.wrap(function()
			close.MouseButton1Click:Wait()
			task.wait(1)
			func("")
		end)()
		return label
	end
	function funcs.CreateButton(text,func)
		local label = Instance.new("TextButton",frame)
		label.Text = "["..text.."]"
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,60,45)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,200,100)
		label.MouseButton1Click:Connect(function()
			func()
			clickSound:Play()
		end)
		label.TextXAlignment = Enum.TextXAlignment.Left
		return label
	end
	function funcs.CreateTextBox(text,func,default)
		local default = default or ""
		local label = Instance.new("TextBox",frame)
		label.PlaceholderText = text
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,60,45)
		label.PlaceholderColor3 = Color3.fromRGB(200,75,75)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,200,100)
		label.ClearTextOnFocus = false
		label.Text = default
		label.TextXAlignment = Enum.TextXAlignment.Left
		if canSave then
			local haveConfig = false
			pcall(function()
				haveConfig = read(tostring(game.PlaceId)..".Fire") ~= nil
				if haveConfig then
					local saveTable = JSONtoLUA(read(tostring(game.PlaceId)..".Fire"))
					haveConfig = saveTable[pageName]["TextBox"..tostring(text)] ~= nil
					if haveConfig then
						label.Text = saveTable[pageName]["TextBox"..tostring(text)] or ""
						func(label.Text)
					else
						func(default)
					end
				else
					func(default)
				end
			end)
		end
		label.FocusLost:Connect(function(enter)
			if enter then
				func(label.Text)
				configTABLE[pageName]["TextBox"..tostring(text)] = label.Text
				if canSave then
					save(tostring(game.PlaceId)..".Fire",LUAtoJSON(configTABLE))
				end
			end
		end)
		return label
	end
	function funcs.CreateSwitch(text,func,default)
		local default = default or false
		local toggle = default
		local label = Instance.new("TextButton",frame)
		label.Text = text
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,60,45)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,255,255)
		label.TextXAlignment = Enum.TextXAlignment.Left
		local status = Instance.new("TextLabel",label)
		status.Size = UDim2.fromScale(0.2,0.9)
		status.Position = UDim2.fromScale(0.7,0.05)
		status.AnchorPoint = Vector2.new(0,0)
		status.BackgroundColor3 = Color3.fromRGB(255,0,0)
		status.Font = Font
		status.TextScaled = true
		status.TextColor3 = Color3.fromRGB(0,0,0)
		status.Text = "OFF"
		if not toggle then
			status.Text = "OFF"
			status.BackgroundColor3 = Color3.fromRGB(255,0,0)
		else
			status.Text = "ON"
			status.BackgroundColor3 = Color3.fromRGB(255,255,0)
		end
		local corner = Instance.new("UICorner",status)
		corner.CornerRadius = UDim.new(0.2,0)
		if canSave then
			local haveConfig = false
			pcall(function()
				haveConfig = read(tostring(game.PlaceId)..".Fire") ~= nil
				if haveConfig then
					local saveTable = JSONtoLUA(read(tostring(game.PlaceId)..".Fire"))
					haveConfig = saveTable[pageName]["Switch"..tostring(text)] ~= nil
					if haveConfig then
						toggle = saveTable[pageName]["Switch"..tostring(text)] or false
						if not toggle then
							status.Text = "OFF"
							game.TweenService:Create(status,TweenInfo.new(0.1),{BackgroundColor3 = Color3.fromRGB(255,0,0)}):Play()
						else
							status.Text = "ON"
							game.TweenService:Create(status,TweenInfo.new(0.1),{BackgroundColor3 = Color3.fromRGB(255,255,0)}):Play()
						end
					end
				end
			end)
		end
		func(toggle)
		label.MouseButton1Click:Connect(function()
			clickSound:Play()
			toggle = not toggle
			if not toggle then
				status.Text = "OFF"
				game.TweenService:Create(status,TweenInfo.new(0.1),{BackgroundColor3 = Color3.fromRGB(255,0,0)}):Play()
			else
				status.Text = "ON"
				game.TweenService:Create(status,TweenInfo.new(0.1),{BackgroundColor3 = Color3.fromRGB(255,255,0)}):Play()
			end
			configTABLE[pageName]["Switch"..tostring(text)] = toggle
			func(toggle)
			if canSave then
				save(tostring(game.PlaceId)..".Fire",LUAtoJSON(configTABLE))
			end
		end)
		local grad = Instance.new("UIGradient",status)
		grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(100,100,100)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,255,255))}
		grad.Rotation = -90
		coroutine.wrap(function()
			close.MouseButton1Click:Wait()
			task.wait(1)
			func(false)
		end)()
		return label
	end
	function funcs.CreateSlider(text,minVal,maxVal,step,func,default)
		local default = default or minVal
		local actualMinVal = 0
		local actualMaxVal = maxVal-minVal
		local steps = (actualMaxVal/step)+1
		local cStep = actualMinVal
		local label = Instance.new("TextLabel",frame)
		label.Text = text
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,60,45)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.TextColor3 = Color3.fromRGB(255,255,255)
		local sliderFrame = Instance.new("TextButton",label)
		sliderFrame.Size = UDim2.fromScale(0.2,0.95)
		sliderFrame.AnchorPoint = Vector2.new(0,0.5)
		sliderFrame.Position = UDim2.fromScale(0.7,0.5)
		sliderFrame.AutoButtonColor = false
		sliderFrame.Text = ""
		sliderFrame.BorderSizePixel = 0
		sliderFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
		sliderFrame.ClipsDescendants = true
		local currentStep = Instance.new("TextLabel",label)
		currentStep.BackgroundTransparency = 1
		currentStep.Size = UDim2.fromScale(0.2,1)
		currentStep.AnchorPoint = Vector2.new(0,0.5)
		currentStep.Position = UDim2.fromScale(0.5,0.5)
		currentStep.Text = tostring(minVal)
		currentStep.TextScaled = true
		currentStep.Font = Font
		currentStep.TextXAlignment = Enum.TextXAlignment.Right
		currentStep.TextColor3 = Color3.fromRGB(255,255,0)
		local UITable = Instance.new("UITableLayout",sliderFrame)
		UITable.FillEmptySpaceRows = true
		UITable.FillDirection = Enum.FillDirection.Horizontal
		UITable.FillEmptySpaceColumns = true
		UITable.SortOrder = Enum.SortOrder.LayoutOrder
		if canSave then
			local haveConfig = false
			pcall(function()
				haveConfig = read(tostring(game.PlaceId)..".Fire") ~= nil
				if haveConfig then
					local saveTable = JSONtoLUA(read(tostring(game.PlaceId)..".Fire"))
					if saveTable[pageName]["Slider"..tostring(text)] then
						default = saveTable[pageName]["Slider"..tostring(text)] or 0
					end
				end
			end)
		end
		func(default)
		for i=1,steps do
			local stepButton = Instance.new("TextButton",sliderFrame)
			stepButton.BackgroundTransparency = 1
			if i == 1 or i <= minVal-default or i == minVal-default then
				stepButton.BackgroundTransparency = 0
			end
			stepButton.BackgroundColor3 = Color3.fromRGB(255,150,0)
			stepButton.BorderSizePixel = 0
			stepButton.Text = ""
			stepButton.AutoButtonColor = false
			local function mouse(checkMouse)
				if m1Down and checkMouse or not checkMouse then
					cStep = (math.round(((i-1)*step)*1000))/1000
					currentStep.Text = tostring(cStep+minVal)
					for index,v in pairs(sliderFrame:GetChildren()) do
						if v and v:IsA("TextButton") then
							if index == i or index <= i+1 then
								v.BackgroundTransparency = 0
							else
								v.BackgroundTransparency = 1
							end
						end
					end
					stepButton.BackgroundTransparency = 0
					func(cStep+minVal)
					configTABLE[pageName]["Slider"..text] = cStep+minVal
					if canSave then
						save(tostring(game.PlaceId)..".Fire",LUAtoJSON(configTABLE))
					end
				end
			end
			stepButton.MouseEnter:Connect(function()
				mouse(true)
			end)
			stepButton.MouseButton1Click:Connect(function()
				mouse(false)
			end)
		end
		coroutine.wrap(function()
			close.MouseButton1Click:Wait()
			task.wait(1)
			func(minVal)
		end)()
		return label
	end
	return funcs
end
pageList.CreatePage = pageList.AddPage
local notificationLabel = Instance.new("Frame",screenGui)
notificationLabel.BackgroundTransparency = 1
notificationLabel.Size = UDim2.fromScale(0.2,1)
notificationLabel.ZIndex = 3
notificationLabel.Position = UDim2.fromScale(0.8,0)
local list = Instance.new("UIListLayout",notificationLabel)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Padding = UDim.new(0.02,0)
list.FillDirection = Enum.FillDirection.Vertical
list.VerticalAlignment = Enum.VerticalAlignment.Bottom
function pageList.Notify(text,time)
	coroutine.wrap(function()
		local time = time or 5
		local frame = Instance.new("Frame",notificationLabel)
		local stroke = Instance.new("UIStroke",frame)
		stroke.Color = Color3.fromRGB(0,0,0)
		stroke.Thickness = 3
		local notificationSound = Instance.new("Sound",frame)
		notificationSound.SoundId = "rbxassetid://4590662766"
		notificationSound:Play()
		frame.Size = UDim2.fromScale(1,0)
		frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		frame.BorderSizePixel = 0
		local timer = Instance.new("Frame",frame)
		timer.Size = UDim2.fromScale(1,0.05)
		timer.Position = UDim2.fromScale(0,0.1)
		timer.BackgroundColor3 = Color3.fromRGB(75,50,50)
		timer.BorderSizePixel = 0
		timer.ZIndex = timer.ZIndex + 1
		local fframe = timer:Clone()
		fframe.Parent = timer.Parent
		fframe.BackgroundColor3 = Color3.fromRGB(25,25,25)
		fframe.ZIndex = fframe.ZIndex - 1
		local stroke = stroke:Clone()
		stroke.Parent = fframe
		stroke.Thickness = 1
		local title = Instance.new("TextLabel",frame)
		title.BackgroundTransparency = 1
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.Text = _G.actualName
		title.Font = Font
		title.BorderSizePixel = 0
		title.TextScaled = true
		title.TextColor3 = Color3.fromRGB(255,255,255)
		title.Size = UDim2.fromScale(1,0.1)
		local content = title:Clone()
		content.Parent = frame
		content.Size = UDim2.fromScale(1,0.85)
		content.Position = UDim2.fromScale(0,0.15)
		content.Text = text
		content.TextYAlignment = Enum.TextYAlignment.Top
		game.TweenService:Create(timer,TweenInfo.new(time,Enum.EasingStyle.Linear),{Size = UDim2.fromScale(0,0.05)}):Play()
		game.TweenService:Create(frame,TweenInfo.new(0.5),{Size = UDim2.fromScale(1,0.2)}):Play()
		task.wait(time)
		game.TweenService:Create(frame,TweenInfo.new(0.5,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(1,0)}):Play()
		wait(0.5)
		frame:Destroy()
	end)()
end
function isnumber(txt)
	txt = tostring(txt)
	if tonumber(txt) ~= nil or txt == "inf" or txt == "-inf" or txt == "nan" then
		return true
	else
		return false
	end
end
local pagelist = pageList
local placeName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
if not game["Run Service"]:IsStudio() then
	pageList.Notify("Please wait, loading script for game "..placeName.."...",5)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Fire-Hub/main/GetInfo.lua"))()
end
local page = pageList.CreatePage("Main")
page.CreateLabel("NO MORE VERSIONS!")
page.CreateLabel(fullName.." was made by GodWorldX - Infernus#0863")
page.CreateTextBox("Custom logo [IMAGE ID]",
	function(id)
		if id ~= "" then
			logo.Image = id
		else
			logo.Image = "http://www.roblox.com/asset/?id=876744268"
		end
	end
)
page.CreateTextBox("Custom name",
	function(id)
		if id ~= "" then
			title.Text = id
		else
			title.Text = "Fire~Doors"
		end
	end
)
page.CreateTextBox('Make notification: [Prefix: ";"] [Text,time] ',
	function(id)
		local split = string.split(id,";")
		if not isnumber(split[2]) or #split ~= 2 then
			return
		end
		pagelist.Notify(split[1],tonumber(split[2]))
	end
)
game.TweenService:Create(mainFrame,TweenInfo.new(2,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(0.3,0.4)}):Play()
mainFrame.Visible = true
pageList.Notify("Welcome to FIRE-HUB!".."\10".."Script: "..placeName,5)
return pageList,close,screenGui
