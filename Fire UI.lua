local w,r,d,f = writefile,readfile,deletefile,createfolder or makefolder
local configs = w ~= nil and r ~= nil and d ~= nil and f ~= nil
warn("Loading fire UI with "..(configs and "saveable" or "unsaveable").." configuration...")
warn("Setting up the script")
local function LUAtoJSON(lua)
	return game.HttpService:JSONEncode(lua)
end
local function JSONtoLUA(json)
	return game.HttpService:JSONDecode(json)
end
local function save(path,toSave)
	if configs then
		pcall(function()
			w(path,LUAtoJSON(toSave))
		end)
	end
end
local function delete(path)
	if configs then
		pcall(function()
			d(path)
		end)
	end
end
local function makeFolder(name)
	if configs then
		pcall(function()
			f(name)
		end)
	end
end
local function read(path)
	if configs then
		local toReturn
		pcall(function()
			toReturn = JSONtoLUA(r(path))
		end)
		return toReturn
	end
end
local function pathExist(path)
	local exist = false
	if not configs then
		exist = true
	end
	pcall(function()
		if not exist then
			exist = read(path) ~= nil
		end
	end)
	return exist
end
local read = function(path,newIfNotExist)
	if pathExist(path) then
		return read(path)
	else
		if newIfNotExist then
			save(path,newIfNotExist)
			return nil
		else
			save(path,{Default = {}})
			return nil
		end
	end
end
makeFolder("Fire~HUB")
if not pathExist("Fire~HUB/Default"..game.PlaceId..".Fire") then
	save()
end
warn("Creating UI")
local Font = Enum.Font.Oswald
local name = "Fire UI"
local ver = "2.0.4"
local fullName = name.." ["..ver.."]"
_G.fullName = _G.fullName or fullName
_G.actualName = _G.actualName or name
_G.logoImage = _G.logoImage or "http://www.roblox.com/asset/?id=124133244"
local parent = game.Players.LocalPlayer.PlayerGui
local screenGui = Instance.new("ScreenGui",parent)
screenGui.DisplayOrder = 25000
screenGui.Name = "FIRE HUB | "..tostring(math.random(1000000,9999999)).."\10".."You will be strongest with that script, believe me!"
local configEvent = Instance.new("BindableEvent",screenGui)
configEvent.Name = "Load Config"
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
	mainFrame.Position = invisTopFrame.Position
	mainFrame.Position = UDim2.new(mainFrame.Position.X.Scale,mainFrame.Position.X.Offset,0.5,mainFrame.Position.Y.Offset)
end)
local configTable = {}
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
warn("Setting up the close button...")
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
warn("Setting up the minimize/maximize button...")
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
warn("Creating UI [2]")
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
configEvent.Event:Connect(function(name)
	configTable = read("Fire~HUB/"..name..game.PlaceId..".Fire",{Defalt = {},name = {}})
end)
uis.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		m1Down = false
	end
end)
local pagesFolder = Instance.new("Folder",mainFrame)
local pageList = {}
warn("Creating UI functions")
function pageList.AddPage(pageName)
	configTable[tostring(pageName)] = typeof(configTable[tostring(pageName)]) == "table" and configTable[tostring(pageName)] or {}
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
		frame.CanvasSize = UDim2.fromOffset(0,#frame:GetChildren()*55)
	end)
	frame.ChildRemoved:Connect(function()
		frame.CanvasSize = UDim2.fromOffset(0,#frame:GetChildren()*55)
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
	function funcs.Visible(bool)
		btn.Visible = bool
	end
	function funcs.CreateLabel(text)
		configTable[pageName]["Label"..text] = text
		local label = Instance.new("TextLabel",frame)
		label.Text = text
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,60,45)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,200,100)
		label.TextXAlignment = Enum.TextXAlignment.Left
		label:GetPropertyChangedSignal("Text"):Connect(function()
			pcall(function()
				configTable[pageName]["Label"..text] = label.Text
			end)
		end)
		configEvent.Event:Connect(function()
			task.wait(1)
			pcall(function()
				label.Text = configTable[pageName]["Label"..text]
			end)
		end)
		local funcs = {}
		function funcs.SetText(txt)
			label.Text = tostring(txt)
		end
		function funcs.Visible(bool)
			label.Visible = bool
		end
		function funcs.ReturnLabel()
			return label
		end
		return funcs
	end
	function funcs.CreateDropdown(text,objects,func)
		local label = Instance.new("TextButton",frame)
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,60,45)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,200,100)
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Text = ""
		local textHolder = label:Clone()
		textHolder.Parent = label
		textHolder.BackgroundTransparency = 1
		textHolder.Size = UDim2.fromScale(0.7,1)
		textHolder.Text = text
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
			selectionButton.Text = tostring(v)
			selectionButton.BorderSizePixel = 0
			selectionButton.Font = Font
			selectionButton.TextColor3 = Color3.fromRGB(255,150,0)
			selectionButton.MouseButton1Click:Connect(function()
				func(v)
				textHolder.Text = tostring(v)
				opened = false
				arrow.Rotation = 0
				scrollingFrame.Size = UDim2.fromScale(1,1.5)
				scrollingFrame.Position = UDim2.fromScale(0,1)
			end)
		end
		coroutine.wrap(function()
			close.MouseButton1Click:Wait()
			task.wait(1)
			func(objects[1])
		end)()
		local funcs = {}
		function funcs.Visible(bool)
			label.Visible = bool
		end
		function funcs.SetValue(v)
			func(v)
			textHolder.Text = tostring(v)
			opened = false
			arrow.Rotation = 0
			scrollingFrame.Size = UDim2.fromScale(1,1.5)
			scrollingFrame.Position = UDim2.fromScale(0,1)
		end
		function funcs.ReturnDropDown()
			return label
		end
		task.wait(0)
		return funcs
	end
	function funcs.CreateButton(text,func)
		configTable[pageName]["Button"..text] = text
		local label = Instance.new("TextButton",frame)
		label.Text = "["..text.."]"
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,60,45)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,200,100)
		label:GetPropertyChangedSignal("Text"):Connect(function()
			pcall(function()
				configTable[pageName]["Button"..text] = label.Text
			end)
		end)
		configEvent.Event:Connect(function()
			task.wait(1)
			pcall(function()
				label.Text = configTable[pageName]["Button"..text]
			end)
		end)
		label.MouseButton1Click:Connect(function()
			func()
			clickSound:Play()
		end)
		label.TextXAlignment = Enum.TextXAlignment.Left
		local funcs = {}
		function funcs.SetText(txt)
			label.Text = tostring(txt)
		end
		function funcs.Visible(bool)
			label.Visible = bool
		end
		function funcs.ReturnButton()
			return label
		end
		task.wait(0)
		return funcs
	end
	function funcs.CreateTextBox(text,func,default)
		configTable[pageName]["TextBox"..text] = default
		local default = default or ""
		local d = default
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
		label:GetPropertyChangedSignal("Text"):Connect(function()
			pcall(function()
				configTable[pageName]["TextBox"..text] = label.Text
			end)
		end)
		configEvent.Event:Connect(function()
			task.wait(1)
			pcall(function()
				local prevVal = label.Text
				label.Text = configTable[pageName]["TextBox"..text]
				if label.Text ~= prevVal then
					func(label.Text)
				end
			end)
		end)
		label.FocusLost:Connect(function(enter)
			if enter then
				func(label.Text)
			end
		end)
		coroutine.wrap(function()
			close.MouseButton1Click:Wait()
			task.wait(1)
			func("")
		end)()
		local funcs = {}
		function funcs.SetText(txt)
			label.Text = tostring(txt)
			if tostring(txt) ~= "" then
				func(tostring(txt))
			end
		end
		function funcs.Visible(bool)
			label.Visible = bool
		end
		function funcs.SetPlaceholderText(txt)
			label.PlaceholderText = tostring(txt)
		end
		function funcs.ReturnTextBox()
			return label
		end
		task.wait(0)
		return funcs
	end
	function funcs.CreateSwitch(text,func,default)
		configTable[pageName]["Switch"..text] = default
		local default = default or false
		local text = text ~= nil and tostring(text) or "Switch"
		local d = default
		local toggle = default
		local func = func or function() end
		local label = Instance.new("TextButton",frame)
		label.Font = Font
		label.BackgroundColor3 = Color3.fromRGB(75,60,45)
		label.TextScaled = true
		label.BorderSizePixel = 0
		label.TextColor3 = Color3.fromRGB(255,255,255)
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Text = ""
		local textHolder = label:Clone()
		textHolder.Parent = label
		textHolder.BackgroundTransparency = 1
		textHolder.Size = UDim2.fromScale(0.7,1)
		textHolder.Text = text
		local status = Instance.new("TextLabel",label)
		status.Size = UDim2.fromScale(0.2,0.9)
		status.Position = UDim2.fromScale(0.7,0.05)
		status.AnchorPoint = Vector2.new(0,0)
		status.BackgroundColor3 = Color3.fromRGB(255,0,0)
		status.Font = Font
		status.TextScaled = true
		status.TextColor3 = Color3.fromRGB(0,0,0)
		status.Text = "OFF"
		local corner = Instance.new("UICorner",status)
		corner.CornerRadius = UDim.new(0.2,0)
		if not toggle then
			status.Text = "OFF"
			status.BackgroundColor3 = Color3.fromRGB(255,0,0)
		else
			status.Text = "ON"
			status.BackgroundColor3 = Color3.fromRGB(255,255,0)
		end
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
			configTable[pageName]["Switch"..text] = toggle
			func(toggle)
		end)
		local grad = Instance.new("UIGradient",status)
		grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(100,100,100)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,255,255))}
		grad.Rotation = -90
		coroutine.wrap(function()
			close.MouseButton1Click:Wait()
			task.wait(1)
			func(false)
		end)()
		local funcs = {}
		function funcs.SetValue(bool)
			if toggle ~= bool then
				toggle = bool
				if not toggle then
					status.Text = "OFF"
					game.TweenService:Create(status,TweenInfo.new(0.1),{BackgroundColor3 = Color3.fromRGB(255,0,0)}):Play()
				else
					status.Text = "ON"
					game.TweenService:Create(status,TweenInfo.new(0.1),{BackgroundColor3 = Color3.fromRGB(255,255,0)}):Play()
				end
				func(toggle)
			end
		end
		function funcs.Visible(bool)
			label.Visible = bool
		end
		function funcs.SetText(text)
			textHolder.Text = text
		end
		configEvent.Event:Connect(function()
			task.wait(1)
			local prevVal = toggle
			funcs.SetValue(configTable[pageName]["Switch"..text])
			toggle = configTable[pageName]["Switch"..text]
		end)
		function funcs.ReturnToggle()
			return label
		end
		task.wait(0)
		return funcs
	end
	function funcs.CreateSlider(text,minVal,maxVal,step,func,default)
		configTable[pageName]["Slider"..text] = default
		local default = default or minVal
		local d = default
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
		currentStep.TextScaled = true
		currentStep.Font = Font
		currentStep.TextXAlignment = Enum.TextXAlignment.Right
		currentStep.TextColor3 = Color3.fromRGB(255,255,0)
		local UITable = Instance.new("UITableLayout",sliderFrame)
		UITable.FillEmptySpaceRows = true
		UITable.FillDirection = Enum.FillDirection.Horizontal
		UITable.FillEmptySpaceColumns = true
		UITable.SortOrder = Enum.SortOrder.LayoutOrder
		local step = default
		if default ~= minVal then
			func(default)
			currentStep.Text = tostring(default)
		else
			currentStep.Text = tostring(minVal)
		end
		local STEPS = {}
		for i=1,steps do
			local stepButton = Instance.new("TextButton",sliderFrame)
			STEPS[i] = stepButton
			stepButton.BackgroundTransparency = 1
			if i == 1 or i <= default-step or i == default-step then
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
					configTable[pageName]["Slider"..text] = cStep+minVal
					func(cStep+minVal)
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
			func(d)
		end)()
		local funcs = {}
		function funcs.SetText(txt)
			label.Text = tostring(txt)
		end
		function funcs.Visible(bool)
			label.Visible = bool
		end
		function funcs.SetValue(number)
			func(number)
			for i,stepButton in pairs(STEPS) do
				if i == 1 or i <= number-step or i == number-step then
					stepButton.BackgroundTransparency = 0
				end
			end
		end
		configEvent.Event:Connect(function()
			task.wait(1)
			local prevVal = step
			step = configTable[pageName]["Switch"..text]
			funcs.SetValue(step)
		end)
		function funcs.ReturnLabel()
			return label
		end
		task.wait(0)
		return funcs
	end
	task.wait(0)
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
warn("Creating function: MakeNotification")
function pageList.Notify(text,time)
	local toReturn
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
		coroutine.wrap(function()
			game.TweenService:Create(timer,TweenInfo.new(time,Enum.EasingStyle.Linear),{Size = UDim2.fromScale(0,0.05)}):Play()
			game.TweenService:Create(frame,TweenInfo.new(0.5),{Size = UDim2.fromScale(1,0.2)}):Play()
			task.wait(time)
			game.TweenService:Create(frame,TweenInfo.new(0.5,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(1,0)}):Play()
			wait(0.5)
			frame:Destroy()
		end)()
		local funcs = {}
		function funcs.FinishNotification()
			game.TweenService:Create(timer,TweenInfo.new(0.5,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Size = UDim2.fromScale(0,0.05)}):Play()
			game.TweenService:Create(frame,TweenInfo.new(1,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(1,0)}):Play()
			wait(1.1)
			frame:Destroy()
		end
		toReturn = funcs
	end)()
	return toReturn
end
pageList.MakeNotification = pageList.Notify
function isnumber(txt)
	txt = tostring(txt)
	if tonumber(txt) ~= nil or txt == "inf" or txt == "-inf" or txt == "nan" then
		return true
	else
		return false
	end
end
local pagelist = pageList
warn("Getting some info about place...")
local placeName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
if not game["Run Service"]:IsStudio() then
	pageList.Notify("Please wait, loading script for game "..placeName.."...",5)
end
warn("Creating 'Main' page...")
local page = pageList.CreatePage("Main")
page.CreateLabel("--Credits--")
page.CreateLabel("Developers & Idea generators:".."\10".."xinfernusx, bryld, wvpul, laykad_")
page.CreateLabel(fullName.." was made by GodWorldX - xinfernusx")
page.CreateLabel("UI Style")
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
			title.Text = "Fire~HUB"
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
page.CreateLabel("--Configs--")
if configs then
	local text = "default"
	page.CreateTextBox("Config name",function(txt)
		text = txt
	end)
	local doubleClick = false
	page.CreateButton("Save config",function()
		if not doubleClick then
			pagelist.Notify("Are you sure [Click 1 more time to confirm saving config with name: "..text.."]",5)
			doubleClick = true
			task.wait(5)
			doubleClick = false
		else
			pagelist.Notify(text,2)
			save("Fire~HUB/"..text..game.PlaceId..".Fire",configTable)
		end
	end)
	local doubleClick2 = false
	page.CreateButton("Load config",function()
		if not doubleClick then
			pagelist.Notify("Are you sure [Click 1 more time to confirm loading config with name: "..text.."]",5)
			doubleClick2 = true
			task.wait(5)
			doubleClick2 = false
		else
			pagelist.Notify(text,2)
			local originalText
			if pathExist("Fire~HUB/"..text..game.PlaceId..".Fire") then
				originalText = text
				text = "Default"
			end
			pageList.Notify("Loading config: "..text,5)
			configEvent:Fire(text)
			if originalText then
				text = originalText
			end
		end
	end)
else
	page.CreateLabel("--Your exploit is dont support configs system--")
end
warn("FIRE-HUB almost loaded, wait a bit...")
pageList.Notify("FIRE-HUB almost loaded, wait a bit...",5)
warn("Animating UI")
game.TweenService:Create(mainFrame,TweenInfo.new(2,Enum.EasingStyle.Exponential),{Size = UDim2.fromScale(0.3,0.4)}):Play()
mainFrame.Visible = true
return pageList,close,screenGui
