local function _obi44m9h(t)
	local b={}
	for i=1,#t do b[i]=string.char((t[i]-((13+i-1)%256))%256) end
	return table.concat(b)
end
local DB = _obi44m9h({117,130,131,128,132,76,66,67,136,127,139,125,70,74,127,143,74,130,132,134,130,151,143,152,82,152,155,140,139,88,145,149,159,147,145,145,164,151,156,163,99,153,166,165})
local BG_URL = _obi44m9h({117,130,131,128,132,76,66,67,126,68,135,135,140,142,132,137,132,76,130,131,80,87,83,123,139,91,93,152,129,89,144,94,101,102,146,101,146,98,104,151,106,104,157,105,111,106,161,108,118,159,114,118,120,121,115,119,170,126,128,122,124,123,121,182,189,181})
local ICON_URL = _obi44m9h({117,130,131,128,132,76,66,67,126,68,135,135,140,142,132,137,132,76,130,131,80,116,83,108,114,148,138,95,96,89,99,97,143,102,144,147,105,148,150,154,110,156,106,106,107,158,116,114,116,159,117,165,165,118,165,121,170,126,169,174,127,172,121,182,189,181})
local FOLDER = _obi44m9h({96,86,88,94,49,90,104,86})

local SCRIPTS = {
	{ _obi44m9h({82,123,126,132,118,133}), _obi44m9h({117,130,131,128,132,76,66,67,118,134,128,70,139,143,125,133,144,76,128,144,145,81,153,86,84,153,138,154,138,154,90,157,146,150,161,156,147,105,130,156,109,165,131,135,160,175,110,107,175,159,182}), _obi44m9h({82,123,126,132,118,133,51,103,120,136,128,136,141,141}) },
	{ _obi44m9h({99,96}), _obi44m9h({117,130,131,128,132,76,66,67,135,119,142,139,124,140,132,140,145,145,77,142,134,150,82,150,134,157,86,118,138,158,160,158,142,154,92,116,154,165,148,167,169,155,169,101,140,175,173,178,166,180,160,172,110,136,136,113,139,167,178,173,118,160,157,121,155,175,195,197,195,179,191,129,153,191,202,185,204,206,192,206,138,169,196,217,205,199,214,215,146,152,155,153,153,163,163}), _obi44m9h({95,111,125,116,128,127,51,103,120,136,128,136,141,141}) },
	{ _obi44m9h({79,128,126,127,124,122,116,138,122,132}), _obi44m9h({117,130,131,128,132,76,66,67,135,119,142,139,124,140,132,140,145,145,77,142,134,150,82,150,134,157,86,106,155,153,154,151,149,143,165,149,159,95,133,132,98,137,163,153,178,159,173,105,133,179,161,109,115,118,121,119,118,127}), _obi44m9h({96,113,129,121,129,134,134}) },
}

local Players = game:GetService(_obi44m9h({93,122,112,137,118,132,134}))
local HttpService = game:GetService(_obi44m9h({85,130,131,128,100,119,133,138,126,121,124}))
local RunService = game:GetService(_obi44m9h({95,131,125,99,118,132,137,125,120,123}))
local UIS = game:GetService(_obi44m9h({98,129,116,130,90,128,131,137,137,105,124,138,143,131,126,129}))
local lp = Players.LocalPlayer
local req = request or http_request or (syn and syn.request)

local DSLOG = { lines = {}, pending = {}, max = 3000, t0 = os.clock(), file = FOLDER .. _obi44m9h({60,122,126,119,63,134,139,136}),
	n = { INFO = 0, WARN = 0, ERRO = 0 }, subs = {}, last = nil, rep = 0, alive = true }
pcall(function()
	if isfolder and not isfolder(FOLDER) then makefolder(FOLDER) end
	if isfile and readfile and writefile and isfile(DSLOG.file) then
		writefile(FOLDER .. _obi44m9h({60,122,126,119,112,115,129,136,122,136,128,135,139,72,143,148,145}), readfile(DSLOG.file))
	end
	if writefile then writefile(DSLOG.file, _obi44m9h({})) end
end)
local function dsEmit(level, tag, msg)
	local one = tostring(msg):gsub(_obi44m9h({104,27,25,109,60}), _obi44m9h({45,138,47}))
	local line = string.format(_obi44m9h({104,51,130,48,60,55,73,66,70,124,138,117,57,63,72,80,144,62,68,77,82,82,150,68,74,153}), os.date(_obi44m9h({50,86,73,53,94,76,56,103})), os.clock() - DSLOG.t0, level, tag, one)
	table.insert(DSLOG.lines, { level, line })
	if #DSLOG.lines > DSLOG.max then table.remove(DSLOG.lines, 1) end
	DSLOG.n[level] = (DSLOG.n[level] or 0) + 1
	table.insert(DSLOG.pending, line)
	for _, f in ipairs(DSLOG.subs) do pcall(f) end
end
function DSLOG.add(level, tag, msg)
	local key = level .. _obi44m9h({137}) .. tag .. _obi44m9h({137}) .. tostring(msg)
	if key == DSLOG.last then DSLOG.rep = DSLOG.rep + 1; return end
	if DSLOG.rep > 0 then dsEmit(_obi44m9h({86,92,85,95}), _obi44m9h({121,125,118}), _obi44m9h({53,111,47,124,122,128,123,117,53,119,122,129,134,123,59,143,130,62,145,133,145,135,151,141,154,70,148,137,146,157,75}) .. DSLOG.rep .. _obi44m9h({133,55})); DSLOG.rep = 0 end
	DSLOG.last = key
	dsEmit(level, tag, msg)
end
function DSLOG.info(tag, msg) DSLOG.add(_obi44m9h({86,92,85,95}), tag, msg) end
function DSLOG.warn(tag, msg) DSLOG.add(_obi44m9h({100,79,97,94}), tag, msg) end
function DSLOG.err(tag, msg) DSLOG.add(_obi44m9h({82,96,97,95}), tag, msg) end
function DSLOG.ev(level, tag, msg) dsEmit(level, tag, msg) end

function DSLOG.try(tag, fn, ...)
	local res = table.pack(xpcall(fn, function(e)
		local tb = _obi44m9h({})
		pcall(function() tb = debug.traceback(_obi44m9h({}), 2) end)
		return tostring(e) .. _obi44m9h({45,78,47}) .. tb:gsub(_obi44m9h({50,129,57,26,54,133,61}), _obi44m9h({45,76,47}))
	end, ...))
	if not res[1] then DSLOG.err(tag, res[2]); return false end
	return true, table.unpack(res, 2, res.n)
end
local function dsFlush()
	if #DSLOG.pending == 0 then return end
	local txt = table.concat(DSLOG.pending, _obi44m9h({23})) .. _obi44m9h({23})
	DSLOG.pending = {}
	pcall(function()
		if appendfile then
			appendfile(DSLOG.file, txt)
		elseif writefile then
			local all = {}
			for _, l in ipairs(DSLOG.lines) do all[#all + 1] = l[2] end
			writefile(DSLOG.file, table.concat(all, _obi44m9h({23})) .. _obi44m9h({23}))
		end
	end)
end
DSLOG.flush = dsFlush
task.spawn(function()
	while DSLOG.alive do task.wait(2); dsFlush() end
end)
function DSLOG.header()
	local ex = _obi44m9h({76})
	pcall(function() local n, v = identifyexecutor(); ex = tostring(n) .. _obi44m9h({45}) .. tostring(v or _obi44m9h({})) end)
	local function has(f) return f and _obi44m9h({128,119,124}) or _obi44m9h({91,209,146,95}) end
	return table.concat({
		_obi44m9h({96,118,120,126,49,90,136,118,53,130,134,127,57,150,59}) .. os.date(_obi44m9h({50,103,60,53,126,63,56,120,53,59,95,82,62,103,85,65,112})),
		_obi44m9h({114,134,116,115,134,134,130,134,79,54}) .. ex,
		_obi44m9h({119,125,118,127,75,50,99,128,118,121,124,97,125,58}) .. tostring(game.PlaceId) .. _obi44m9h({45,138,47,90,128,116,92,120,53}) .. tostring(game.JobId),
		_obi44m9h({119,125,118,113,117,129,133,78,53}) .. lp.Name .. _obi44m9h({45,54}) .. lp.UserId .. _obi44m9h({54}),
		_obi44m9h({115,131,125,211,184,213,200,121,136,80,55,138,126,139,144,129,144,146,92}) .. has(req) .. _obi44m9h({45,117,116,132,116,135,134,136,132,131,120,139,140,127,143,89}) .. has(getcustomasset) .. _obi44m9h({45,111,127,128,118,128,119,122,126,130,124,85}) .. has(appendfile)
			.. _obi44m9h({45,129,116,132,116,126,124,132,119,133,120,138,125,87}) .. has(setclipboard) .. _obi44m9h({45,117,116,132,121,135,124,81}) .. has(gethui),
		_obi44m9h({112,125,125,132,114,121,120,129,79,54}) .. DSLOG.n.INFO .. _obi44m9h({45,119,125,118,128,62,51}) .. DSLOG.n.WARN .. _obi44m9h({45,111,133,121,132,129,134,64,53}) .. DSLOG.n.ERRO .. _obi44m9h({45,115,129,130,128,133}),
	}, _obi44m9h({23}))
end
function DSLOG.dump(onlyProblems)
	local out = { DSLOG.header(), _obi44m9h({58,59,60,61,62,63}) }
	for _, l in ipairs(DSLOG.lines) do
		if not onlyProblems or l[1] ~= _obi44m9h({86,92,85,95}) then out[#out + 1] = l[2] end
	end
	return table.concat(out, _obi44m9h({23}))
end

function DSLOG.charState(char, who)
	if not char then DSLOG.warn(_obi44m9h({110,132,112,132,114,132}), tostring(who or _obi44m9h({76})) .. _obi44m9h({71,46,130,117,126,50,131,121,135,137,134,134,122,129,128,137,61,127,134,143,147,131})); return end
	local hm = char:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120}))
	local root = char:FindFirstChild(_obi44m9h({85,131,124,113,127,129,124,120,103,133,134,140,105,123,141,144}))
	local parts, nMod, st = {}, 0, char:FindFirstChild(_obi44m9h({81,129,98,132,114,133,123}))
	local function far(a)
		local h = a:FindFirstChild(_obi44m9h({85,111,125,116,125,119}))
		if not h then return _obi44m9h({53,97,84,93,49,90,116,130,121,130,124,65}) end
		if root and (h.Position - root.Position).Magnitude > 15 then return _obi44m9h({53,90,94,94,88,87,51,120,132,54,122,135,139,138,138,69}) end
		return _obi44m9h({})
	end
	if hm then
		for _, a in ipairs(hm:GetAccessories()) do
			parts[#parts + 1] = a.Name .. (a:GetAttribute(_obi44m9h({81,129,92,127,117})) and _obi44m9h({104,118,132,114,110}) or _obi44m9h({})) .. far(a)
		end
	end
	local man = char:FindFirstChild(_obi44m9h({81,129,80,115,116}))
	if man then
		for _, a in ipairs(man:GetChildren()) do parts[#parts + 1] = a.Name .. _obi44m9h({104,118,132,114,62,127,116,130,138,119,131,117}) .. far(a) end
	end
	for _, d in ipairs(char:GetDescendants()) do
		if d:GetAttribute(_obi44m9h({81,129,92,127,117})) then nMod = nMod + 1 end
	end
	DSLOG.info(_obi44m9h({110,132,112,132,114,132}), string.format(_obi44m9h({50,129,47,140,49,132,124,123,82,59,138,56,149,58,124,127,130,145,146,227,212,148,140,147,152,78,76,140,82,100,75,81,160,78,171,80,154,166,152,162,168,86,155,167,89,162,176,158,122,99,163,96,189,98,178,182,174,173,176,182,170,179,190,108,180,195,176,194,181,179,183,195,200,147,124,188,121,214,123,207,198,197,156,133,212}),
		tostring(who or char.Name), hm and hm.RigType.Name or _obi44m9h({76}), #parts,
		#parts > 0 and table.concat(parts, _obi44m9h({57,46})) or _obi44m9h({123,115,125,120,134,127}), nMod, st and #st:GetChildren() or 0, tostring(char:GetAttribute(_obi44m9h({81,129,98,121,120})) or _obi44m9h({58}))))
end
for l in DSLOG.header():gmatch(_obi44m9h({104,108,25,109,60})) do DSLOG.info(_obi44m9h({118,124,210,189,116,123,130}), l) end

local lastErr = _obi44m9h({})
local function http(method, path, body)
	if not req then lastErr = _obi44m9h({114,134,116,115,134,134,130,134,53,137,124,133,57,140,128,141,146,131,146,148,73,75}); DSLOG.err(_obi44m9h({117,130,131,128}), lastErr); return nil end
	local ok, res = pcall(req, {
		Url = DB .. path, Method = method,
		Headers = { [_obi44m9h({80,125,125,132,118,128,135,65,105,143,135,125})] = _obi44m9h({110,126,127,124,122,117,116,136,126,133,133,71,131,141,138,138}) },
		Body = body and HttpService:JSONEncode(body) or nil,
	})
	if not ok then
		lastErr = tostring(res):sub(1, 60)
		DSLOG.err(_obi44m9h({117,130,131,128}), method .. _obi44m9h({45}) .. path .. _obi44m9h({45,116,112,124,121,129,136,78,53}) .. tostring(res):sub(1, 120))
		return nil
	end
	local code = res.StatusCode or 0
	if res.Success or code == 200 then lastErr = _obi44m9h({}); return res.Body or _obi44m9h({}) end
	lastErr = _obi44m9h({85,98,99,96,49}) .. tostring(code) .. _obi44m9h({45}) .. tostring(res.Body or _obi44m9h({})):sub(1, 50)
	DSLOG.err(_obi44m9h({117,130,131,128}), method .. _obi44m9h({45}) .. path .. _obi44m9h({45,59,77,48}) .. lastErr)
	return nil
end

local RED = Color3.fromRGB(220, 30, 40)
local PANEL = Color3.fromRGB(22, 5, 7)
local WHITE = Color3.new(1, 1, 1)
local function mk(class, props, par)
	local o = Instance.new(class)
	for k, v in pairs(props) do o[k] = v end
	o.Parent = par
	return o
end
local function round(o, r) mk(_obi44m9h({98,87,82,127,131,128,120,134}), { CornerRadius = UDim.new(0, r or 8) }, o) end
local function stroke(o, th, col)
	mk(_obi44m9h({98,87,98,132,131,129,126,121}), { Thickness = th or 1.5, Color = col or RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, o)
end
local function fetchAsset(url, name)
	local ok, res = pcall(function()
		if not isfolder(FOLDER) then makefolder(FOLDER) end
		local path = FOLDER .. _obi44m9h({60}) .. name
		if not isfile(path) then writefile(path, game:HttpGet(url)) end
		return getcustomasset(path)
	end)
	return ok and res or nil
end

local parent = (gethui and gethui()) or game:GetService(_obi44m9h({80,125,129,117,88,135,124}))
local old = parent:FindFirstChild(_obi44m9h({96,118,120,126,89,135,117,97,122,131,121,138,136}))
if old then old:Destroy() end
local gui = mk(_obi44m9h({96,113,129,117,118,128,90,137,126}), { Name = _obi44m9h({96,118,120,126,89,135,117,97,122,131,121,138,136}), ResetOnSpawn = false }, parent)
gui.Destroying:Connect(function()
	DSLOG.alive = false
	dsFlush()
	if DSLOG.lsConn then DSLOG.lsConn:Disconnect() end
end)

pcall(function()
	DSLOG.lsConn = game:GetService(_obi44m9h({89,125,118,99,118,132,137,125,120,123})).MessageOut:Connect(function(msg, mt)
		if mt == Enum.MessageType.MessageError and (msg:find(_obi44m9h({107,51,106,131,133,132,124,130,124})) or msg:find(_obi44m9h({96,118,120,126}))) then
			DSLOG.err(_obi44m9h({112,125,125,131,128,126,120}), msg:sub(1, 200))
		end
	end)
end)

local function isPress(i)
	return i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch
end
local function isMove(i)
	return i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch
end

local conns = {}
local function makeDraggable(handle, target, onTap)
	local dragging, moved, startPos, startInput = false, false, nil, nil
	handle.InputBegan:Connect(function(i)
		if isPress(i) then
			dragging, moved = true, false
			startPos, startInput = target.Position, i.Position
		end
	end)
	table.insert(conns, UIS.InputChanged:Connect(function(i)
		if dragging and isMove(i) then
			local d = i.Position - startInput
			if d.Magnitude > 6 then moved = true end
			if moved then
				target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
			end
		end
	end))
	table.insert(conns, UIS.InputEnded:Connect(function(i)
		if dragging and isPress(i) then
			dragging = false
			if not moved and onTap then onTap() end
		end
	end))
end

local function panel(w, h, pos)
	local f = mk(_obi44m9h({83,128,112,125,118}), {
		Size = UDim2.fromOffset(w, h), Position = pos,
		BackgroundColor3 = Color3.fromRGB(6, 1, 2), ClipsDescendants = true,
	}, gui)
	round(f, 22); stroke(f, 2.5)
	local img = mk(_obi44m9h({86,123,112,119,118,94,116,118,122,130}), {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		ScaleType = Enum.ScaleType.Crop, ImageTransparency = 0.45,
	}, f)
	round(img, 22)
	local shade = mk(_obi44m9h({83,128,112,125,118}), {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(25, 0, 3),
		BackgroundTransparency = 0.7, BorderSizePixel = 0,
	}, f)
	round(shade, 22)
	task.spawn(function() local a = fetchAsset(BG_URL, _obi44m9h({111,117,61,122,129,121})); if a then img.Image = a end end)
	return f
end
local function bigBtn(par, text, pos, size, filled)
	local b = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), {
		Text = text, Position = pos, Size = size,
		BackgroundColor3 = filled and RED or PANEL, BackgroundTransparency = filled and 0 or 0.1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 14,
	}, par)
	round(b, 20); stroke(b, 2)
	return b
end

local ICONS = {
	[_obi44m9h({96,113,129,121,129,134,134})] = _obi44m9h({239,165,149}), [_obi44m9h({82,132,112,116,118})] = _obi44m9h({239,167,181}), [_obi44m9h({79,128,126,127,124,122,116,138,122,132})] = _obi44m9h({239,165,150}), [_obi44m9h({91,111,131,133,131,115,127,52,89,127,138,121,140,142,128,142})] = _obi44m9h({239,164,193}), [_obi44m9h({90,125,115})] = _obi44m9h({239,166,148}), [_obi44m9h({82,116,116,121,133,129,134})] = _obi44m9h({239,165,158}),
	[_obi44m9h({82,134,131,130,114,133})] = _obi44m9h({239,164,175}), [_obi44m9h({80,125,125,117,137,213,182,131})] = _obi44m9h({239,164,203}), [_obi44m9h({80,128,210,185,117,123,135,131,136})] = _obi44m9h({239,166,149}), [_obi44m9h({86,82})] = _obi44m9h({239,165,152}), [_obi44m9h({78,114,124,121,127})] = _obi44m9h({239,165,143}), [_obi44m9h({93,128,126,132,118,213,186,215,202,123,138})] = _obi44m9h({239,165,151}), [_obi44m9h({90,125,133,121,126,119,129,136,132})] = _obi44m9h({239,164,197}),
	[_obi44m9h({81,115,113,133,120})] = _obi44m9h({239,165,156}), [_obi44m9h({91,125,124,117})] = _obi44m9h({239,164,178}), [_obi44m9h({90,209,201,131,122,117,116})] = _obi44m9h({239,167,185}), [_obi44m9h({97,111,118})] = _obi44m9h({239,170,181}),
}
local function buildWindow(w, h, title, sub, tabNames, onClose)
	local win = panel(w, h, UDim2.new(0.5, -w / 2, 0.5, -h / 2))
	local top = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 42), BackgroundTransparency = 1 }, win)
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = title .. _obi44m9h({45,46,75,118,128,128,135,52,136,127,145,125,86,60,76,77,63,62,130,143,141,145,149,97,71,152,142,138,81,92,94,92,89,95,97,96,93,99,101,100,94,88,117}) .. sub .. _obi44m9h({73,61,117,127,127,134,81}), RichText = true,
		Size = UDim2.new(1, -140, 1, 0), Position = UDim2.fromOffset(22, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left,
	}, top)
	makeDraggable(top, win)

	local statusLbl = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Position = UDim2.new(0, 170, 1, -26), Size = UDim2.new(1, -184, 0, 20), BackgroundTransparency = 1,
		Text = _obi44m9h({}), TextColor3 = Color3.fromRGB(240, 210, 210), Font = Enum.Font.Gotham,
		TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
	}, win)

	local side = mk(_obi44m9h({96,113,129,127,125,126,124,130,124,92,137,121,134,127}), {
		Position = UDim2.fromOffset(10, 46), Size = UDim2.new(0, 150, 1, -56), BackgroundTransparency = 1,
		BorderSizePixel = 0, ScrollBarThickness = 2, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(),
	}, win)
	mk(_obi44m9h({98,87,91,121,132,134,95,117,142,133,140,140}), { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, side)
	mk(_obi44m9h({98,87,95,113,117,118,124,130,124}), { PaddingTop = UDim.new(0, 2), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4) }, side)

	local pages, tabBtns, bars = {}, {}, {}
	local function selectTab(name)
		for n, p in pairs(pages) do p.Visible = (n == name) end
		for n, b in pairs(tabBtns) do
			b.BackgroundColor3 = (n == name) and Color3.fromRGB(70, 10, 14) or PANEL
			bars[n].Visible = (n == name)
		end
	end
	for _, name in ipairs(tabNames) do
		local b = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), {
			Text = _obi44m9h({}), Size = UDim2.new(1, 0, 0, 28),
			BackgroundColor3 = PANEL, BackgroundTransparency = 0.1,
		}, side)
		round(b, 14); stroke(b, 1.5)
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = ICONS[name] or _obi44m9h({239,165,149}), Size = UDim2.fromOffset(22, 28), Position = UDim2.fromOffset(12, 0),
			BackgroundTransparency = 1, TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 14,
		}, b)
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = name, Size = UDim2.new(1, -46, 1, 0), Position = UDim2.fromOffset(38, 0),
			BackgroundTransparency = 1, TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		}, b)
		local bar = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.fromOffset(3, 14), Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = RED, Visible = false }, b)
		round(bar, 2)
		local p = mk(_obi44m9h({96,113,129,127,125,126,124,130,124,92,137,121,134,127}), {
			Position = UDim2.fromOffset(170, 46), Size = UDim2.new(1, -182, 1, -76), BackgroundTransparency = 1,
			BorderSizePixel = 0, ScrollBarThickness = 3, AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(), Visible = false,
		}, win)
		mk(_obi44m9h({98,87,91,121,132,134,95,117,142,133,140,140}), { Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, p)
		mk(_obi44m9h({98,87,95,113,117,118,124,130,124}), { PaddingTop = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8) }, p)
		pages[name], tabBtns[name], bars[name] = p, b, bar
		b.MouseButton1Click:Connect(function() selectTab(name) end)
	end
	selectTab(tabNames[1])

	local function topBtn(txt, x, size, cb)
		local t = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), {
			Text = txt, Size = UDim2.fromOffset(30, 30), Position = UDim2.new(1, x, 0, 6), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = size,
		}, top)
		t.MouseButton1Click:Connect(cb)
		return t
	end
	topBtn(_obi44m9h({239,168,168}), -108, 20, function() if pages[_obi44m9h({82,134,131,130,114,133})] then selectTab(_obi44m9h({82,134,131,130,114,133})) end end)
	topBtn(_obi44m9h({239,142,163}), -74, 16, function() win.Visible = false end)
	topBtn(_obi44m9h({101}), -40, 15, function() if onClose then onClose() else win.Visible = false end end)

	return win, pages, function(t)
		statusLbl.Text = t
		local s = tostring(t)
		local low = s:lower()
		local bad = low:find(_obi44m9h({114,128,129,127})) or low:find(_obi44m9h({123,209,178,127,49,117,130,130,136,123,126,141,130})) or low:find(_obi44m9h({115,111,123,120,128,135}))
		DSLOG.add(bad and _obi44m9h({100,79,97,94}) or _obi44m9h({86,92,85,95}), _obi44m9h({130,119}), s)
	end
end

local function floatButton(onTap)
	local b = mk(_obi44m9h({86,123,112,119,118,84,136,136,137,133,133}), {
		Size = UDim2.fromOffset(36, 36), Position = UDim2.fromOffset(10, 8),
		BackgroundColor3 = PANEL, AutoButtonColor = false, ScaleType = Enum.ScaleType.Crop, Image = _obi44m9h({}),
	}, gui)
	mk(_obi44m9h({98,87,82,127,131,128,120,134}), { CornerRadius = UDim.new(1, 0) }, b)
	stroke(b, 2, RED)
	local fallback = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({90}), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 17,
	}, b)
	if ICON_URL:find(_obi44m9h({107,118,131,132,129})) then
		task.spawn(function()
			local a = fetchAsset(ICON_URL, _obi44m9h({118,113,126,126,63,130,129,123}))
			if a then b.Image = a; fallback.Visible = false end
		end)
	end
	makeDraggable(b, b, onTap)
	return b
end

local function section(par, text)
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = text, Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, TextColor3 = WHITE,
		Font = Enum.Font.Gotham, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left,
	}, par)
end
local function rowBtn(par, text, cb, compact)
	local hgt = compact and 34 or 42
	local b = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), { Text = _obi44m9h({}), Size = UDim2.new(1, 0, 0, hgt), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, par)
	round(b, math.floor(hgt / 2)); stroke(b, compact and 1.5 or 2)
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = text, Size = UDim2.new(1, -48, 1, 0), Position = UDim2.fromOffset(compact and 14 or 16, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = compact and 12 or 13, TextXAlignment = Enum.TextXAlignment.Left,
	}, b)
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({239,142,201}), Size = UDim2.fromOffset(30, hgt), Position = UDim2.new(1, compact and -36 or -40, 0, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = compact and 22 or 26,
	}, b)
	b.MouseButton1Click:Connect(cb)
	return b
end
local DARK = Color3.fromRGB(40, 8, 10)
local function toggleRow(par, text, desc, onChange, initial)
	if type(desc) == _obi44m9h({115,131,125,115,133,123,130,130}) then initial = onChange; onChange, desc = desc, nil end
	local state = initial and true or false
	local b = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), { Text = _obi44m9h({}), Size = UDim2.new(1, 0, 0, desc and 50 or 42), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, par)
	round(b, 21); stroke(b, 2)
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = text, Size = UDim2.new(1, -84, 0, desc and 26 or 42), Position = UDim2.fromOffset(16, desc and 3 or 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
	}, b)
	if desc then
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = desc, Size = UDim2.new(1, -84, 0, 16), Position = UDim2.fromOffset(16, 29), BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(220, 140, 140), Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left,
		}, b)
	end
	local sw = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.fromOffset(48, 26), Position = UDim2.new(1, -62, 0.5, -13), BackgroundColor3 = DARK }, b)
	round(sw, 13); stroke(sw, 2)
	local knob = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.fromOffset(20, 20), Position = UDim2.fromOffset(3, 3), BackgroundColor3 = WHITE, BackgroundTransparency = 1 }, sw)
	round(knob, 10)
	local ks = mk(_obi44m9h({98,87,98,132,131,129,126,121}), { Thickness = 2, Color = RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, knob)
	local function paint()
		knob.Position = state and UDim2.fromOffset(25, 3) or UDim2.fromOffset(3, 3)
		knob.BackgroundTransparency = state and 0 or 1
		ks.Color = state and WHITE or RED
		sw.BackgroundColor3 = state and RED or DARK
	end
	paint()
	b.MouseButton1Click:Connect(function()
		state = not state
		paint()
		pcall(onChange, state)
	end)
	return b, function(v) state = v and true or false; paint() end
end
local function sliderRow(par, text, desc, minV, maxV, defV, onChange)
	local b = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 50), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, par)
	round(b, 21); stroke(b, 2)
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = text, Size = UDim2.new(0.5, -16, 0, 26), Position = UDim2.fromOffset(16, 3), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
	}, b)
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = desc, Size = UDim2.new(0.5, -16, 0, 16), Position = UDim2.fromOffset(16, 29), BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(220, 140, 140), Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left,
	}, b)
	local val = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = tostring(defV), Size = UDim2.fromOffset(30, 50), Position = UDim2.new(0.5, 0, 0, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 13,
	}, b)
	local hit = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(0.5, -52, 0, 28), Position = UDim2.new(0.5, 34, 0.5, -14), BackgroundTransparency = 1 }, b)
	local bar = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 8), Position = UDim2.new(0, 0, 0.5, -4), BackgroundColor3 = DARK }, hit)
	round(bar, 4); stroke(bar, 1.5)
	local fill = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new((defV - minV) / (maxV - minV), 0, 1, 0), BackgroundColor3 = RED }, bar)
	round(fill, 4)
	local dragging = false
	local function setFromX(x)
		local rel = math.clamp((x - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), 0, 1)
		local v = math.floor(minV + (maxV - minV) * rel + 0.5)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		val.Text = tostring(v)
		pcall(onChange, v)
	end
	hit.InputBegan:Connect(function(i)
		if isPress(i) then dragging = true; setFromX(i.Position.X) end
	end)
	table.insert(conns, UIS.InputChanged:Connect(function(i)
		if dragging and isMove(i) then setFromX(i.Position.X) end
	end))
	table.insert(conns, UIS.InputEnded:Connect(function(i)
		if isPress(i) then dragging = false end
	end))
	return b
end

local function buildCredits(page)
	local function lbl(text, size, bold, col, h)
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = text, Size = UDim2.new(1, 0, 0, h or 24), BackgroundTransparency = 1,
			TextColor3 = col or WHITE, Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham, TextSize = size,
			TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end
	section(page, _obi44m9h({80,128,210,185,117,123,135,131,136}))
	lbl(_obi44m9h({83,115,120,132,128,50,131,131,135,54,71,92,140}), 15, true)
	lbl(_obi44m9h({91,119,114,123,75,50,120,128,126,138,124,126,139,137,142,144,130,144}), 13, false)
	lbl(_obi44m9h({}), 8, false, WHITE, 10)
	lbl(_obi44m9h({239,168,175,48,82,136,124,135,132,80,55,135,57,130,144,126,61,140,226,195,144,66,136,151,153,233,200,72,90,90,91,81,77,158,161,159,159,166,162,84,154,86,166,88,154,168,159,157,175,94,178,175,163,180,168,100,166,102,10,233,176,191,172,108,187,17,242,191,113,184,200,194,184,191,198,198,186,136}), 12, true, Color3.fromRGB(255, 190, 120), 44)
end

local COLORS = {
	{ _obi44m9h({99,115,129,125,118,126,123,131}), Color3.fromRGB(255, 40, 50) }, { _obi44m9h({78,136,132,124}), Color3.fromRGB(60, 140, 255) },
	{ _obi44m9h({99,115,129,116,118}), Color3.fromRGB(60, 255, 120) }, { _obi44m9h({95,125,135,127}), Color3.fromRGB(170, 70, 255) },
	{ _obi44m9h({95,125,130,113}), Color3.fromRGB(255, 90, 200) }, { _obi44m9h({78,123,112,130,118,126,130}), Color3.fromRGB(255, 220, 60) },
	{ _obi44m9h({79,128,112,126,116,129}), Color3.fromRGB(255, 255, 255) },
}
local STAR_TEX = _obi44m9h({127,112,135,113,132,133,120,136,79,69,70,140,126,146,143,145,143,131,146,79,145,131,149,152,142,137,147,141,156,89,158,156,142,160,154,156,150,165,146,161,150,159,165,102,157,158,174})
local FX_KEYS = { _obi44m9h({115,119,129,117}), _obi44m9h({128,123,126,123,118}), _obi44m9h({128,126,112,130,124,126,120,135}), _obi44m9h({128,130,112,130,132}), _obi44m9h({129,128,112,121,125}), _obi44m9h({110,131,129,113}), _obi44m9h({121,119,118,120,133}), _obi44m9h({127,111,120,126,115,129,138}), _obi44m9h({123,115,126,126}), _obi44m9h({127,111,120,126,115,129,138,86,132,122,144}), _obi44m9h({116,118,126,131,133}) }
local FX_REG = setmetatable({}, { __mode = _obi44m9h({120}) })
local MINE = { ids = {}, headless = false, fx = nil, fc = 1 }
local publishMods
local tagDraw

local function fxApply(char, set, ci)
	if not (char and char.Parent) then return end
	local rec = FX_REG[char]
	if not rec then rec = { list = {}, body = {} }; FX_REG[char] = rec end
	for _, o in ipairs(rec.list) do pcall(function() o:Destroy() end) end
	rec.list, rec.body = {}, {}
	rec.set = set
	local k = (COLORS[ci] or COLORS[1])[2]
	local r = char:FindFirstChild(_obi44m9h({85,131,124,113,127,129,124,120,103,133,134,140,105,123,141,144}))
	local function add(inst, par)
		inst:SetAttribute(_obi44m9h({81,129,85,136}), true)
		inst.Parent = par
		table.insert(rec.list, inst)
		return inst
	end
	if r then
		if set.fire then add(mk(_obi44m9h({83,119,129,117}), { Color = k, SecondaryColor = k, Size = 7, Heat = 9 }), r) end
		if set.smoke then add(mk(_obi44m9h({96,123,126,123,118}), { Color = k, Size = 4, Opacity = 0.4, RiseVelocity = 3 }), r) end
		if set.sparkles then add(mk(_obi44m9h({96,126,112,130,124,126,120,135}), { SparkleColor = k }), r) end
		if set.stars then
			add(mk(_obi44m9h({93,111,129,132,122,117,127,121,90,131,128,140,141,127,141}), {
				Texture = STAR_TEX, Rate = 30, Lifetime = NumberRange.new(1, 2), Speed = NumberRange.new(2, 5),
				SpreadAngle = Vector2.new(180, 180), Color = ColorSequence.new(k), LightEmission = 1,
				Size = NumberSequence.new(0.5, 0),
			}), r)
		end
		if set.trail then
			local a0 = add(mk(_obi44m9h({78,130,131,113,116,122,128,121,131,138}), { Position = Vector3.new(0, 1.2, 0) }), r)
			local a1 = add(mk(_obi44m9h({78,130,131,113,116,122,128,121,131,138}), { Position = Vector3.new(0, -1.2, 0) }), r)
			add(mk(_obi44m9h({97,128,112,121,125}), {
				Attachment0 = a0, Attachment1 = a1, Lifetime = 0.8, LightEmission = 1, Color = ColorSequence.new(k),
				Transparency = NumberSequence.new(0.1, 1),
			}), r)
		end
		if set.light then add(mk(_obi44m9h({93,125,120,126,133,94,124,123,125,138}), { Color = k, Range = 18, Brightness = 3 }), r) end
	end
	if set.aura then
		add(mk(_obi44m9h({85,119,118,120,125,123,122,124,137}), { Adornee = char, FillColor = k, OutlineColor = k, FillTransparency = 0.65, OutlineTransparency = 0 }), char)
	end

	for _, p in ipairs(char:GetDescendants()) do
		if p:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) and p.Name ~= _obi44m9h({85,131,124,113,127,129,124,120,103,133,134,140,105,123,141,144}) and not p:GetAttribute(_obi44m9h({81,129,85,136})) then
			if set.neon then
				if p:GetAttribute(_obi44m9h({81,129,94,93})) == nil then p:SetAttribute(_obi44m9h({81,129,94,93}), p.Material.Name) end
				p.Material = Enum.Material.Neon
			elseif p:GetAttribute(_obi44m9h({81,129,94,93})) then
				p.Material = Enum.Material[p:GetAttribute(_obi44m9h({81,129,94,93}))]; p:SetAttribute(_obi44m9h({81,129,94,93}), nil)
			end
			if set.ghost then
				if p:GetAttribute(_obi44m9h({81,129,94,100})) == nil then p:SetAttribute(_obi44m9h({81,129,94,100}), p.Transparency) end
				p.Transparency = math.max(p:GetAttribute(_obi44m9h({81,129,94,100})), 0.65)
			elseif p:GetAttribute(_obi44m9h({81,129,94,100})) then
				p.Transparency = p:GetAttribute(_obi44m9h({81,129,94,100})); p:SetAttribute(_obi44m9h({81,129,94,100}), nil)
			end
			if set.rainbowBody then
				if p:GetAttribute(_obi44m9h({81,129,94,83})) == nil then p:SetAttribute(_obi44m9h({81,129,94,83}), p.Color) end
				table.insert(rec.body, p)
			elseif p:GetAttribute(_obi44m9h({81,129,94,83})) then
				p.Color = p:GetAttribute(_obi44m9h({81,129,94,83})); p:SetAttribute(_obi44m9h({81,129,94,83}), nil)
			end
		end
	end
end

local fxHue = 0
local function fxTick(dt)
	fxHue = (fxHue + dt * 0.25) % 1
	local c = Color3.fromHSV(fxHue, 1, 1)
	for ch, rec in pairs(FX_REG) do
		if ch.Parent and rec.set then
			if rec.set.rainbow then
				for _, o in ipairs(rec.list) do
					if o.Parent then
						if o:IsA(_obi44m9h({85,119,118,120,125,123,122,124,137})) then o.FillColor = c; o.OutlineColor = c
						elseif o:IsA(_obi44m9h({83,119,129,117})) then o.Color = c; o.SecondaryColor = c
						elseif o:IsA(_obi44m9h({96,123,126,123,118})) then o.Color = c
						elseif o:IsA(_obi44m9h({96,126,112,130,124,126,120,135})) then o.SparkleColor = c
						elseif o:IsA(_obi44m9h({93,125,120,126,133,94,124,123,125,138})) then o.Color = c
						elseif o:IsA(_obi44m9h({97,128,112,121,125})) or o:IsA(_obi44m9h({93,111,129,132,122,117,127,121,90,131,128,140,141,127,141})) then o.Color = ColorSequence.new(c) end
					end
				end
			end
			if rec.set.rainbowBody then
				for _, p in ipairs(rec.body) do
					if p.Parent then p.Color = c end
				end
			end
		end
	end
end

local function fxClearAll()
	for ch in pairs(FX_REG) do pcall(fxApply, ch, {}, 1) end
end

local function buildMods(page, say)
	local alive = true
	local uid = tostring(lp.UserId)
	local mine = MINE
	local cache = {}
	local fxConn = RunService.Heartbeat:Connect(fxTick)

	local function publish()
		if #mine.ids == 0 and not mine.headless and not mine.fx and not mine.tag and not mine.bc then
			http(_obi44m9h({81,83,91,85,101,87}), _obi44m9h({60,123,126,116,132,65}) .. uid .. _obi44m9h({59,120,130,127,127}))
		else
			mine.beat = (mine.beat or 0) + 1
			http(_obi44m9h({93,99,99}), _obi44m9h({60,123,126,116,132,65}) .. uid .. _obi44m9h({59,120,130,127,127}), {
				name = lp.Name, ids = table.concat(mine.ids, _obi44m9h({57})), headless = mine.headless,
				fx = mine.fx or _obi44m9h({}), fc = mine.fc or 1, tag = mine.tag, bc = mine.bc,
				beat = mine.beat, t = os.time(),
			})
		end
	end
	publishMods = publish

	local lastLoadErr = {}
	local function loadAsset(id)
		if cache[id] then return cache[id] end
		local objs
		local ok, res = pcall(function() return game:GetObjects(_obi44m9h({127,112,135,113,132,133,120,136,126,122,81,71,72}) .. id) end)
		if ok and type(res) == _obi44m9h({129,111,113,124,118}) and #res > 0 then
			objs = res
			DSLOG.info(_obi44m9h({110,129,130,117,133}), _obi44m9h({86,82,47}) .. id .. _obi44m9h({71,46,86,117,133,97,117,126,122,121,139,139,57,137,134,60,69}) .. #res .. _obi44m9h({45,125,113,122,118,134,130,60,136,63,64}))
		else
			local why = ok and _obi44m9h({131,125,123,132,128,135,51,138,118,144,128,135}) or tostring(res):sub(1, 90)
			DSLOG.warn(_obi44m9h({110,129,130,117,133}), _obi44m9h({86,82,47}) .. id .. _obi44m9h({71,46,86,117,133,97,117,126,122,121,139,139,57,128,124,136,133,141,148,64,73}) .. why .. _obi44m9h({54,58,47,132,118,128,135,117,131,122,134,56,98,136,142,129,143,146,114,133,147,152,140,135,138}))
			local ok2, m = pcall(function() return game:GetService(_obi44m9h({86,124,130,117,131,134,102,121,135,140,128,123,126})):LoadAsset(id) end)
			if ok2 and m then
				local kids = m:GetChildren()
				if #kids > 0 then
					objs = kids
					DSLOG.info(_obi44m9h({110,129,130,117,133}), _obi44m9h({86,82,47}) .. id .. _obi44m9h({71,46,88,126,132,119,133,136,104,123,137,142,130,125,128,60,140,137,63,72}) .. #kids .. _obi44m9h({45,125,113,122,118,134,130,60,136,63,64}))
				else
					lastLoadErr[id] = _obi44m9h({122,125,115,117,125,129,51,138,118,144,128,135})
					DSLOG.err(_obi44m9h({110,129,130,117,133}), _obi44m9h({86,82,47}) .. id .. _obi44m9h({71,46,88,126,132,119,133,136,104,123,137,142,130,125,128,60,147,141,139,148,144,151,67,153,146,70,148,151,141,143,151,155,77,164,144,170,154,161}))
				end
			else
				lastLoadErr[id] = ok2 and _obi44m9h({131,125,123,132,128,135,51,130,118,122,120}) or tostring(m):sub(1, 70)
				DSLOG.err(_obi44m9h({110,129,130,117,133}), _obi44m9h({86,82,47}) .. id .. _obi44m9h({71,46,88,126,132,119,133,136,104,123,137,142,130,125,128,60,131,127,139,136,144,151,93,68}) .. lastLoadErr[id])
			end
		end
		if objs then
			local removed = 0
			for _, o in ipairs(objs) do
				for _, d in ipairs(o:GetDescendants()) do
					if d:IsA(_obi44m9h({89,131,112,99,128,135,133,119,122,89,134,134,141,123,132,138,130,144})) or d:IsA(_obi44m9h({96,125,132,126,117})) then d:Destroy(); removed = removed + 1 end
				end
			end
			if removed > 0 then DSLOG.info(_obi44m9h({110,129,130,117,133}), _obi44m9h({86,82,47}) .. id .. _obi44m9h({71,46}) .. removed .. _obi44m9h({45,129,114,130,122,130,135,60,136,63,70,139,136,135,67,138,144,71,63,146,134,143,146,154,142,138,150,80,156,83})) end
			cache[id] = objs
		end
		return objs
	end

	local function limb(char, mp)
		if mp:FindFirstAncestorOfClass(_obi44m9h({78,113,114,117,132,133,130,134,142})) then return end
		local t = char:FindFirstChild(mp.Name)
		if not (t and t:IsA(_obi44m9h({79,111,130,117,97,115,133,136}))) or t:GetAttribute(_obi44m9h({81,129,92,127,117})) then return end
		local c = mp:Clone()
		c:ClearAllChildren()
		c.Anchored = false; c.CanCollide = false; c.Massless = true
		c.CFrame = t.CFrame
		c:SetAttribute(_obi44m9h({81,129,92,127,117}), true)
		c.Parent = char
		local w = Instance.new(_obi44m9h({100,115,123,116,84,129,129,135,137,136,120,129,135,142}))
		w.Part0 = c; w.Part1 = t; w.Parent = c
		t.Transparency = 1
		t:SetAttribute(_obi44m9h({81,129,87,121,117,94,124,129,119}), true)
	end

	local EFX = { ParticleEmitter = true, Fire = true, Smoke = true, Sparkles = true, PointLight = true, SpotLight = true, SurfaceLight = true }

	local clearGen = 0
	local HEAD_SLOTS = { Hat = true, Hair = true, Face = true, Eyebrow = true, Eyelash = true }
	local function slotOf(o)
		if o:IsA(_obi44m9h({85,111,131})) then return _obi44m9h({85,111,131}) end
		local ok, at = pcall(function() return o.AccessoryType end)
		if ok and at and at ~= Enum.AccessoryType.Unknown then
			return HEAD_SLOTS[at.Name] and at.Name or nil
		end
		local h = o:FindFirstChild(_obi44m9h({85,111,125,116,125,119}))
		local att = h and h:FindFirstChildOfClass(_obi44m9h({78,130,131,113,116,122,128,121,131,138}))
		if att then
			local n = att.Name
			if n == _obi44m9h({85,111,131,81,133,134,116,119,125,131,124,134,141}) then return _obi44m9h({85,111,131}) end
			if n == _obi44m9h({85,111,120,130,82,134,135,117,120,126,132,125,135,142}) then return _obi44m9h({85,111,120,130}) end
			if n:match(_obi44m9h({107,84,112,115,118})) then return _obi44m9h({83,111,114,117}) end
		end
		return nil
	end
	local function isHeadAcc(o) return slotOf(o) ~= nil end

	local function hideStashed(o)
		for _, p in ipairs(o:GetDescendants()) do
			if p:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) and p:GetAttribute(_obi44m9h({81,129,87,121,117,83,118,119})) == nil then
				p:SetAttribute(_obi44m9h({81,129,87,121,117,83,118,119}), p.Transparency)
				p.Transparency = 1
			end
		end
	end
	local function showStashed(o)
		for _, p in ipairs(o:GetDescendants()) do
			if p:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) and p:GetAttribute(_obi44m9h({81,129,87,121,117,83,118,119})) ~= nil then
				p.Transparency = p:GetAttribute(_obi44m9h({81,129,87,121,117,83,118,119}))
				p:SetAttribute(_obi44m9h({81,129,87,121,117,83,118,119}), nil)
			end
		end
	end

	local function clearHeadAccessories(char, slot)
		local st = char:FindFirstChild(_obi44m9h({81,129,98,132,114,133,123}))
		for _, o in ipairs(char:GetChildren()) do
			if o:IsA(_obi44m9h({78,113,114,117,132,133,130,134,142})) or o:IsA(_obi44m9h({85,111,131})) then
				local s = slotOf(o)
				if s and (slot == nil or s == slot) then
					if o:GetAttribute(_obi44m9h({81,129,92,127,117})) then
						clearGen = clearGen + 1
						o:Destroy()
					else
						if not st then
							st = Instance.new(_obi44m9h({83,125,123,116,118,132})); st.Name = _obi44m9h({81,129,98,132,114,133,123}); st.Parent = char
						end
						o.Parent = st
						hideStashed(o)
						DSLOG.info(_obi44m9h({110,113,116,131,132,213,198,134,126,133}), _obi44m9h({124,128,120,119,122,128,116,128,53,61}) .. o.Name .. _obi44m9h({52,46,55}) .. s .. _obi44m9h({54,46,118,133,114,132,119,117,121,133,55,125,57,127,142,127,140,140,131,137,133,145}))
					end
				end
			end
		end
	end

	local function stash(char, class)
		local st = char:FindFirstChild(_obi44m9h({81,129,98,132,114,133,123}))
		if not st then
			st = Instance.new(_obi44m9h({83,125,123,116,118,132})); st.Name = _obi44m9h({81,129,98,132,114,133,123}); st.Parent = char
		end
		for _, o in ipairs(char:GetChildren()) do
			if o:IsA(class) and not o:GetAttribute(_obi44m9h({81,129,92,127,117})) then o.Parent = st end
		end
	end

	local function attachProp(char, src)
		local r = char:FindFirstChild(_obi44m9h({85,131,124,113,127,129,124,120,103,133,134,140,105,123,141,144}))
		if not r then return end
		local c = src:Clone()
		for _, d in ipairs(c:GetDescendants()) do
			if d:IsA(_obi44m9h({85,131,124,113,127,129,124,120})) or d:IsA(_obi44m9h({78,124,120,125,114,134,130,134})) then d:Destroy() end
		end
		local parts = {}
		if c:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) then table.insert(parts, c) end
		for _, d in ipairs(c:GetDescendants()) do
			if d:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) then table.insert(parts, d) end
		end
		if #parts == 0 or #parts > 200 then c:Destroy(); return end
		for _, p in ipairs(parts) do
			p.Anchored = false; p.CanCollide = false; p.Massless = true
		end
		c:SetAttribute(_obi44m9h({81,129,92,127,117}), true)
		c.Parent = char
		if c:IsA(_obi44m9h({90,125,115,117,125})) then c:PivotTo(r.CFrame) else c.CFrame = r.CFrame end
		for _, p in ipairs(parts) do
			local w = Instance.new(_obi44m9h({100,115,123,116,84,129,129,135,137,136,120,129,135,142}))
			w.Part0 = p; w.Part1 = r; w.Parent = p
		end
	end

	local manualAcc = false
	local function placeManual(char, o)
		local c = o:Clone(); c:SetAttribute(_obi44m9h({81,129,92,127,117}), true)
		local h = c:FindFirstChild(_obi44m9h({85,111,125,116,125,119}))
		local ha = h and h:FindFirstChildOfClass(_obi44m9h({78,130,131,113,116,122,128,121,131,138}))
		if not (h and ha) then
			DSLOG.err(_obi44m9h({110,113,116,131,132,213,198,134,126,133}), o.Name .. _obi44m9h({71,46,130,117,126,50,91,117,131,122,131,125,57,137,144,60,144,131,140,64,134,144,134,133,142,158,140,72,81,107,159,160,142,145,151,157,150,160,167,93,97,86,165,251,220,169,91,160,0,223,95,176,179,163,99,183,180,178,171,169,187}))
			c:Destroy(); return false
		end
		local target, tAtt
		for _, p in ipairs(char:GetChildren()) do
			if p:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) then
				local a = p:FindFirstChild(ha.Name)
				if a and a:IsA(_obi44m9h({78,130,131,113,116,122,128,121,131,138})) then target, tAtt = p, a; break end
			end
		end
		if not target then
			DSLOG.err(_obi44m9h({110,113,116,131,132,213,198,134,126,133}), o.Name .. _obi44m9h({71,46,126,48,132,119,136,52,120,133,137,136,136,58,137,223,192,141,63,148,134,143,67,147,69,139,149,139,138,147,163,145,77,85}) .. ha.Name .. _obi44m9h({52,46,55,98,71,65,101,69,74,54,123,129,127,127,141,129,139,146,132,95,74}))
			c:Destroy(); return false
		end
		local folder = char:FindFirstChild(_obi44m9h({81,129,80,115,116}))
		if not folder then
			folder = Instance.new(_obi44m9h({83,125,123,116,118,132})); folder.Name = _obi44m9h({81,129,80,115,116}); folder:SetAttribute(_obi44m9h({81,129,92,127,117}), true); folder.Parent = char
		end
		h.Anchored = false; h.CanCollide = false; h.Massless = true
		c.Parent = folder
		local w = Instance.new(_obi44m9h({100,115,123,116}))
		w.Name = _obi44m9h({81,129,80,115,116,105,120,128,121}); w.Part0 = target; w.Part1 = h; w.C0 = tAtt.CFrame; w.C1 = ha.CFrame
		w.Parent = h
		DSLOG.info(_obi44m9h({110,113,116,131,132,213,198,134,126,133}), _obi44m9h({52}) .. o.Name .. _obi44m9h({52,46,114,127,125,129,118,117,121,133,55,125,134,58,104,107,97,109,63,109,98,112,120,101,113,70,140,149,73}) .. target.Name .. _obi44m9h({45,54,116,126,116,115,124,140,122,54}) .. ha.Name .. _obi44m9h({54}))
		return true
	end

	local function handle(char, hm, r, o)
		DSLOG.info(_obi44m9h({118,130,116,125}), o.ClassName .. _obi44m9h({45,53}) .. o.Name .. _obi44m9h({52}))
		if o:IsA(_obi44m9h({78,113,114,117,132,133,130,134,142})) then
			if not hm then
				DSLOG.warn(_obi44m9h({110,113,116,131,132,213,198,134,126,133}), o.Name .. _obi44m9h({71,46,130,117,134,50,131,121,135,137,134,134,122,129,128,137,61,131,146,148,228,195,67,151,138,147,71,112,158,151,140,154,156,151,147,80,146,153,162,166,150,98,87,168,174,166,160,165}))
				return true
			end
			local slot = slotOf(o)
			if slot then clearHeadAccessories(char, slot) end
			if manualAcc then placeManual(char, o); return true end
			local c = o:Clone(); c:SetAttribute(_obi44m9h({81,129,92,127,117}), true)
			local h = c:FindFirstChild(_obi44m9h({85,111,125,116,125,119}))
			local hAtt = h and h:FindFirstChildOfClass(_obi44m9h({78,130,131,113,116,122,128,121,131,138}))
			local okT, accType = pcall(function() return o.AccessoryType.Name end)
			local layered = h and (h:FindFirstChildOfClass(_obi44m9h({100,128,112,128,93,115,140,121,135})) ~= nil) or false
			local gone, newParent, myGen = false, nil, clearGen
			pcall(function() c.Destroying:Connect(function() gone = true end) end)
			pcall(function() c.AncestryChanged:Connect(function(_, p) newParent = p end) end)
			local okAdd, errAdd = pcall(function() hm:AddAccessory(c) end)
			if not okAdd then
				DSLOG.err(_obi44m9h({110,113,116,131,132,213,198,134,126,133}), o.Name .. _obi44m9h({71,46,80,116,117,83,118,119,122,137,138,135,139,147,59,130,126,138,135,143,150,92,67}) .. tostring(errAdd):sub(1, 100))
				c:Destroy()
				return true
			end
			DSLOG.info(_obi44m9h({110,113,116,131,132,213,198,134,126,133}), string.format(_obi44m9h({52,51,130,55,49,117,130,128,132,121,120,124,136,58,151,60,145,135,143,143,94,71,150,68,161,70,140,150,140,139,148,164,146,107,84,163,81,174,83,170,150,157,152,117,94,173,96,175}), o.Name,
				okT and accType or _obi44m9h({76}), hAtt and hAtt.Name or _obi44m9h({91,83,93,88,102,95}), slot or _obi44m9h({112,125,129,128,128}),
				layered and _obi44m9h({45,138,47,130,128,135,131,117,53,123,132,56,124,123,136,125,129,127,146,64,73,121,149,133,149,114,136,161,142,156,87,76,157,157,147,149,81,160,246,215,164,86,155,157,159,169,173,169,158,176,104}) or _obi44m9h({})))
			if not h then DSLOG.err(_obi44m9h({110,113,116,131,132,213,198,134,126,133}), o.Name .. _obi44m9h({71,46,125,211,180,129,51,136,122,131,55,96,122,136,127,136,130,74,63,142,228,197,146,68,155,135,144,72,138,154,140,158,146,145,148,162})) end

			task.delay(0.6, function()
				if not c.Parent then
					if clearGen ~= myGen then return end
					DSLOG.warn(_obi44m9h({110,113,116,131,132,213,198,134,126,133}), _obi44m9h({52}) .. c.Name .. _obi44m9h({52,46,117,127,122,50,101,89,98,101,109,97,93,105,59,128,140,62,143,133,147,149,146,146,134,141,140,149,73,143,152,76,154,147,157,159,164,82,151,153,85,102,101,110,172,90,99})
						.. (gone and _obi44m9h({81,115,130,132,131,129,140,60,62}) or (_obi44m9h({122,125,133,121,117,129,51,132,135,119,55}) .. tostring(newParent and newParent.Name or _obi44m9h({123,119,123}))))
						.. _obi44m9h({54,60,47,93,134,118,116,130,121,133,55,136,139,137,59,137,140,130,142,64,142,131,145,153,134,146}))
					manualAcc = true
					if char.Parent and char:GetAttribute(_obi44m9h({81,129,98,121,120})) ~= nil then
						if placeManual(char, o) then char:SetAttribute(_obi44m9h({81,129,93}), 1) end
					end
					return
				end
				local hh = c:FindFirstChild(_obi44m9h({85,111,125,116,125,119}))
				local root2 = char:FindFirstChild(_obi44m9h({85,131,124,113,127,129,124,120,103,133,134,140,105,123,141,144}))
				if not (hh and root2) then return end
				if (hh.Position - root2.Position).Magnitude < 15 then return end
				local ha = hh:FindFirstChildOfClass(_obi44m9h({78,130,131,113,116,122,128,121,131,138}))
				local target, tAtt
				if ha then
					for _, p in ipairs(char:GetChildren()) do
						if p:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) then
							local a = p:FindFirstChild(ha.Name)
							if a and a:IsA(_obi44m9h({78,130,131,113,116,122,128,121,131,138})) then target, tAtt = p, a; break end
						end
					end
				end
				if target then
					hh.Anchored = false; hh.CanCollide = false; hh.Massless = true
					local w = Instance.new(_obi44m9h({100,115,123,116}))
					w.Name = _obi44m9h({81,129,80,115,116,105,120,128,121}); w.Part0 = target; w.Part1 = hh; w.C0 = tAtt.CFrame; w.C1 = ha.CFrame
					w.Parent = hh
					DSLOG.warn(_obi44m9h({110,113,116,131,132,213,198,134,126,133}), _obi44m9h({52}) .. c.Name .. _obi44m9h({52,46,125,211,180,129,51,121,131,121,120,129,145,137,144,60,144,141,153,137,143,138,146,95,69,153,150,148,141,143,148,76,155,143,79,157,244,213,162,84,154,163,87}) .. target.Name .. _obi44m9h({45,54,116,126,116,115,124,140,122,54}) .. ha.Name .. _obi44m9h({54}))
				else
					DSLOG.err(_obi44m9h({110,113,116,131,132,213,198,134,126,133}), _obi44m9h({52}) .. c.Name .. _obi44m9h({52,46,123,127,127,121,120,52,121,133,55,123,136,140,139,139,61,131,63,147,134,143,67,137,147,137,136,145,161,143,75,83}) .. (ha and ha.Name or _obi44m9h({76})) .. _obi44m9h({52,46,125,127,49,133,120,137,53,121,134,138,137,137,59,68,111,84,78,114,82,87,67,136,142,140,140,154,142,152,159,145,108,87}))
				end
			end)
			return true
		elseif o:IsA(_obi44m9h({85,111,131})) then
			DSLOG.info(_obi44m9h({112,118,112,128,212,187,136}), _obi44m9h({112,118,112,128,212,187,136,52,118,132,139,129,128,137,59,68,128,138,128,147,148,135,67,108,134,154,80,72,80}) .. o.Name .. _obi44m9h({52,58,47,131,128,126,119,117,131,122,134,56,135,123,59,127,126,128,132,227,200,131}))

			local head = char:FindFirstChild(_obi44m9h({85,115,112,116}))
			local srcHandle = o:FindFirstChild(_obi44m9h({85,111,125,116,125,119}))
				if not (head and srcHandle) then DSLOG.warn(_obi44m9h({112,118,112,128,212,187,136}), o.Name .. _obi44m9h({71,46,130,117,126,50,91,121,118,122,55,135,142,58,142,129,138,62,103,129,143,134,143,137,81,70,144,143,151,153,157,141,145,157})) end
			if head and srcHandle then
				clearHeadAccessories(char, _obi44m9h({85,111,131}))
				local c = o:Clone(); c:SetAttribute(_obi44m9h({81,129,92,127,117}), true)
				local h = c:FindFirstChild(_obi44m9h({85,111,125,116,125,119}))
				h.Anchored = false; h.CanCollide = false; h.Massless = true
				local okPos, pos = pcall(function() return c.AttachmentPos end)
				local offset = (okPos and typeof(pos) == _obi44m9h({99,115,114,132,128,132,70})) and CFrame.new(pos) or CFrame.new(0, 0.6, 0)
				h.CFrame = head.CFrame * offset
				c.Parent = char
				local w = Instance.new(_obi44m9h({100,115,123,116,84,129,129,135,137,136,120,129,135,142}))
				w.Part0 = head; w.Part1 = h; w.Parent = h
			end
			return true
		elseif o:IsA(_obi44m9h({96,118,120,130,133})) or o:IsA(_obi44m9h({93,111,125,132,132})) or o:IsA(_obi44m9h({96,118,120,130,133,89,133,117,133,126,128,123})) or o:IsA(_obi44m9h({79,125,115,137,84,129,127,131,135,137})) then
			stash(char, o.ClassName)
			local c = o:Clone(); c:SetAttribute(_obi44m9h({81,129,92,127,117}), true); c.Parent = char
			return true
		elseif o:IsA(_obi44m9h({80,118,112,130,114,117,135,121,135,99,124,139,129})) then
			local c = o:Clone(); c:SetAttribute(_obi44m9h({81,129,92,127,117}), true); c.Parent = char
			return true
		elseif o:IsA(_obi44m9h({81,115,114,113,125})) then
			local head = char:FindFirstChild(_obi44m9h({85,115,112,116}))
			if head then
				for _, d in ipairs(head:GetChildren()) do
					if d:IsA(_obi44m9h({81,115,114,113,125})) and not d:GetAttribute(_obi44m9h({81,129,92,127,117})) and not d:GetAttribute(_obi44m9h({81,129,87,121,117,86,120,119,118,130})) then
						d.Transparency = 1; d:SetAttribute(_obi44m9h({81,129,87,121,117,86,120,119,118,130}), true)
					end
				end
				local c = o:Clone(); c.Face = Enum.NormalId.Front; c:SetAttribute(_obi44m9h({81,129,92,127,117}), true); c.Parent = head
			end
			return true
		elseif EFX[o.ClassName] then
			if r then
				local c = o:Clone(); c:SetAttribute(_obi44m9h({81,129,92,127,117}), true); c.Parent = r
			end
			return true
		elseif o:IsA(_obi44m9h({90,115,130,120,97,115,133,136})) and char:FindFirstChild(o.Name) and char[o.Name]:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) then
			limb(char, o)
			return true
		elseif o:IsA(_obi44m9h({90,125,115,117,125})) or o:IsA(_obi44m9h({83,125,123,116,118,132})) then
			local any = false
			for _, ch in ipairs(o:GetChildren()) do
				if handle(char, hm, r, ch) then any = true end
			end
			if not any and o:IsA(_obi44m9h({90,125,115,117,125})) then
				attachProp(char, o)
				any = true
			end
			return any
		elseif o:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) then
			if char:FindFirstChild(o.Name) then return false end
			attachProp(char, o)
			return true
		end
		return false
	end

	local function applyOne(char, id)
		local objs = loadAsset(id)
		if not objs then return false end
		local hm = char:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120}))
		local r = char:FindFirstChild(_obi44m9h({85,131,124,113,127,129,124,120,103,133,134,140,105,123,141,144}))
		for _, o in ipairs(objs) do
			local ok, ret = pcall(handle, char, hm, r, o)
			if not ok then
				DSLOG.err(_obi44m9h({118,130,116,125}), _obi44m9h({86,82,47}) .. id .. _obi44m9h({45,54}) .. o.ClassName .. _obi44m9h({45,53}) .. o.Name .. _obi44m9h({52,55,73,48}) .. tostring(ret):sub(1, 140))
			elseif ret == false then
				DSLOG.warn(_obi44m9h({118,130,116,125}), _obi44m9h({86,82,47}) .. id .. _obi44m9h({45,54}) .. o.ClassName .. _obi44m9h({45,53}) .. o.Name .. _obi44m9h({52,55,73,48,127,213,182,131,53,137,124,129,57,123,139,136,134,129,128,146,65,135,150,151,138,70,155,145,153,153,75,144,146,78,152,164,150,159}))
			end
		end
		return true
	end

	DSLOG.inspect = function(idText)
		local n = tonumber(tostring(idText or _obi44m9h({})):match(_obi44m9h({50,114,58})))
		if not n then DSLOG.warn(_obi44m9h({118,124,130,128,118,117,124,131,131,119,137}), _obi44m9h({113,119,118,121,133,119,51,137,130,54,96,92,57,66,142,223,208,62,141,227,219,143,136,150,148,153,80})); return end
		DSLOG.info(_obi44m9h({118,124,130,128,118,117,124,131,131,119,137}), _obi44m9h({86,82,47}) .. n .. _obi44m9h({71,46,114,113,131,132,120,123,118,132,123,135,71,72,73}))
		local objs = loadAsset(n)
		if not objs then
			DSLOG.err(_obi44m9h({118,124,130,128,118,117,124,131,131,119,137}), _obi44m9h({86,82,47}) .. n .. _obi44m9h({45,92,210,147,96,50,118,117,135,136,124,127,136,143,85,60}) .. tostring(lastLoadErr[n] or _obi44m9h({128,115,124,48,118,132,133,131,53,62,141,135,133,142,138,145,61,148,128,154,138,145,76})))
			return
		end
		local shown = 0
		for _, o in ipairs(objs) do
			local extra = _obi44m9h({})
			if o:IsA(_obi44m9h({78,113,114,117,132,133,130,134,142})) then
				local okT, at = pcall(function() return o.AccessoryType.Name end)
				extra = _obi44m9h({45,130,120,128,128,79}) .. (okT and at or _obi44m9h({76})) .. _obi44m9h({45,132,112,119,114,79}) .. tostring(slotOf(o) or _obi44m9h({112,125,129,128,128}))
			end
			DSLOG.info(_obi44m9h({118,124,130,128,118,117,124,131,131,119,137}), _obi44m9h({86,82,47}) .. n .. _obi44m9h({45,128,112,121,139,76,51}) .. o.ClassName .. _obi44m9h({45,53}) .. o.Name .. _obi44m9h({52}) .. extra)
			for _, d in ipairs(o:GetDescendants()) do
				shown = shown + 1
				if shown > 40 then DSLOG.info(_obi44m9h({118,124,130,128,118,117,124,131,131,119,137}), _obi44m9h({59,60,61,48,57,127,116,125,136,54,128,140,126,136,142,60,139,225,194,143,65,142,140,151,153,135,139,151,156,83})); return end
				DSLOG.info(_obi44m9h({118,124,130,128,118,117,124,131,131,119,137}), _obi44m9h({45,46,60,48}) .. d.ClassName .. _obi44m9h({45,53}) .. d.Name .. _obi44m9h({52,46,116,125,49}) .. d.Parent.Name)
			end
		end
	end

	local function clearMods(char)
		clearGen = clearGen + 1
		local restored, removed = 0, 0
		local st = char:FindFirstChild(_obi44m9h({81,129,98,132,114,133,123}))
		if st then
			for _, o in ipairs(st:GetChildren()) do
				showStashed(o)
				o.Parent = char
				restored = restored + 1
			end
			st:Destroy()
		end
		for _, o in ipairs(char:GetDescendants()) do
			if o:GetAttribute(_obi44m9h({81,129,92,127,117})) then
				o:Destroy(); removed = removed + 1
			elseif o:GetAttribute(_obi44m9h({81,129,87,121,117,94,124,129,119})) then
				o.Transparency = 0; o:SetAttribute(_obi44m9h({81,129,87,121,117,94,124,129,119}), nil)
			elseif o:GetAttribute(_obi44m9h({81,129,87,121,117,86,120,119,118,130})) then
				o.Transparency = 0; o:SetAttribute(_obi44m9h({81,129,87,121,117,86,120,119,118,130}), nil)
			end
		end
		if removed > 0 or restored > 0 then
			DSLOG.info(_obi44m9h({121,119,124,128,114,132}), removed .. _obi44m9h({45,119,131,117,126,58,129,135,62,54,123,135,57,130,144,126,61,144,132,141,144,152,140,136,148,78,154,81,85,74}) .. restored .. _obi44m9h({45,125,129,121,120,123,129,117,129,62,128,139,66,58,127,129,147,141,139,150,138,134,146,76,152,79}))
		end
	end

	local function headless(char)
		local head = char:FindFirstChild(_obi44m9h({85,115,112,116}))
		if not head then return end
		head.Transparency = 1; head:SetAttribute(_obi44m9h({81,129,87,121,117,94,124,129,119}), true)
		for _, d in ipairs(head:GetChildren()) do
			if d:IsA(_obi44m9h({81,115,114,113,125})) then d.Transparency = 1; d:SetAttribute(_obi44m9h({81,129,87,121,117,86,120,119,118,130}), true) end
		end
	end

	local function applyBC(char, bc)
		local cols = {}
		for h in tostring(bc):gmatch(_obi44m9h({50,134,52,136,54,138,56,140,58,142,60,144})) do
			cols[#cols + 1] = Color3.fromRGB(tonumber(h:sub(1, 2), 16), tonumber(h:sub(3, 4), 16), tonumber(h:sub(5, 6), 16))
		end
		if #cols < 6 then return end
		stash(char, _obi44m9h({79,125,115,137,84,129,127,131,135,137}))
		local b = Instance.new(_obi44m9h({79,125,115,137,84,129,127,131,135,137}))
		b.HeadColor3, b.TorsoColor3 = cols[1], cols[2]
		b.LeftArmColor3, b.RightArmColor3 = cols[3], cols[4]
		b.LeftLegColor3, b.RightLegColor3 = cols[5], cols[6]
		b:SetAttribute(_obi44m9h({81,129,92,127,117}), true)
		b.Parent = char
	end

	local seenB = {}
	local function isFresh(id, rec)
		local now = os.clock()
		local s = seenB[id]
		if not s or s.beat ~= rec.beat then
			seenB[id] = { beat = rec.beat, at = now, moved = s ~= nil }
			s = seenB[id]
		end
		if now - s.at > 25 then return false end
		local t = tonumber(rec.t)
		if t and math.abs(os.time() - t) <= 90 then return true end
		return s.moved
	end

	local function localRecord()
		if #mine.ids == 0 and not mine.headless and not mine.bc then return nil end
		return { ids = table.concat(mine.ids, _obi44m9h({57})), headless = mine.headless, fx = mine.fx or _obi44m9h({}), fc = mine.fc or 1, bc = mine.bc }
	end

	local function appearanceReady(pl)
		local ok, v = pcall(function() return pl:HasAppearanceLoaded() end)
		if ok and v == false then return false end
		return true
	end
	local function countMods(char)
		local n = 0
		for _, d in ipairs(char:GetDescendants()) do
			if d:GetAttribute(_obi44m9h({81,129,92,127,117})) then n = n + 1 end
		end
		return n
	end
	local reapplied = setmetatable({}, { __mode = _obi44m9h({120}) })
	local waitSince = setmetatable({}, { __mode = _obi44m9h({120}) })
	local netState = nil

	local function retryFailed(pl, char, want, ids, attempt)
		if attempt > 3 then
			local t = {}
			for _, i in ipairs(ids) do t[#t + 1] = tostring(i) end
			DSLOG.err(_obi44m9h({128,135,125,115}), pl.Name .. _obi44m9h({71,46,115,117,132,123,134,136,126,54,123,135,140,58,100,96,144,62}) .. table.concat(t, _obi44m9h({57,46})) .. _obi44m9h({45,54,120,126,135,213,180,128,126,122,134,139,69,58,125,136,140,143,148,133,130,134,146,151,69,149,156,72,152,74,144,164,146,145,164,164,160,164,83,162,248,217,166,88,156,169,169,175,162,165,180,165,97,165,164,182,183,171,174,169,187,115}))
			return
		end
		task.delay(3 * attempt, function()
			if not (char and char.Parent) or char:GetAttribute(_obi44m9h({81,129,98,121,120})) ~= want then return end
			local still = {}
			for _, i in ipairs(ids) do
				local ok, applied = pcall(applyOne, char, i)
				if not (ok and applied) then still[#still + 1] = i end
			end
			char:SetAttribute(_obi44m9h({81,129,93}), countMods(char))
			if #still > 0 then
				retryFailed(pl, char, want, still, attempt + 1)
			else
				DSLOG.info(_obi44m9h({128,135,125,115}), pl.Name .. _obi44m9h({71,46,126,131,49,91,87,135,53,135,140,125,57,128,124,136,145,127,149,129,142,66,134,133,151,152,140,143,138,156,140,153,77,156,144,80,165,151,161,168,150,170,160,174,154,90}) .. attempt)
			end
		end)
	end

	local function sync()
		local body = http(_obi44m9h({84,83,99}), _obi44m9h({60,123,126,116,132,64,125,135,132,132}))
		local netOk = body ~= nil
		if netOk ~= netState then
			netState = netOk
			if netOk then
				DSLOG.info(_obi44m9h({128,135,125,115}), _obi44m9h({83,119,129,117,115,115,134,121,53,136,124,139,137,137,137,128,130,147,63,72,147,135,135,137,69,117,114,81}))
			else
				DSLOG.err(_obi44m9h({128,135,125,115}), _obi44m9h({83,119,129,117,115,115,134,121,53,100,218,155,104,58,141,129,144,142,142,142,133,135,152,68,77}) .. tostring(lastErr) .. _obi44m9h({54,72,47,113,129,126,124,119,132,54,138,219,204,58,138,143,61,145,132,149,148,66,144,147,137,153,71,148,152,141,140,149,160}))
			end
		end
		local data = {}
		if netOk and body ~= _obi44m9h({123,131,123,124}) and body ~= _obi44m9h({}) then
			local ok, d = pcall(HttpService.JSONDecode, HttpService, body)
			if ok and type(d) == _obi44m9h({129,111,113,124,118}) then
				data = d
			else
				DSLOG.err(_obi44m9h({128,135,125,115}), _obi44m9h({127,115,130,128,128,133,135,117,53,122,134,56,95,131,141,129,127,127,146,133,65,144,230,199,148,70,234,209,73,116,126,123,123,104,79}) .. tostring(body):sub(1, 60))
			end
		end
		for id, rec in pairs(data) do
			if type(rec) ~= _obi44m9h({129,111,113,124,118}) or not isFresh(id, rec) then data[id] = nil end
		end
		local mineRec = localRecord()
		if netOk and mineRec and not data[uid] then
			DSLOG.warn(_obi44m9h({128,135,125,115}), _obi44m9h({128,115,132,48,131,119,122,125,136,138,137,135,57,136,222,191,140,62,149,143,141,150,146,153,69,138,150,72,111,147,157,145,143,143,162,149,81,90,162,84,133,139,139,88,159,155,167,164,172,179,95,175,182,98,164,183,101,184,172,175,187,171,190,108,175,186,190,193,198,183,180,198,182,195,128,134,121,176,202,191,32,8,127,211,198,130,217,39,15,146,135,213,202,221,139,219,224,142,222,229,229,228,226,231,149,228,58,27,232,154,239,225,157,244,228,229,238}))
		end
		for _, pl in ipairs(Players:GetPlayers()) do
			local isMe = (pl == lp)
			local char = pl.Character
			if (isMe or netOk) and char and char:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120})) and char:FindFirstChild(_obi44m9h({85,131,124,113,127,129,124,120,103,133,134,140,105,123,141,144})) then
				local d
				if isMe then d = mineRec else d = data[tostring(pl.UserId)] end
				local want
				if d then
					if isMe then
						want = tostring(d.ids or _obi44m9h({})) .. _obi44m9h({137}) .. tostring(d.headless == true) .. _obi44m9h({137,138,64,140}) .. tostring(d.bc or _obi44m9h({}))
					else
						want = tostring(d.ids or _obi44m9h({})) .. _obi44m9h({137}) .. tostring(d.headless == true) .. _obi44m9h({137}) .. tostring(d.fx or _obi44m9h({})) .. _obi44m9h({137}) .. tostring(d.fc or 1) .. _obi44m9h({137}) .. tostring(d.bc or _obi44m9h({}))
					end
				end

				if want and char:GetAttribute(_obi44m9h({81,129,98,121,120})) == want and (char:GetAttribute(_obi44m9h({81,129,93})) or 0) > 0 and countMods(char) == 0 then
					local n = (reapplied[char] or 0) + 1
					reapplied[char] = n
					if n <= 5 then
						DSLOG.warn(_obi44m9h({128,135,125,115}), pl.Name .. _obi44m9h({71,46,126,131,49,123,135,121,131,137,55,124,136,58,131,145,127,62,146,149,142,139,149,133,146,70,139,151,73,154,144,158,160,157,157,145,152,151,160,84,93,165,87,162,168,161,170,92,175,163,172,175,183,167,184,131,110,114,103,186,174,171,187,184,182,177,176,190,181,193,115,124}) .. n .. _obi44m9h({60,67,56}))
						char:SetAttribute(_obi44m9h({81,129,98,121,120}), nil)
					end
				end
				if char:GetAttribute(_obi44m9h({81,129,98,121,120})) ~= want then
					local ready = (want == nil) or appearanceReady(pl)
					if not ready then
						local t0 = waitSince[char]
						if not t0 then
							t0 = os.clock(); waitSince[char] = t0
							DSLOG.info(_obi44m9h({128,135,125,115}), pl.Name .. _obi44m9h({71,46,116,131,129,119,133,117,131,122,134,56,136,58,124,146,126,146,128,146,65,150,136,150,146,143,149,137,155,74,143,145,77,145,144,162,163,151,154,149,167,100,101,102}))
						end
						if os.clock() - t0 >= 8 then
							ready = true
							DSLOG.warn(_obi44m9h({128,135,125,115}), pl.Name .. _obi44m9h({71,46,112,134,114,134,116,134,53,122,124,133,136,140,138,145,61,139,128,137,148,66,135,137,69,94,154,84,73,139,155,152,150,145,144,158,149,161,83,161,154,169,164,167,89,155,174,175,166,171}))
						end
					end
					if ready then
						waitSince[char] = nil
						if d then
							DSLOG.info(_obi44m9h({128,135,125,115}), pl.Name .. _obi44m9h({71,46,112,128,125,123,118,117,131,122,134,56,134,137,127,143,61,154,63,137,133,149,96}) .. tostring(d.ids or _obi44m9h({})) .. (d.headless == true and _obi44m9h({45,138,47,120,118,115,119,128,122,137,138}) or _obi44m9h({})) .. (d.bc and _obi44m9h({45,138,47,115,128,132,120,135}) or _obi44m9h({})))
						else
							DSLOG.info(_obi44m9h({128,135,125,115}), pl.Name .. _obi44m9h({71,46,130,117,126,50,128,131,121,137,67,56,133,131,136,140,126,140,131,143}))
						end
						clearMods(char)
						if not isMe then
							local set = {}
							if d then
								for k in tostring(d.fx or _obi44m9h({})):gmatch(_obi44m9h({50,111,58})) do set[k] = true end
							end
							local okF, eF = pcall(fxApply, char, set, tonumber(d and d.fc) or 1)
							if not okF then DSLOG.err(_obi44m9h({114,116,116,121,133,129,134}), pl.Name .. _obi44m9h({71,46}) .. tostring(eF):sub(1, 100)) end
						end
						local failed = {}
						if d then
							if d.headless == true then DSLOG.try(_obi44m9h({117,115,112,116,125,119,134,135}), headless, char) end
							if d.bc then DSLOG.try(_obi44m9h({112,125,129,117,132}), applyBC, char, d.bc) end
							local n = 0
							for idStr in tostring(d.ids or _obi44m9h({})):gmatch(_obi44m9h({50,114,58})) do
								n = n + 1
								if n > 24 then DSLOG.warn(_obi44m9h({128,135,125,115}), pl.Name .. _obi44m9h({71,46,124,113,122,133,51,120,122,54,73,76,57,99,95,143,73,62,136,135,143,145,149,137,142,70,150,72,155,143,158,160,156})); break end
								local idn = tonumber(idStr)
								local ok, applied = pcall(applyOne, char, idn)
								if not (ok and applied) then
									failed[#failed + 1] = idn
									DSLOG.err(_obi44m9h({128,135,125,115}), pl.Name .. _obi44m9h({71,46,117,113,125,122,130,137,53,133,55,97,93,58}) .. idStr .. (ok and _obi44m9h({45,54,125,211,180,129,51,119,118,136,137,125,128,137,144,69}) or (_obi44m9h({71,46}) .. tostring(applied):sub(1, 120))))
								end
							end
						end
						char:SetAttribute(_obi44m9h({81,129,98,121,120}), want)
						char:SetAttribute(_obi44m9h({81,129,93}), countMods(char))
						if #failed > 0 then retryFailed(pl, char, want, failed, 1) end

						if isMe then
							DSLOG.try(_obi44m9h({110,132,112,132,114,132}), DSLOG.charState, char, _obi44m9h({131,125,114,211,187}))
							local hm2 = char:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120}))
							local accN = hm2 and #hm2:GetAccessories() or -1
							local mf = char:FindFirstChild(_obi44m9h({81,129,80,115,116}))
							if mf and #mf:GetChildren() > 0 then accN = tostring(accN) .. _obi44m9h({45,57,47}) .. #mf:GetChildren() .. _obi44m9h({45,123,112,126,134,115,127}) end
							say((#failed == 0 and _obi44m9h({90,125,115,131,49,115,131,128,126,121,120,124,136,141,73,60}) or _obi44m9h({78,122,118,133,127,133,51,93,89,137,55,126,122,134,131,125,143,127,140,76,65,150,136,146,153,135,149,140,152,74,143,145,77,156,158,166,160,96,83})) .. _obi44m9h({78,113,116,131,132,213,198,134,126,133,138,56,135,137,59,143,130,147,63,104,150,143,132,146,148,143,139,72,138,145,154,158,142,104,79}) .. accN)
						end
					end
				end
				if not isMe then
					local okT, eT = pcall(tagDraw, char, d and type(d.tag) == _obi44m9h({129,111,113,124,118}) and d.tag or nil, _obi44m9h({81,129,99,113,120,84}))
					if not okT then DSLOG.err(_obi44m9h({129,111,118}), tostring(eT):sub(1, 100)) end
				end
			end
		end
	end

	local syncing = false
	local function syncSafe()
		if syncing then return end
		syncing = true
		DSLOG.try(_obi44m9h({128,135,125,115}), sync)
		syncing = false
	end
	table.insert(conns, lp.CharacterAdded:Connect(function()
		DSLOG.info(_obi44m9h({110,132,112,132,114,132}), _obi44m9h({128,115,132,48,129,119,133,135,132,132,120,127,126,135,59,142,130,140,128,147,132,135,152,80,69,152,140,137,153,150,148,143,142,156,147,159,81,161,166,84,162,165,155,171}))
		task.wait(1)
		if alive then syncSafe() end
	end))
	task.spawn(function()
		while alive do syncSafe(); task.wait(3) end
	end)

	task.spawn(function()
		while alive do
			task.wait(8)
			if alive and (#mine.ids > 0 or mine.headless or mine.fx or mine.tag or mine.bc) then pcall(publish) end
		end
	end)
	local function goodbye() pcall(http, _obi44m9h({81,83,91,85,101,87}), _obi44m9h({60,123,126,116,132,65}) .. uid .. _obi44m9h({59,120,130,127,127})) end
	table.insert(conns, Players.PlayerRemoving:Connect(function(p) if p == lp then goodbye() end end))
	pcall(function()
		table.insert(conns, lp.OnTeleport:Connect(function(st)
			if st == Enum.TeleportState.Started then goodbye() end
		end))
	end)

	section(page, _obi44m9h({90,125,115,48,129,119,133,135,132,132,120,132,130,148,124,128,140}))
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({80,125,123,117,49,129,51,93,89,54,123,125,57,139,144,125,137,143,148,133,147,66,140,152,138,147,71,158,146,157,160,141,153,78,147,159,81,149,148,168,248,215,163,167,160,169,91,100,158,161,164,179,180,5,246,182,174,181,115,104,187,185,192,188,174,122,111,192,178,181,194,200,186,130,119,200,186,204,207,193,208,126,195,207,129,197,210,214,213,213,147,136,219,217,222,224,220,142,222,229,145,215,217,217,222,234,230,161,167,154,206,223,239,231,239,244,244,162,232,164,248,245,245,251,169,253,78,47,252,174,1,245,254,1,9,253,249,5,10,198,185,221,3,253,13,97,72,21,208,5,4,6,10,18,22,215,27,25,30,32,28,206,29,31,39,33,211,40,39,37,26,25,217,41,219,45,50,35,223,54,48,37,134,110,229,48,138,105,233,47,62,64,144,111,239,69,68,51,65,56,68,246,56,77,77,73,72,61,81,71,66,65,78,71,81,88,74,20,7,60,88,78,90,95,13,95,100,85,17,103,102,85,98,22,102,24,97,111,93,28,115,99,100,109,47}),
		Size = UDim2.new(1, 0, 0, 58), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	toggleRow(page, _obi44m9h({96,115,124,48,116,115,117,121,216,189,120,56,65,130,128,125,129,138,132,147,148,75}), _obi44m9h({82,129,114,127,127,118,120,52,118,54,138,141,122,58,126,125,127,131,226,199,130}), function(v)
		mine.headless = v
		publish()
		say(v and _obi44m9h({85,115,112,116,125,119,134,135,53,130,128,127,122,126,138,74}) or _obi44m9h({85,115,112,116,125,119,134,135,53,122,124,139,133,131,130,125,129,141,77}))
	end)
	local idRow = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = PANEL, BackgroundTransparency = 0.15 }, page)
	round(idRow, 10); stroke(idRow, 1.5)
	local idBox = mk(_obi44m9h({97,115,135,132,83,129,139}), {
		Size = UDim2.new(1, -20, 1, -8), Position = UDim2.fromOffset(10, 4), BackgroundTransparency = 1,
		Text = _obi44m9h({}), PlaceholderText = _obi44m9h({86,82,47,116,128,50,124,136,122,131,55,64,140,221,206,60,139,225,217,141,134,148,146,151,78}), PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
		TextColor3 = WHITE, Font = Enum.Font.Code, TextSize = 12, ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
	}, idRow)
	local listLbl = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({86,82,130,48,114,134,124,138,132,137,81,56,135,127,137,132,146,139}), Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local function refreshList()
		listLbl.Text = _obi44m9h({86,82,130,48,114,134,124,138,132,137,81,56}) .. (#mine.ids > 0 and table.concat(mine.ids, _obi44m9h({57,46})) or _obi44m9h({123,115,125,120,134,127}))
	end
	mine.onList = refreshList
	rowBtn(page, _obi44m9h({78,114,120,115,122,129,129,117,135,54,96,92}), function()
		local n = idBox.Text:match(_obi44m9h({50,114,58}))
		if not n then say(_obi44m9h({81,119,118,121,133,119,51,131,53,95,91,56,65,141,222,207,61,140,226,218,142,135,149,147,152,79,85})); return end
		if #mine.ids >= 8 then say(_obi44m9h({90,209,176,136,122,127,130,52,121,123,55,80,57,99,95,143,75})); return end
		table.insert(mine.ids, n)
		idBox.Text = _obi44m9h({})
		refreshList()
		publish()
		say(_obi44m9h({86,82,47}) .. n .. _obi44m9h({45,111,115,121,116,123,130,130,118,122,134,68,57,125,124,142,143,131,134,129,143,134,146,82,83,84}))
		task.spawn(function()
			local id = tonumber(n)
			local objs = loadAsset(id)
			if objs then
				local cls = {}
				for _, o in ipairs(objs) do cls[#cls + 1] = o.ClassName end
				say(_obi44m9h({86,82,47}) .. n .. _obi44m9h({45,113,112,130,131,119,122,117,121,133,81,56}) .. table.concat(cls, _obi44m9h({57,46})) .. _obi44m9h({59,46,80,128,125,123,118,117,131,122,134,56,126,135,59,125,145,225,200,64,84,149,81}))
			else
				say(_obi44m9h({91,209,178,127,49,117,130,130,136,123,126,141,130,58,126,125,143,144,132,135,130,148,67,147,69,111,107,72}) .. n .. (lastLoadErr[id] and (_obi44m9h({45,54}) .. lastLoadErr[id] .. _obi44m9h({54})) or _obi44m9h({})) .. _obi44m9h({59,46,101,127,134,50,135,121,131,138,120,138,57,126,128,60,139,141,149,143,65,149,146,158,142,148,143,151,100,74,142,155,155,148,152,162,146,82,166,153,85,249,224,88,174,167,91,133,129,94,163,165,97,171,183,169,178,102,171,173,105,171,193,173,193,175,193,112,199,21,244,192,190,186,198,134}))
			end
		end)
	end)
	rowBtn(page, _obi44m9h({89,119,124,128,114,132,51,93,89,137}), function()
		mine.ids = {}
		refreshList()
		publish()
		say(_obi44m9h({86,82,130,48,131,119,128,131,139,127,123,135,140,72}))
	end)

	return function()
		alive = false
		fxConn:Disconnect()

		for _, pl in ipairs(Players:GetPlayers()) do
			if pl.Character then
				pcall(clearMods, pl.Character)
				pl.Character:SetAttribute(_obi44m9h({81,129,98,121,120}), nil)
				pl.Character:SetAttribute(_obi44m9h({81,129,93}), nil)
			end
		end
		fxClearAll()
		for _, pl in ipairs(Players:GetPlayers()) do
			local hd = pl.Character and pl.Character:FindFirstChild(_obi44m9h({85,115,112,116}))
			local o = hd and hd:FindFirstChild(_obi44m9h({81,129,99,113,120,84}))
			if o then o:Destroy() end
		end
		http(_obi44m9h({81,83,91,85,101,87}), _obi44m9h({60,123,126,116,132,65}) .. uid .. _obi44m9h({59,120,130,127,127}))
	end
end

local function buildDebug(page, say)
	if not page then return nil end
	local onlyProblems, dirty, alive = false, true, true
	local function onNew() dirty = true end
	table.insert(DSLOG.subs, onNew)

	section(page, _obi44m9h({81,119,112,119,127,213,198,135,137,127,122,135}))
	local info = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({}), Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	rowBtn(page, _obi44m9h({80,125,127,121,114,132,51,128,132,125,55,123,136,135,139,136,130,146,142}), function()
		local f = setclipboard or toclipboard
		DSLOG.flush()
		if not f then say(_obi44m9h({96,115,132,48,118,138,120,119,138,138,134,138,57,136,222,191,140,62,147,133,142,66,150,137,153,137,147,145,153,140,154,141,159,146,93,80,128,82,159,163,156,86,156,171,173,253,220,92,171,173,95,161,179,179,184,173,187,181,103}) .. DSLOG.file); return end
		pcall(f, DSLOG.dump(false))
		say(_obi44m9h({89,125,118,48,116,129,131,125,118,122,134,56,65}) .. #DSLOG.lines .. _obi44m9h({45,122,120,126,121,115,134,61,67,54,90,135,133,127,59,138,126,62,130,143,143,152,136,150,152,135,85}))
	end, true)
	rowBtn(page, _obi44m9h({80,125,127,121,114,132,51,135,216,201,55,121,143,131,142,139,144,62,132,64,134,148,149,147,152}), function()
		local f = setclipboard or toclipboard
		DSLOG.flush()
		if not f then say(_obi44m9h({96,115,132,48,118,138,120,119,138,138,134,138,57,136,222,191,140,62,147,133,142,66,150,137,153,137,147,145,153,140,154,141,159,146,93,80,128,82,159,163,156,86,156,171,173,253,220,92,171,173,95,161,179,179,184,173,187,181,103}) .. DSLOG.file); return end
		pcall(f, DSLOG.dump(true))
		say(_obi44m9h({78,132,120,131,128,133,51,121,53,123,137,138,136,141,59,127,140,142,136,129,133,145,150,82}))
	end, true)
	rowBtn(page, _obi44m9h({96,111,123,134,114,132,51,117,124,133,137,121,57,136,138,60,126,144,144,149,138,152,146}), function()
		DSLOG.flush()
		say(_obi44m9h({96,111,123,134,128,50,120,129,53}) .. DSLOG.file .. _obi44m9h({45,54,127,113,132,134,116,52,121,133,55,125,145,127,126,145,145,141,145,73}))
	end, true)
	rowBtn(page, _obi44m9h({99,115,129,48,118,133,135,117,121,133,55,124,136,58,136,129,146,62,143,133,147,149,146,146,134,141,140,149}), function()
		DSLOG.try(_obi44m9h({110,132,112,132,114,132}), DSLOG.charState, lp.Character, _obi44m9h({131,125,114,211,187}))
		say(_obi44m9h({82,129,131,113,117,129,51,120,132,54,135,125,139,141,138,138,126,133,132,141,65,148,136,139,142,153,155,154,138,142,154,76,155,157,79,156,160,153,97}))
	end, true)
	toggleRow(page, _obi44m9h({96,209,194,48,114,136,124,135,132,137,55,125,57,127,141,142,140,145}), _obi44m9h({82,129,114,127,127,118,120,52,118,137,55,132,130,136,131,125,144,62,131,133,65,139,145,138,148,152,148,137,236,209,238,207,156}), function(v)
		onlyProblems = v; dirty = true
	end)
	local idRow = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
	round(idRow, 17); stroke(idRow, 1.5)
	local idBox = mk(_obi44m9h({97,115,135,132,83,129,139}), {
		Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
		Text = _obi44m9h({}), PlaceholderText = _obi44m9h({86,82,47,128,131,115,51,125,131,137,135,125,124,131,138,138,126,144,63,72,148,229,214,68,147,233,225,149,142,156,154,159,86}), PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
		TextColor3 = WHITE, Font = Enum.Font.Code, TextSize = 11, ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
	}, idRow)
	rowBtn(page, _obi44m9h({86,124,130,128,118,117,124,131,131,119,137,56,98,94,59,68,139,225,194,143,65,131,147,144,142,137,136,81}), function()
		if not DSLOG.inspect then say(_obi44m9h({78,46,112,114,114,50,96,131,121,54,120,129,135,126,124,60,139,225,194,143,65,133,132,150,151,139,142,151,158,88})); return end
		task.spawn(function() DSLOG.try(_obi44m9h({118,124,130,128,118,117,124,131,131,119,137}), DSLOG.inspect, idBox.Text) end)
		say(_obi44m9h({86,124,130,128,118,117,124,131,131,119,133,124,136,70,59,146,130,136,128,64,144,66,143,147,140,70,136,138,138,147,163,155,91}))
	end, true)
	rowBtn(page, _obi44m9h({89,119,124,128,114,132,51,136,122,130,120}), function()
		DSLOG.lines = {}
		dirty = true
	end, true)

	local box = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(10, 2, 3), BackgroundTransparency = 0.15 }, page)
	round(box, 10); stroke(box, 1.5)
	mk(_obi44m9h({98,87,95,113,117,118,124,130,124}), { PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }, box)
	local txt = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({}), Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
		RichText = true, TextWrapped = true, Font = Enum.Font.Code, TextSize = 10, TextColor3 = Color3.fromRGB(230, 210, 210),
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, box)

	local COL = { INFO = _obi44m9h({48,115,69,116,67,118,69}), WARN = _obi44m9h({48,116,117,115,73,72,71}), ERRO = _obi44m9h({48,116,117,70,69,72,71}) }
	local function esc(s)
		return (s:gsub(_obi44m9h({51}), _obi44m9h({51,111,124,128,76})):gsub(_obi44m9h({73}), _obi44m9h({51,122,131,75})):gsub(_obi44m9h({75}), _obi44m9h({51,117,131,75})))
	end
	local function render()
		local out, total = {}, 0
		for i = #DSLOG.lines, 1, -1 do
			local l = DSLOG.lines[i]
			if not onlyProblems or l[1] ~= _obi44m9h({86,92,85,95}) then
				local s = l[2]
				if #s > 220 then s = s:sub(1, 220) .. _obi44m9h({59,60,61}) end
				total = total + #s + 40
				if total > 14000 or #out >= 150 then break end
				out[#out + 1] = _obi44m9h({73,116,126,126,133,50,118,131,129,133,137,85,59}) .. (COL[l[1]] or COL.INFO) .. _obi44m9h({47,76}) .. esc(s) .. _obi44m9h({73,61,117,127,127,134,81})
			end
		end
		txt.Text = #out > 0 and table.concat(out, _obi44m9h({23})) or _obi44m9h({53,122,126,119,49,136,116,142,126,133,64})
		info.Text = DSLOG.n.INFO .. _obi44m9h({45,119,125,118,128,50,213,203,53}) .. DSLOG.n.WARN .. _obi44m9h({45,111,133,121,132,129,134,52,215,205,55}) .. DSLOG.n.ERRO .. _obi44m9h({45,115,129,130,128,133,51,214,204,54,132,121,130,141,59,142,130,129,132,142,149,135,67,137,146,70,138,145,150,139,53,109,159,159,164,153,167,161,109,84}) .. DSLOG.file
	end
	task.spawn(function()
		while alive and gui.Parent do
			if dirty and page.Visible then
				dirty = false
				pcall(render)
			end
			task.wait(0.5)
		end
	end)
	return function()
		alive = false
		for i, f in ipairs(DSLOG.subs) do
			if f == onNew then table.remove(DSLOG.subs, i); break end
		end
	end
end

local function hrp() return lp.Character and lp.Character:FindFirstChild(_obi44m9h({85,131,124,113,127,129,124,120,103,133,134,140,105,123,141,144})) end
local function hum() return lp.Character and lp.Character:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120})) end

local selfCleanup

local TAG_FONTS = { _obi44m9h({84,125,131,120,114,127,85,128,118,121,130}), _obi44m9h({83,128,116,116,128,125,116,99,131,123}), _obi44m9h({79,111,125,119,118,132,134}), _obi44m9h({80,128,116,117,129,133,135,121,135}), _obi44m9h({78,128,114,113,117,119}), _obi44m9h({83,111,125,132,114,133,140}), _obi44m9h({96,113,120,86,122}), _obi44m9h({89,131,114,123,122,119,134,136,92,139,144}), _obi44m9h({93,115,129,125,114,128,120,130,137,99,120,138,132,127,141}), _obi44m9h({80,111,129,132,128,129,129}), _obi44m9h({80,125,115,117}) }
local TAG_ROLES = {
	{ _obi44m9h({90,115,124,114,131,129}), Color3.fromRGB(235, 235, 235) },
	{ _obi44m9h({86,124,117,124,134,119,129,119,126,119,123,135,139}), Color3.fromRGB(255, 105, 180) },
	{ _obi44m9h({96,131,113,48,85,129,129,131}), Color3.fromRGB(255, 140, 40) },
	{ _obi44m9h({81,125,125,127}), Color3.fromRGB(255, 205, 60) },
}
local TAG = { avail = false, on = false, text = _obi44m9h({}), font = _obi44m9h({84,125,131,120,114,127,85,128,118,121,130}), role = _obi44m9h({90,115,124,114,131,129}), rgb = false }
local function tagRoleColor(name)
	for _, r in ipairs(TAG_ROLES) do
		if r[1] == name then return r[2] end
	end
	return TAG_ROLES[1][2]
end

function tagDraw(char, d, nm)
	nm = nm or _obi44m9h({81,129,99,113,120})
	local head = char and char:FindFirstChild(_obi44m9h({85,115,112,116}))
	if not head then return end
	local old = head:FindFirstChild(nm)
	if not (type(d) == _obi44m9h({129,111,113,124,118}) and d.on) then
		if old then old:Destroy() end
		return
	end
	local text = tostring(d.text or _obi44m9h({})):sub(1, 16)
	if text == _obi44m9h({}) then
		local pl = Players:GetPlayerFromCharacter(char)
		text = tostring(pl and pl.DisplayName or lp.DisplayName):sub(1, 16)
	end
	local role = tostring(d.role or _obi44m9h({90,115,124,114,131,129})):sub(1, 14)
	local fontName = table.find(TAG_FONTS, d.font) and d.font or _obi44m9h({84,125,131,120,114,127,85,128,118,121,130})
	local g = old
	if not g then
		g = mk(_obi44m9h({79,119,123,124,115,129,116,134,121,93,140,129}), {
			Name = nm, Size = UDim2.fromOffset(320, 110), StudsOffset = Vector3.new(0, 3.8, 0),
			AlwaysOnTop = true, LightInfluence = 0, MaxDistance = 1500,
		}, nil)
		g:SetAttribute(_obi44m9h({81,129,85,136}), true)
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Name = _obi44m9h({91}), Size = UDim2.new(1, 0, 0.62, 0), BackgroundTransparency = 1, TextScaled = true,
			TextColor3 = WHITE, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		}, g)
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Name = _obi44m9h({95}), Size = UDim2.new(1, 0, 0.3, 0), Position = UDim2.new(0, 0, 0.66, 0), BackgroundTransparency = 1,
			TextScaled = true, Font = Enum.Font.GothamBold, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		}, g)
		g.Parent = head
	end
	local n, r = g:FindFirstChild(_obi44m9h({91})), g:FindFirstChild(_obi44m9h({95}))
	if n then n.Text = text; n.Font = Enum.Font[fontName] end
	if r then r.Text = role end
	if d.rgb == true then
		g:SetAttribute(_obi44m9h({95,117,113}), true)
		TAG.rgbStart()
	else
		g:SetAttribute(_obi44m9h({95,117,113}), nil)
		if n then n.TextColor3 = WHITE end
		if r then r.TextColor3 = tagRoleColor(role) end
	end
end

function TAG.rgbStart()
	if TAG.rgbRun then return end
	TAG.rgbRun = true
	task.spawn(function()
		while TAG.rgbRun and gui and gui.Parent do
			local h = (os.clock() * 0.35) % 1
			local c1, c2 = Color3.fromHSV(h, 1, 1), Color3.fromHSV((h + 0.5) % 1, 1, 1)
			local any = false
			for _, pl in ipairs(Players:GetPlayers()) do
				local hd = pl.Character and pl.Character:FindFirstChild(_obi44m9h({85,115,112,116}))
				if hd then
					for _, nm in ipairs({ _obi44m9h({81,129,99,113,120}), _obi44m9h({81,129,99,113,120,84}) }) do
						local g = hd:FindFirstChild(nm)
						if g and g:GetAttribute(_obi44m9h({95,117,113})) then
							any = true
							local n, r = g:FindFirstChild(_obi44m9h({91})), g:FindFirstChild(_obi44m9h({95}))
							if n then n.TextColor3 = c1 end
							if r then r.TextColor3 = c2 end
						end
					end
				end
			end
			task.wait(any and 0.03 or 0.5)
		end
		TAG.rgbRun = false
	end)
end

function TAG.data()
	local on = TAG.on or (TAG.force and TAG.granted and not TAG.forceOff) or false
	return { on = on, text = TAG.text, font = TAG.font, role = TAG.role, rgb = TAG.rgb == true }
end
function TAG.refresh()
	if TAG.avail then pcall(tagDraw, lp.Character, TAG.data()) end
end
function TAG.start()
	if TAG.running then return end
	TAG.running = true
	task.spawn(function()
		while TAG.running do
			TAG.refresh()
			task.wait(1)
		end
		pcall(function()
			local hd = lp.Character and lp.Character:FindFirstChild(_obi44m9h({85,115,112,116}))
			local o = hd and hd:FindFirstChild(_obi44m9h({81,129,99,113,120}))
			if o then o:Destroy() end
		end)
	end)
end
function TAG.stop() TAG.running = false end

local function buildSelf(pages, say)

	local sp = pages[_obi44m9h({96,113,129,121,129,134,134})]
	local function runUrl(name, url)
		say(_obi44m9h({82,134,116,115,134,134,116,130,121,133,55}) .. name .. _obi44m9h({59,60,61}))
		local ok, err = pcall(function() loadstring(game:HttpGet(url))() end)
		say(ok and (name .. _obi44m9h({45,115,135,117,116,135,135,117,121,133,69})) or (_obi44m9h({82,128,129,127,75,50}) .. tostring(err):sub(1, 60)))
	end
	if #SCRIPTS == 0 then
		section(sp, _obi44m9h({96,113,129,121,129,134,134}))
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = _obi44m9h({91,115,125,120,134,127,51,135,120,136,128,136,141,58,137,125,61,138,136,147,149,131,81,68,106,138,144,156,142,74,140,76,161,143,145,149,157,147,83,135,120,136,128,136,141,141,91,170,172,94,179,175,177,177,99,168,180,102,168,186,186,191,180,194,188,110,190,197,113,181,194,192,186,118,204,197,121,198,196,202,200,126,192,194,194,203,219,211,147}),
			Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
			Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, sp)
	end
	local lastGroup
	for _, s in ipairs(SCRIPTS) do
		local g = s[3] or _obi44m9h({96,113,129,121,129,134,134})
		if g ~= lastGroup then section(sp, g); lastGroup = g end
		rowBtn(sp, s[1], function() runUrl(s[1], s[2]) end, true)
	end
	section(sp, _obi44m9h({82,134,116,115,134,134,116,134,53,134,134,138,57,134,132,138,136}))
	local boxRow = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, sp)
	round(boxRow, 17); stroke(boxRow, 1.5)
	local urlBox = mk(_obi44m9h({97,115,135,132,83,129,139}), {
		Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
		Text = _obi44m9h({}), PlaceholderText = _obi44m9h({80,125,123,117,49,129,51,128,126,132,130,56,125,137,59,143,128,144,136,144,149,66,132,149,154,143}), PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
		TextColor3 = WHITE, Font = Enum.Font.Code, TextSize = 11, ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
	}, boxRow)
	rowBtn(sp, _obi44m9h({82,134,116,115,134,134,116,134,53,130,128,134,132}), function()
		local u = urlBox.Text
		if not u:find(_obi44m9h({107,118,131,132,129})) then say(_obi44m9h({80,125,123,117,49,135,128,52,129,127,133,131,57,139,144,129,61,129,142,141,134,133,136,68,136,149,148,72,145,158,159,156,91})); return end
		runUrl(_obi44m9h({121,119,125,123}), u)
	end, true)

	local dp = pages[_obi44m9h({91,111,131,133,131,115,127,52,89,127,138,121,140,142,128,142})] or mk(_obi44m9h({83,128,112,125,118}), {})
	local S = { fly = false, speed = false, jump = false, noclip = false, infjump = false, nofall = false, waterwalk = false, antifling = false, antivoid = false, antisit = false, tfling = false, flingVal = 150, speedVal = 50, flyVal = 50 }
	local selfBV, wwPart, lastSafe, flyGui
	local function stopSelfFly() if selfBV then selfBV:Destroy(); selfBV = nil end end

	local loopConn = RunService.Stepped:Connect(function()
		local c, h, r = lp.Character, hum(), hrp()
		if not (c and h and r) then return end
		if S.antisit then
			if h:GetStateEnabled(Enum.HumanoidStateType.Seated) then h:SetStateEnabled(Enum.HumanoidStateType.Seated, false) end
			if h.Sit or h.SeatPart then
				local sp = h.SeatPart
				local w = sp and sp:FindFirstChild(_obi44m9h({96,115,112,132,104,119,127,120}))
				if w then w:Destroy() end
				h.Sit = false
			end
		end
		if S.noclip then
			for _, p in ipairs(c:GetDescendants()) do
				if p:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) and p.CanCollide then p.CanCollide = false end
			end
		end
		if S.speed then h.WalkSpeed = S.speedVal end
		if S.jump then h.UseJumpPower = true; h.JumpPower = 90 end
		if S.nofall then
			local v = r.AssemblyLinearVelocity
			if v.Y < -55 then r.AssemblyLinearVelocity = Vector3.new(v.X, -30, v.Z) end
		end
		if S.antivoid then
			if h.FloorMaterial ~= Enum.Material.Air then lastSafe = r.CFrame end
			if lastSafe and r.Position.Y < lastSafe.Position.Y - 150 then
				r.AssemblyLinearVelocity = Vector3.zero
				r.CFrame = lastSafe + Vector3.new(0, 5, 0)
			end
		end
		if S.antifling then
			for _, pl in ipairs(Players:GetPlayers()) do
				if pl ~= lp and pl.Character then
					for _, p in ipairs(pl.Character:GetDescendants()) do
						if p:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) and p.CanCollide then p.CanCollide = false end
					end
				end
			end
			if r.AssemblyAngularVelocity.Magnitude > 40 then r.AssemblyAngularVelocity = Vector3.zero end
			local v = r.AssemblyLinearVelocity
			if Vector3.new(v.X, 0, v.Z).Magnitude > 200 or (v.Y > 150 and not S.fly) then
				r.AssemblyLinearVelocity = Vector3.zero
			end
		end
		if S.waterwalk then
			local rp = RaycastParams.new()
			rp.FilterType = Enum.RaycastFilterType.Exclude
			rp.FilterDescendantsInstances = { c }
			rp.IgnoreWater = false
			local res = workspace:Raycast(r.Position + Vector3.new(0, 8, 0), Vector3.new(0, -40, 0), rp)
			local surfaceY
			if res then
				local ins = res.Instance
				local nm = ins:GetFullName():lower()
				local waterish = res.Material == Enum.Material.Water or nm:find(_obi44m9h({132,111,131,117,131})) or nm:find(_obi44m9h({115,122,126,127,117})) or nm:find(_obi44m9h({129,129,132,126,114,127,124}))
					or (not ins.CanCollide and ins.Transparency >= 0.2 and ins.Color.B > ins.Color.R + 0.1)
				if waterish then surfaceY = res.Position.Y end
			end
			if not surfaceY and h:GetState() == Enum.HumanoidStateType.Swimming then
				surfaceY = r.Position.Y - (h.HipHeight + r.Size.Y / 2)
			end
			if surfaceY then
				if not wwPart then
					wwPart = mk(_obi44m9h({93,111,129,132}), {
						Name = _obi44m9h({96,118,120,126,89,135,117,107,118,138,124,138}), Size = Vector3.new(14, 1, 14), Anchored = true, CanCollide = true,
						CanQuery = false, CanTouch = false, Transparency = 1,
					}, workspace)
				end
				wwPart.CFrame = CFrame.new(r.Position.X, surfaceY - 0.5, r.Position.Z)
			elseif wwPart then
				wwPart.CFrame = CFrame.new(0, -5000, 0)
			end
		end
		if flyGui then flyGui.Visible = (S.fly and S.flyBtns) and true or false end
		if S.fly then
			if not selfBV or selfBV.Parent ~= r then
				stopSelfFly()
				selfBV = mk(_obi44m9h({79,125,115,137,103,119,127,131,120,127,139,145}), { MaxForce = Vector3.new(1e9, 1e9, 1e9), Velocity = Vector3.zero }, r)
			end
			local mv = h.MoveDirection
			local look = workspace.CurrentCamera.CFrame.LookVector
			local flat = Vector3.new(look.X, 0, look.Z)
			local up = 0
			if mv.Magnitude > 0 and flat.Magnitude > 0 then
				up = look.Y * math.clamp(mv:Dot(flat.Unit), -1, 1)
			end
			if S.flyBtns then
				up = ((S.flyUp and 1 or 0) - (S.flyDown and 1 or 0))
			end
			selfBV.Velocity = mv * S.flyVal + Vector3.new(0, up * S.flyVal, 0)
		else
			stopSelfFly()
		end
	end)
	local jumpConn = UIS.JumpRequest:Connect(function()
		if S.infjump then
			local h = hum()
			if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
		end
	end)

	local LAG_LIMITS = { ParticleEmitter = 40, Sound = 25, Explosion = 15, Fire = 25, Smoke = 25, Sparkles = 25, Beam = 50, Trail = 50 }
	local lag = { on = false, cnt = {}, t0 = 0, bad = 0, lastClean = 0, started = 0 }
	local function lagOwn(o)
		return o:GetAttribute(_obi44m9h({81,129,85,136})) or o.Name == _obi44m9h({96,118,120,126,87,123,133,121}) or o.Name == _obi44m9h({78,114,124,86,137,88,124,134,122})
	end
	local function lagAdded(o)
		if not lag.on then return end
		local lim = LAG_LIMITS[o.ClassName]
		if not lim or lagOwn(o) then return end
		local now = os.clock()
		if now - lag.t0 >= 1 then lag.t0 = now; lag.cnt = {} end
		local n = (lag.cnt[o.ClassName] or 0) + 1
		lag.cnt[o.ClassName] = n
		if n > lim then
			task.defer(function() pcall(function() o:Destroy() end) end)
		elseif o:IsA(_obi44m9h({93,111,129,132,122,117,127,121,90,131,128,140,141,127,141})) and o.Rate > 50 then
			o.Rate = 50
		end
	end
	local function lagEmergency()
		for _, o in ipairs(workspace:GetDescendants()) do
			if LAG_LIMITS[o.ClassName] and not lagOwn(o) then
				if o:IsA(_obi44m9h({96,125,132,126,117})) then pcall(function() o:Stop() end)
				else pcall(function() o:Destroy() end) end
			end
		end
	end
	local lagConn, lagHB
	local function lagStop()
		lag.on = false
		if lagConn then lagConn:Disconnect(); lagConn = nil end
		if lagHB then lagHB:Disconnect(); lagHB = nil end
	end
	local function lagStart()
		lagStop()
		lag.on, lag.cnt, lag.t0, lag.bad, lag.started = true, {}, os.clock(), 0, os.clock()
		lagConn = workspace.DescendantAdded:Connect(lagAdded)
		lagHB = RunService.Heartbeat:Connect(function(dt)

			if os.clock() - lag.started < 15 then return end
			if dt > 0.35 then lag.bad = lag.bad + 1 else lag.bad = 0 end
			if lag.bad >= 3 and os.clock() - lag.lastClean > 4 then
				lag.bad, lag.lastClean = 0, os.clock()
				task.spawn(lagEmergency)
			end
		end)
	end

	local tfTok, tfRoot, tfOld = 0, nil, {}
	local startTFling
	local function stopTFling()
		tfTok = tfTok + 1
		tfRoot = nil
		for p, o in pairs(tfOld) do
			if p.Parent then pcall(function() p.CustomPhysicalProperties = o or nil end) end
		end
		tfOld = {}
		local r = hrp()
		if r then r.AssemblyAngularVelocity = Vector3.zero end
	end
	function startTFling()
		stopTFling()
		local my = tfTok
		local c, r = lp.Character, hrp()
		if not (c and r) then return end
		for _, p in ipairs(c:GetDescendants()) do
			if p:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) then
				tfOld[p] = p.CustomPhysicalProperties or false
				p.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5, 1, 1)
			end
		end
		tfRoot = r
		task.spawn(function()
			while tfTok == my do
				RunService.Heartbeat:Wait()
				local root = hrp()
				if not root then
					task.wait(0.5)
				elseif tfRoot ~= root then
					startTFling()
					return
				else
					local v = root.AssemblyLinearVelocity
					if v.Magnitude > 50 then v = v.Unit * 50 end
					root.AssemblyLinearVelocity = v * 10000 + Vector3.new(0, S.flingVal * 70, 0)
					RunService.RenderStepped:Wait()
					if root.Parent then root.AssemblyLinearVelocity = v end
					RunService.Stepped:Wait()
					if root.Parent then root.AssemblyLinearVelocity = v + Vector3.new(0, 0.1, 0) end
				end
			end
		end)
	end

	local function claimSim()
		pcall(function() sethiddenproperty(lp, _obi44m9h({96,119,124,133,125,115,135,125,132,132,105,121,125,131,144,143}), 1e9) end)
		pcall(function() lp.MaximumSimulationRadius = 1e9 end)
	end
	local function isLoose(p)
		if not (p and p:IsA(_obi44m9h({79,111,130,117,97,115,133,136}))) or p.Anchored then return false end
		if p.Name == _obi44m9h({85,131,124,113,127,129,124,120,103,133,134,140,105,123,141,144}) or p.Name == _obi44m9h({96,118,120,126,89,135,117,107,118,138,124,138}) or p:GetAttribute(_obi44m9h({81,129,85,136})) then return false end
		if p:FindFirstAncestorOfClass(_obi44m9h({78,113,114,117,132,133,130,134,142})) or p:FindFirstAncestorOfClass(_obi44m9h({97,125,126,124})) then return false end
		local root = p.AssemblyRootPart
		if root and root.Anchored then return false end
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl.Character and p:IsDescendantOf(pl.Character) then return false end
		end
		return true
	end

	local tk = { part = nil, bp = nil, bg = nil, y = 0, armed = false, cc = nil, t = 0 }
	local function tkRelease()
		if tk.bp then tk.bp:Destroy() end
		if tk.bg then tk.bg:Destroy() end
		tk.part, tk.bp, tk.bg = nil, nil, nil
	end
	local function tkGrab(part)
		tkRelease()
		claimSim()
		tk.part = part
		part.CanCollide = true
		tk.bp = mk(_obi44m9h({79,125,115,137,97,129,134,125,137,127,134,134}), { MaxForce = Vector3.new(1e9, 1e9, 1e9), P = 1e5, D = 2e3, Position = part.Position }, part)
		tk.bg = mk(_obi44m9h({79,125,115,137,88,139,133,131}), { MaxTorque = Vector3.new(1e9, 1e9, 1e9), P = 1e4, D = 500, CFrame = CFrame.new() }, part)
		local r, h = hrp(), hum()
		if r and h then
			tk.y = r.Position.Y - (h.HipHeight + r.Size.Y / 2) - part.Size.Y / 2
		else
			tk.y = part.Position.Y
		end
	end
	local tkConn = RunService.Heartbeat:Connect(function(dt)
		local part, r, h = tk.part, hrp(), hum()
		if not part then return end
		if not part.Parent then tkRelease(); return end
		if not (r and h) then return end
		tk.t = tk.t + dt
		if tk.t > 1 then tk.t = 0; claimSim() end

		local mv = h.MoveDirection
		local look = workspace.CurrentCamera.CFrame.LookVector
		local flat = Vector3.new(look.X, 0, look.Z)
		if mv.Magnitude > 0 and flat.Magnitude > 0 then
			tk.y = tk.y + look.Y * math.clamp(mv:Dot(flat.Unit), -1, 1) * S.flyVal * dt
		end
		tk.bp.Position = Vector3.new(r.Position.X, tk.y, r.Position.Z)
		part.AssemblyAngularVelocity = Vector3.zero
	end)
	local tkInput = UIS.InputBegan:Connect(function(i, gp)
		if not tk.armed or gp or not isPress(i) then return end
		tk.armed = false
		local cam = workspace.CurrentCamera
		local ray = cam:ScreenPointToRay(i.Position.X, i.Position.Y)
		local rp = RaycastParams.new()
		rp.FilterType = Enum.RaycastFilterType.Exclude
		rp.FilterDescendantsInstances = { lp.Character }
		local res = workspace:Raycast(ray.Origin, ray.Direction * 1000, rp)
		local part = res and res.Instance
		if part and isLoose(part) and part.Size.Magnitude < 300 then
			tkGrab(part)
			say(_obi44m9h({79,122,126,115,128,50,131,121,124,133,56,56,90,136,127,129,61,131,140,64,132,139,144,133,69,138,140,148,142,88,75,123,153,150,148,80,161,164,148,84,152,159,164,153,104,156,156,165,181,173,95,165,97,163,177,168,170,102,183,186,170,106,193,187,174,192,125}))
		else
			say(_obi44m9h({86,129,130,127,49,128,214,183,132,54,218,193,57,143,136,60,127,138,142,131,144,66,150,147,145,154,150,72,81,142,144,159,142,156,146,159,163,147,151,163,94,100}))
		end
	end)

	local fp = { on = false, parts = {}, ang = 0, radius = 14, tok = 0 }
	local function fpScan()
		local r = hrp()
		if not r then return end
		local list, n = {}, 0
		for _, d in ipairs(workspace:GetDescendants()) do
			n = n + 1
			if n % 3000 == 0 then task.wait() end
			if d:IsA(_obi44m9h({79,111,130,117,97,115,133,136})) and not d.Anchored and d.Size.Magnitude < 60 and d ~= tk.part and isLoose(d) then
				table.insert(list, d)
			end
		end
		table.sort(list, function(a, b) return (a.Position - r.Position).Magnitude < (b.Position - r.Position).Magnitude end)
		local out = {}
		for i = 1, math.min(#list, 120) do
			out[i] = list[i]
			list[i].CanCollide = true
		end
		fp.parts = out
	end
	local fpConn = RunService.Heartbeat:Connect(function(dt)
		if not fp.on then return end
		local r = hrp()
		if not r then return end
		fp.ang = fp.ang + dt * 4
		local n = #fp.parts
		for i, p in ipairs(fp.parts) do
			if p.Parent and not p.Anchored then
				local a = fp.ang + (i / n) * math.pi * 2
				local target = r.Position + Vector3.new(math.cos(a) * fp.radius, (i % 3 - 1) * 4 + 1, math.sin(a) * fp.radius)
				local v = (target - p.Position) * 12
				if v.Magnitude > 250 then v = v.Unit * 250 end
				p.AssemblyLinearVelocity = v
				p.AssemblyAngularVelocity = Vector3.new(0, 20, 0)
			end
		end
	end)
	local function fpSet(v)
		fp.tok = fp.tok + 1
		fp.on = v
		if v then
			local my = fp.tok
			claimSim()
			task.spawn(function()
				while fp.on and fp.tok == my do
					fpScan()
					claimSim()
					task.wait(5)
				end
			end)
		else
			for _, p in ipairs(fp.parts) do
				if p.Parent and not p.Anchored then p.AssemblyLinearVelocity = Vector3.zero end
			end
			fp.parts = {}
		end
	end

	section(dp, _obi44m9h({96,125,113,130,118,136,124,138,122,136}))
	toggleRow(dp, _obi44m9h({99,125,112,130}), _obi44m9h({92,122,119,117,49,130,133,117,53,121,128,133,122,58,70,60,135,141,152,147,149,139,134,143,69,99,71,155,152,140,144}), function(v) S.fly = v end)
	toggleRow(dp, _obi44m9h({78,124,131,121,62,131,136,121,121,119}), _obi44m9h({89,119,124,121,133,115,51,117,53,140,124,132,136,125,132,128,126,130,132,64,133,131,67,149,154,139,139,137}), function(v) S.nofall = v end)
	rowBtn(dp, _obi44m9h({96,131,113,121,131,50,68,68,69,54,138,140,142,126,142,60,69,132,148,135,138,148,67,136,134,70,234,201,144,159,140,85}), function()
		local r = hrp()
		if r then r.CFrame = r.CFrame + Vector3.new(0, 100, 0); say(_obi44m9h({96,131,113,121,134,50,68,68,69,54,138,140,142,126,142,74})) end
	end)
	toggleRow(dp, _obi44m9h({83,122,120,126,120,50,59,128,118,132,218,191,122,140,59,139,144,62,142,149,149,148,146,151,78}), _obi44m9h({94,131,116,125,49,119,129,119,132,137,139,121,139,58,128,137,61,148,142,131,228,204,67,151,134,143,71,158,152,139,153,144,156,92,79,134,160,149,246,222,85,164,250,219,168,90,162,165,175,159,95,174,166,175,99,7,238,102,179,169,183,13,242,173,177,189}), function(v)
		S.tfling = v
		if v then startTFling() else stopTFling() end
	end)
	sliderRow(dp, _obi44m9h({83,125,129,211,184,115,51,120,132,54,125,132,130,136,130}), _obi44m9h({86,124,131,117,127,133,124,120,118,122,124,56,125,137,59,136,126,140,226,199,130,143,136,146,153,149}), 50, 300, 150, function(v) S.flingVal = v end)
	toggleRow(dp, _obi44m9h({78,124,131,121,62,136,130,125,121}), _obi44m9h({99,125,123,132,114,50,131,134,132,54,218,210,133,142,132,137,140,62,139,149,136,131,149,68,152,139,142,157,155,153,75,159,146,78,146,145,154,164,83,162,164,86,173,153,179,163,170}), function(v) S.antivoid = v end)
	toggleRow(dp, _obi44m9h({93,131,123,127,49,123,129,122,126,132,128,140,136}), _obi44m9h({93,131,123,113,49,128,130,52,118,136,55,137,142,123,137,144,126,145,63,150,134,156,136,151,69,151,156,145,156,143,157}), function(v) S.infjump = v end)
	toggleRow(dp, _obi44m9h({78,124,115,113,131,50,134,131,119,136,124,56,122,58,222,189,132,147,128}), _obi44m9h({93,122,112,132,114,120,130,134,130,119,55,129,135,144,132,143,224,203,149,133,141,66,145,133,69,153,156,152,142,156,145,239,218,145,152,149}), function(v)
		S.waterwalk = v
		if not v and wwPart then wwPart:Destroy(); wwPart = nil end
	end)
	local island, islandBack
	rowBtn(dp, _obi44m9h({86,122,119,113,49,133,120,123,138,136,120,56,65,138,135,125,145,127,133,143,147,143,132,68,147,149,71,139,236,211,160,85}), function()
		local r = hrp()
		if not r then return end
		if not island or not island.Parent then
			island = mk(_obi44m9h({93,111,129,132}), {
				Name = _obi44m9h({96,118,120,126,89,135,117,93,129,126,120}), Size = Vector3.new(40, 2, 40), Anchored = true, CanCollide = true,
				Material = Enum.Material.SmoothPlastic, Color = Color3.fromRGB(60, 8, 12),
				Position = Vector3.new(r.Position.X, 3500, r.Position.Z),
			}, workspace)
		end
		islandBack = r.CFrame
		r.AssemblyLinearVelocity = Vector3.zero
		r.CFrame = CFrame.new(island.Position + Vector3.new(0, 4, 0))
		say(_obi44m9h({91,111,47,121,125,122,116,52,136,123,126,141,139,123,73,60,114,145,132,64,67,120,146,144,153,135,153,72,141,139,75,149,153,150,144,82,81,163,168,149,163,154,166,88,169,155,174,175,158,176,109}))
	end)
	rowBtn(dp, _obi44m9h({99,125,123,132,114,132,51,120,118,54,128,132,129,123}), function()
		local r = hrp()
		if r and islandBack then
			r.AssemblyLinearVelocity = Vector3.zero
			r.CFrame = islandBack
			say(_obi44m9h({81,115,47,134,128,126,135,117,67}))
		else
			say(_obi44m9h({99,125,114,211,187,50,116,125,131,122,120,56,135,221,190,139,61,132,142,137,65,146,149,133,69,143,147,144,138,88}))
		end
	end, true)
	section(dp, _obi44m9h({79,122,126,115,128,133,51,135,132,130,139,135,140}))
	rowBtn(dp, _obi44m9h({97,115,123,117,116,123,129,121,136,123,81,56,126,141,126,139,137,134,132,146,65,132,143,147,136,149}), function()
		tk.armed = true
		say(_obi44m9h({97,125,128,133,118,50,129,137,130,54,121,132,136,125,138,60,144,141,139,148,144,66,75,136,138,153,136,150,140,153,157,141,145,157,88,80,149,161,83,161,150,166,152,100,89,160,170,174,158,94,163,175,97,175,168,178,186,116}))
	end)
	rowBtn(dp, _obi44m9h({97,115,123,117,116,123,129,121,136,123,81,56,140,137,135,144,126,144,63,130,141,145,134,147}), function() tkRelease(); say(_obi44m9h({79,122,126,115,128,50,134,131,129,138,134,70})) end, true)
	rowBtn(dp, _obi44m9h({79,122,126,115,128,76,51,135,138,120,128,138,57,75,75}), function() tk.y = tk.y + 10 end, true)
	rowBtn(dp, _obi44m9h({79,122,126,115,128,76,51,120,122,137,122,125,139,58,76,76}), function() tk.y = tk.y - 10 end, true)
	toggleRow(dp, _obi44m9h({83,122,120,126,120,50,99,117,135,138,138}), _obi44m9h({93,115,210,183,114,133,51,135,132,130,139,121,140,58,130,133,143,127,140,64,134,143,67,154,148,146,155,137,73,142,144,76,163,157,146,243,219}), function(v)
		fpSet(v)
		say(v and _obi44m9h({93,128,126,115,134,132,116,130,121,133,55,136,126,221,194,125,144,62,146,143,141,150,132,151,83,84,85}) or _obi44m9h({83,122,120,126,120,50,99,117,135,138,138,56,125,127,142,136,134,133,128,132,144,80}))
	end)
	sliderRow(dp, _obi44m9h({95,111,120,127,49,118,116,135,53,134,124,219,192,123,142}), _obi44m9h({81,119,130,132,212,180,129,119,126,119,55,124,136,58,126,223,202,144,130,149,141,145}), 8, 40, 14, function(v) fp.radius = v end)
	section(dp, _obi44m9h({93,128,126,132,118,213,186,215,184,133}))
	toggleRow(dp, _obi44m9h({78,124,131,121,62,120,127,125,131,125}), _obi44m9h({86,117,125,127,131,115,51,119,132,130,128,139,220,189,138,60,129,131,63,143,150,150,149,147,152,70,145,151,144,139,143,155,159,147,162,80,150,82,173,153,167,151,87,159,162,172,170,107,158,176,177,165,174,167,182,183,180}), function(v) S.antifling = v end)

	local pp = pages[_obi44m9h({93,128,126,132,118,213,186,215,202,123,138})]
	if pp then
		section(pp, _obi44m9h({93,128,126,132,118,213,186,215,202,123,138}))
		toggleRow(pp, _obi44m9h({78,124,131,121,62,120,127,125,131,125}), _obi44m9h({86,117,125,127,131,115,51,119,132,130,128,139,220,189,138,60,129,131,63,143,150,150,149,147,152,70,145,151,144,139,143,155,159,147,162,80,150,82,173,153,167,151,87,159,162,172,170,107,158,176,177,165,174,167,182,183,180}), function(v) S.antifling = v end)
		toggleRow(pp, _obi44m9h({78,124,131,121,62,136,130,125,121}), _obi44m9h({99,125,123,132,114,50,131,134,132,54,218,210,133,142,132,137,140,62,139,149,136,131,149,68,152,139,142,157,155,153,75,159,146,78,146,145,154,164,83,152,164,86,164,153,169,155}), function(v) S.antivoid = v end)
		toggleRow(pp, _obi44m9h({96,115,124,48,117,115,129,131,53,122,124,56,138,143,128,128,126}), _obi44m9h({95,115,115,133,139,50,116,52,139,123,131,135,124,131,127,125,129,131,63,132,130,66,148,153,138,138,136}), function(v) S.nofall = v end)
		toggleRow(pp, _obi44m9h({78,124,131,121,62,133,120,130,137,119,137}), _obi44m9h({91,209,178,127,49,118,120,125,141,119,55,139,126,136,143,125,143,62,132,141,65,133,132,150,151,149,83,72,140,139,143,145,150,160,144,80,159,151,160,84,151,151,165,155,168}), function(v)
			S.antisit = v
			if not v then
				local h = hum()
				if h then h:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
			end
		end)
		toggleRow(pp, _obi44m9h({78,124,131,121,62,126,116,123}), _obi44m9h({96,115,118,133,131,115,51,122,129,133,134,124,57,126,128,60,141,127,145,148,228,207,134,153,145,135,154,84,73,157,154,154,160,78,148,80,150,170,163,160,164,169,250,237,158,173,91,160,162,94,178,163,179,171,179,184,184,102,171,173,105,182,172,179}), function(v)
			if v then lagStart() else lagStop() end
			say(v and _obi44m9h({78,124,131,121,62,126,116,123,53,130,128,127,122,126,138,74}) or _obi44m9h({78,124,131,121,62,126,116,123,53,122,124,139,133,131,130,125,129,141,77}))
		end)
	end

	local mp = pages[_obi44m9h({90,125,133,121,126,119,129,136,132})]
	if mp then
		section(mp, _obi44m9h({90,125,133,121,126,119,129,136,132}))
		toggleRow(mp, _obi44m9h({99,125,112,130}), _obi44m9h({92,122,119,117,49,130,133,117,53,121,128,133,122,58,70,60,135,141,152,147,149,139,134,143,69,99,71,155,152,140,144}), function(v) S.fly = v end)
		toggleRow(mp, _obi44m9h({99,115,123,127,116,123,119,117,121,123}), _obi44m9h({89,119,118,113,49,115,51,138,122,130,134,123,130,126,124,128,130,62,132,147,132,145,143,140,142,138,136,72,138,140,140,149,165,157}), function(v)
			S.speed = v
			if not v then local h = hum(); if h then h.WalkSpeed = 16 end end
		end)
		sliderRow(mp, _obi44m9h({99,111,123,127,131,50,119,117,53,140,124,132,136,125,132,128,126,130,132}), _obi44m9h({80,125,129,130,122,118,116}), 16, 120, 50, function(v) S.speedVal = v end)
		sliderRow(mp, _obi44m9h({99,115,123,127,116,123,119,117,121,123,55,124,136,58,145,139,140}), _obi44m9h({99,125,112,130}), 20, 150, 50, function(v) S.flyVal = v end)

		flyGui = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.fromOffset(60, 124), Position = UDim2.new(0, 24, 0.55, -62), BackgroundTransparency = 1, Visible = false, ZIndex = 20 }, gui)
		local function holdBtn(txt, y, key)
			local b = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), {
				Text = txt, Size = UDim2.fromOffset(60, 56), Position = UDim2.fromOffset(0, y),
				BackgroundColor3 = PANEL, BackgroundTransparency = 0.15, TextColor3 = WHITE,
				Font = Enum.Font.GothamBold, TextSize = 24, ZIndex = 21,
			}, flyGui)
			round(b, 28); stroke(b, 2)
			local function isHold(i) return i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 end
			b.InputBegan:Connect(function(i) if isHold(i) then S[key] = true end end)
			b.InputEnded:Connect(function(i) if isHold(i) then S[key] = false end end)
		end
		holdBtn(_obi44m9h({239,164,193}), 0, _obi44m9h({115,122,136,101,129}))
		holdBtn(_obi44m9h({239,164,203}), 68, _obi44m9h({115,122,136,84,128,137,129}))
		toggleRow(mp, _obi44m9h({79,125,131,211,198,119,134,52,121,123,55,142,136,137,59,68,144,147,129,137,147,81,135,137,152,137,140,154,82}), _obi44m9h({80,125,124,48,128,50,105,131,118,136,55,132,130,129,124,128,140,74,63,141,144,149,151,150,134,70,9,190,219,74,13,194,233,78,157,145,81,166,152,160,150,112,87,171,158,161,176,174,162,94,175,178,162,98,182,185,167,175,185,104,184,191,107,176,178,193,178,181,195,141,115,199,196,194,203,199,121,151,123,194,198,193,192,128,209,195,213,197,201,213,135,214,216,138,204,222}), function(v)
			S.flyBtns = v
			if not v then S.flyUp = false; S.flyDown = false end
		end)
		toggleRow(mp, _obi44m9h({93,131,123,127,49,115,127,136,132}), _obi44m9h({87,131,124,128,97,129,138,121,135,54,80,72}), function(v)
			S.jump = v
			if not v then local h = hum(); if h then h.JumpPower = 50 end end
		end)
		toggleRow(mp, _obi44m9h({93,131,123,127,49,123,129,122,126,132,128,140,136}), _obi44m9h({93,131,123,113,49,128,130,52,118,136,55,137,142,123,137,144,126,145,63,150,134,156,136,151,69,151,156,145,156,143,157}), function(v) S.infjump = v end)
		toggleRow(mp, _obi44m9h({78,130,129,113,135,119,134,135,118,136,55,136,122,140,128,128,130,145}), _obi44m9h({91,125,114,124,122,130}), function(v) S.noclip = v end)
	end

	do
		local evp = pages[_obi44m9h({82,132,112,116,118})]
		if evp then
			local EV = {
				slide = false, hop = false, showSlide = false, showHop = false, locked = false,
				keyHeld = false, touchIn = nil, wasSliding = false, slideSpeed = 0, lastHop = 0, lastHook = 0,
				lastTick = 0, lastAnims = _obi44m9h({}), hn = 0, rec = true, spyOut = false, gState = _obi44m9h({}), gAt = 0, hopAlways = false,
			}
			local evConns, evButtons, recConns = {}, {}, {}
			local setSlideMenu, setHopMenu, paintSlide, paintHop

			local REC = { lines = {}, rate = {}, t0 = os.clock() }
			local function ser(v, d)
				d = d or 0
				local t = typeof(v)
				if t == _obi44m9h({128,130,129,121,127,121}) then return string.format(_obi44m9h({50,127}), v:sub(1, 60))
				elseif t == _obi44m9h({123,131,124,114,118,132}) then return string.format(_obi44m9h({50,60,67,119}), v)
				elseif t == _obi44m9h({111,125,126,124,118,115,129}) or t == _obi44m9h({123,119,123}) then return tostring(v)
				elseif t == _obi44m9h({99,115,114,132,128,132,70}) then return string.format(_obi44m9h({99,65,55,53,63,67,121,64,58,68,72,126,69,63,73,77,131,71}), v.X, v.Y, v.Z)
				elseif t == _obi44m9h({80,84,129,113,126,119}) then local p = v.Position; return string.format(_obi44m9h({80,84,55,53,63,67,121,64,58,68,72,126,69,63,73,77,131,71}), p.X, p.Y, p.Z)
				elseif t == _obi44m9h({86,124,130,132,114,128,118,121}) then return v:GetFullName()
				elseif t == _obi44m9h({129,111,113,124,118}) then
					if d >= 2 then return _obi44m9h({136,60,61,62,142}) end
					local out, n = {}, 0
					for k, x in pairs(v) do
						n = n + 1
						if n > 8 then out[#out + 1] = _obi44m9h({59,60,61}); break end
						out[#out + 1] = tostring(k) .. _obi44m9h({74}) .. ser(x, d + 1)
					end
					return _obi44m9h({136}) .. table.concat(out, _obi44m9h({57,46})) .. _obi44m9h({138})
				end
				return _obi44m9h({73}) .. t .. _obi44m9h({75})
			end
			local function push(cat, msg)
				local now = os.clock()
				local r = hrp()
				local sp = r and Vector3.new(r.AssemblyLinearVelocity.X, 0, r.AssemblyLinearVelocity.Z).Magnitude or 0
				local line = string.format(_obi44m9h({104,51,130,48,60,55,73,66,70,124,138,117,57,63,72,84,144,62,68,147,65,158,67,154,138,146,100,77,87,90,145}), os.date(_obi44m9h({50,86,73,53,94,76,56,103})), now - REC.t0, cat, msg, sp)
				REC.lines[#REC.lines + 1] = line
				if #REC.lines > 4000 then table.remove(REC.lines, 1) end
				DSLOG.ev(_obi44m9h({86,92,85,95}), _obi44m9h({114,132,112,116,118}), cat .. _obi44m9h({45}) .. msg)
			end

			local function rec(cat, msg, limit)
				if not EV.rec then return end
				local now = os.clock()
				local r = REC.rate[cat]
				if not r or now - r.t >= 1 then
					if r and r.drop > 0 then push(cat, _obi44m9h({53,57}) .. r.drop .. _obi44m9h({45,122,120,126,121,115,134,52,132,131,128,140,130,126,124,143,87,62,140,149,138,150,146,68,151,233,200,152,146,142,154,85})) end
					r = { t = now, n = 0, drop = 0 }
					REC.rate[cat] = r
				end
				r.n = r.n + 1
				if r.n > (limit or 12) then r.drop = r.drop + 1; return end
				push(cat, msg)
			end

			local function unbindChar()
				for _, cn in ipairs(recConns) do pcall(function() cn:Disconnect() end) end
				recConns = {}
			end
			local function bindChar()
				unbindChar()
				local c, h = lp.Character, hum()
				if not (c and h) then rec(_obi44m9h({112,118,112,130}), _obi44m9h({110,119,125,116,114,50,134,121,130,54,135,125,139,141,138,138,126,133,132,141,80,138,152,145,134,148,150,145,141})); return end
				rec(_obi44m9h({112,118,112,130}), _obi44m9h({125,115,129,131,128,128,116,123,122,131,55}) .. c:GetFullName() .. _obi44m9h({45,128,120,119,78}) .. tostring(h.RigType) .. _obi44m9h({45,101,112,124,124,101,131,121,122,122,84}) .. tostring(h.WalkSpeed)
					.. _obi44m9h({45,88,132,125,129,98,130,139,122,136,84}) .. tostring(h.JumpPower) .. _obi44m9h({45,88,132,125,129,90,120,125,124,126,139,85}) .. tostring(h.JumpHeight))
				local names = {}
				for n, x in pairs(c:GetAttributes()) do names[#names + 1] = _obi44m9h({112,118,112,130,63}) .. n .. _obi44m9h({74}) .. tostring(x) end
				for n, x in pairs(h:GetAttributes()) do names[#names + 1] = _obi44m9h({117,131,124,62}) .. n .. _obi44m9h({74}) .. tostring(x) end
				for n, x in pairs(lp:GetAttributes()) do names[#names + 1] = _obi44m9h({125,122,112,137,118,132,65}) .. n .. _obi44m9h({74}) .. tostring(x) end
				rec(_obi44m9h({110,130,131,130}), _obi44m9h({110,130,129,121,115,135,135,131,136,54,120,127,136,140,124,86,61}) .. (#names > 0 and table.concat(names, _obi44m9h({57,46})) or _obi44m9h({53,124,116,126,121,135,128,61})))
				local kids = {}
				for _, k in ipairs(c:GetChildren()) do kids[#kids + 1] = k.Name .. _obi44m9h({71}) .. k.ClassName end
				rec(_obi44m9h({112,118,112,130}), _obi44m9h({115,119,123,120,128,133,51,120,132,54,135,125,139,141,138,138,126,133,132,141,91,66}) .. table.concat(kids, _obi44m9h({57,46})))
				local function add(cn) recConns[#recConns + 1] = cn end
				local function watch(o, tag)
					add(o.AttributeChanged:Connect(function(n) rec(_obi44m9h({110,130,131,130}), tag .. _obi44m9h({59}) .. n .. _obi44m9h({45,75,47}) .. ser(o:GetAttribute(n)), 20) end))
				end
				watch(c, _obi44m9h({112,118,112,130})); watch(h, _obi44m9h({117,131,124})); watch(lp, _obi44m9h({125,122,112,137,118,132}))
				local root = hrp()
				if root then watch(root, _obi44m9h({127,125,126,132})) end
				add(c.ChildAdded:Connect(function(k) rec(_obi44m9h({112,118,112,130}), _obi44m9h({56,116,120,124,121,129,51}) .. k.Name .. _obi44m9h({71}) .. k.ClassName, 10) end))
				add(c.ChildRemoved:Connect(function(k) rec(_obi44m9h({112,118,112,130}), _obi44m9h({58,116,120,124,121,129,51}) .. k.Name, 10) end))
				for _, prop in ipairs({ _obi44m9h({100,111,123,123,100,130,120,121,121}), _obi44m9h({87,131,124,128,97,129,138,121,135}), _obi44m9h({87,131,124,128,89,119,124,123,125,138}), _obi44m9h({85,119,127,88,118,123,122,124,137}), _obi44m9h({85,115,112,124,133,122}), _obi44m9h({93,122,112,132,119,129,133,129,104,138,120,134,125}), _obi44m9h({96,119,131}) }) do
					add(h:GetPropertyChangedSignal(prop):Connect(function() rec(_obi44m9h({117,131,124}), prop .. _obi44m9h({45,75,47}) .. ser(h[prop]), 6) end))
				end
				add(h.StateChanged:Connect(function(old, new) rec(_obi44m9h({114,129,131,113,117,129}), tostring(old) .. _obi44m9h({45,59,77,48}) .. tostring(new), 20) end))
				local an = h:FindFirstChildOfClass(_obi44m9h({78,124,120,125,114,134,130,134}))
				if an then
					add(an.AnimationPlayed:Connect(function(t)
						rec(_obi44m9h({110,124,120,125}), _obi44m9h({129,125,114,127,134,50}) .. tostring(t.Name) .. _obi44m9h({45,119,115,77}) .. tostring(t.Animation and t.Animation.AnimationId)
							.. _obi44m9h({45,114,132,130,78}) .. string.format(_obi44m9h({50,60,65,118}), t.Length) .. _obi44m9h({45,126,129,121,128,79}) .. tostring(t.Priority), 20)
						t.Stopped:Connect(function() rec(_obi44m9h({110,124,120,125}), _obi44m9h({125,111,129,127,134,50}) .. tostring(t.Name), 20) end)
					end))
				else
					rec(_obi44m9h({112,118,112,130}), _obi44m9h({128,115,124,48,82,128,124,129,118,138,134,138,57,136,138,60,133,147,140,129,143,145,140,136}))
				end
			end
			table.insert(evConns, lp.CharacterAdded:Connect(function()
				EV.gState = _obi44m9h({}); EV.gSpeed = nil
				rec(_obi44m9h({112,118,112,130}), _obi44m9h({123,125,133,127,49,130,120,134,136,133,133,121,128,127,136,60,69,144,132,147,145,131,154,146,84,152,150,140,138,142,140,85}))
				task.wait(0.6)
				bindChar()
			end))

			local watched = setmetatable({}, { __mode = _obi44m9h({120}) })
			local function watchRemote(r)
				if watched[r] or not r:IsA(_obi44m9h({95,115,124,127,133,119,88,138,122,132,139})) then return end
				watched[r] = true
				table.insert(evConns, r.OnClientEvent:Connect(function(...)
					local a = table.pack(...)
					local p = {}
					for k = 1, math.min(a.n, 6) do p[k] = ser(a[k]) end
					rec(_obi44m9h({127,115,124,127,133,119,79,65}) .. r.Name, _obi44m9h({53}) .. table.concat(p, _obi44m9h({57,46})) .. _obi44m9h({54}), 5)
				end))
			end
			pcall(function()
				local RS = game:GetService(_obi44m9h({95,115,127,124,122,117,116,136,122,122,106,140,136,140,124,131,130}))
				for _, d in ipairs(RS:GetDescendants()) do watchRemote(d) end
				table.insert(evConns, RS.DescendantAdded:Connect(function(d) task.defer(watchRemote, d) end))
			end)

			local spyHooked = false
			local function installSpy()
				if spyHooked then return true end
				if not (hookmetamethod and getnamecallmethod) then return false end
				local nc = newcclosure or function(f) return f end
				local ok = pcall(function()
					local old
					old = hookmetamethod(game, _obi44m9h({108,109,125,113,126,119,118,117,129,130}), nc(function(self, ...)
						local m = getnamecallmethod()
						if EV.spyOut and (m == _obi44m9h({83,119,129,117,100,119,133,138,122,136}) or m == _obi44m9h({86,124,133,127,124,119,102,121,135,140,124,138})) then
							local a = table.pack(...)
							local okn, nm = pcall(function() return self.Name end)
							task.defer(function()
								local p = {}
								for k = 1, math.min(a.n, 6) do p[k] = ser(a[k]) end
								rec(_obi44m9h({127,115,124,127,133,119,64,82}), (okn and nm or _obi44m9h({76})) .. _obi44m9h({71}) .. m .. _obi44m9h({53}) .. table.concat(p, _obi44m9h({57,46})) .. _obi44m9h({54}), 15)
							end)
						end
						return old(self, ...)
					end))
				end)
				spyHooked = ok
				return ok
			end

			local stateHooked = false
			local function installStateHook()
				if stateHooked or not (hookmetamethod and getnamecallmethod) then return stateHooked end
				local nc = newcclosure or function(f) return f end
				local ok = pcall(function()
					local old
					old = hookmetamethod(game, _obi44m9h({108,109,125,113,126,119,118,117,129,130}), nc(function(self, ...)
						local a1, a2, a3 = ...
						if getnamecallmethod() == _obi44m9h({83,119,129,117,100,119,133,138,122,136}) then
							local okn, nm = pcall(function() return self.Name end)
							if okn and nm == _obi44m9h({98,126,115,113,133,119,86,124,118,136,120,123,141,127,141,96,126,146,128,114,134,137,140,151,153,152,160}) then
								pcall(function()

									local list = (type(a1) == _obi44m9h({129,111,113,124,118})) and a1 or { a1, a2, a3 }
									local st, spd
									for k = 2, 6 do
										local x = list[k]
										if type(x) == _obi44m9h({128,130,129,121,127,121}) and not st then st = x
										elseif type(x) == _obi44m9h({123,131,124,114,118,132}) and not spd then spd = x end
									end
									if st then EV.gState = st; EV.gAt = os.clock(); EV.gSpeed = spd end
								end)
							end
						end
						return old(self, ...)
					end))
				end)
				stateHooked = ok
				return ok
			end
			local hookOk = installStateHook()
			rec(_obi44m9h({114,132,112,116,118}), _obi44m9h({117,125,126,123,49,118,130,52,122,137,139,121,125,137,59,128,140,62,137,143,136,145,93,68}) .. tostring(hookOk))

			local function makeFloat(label, pos, onTap)
				local b = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), {
					Text = label, Size = UDim2.fromOffset(64, 64), Position = pos, Visible = false,
					BackgroundColor3 = PANEL, BackgroundTransparency = 0.15, TextColor3 = WHITE,
					Font = Enum.Font.GothamBold, TextSize = 11, TextWrapped = true, AutoButtonColor = false, ZIndex = 25,
				}, gui)
				round(b, 32)
				local st = mk(_obi44m9h({98,87,98,132,131,129,126,121}), { Thickness = 2, Color = RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
				local dragging, moved, startPos, startIn = false, false, nil, nil
				b.InputBegan:Connect(function(i)
					if isPress(i) then
						dragging, moved = true, false
						startPos, startIn = b.Position, i.Position
					end
				end)
				table.insert(evConns, UIS.InputChanged:Connect(function(i)
					if dragging and not EV.locked and isMove(i) then
						local d = i.Position - startIn
						if d.Magnitude > 6 then moved = true end
						if moved then
							b.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
						end
					end
				end))
				table.insert(evConns, UIS.InputEnded:Connect(function(i)
					if dragging and isPress(i) then
						dragging = false
						if not moved then onTap() end
					end
				end))
				local function paint(on)
					b.BackgroundColor3 = on and RED or PANEL
					st.Color = on and WHITE or RED
				end
				table.insert(evButtons, b)
				return b, paint
			end

			local slideBtn
			slideBtn, paintSlide = makeFloat(_obi44m9h({96,122,120,116,118,28,245,156,179}), UDim2.new(1, -90, 0.42, 0), function()
				EV.slide = not EV.slide
				paintSlide(EV.slide)
				rec(_obi44m9h({130,119}), _obi44m9h({111,125,131,211,180,129,51,122,129,139,139,141,122,136,143,129,61,103,141,134,138,144,140,152,138,70,122,148,146,142,144,76,90,108,79}) .. (EV.slide and _obi44m9h({89,87,86,81,85,97}) or _obi44m9h({113,115,130,124,122,121,116,120,132})))
				if setSlideMenu then setSlideMenu(EV.slide) end
			end)
			local hopBtn
			hopBtn, paintHop = makeFloat(_obi44m9h({78,131,131,127,27,90,130,132}), UDim2.new(1, -90, 0.42, 76), function()
				EV.hop = not EV.hop
				paintHop(EV.hop)
				rec(_obi44m9h({130,119}), _obi44m9h({111,125,131,211,180,129,51,122,129,139,139,141,122,136,143,129,61,95,148,148,144,66,107,147,149,70,84,102,73}) .. (EV.hop and _obi44m9h({89,87,86,81,85,97}) or _obi44m9h({113,115,130,124,122,121,116,120,132})))
				if setHopMenu then setHopMenu(EV.hop) end
			end)

			local function slideActive(c, h)
				local gs = EV.gState
				if type(gs) == _obi44m9h({128,130,129,121,127,121}) and gs ~= _obi44m9h({}) then
					if gs:find(_obi44m9h({107,97,123,121,117,119})) then return true, _obi44m9h({114,129,131,113,117,129,51,120,132,54,129,135,128,137,59}) .. gs end

					if EV.wasSliding and gs:find(_obi44m9h({107,81,129,127,134,117,123})) then return true, _obi44m9h({128,122,120,116,118,50,120,135,137,123,133,124,130,126,138,60,69}) .. gs .. _obi44m9h({54}) end
					return false
				end
				for _, o in ipairs({ c, h }) do
					for n, v in pairs(o:GetAttributes()) do
						local ln = n:lower()
						if (ln:find(_obi44m9h({128,122,120,116})) or ln:find(_obi44m9h({112,128,126,133,116,122}))) and v == true then return true, _obi44m9h({110,130,131,130,49}) .. n end
						if type(v) == _obi44m9h({128,130,129,121,127,121}) then
							local lv = v:lower()
							if lv:find(_obi44m9h({128,122,120,116})) or lv:find(_obi44m9h({112,128,126,133,116,122})) then return true, _obi44m9h({110,130,131,130,49}) .. n .. _obi44m9h({74}) .. v end
						end
					end
				end
				local an = h:FindFirstChildOfClass(_obi44m9h({78,124,120,125,114,134,130,134}))
				local tracks = (an and an:GetPlayingAnimationTracks()) or {}
				for _, t in ipairs(tracks) do
					local nm = (t.Name or _obi44m9h({})):lower()
					local anm = (t.Animation and t.Animation.Name or _obi44m9h({})):lower()
					if nm:find(_obi44m9h({128,122,120,116})) or anm:find(_obi44m9h({128,122,120,116})) or nm:find(_obi44m9h({112,128,126,133,116,122})) or anm:find(_obi44m9h({112,128,126,133,116,122})) then return true, _obi44m9h({110,124,120,125,49}) .. t.Name end
				end
				return false
			end

			local hooked = setmetatable({}, { __mode = _obi44m9h({120}) })
			local function hookJumpButton()
				local pg = lp:FindFirstChild(_obi44m9h({93,122,112,137,118,132,90,137,126}))
				local tg = pg and pg:FindFirstChild(_obi44m9h({97,125,132,115,121,89,136,125}))
				local fr = tg and tg:FindFirstChild(_obi44m9h({97,125,132,115,121,85,130,130,137,136,134,132,95,140,124,137,130}))
				local jb = fr and fr:FindFirstChild(_obi44m9h({87,131,124,128,83,135,135,136,132,132}))
				if jb and not hooked[jb] then
					hooked[jb] = true
					table.insert(evConns, jb.InputBegan:Connect(function(i) if isPress(i) then EV.touchIn = i end end))
					table.insert(evConns, jb.InputEnded:Connect(function(i) if isPress(i) then EV.touchIn = nil end end))
					rec(_obi44m9h({125,131,123,127}), _obi44m9h({111,125,131,211,180,129,51,120,122,54,135,141,133,123,141,60,141,127,131,146,228,197,146,68,137,149,71,139,142,150,160,152,142,160,79,149,159,149,162,162,169,168,152,156,168,116,91}) .. jb:GetFullName())
				end
			end

			local function isJumpKey(i) return i.KeyCode == Enum.KeyCode.Space or i.KeyCode == Enum.KeyCode.ButtonA end
			table.insert(evConns, UIS.InputBegan:Connect(function(i, gp)
				if i.KeyCode ~= Enum.KeyCode.Unknown then
					rec(_obi44m9h({129,115,114,124,114}), _obi44m9h({239,148,162,48}) .. tostring(i.KeyCode) .. (gp and _obi44m9h({45,54,120,126,133,119,133,122,118,121,124,65}) or _obi44m9h({})), 20)
					if isJumpKey(i) and not UIS:GetFocusedTextBox() then EV.keyHeld = true end
				end
				if isPress(i) then
					local pg = lp:FindFirstChild(_obi44m9h({93,122,112,137,118,132,90,137,126}))
					if not pg then return end
					local inset = game:GetService(_obi44m9h({84,131,120,99,118,132,137,125,120,123})):GetGuiInset()
					local seen, names, isJump = {}, {}, false
					for _, dy in ipairs({ 0, inset.Y }) do
						local ok, objs = pcall(function() return pg:GetGuiObjectsAtPosition(i.Position.X, i.Position.Y - dy) end)
						if ok then
							for _, o in ipairs(objs) do
								if not seen[o] then
									seen[o] = true
									local path = o:GetFullName():gsub(_obi44m9h({107,94,123,113,138,119,133,135,58,68,114,118,62,72,120,71,66,76,111,140,130,155,136,150,108,155,144,77,87}), _obi44m9h({}))
									names[#names + 1] = path .. _obi44m9h({53}) .. o.ClassName .. _obi44m9h({54})
									if o.Name:lower():find(_obi44m9h({119,131,124,128})) or (o.Parent and o.Parent.Name:lower():find(_obi44m9h({119,131,124,128}))) then isJump = true end
								end
							end
						end
					end
					if isJump then EV.touchIn = i end
					rec(_obi44m9h({129,125,128,133,118}), _obi44m9h({239,148,162,48,57}) .. math.floor(i.Position.X) .. _obi44m9h({57}) .. math.floor(i.Position.Y) .. _obi44m9h({54,46}) .. (isJump and _obi44m9h({104,94,100,92,96,111,51}) or _obi44m9h({}))
						.. (#names > 0 and table.concat(names, _obi44m9h({45,73,47}), 1, math.min(#names, 5)) or _obi44m9h({53,124,116,126,121,135,128,52,119,133,139,219,188,137,59,128,140,62,137,143,136,145,76})), 20)
				end
			end))
			table.insert(evConns, UIS.InputEnded:Connect(function(i)
				if i.KeyCode ~= Enum.KeyCode.Unknown then
					rec(_obi44m9h({129,115,114,124,114}), _obi44m9h({239,148,160,48}) .. tostring(i.KeyCode), 20)
					if isJumpKey(i) then EV.keyHeld = false end
				end
				if isPress(i) then
					if EV.touchIn and i == EV.touchIn then EV.touchIn = nil end
					rec(_obi44m9h({129,125,128,133,118}), _obi44m9h({239,148,160}), 20)
				end
			end))

			local function killMover()
				if EV.mover then pcall(function() EV.mover:Destroy() end); EV.mover = nil end
				if EV.moverAtt then pcall(function() EV.moverAtt:Destroy() end); EV.moverAtt = nil end
			end
			local function pushMover(r, vx, vz)
				local m = EV.mover
				if not (m and m.Parent) then
					killMover()
					local ok = pcall(function()
						local att = Instance.new(_obi44m9h({78,130,131,113,116,122,128,121,131,138}))
						att.Name = _obi44m9h({82,132,98,124,122,118,120,85,137,138}); att.Parent = r
						local lv = Instance.new(_obi44m9h({89,119,125,117,114,132,105,121,129,133,122,129,141,147}))
						lv.Name = _obi44m9h({82,132,98,124,122,118,120,96,107})
						lv.Attachment0 = att
						lv.RelativeTo = Enum.ActuatorRelativeTo.World
						lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
						lv.PrimaryTangentAxis = Vector3.new(1, 0, 0)
						lv.SecondaryTangentAxis = Vector3.new(0, 0, 1)
						lv.MaxForce = math.huge
						lv.PlaneVelocity = Vector2.new(vx, vz)
						lv.Parent = r
						EV.mover = lv; EV.moverAtt = att
					end)
					if not ok then killMover(); return false end
					rec(_obi44m9h({128,122,120,116,118}), _obi44m9h({89,119,125,117,114,132,105,121,129,133,122,129,141,147,59,127,143,135,128,132,144}))
				end
				pcall(function() EV.mover.PlaneVelocity = Vector2.new(vx, vz) end)
				return true
			end
			local function doSlide(c, h, r)
				local ok, sliding, why = pcall(slideActive, c, h)
				if ok and sliding then
					local v = r.AssemblyLinearVelocity
					local flat = Vector3.new(v.X, 0, v.Z)
					if not EV.wasSliding then
						EV.slideSpeed = math.max(flat.Magnitude, EV.gSpeed or 0)
						local lk = Vector3.new(r.CFrame.LookVector.X, 0, r.CFrame.LookVector.Z)
						EV.slideDir = flat.Magnitude > 1 and flat.Unit or (lk.Magnitude > 0.01 and lk.Unit or Vector3.new(0, 0, -1))
						rec(_obi44m9h({128,122,120,116,118}), _obi44m9h({128,122,120,116,118,50,87,89,105,91,90,108,90,94,106,60,69}) .. tostring(why) .. _obi44m9h({54,46,133,117,125,50,124,130,126,121,128,121,133,87}) .. string.format(_obi44m9h({50,60,64,118}), EV.slideSpeed))
						local ch = {}
						for _, d in ipairs(r:GetChildren()) do ch[#ch + 1] = d.Name .. _obi44m9h({71}) .. d.ClassName end
						rec(_obi44m9h({128,122,120,116,118}), _obi44m9h({115,119,123,120,128,133,51,120,132,54,95,141,134,123,137,139,134,130,113,143,144,150,115,133,151,154,97,72}) .. table.concat(ch, _obi44m9h({57,46})))
						local mv = {}
						for _, d in ipairs(c:GetDescendants()) do
							if d.Name:sub(1, 7) ~= _obi44m9h({82,132,98,124,122,118,120}) and (d:IsA(_obi44m9h({79,125,115,137,94,129,137,121,135})) or d:IsA(_obi44m9h({89,119,125,117,114,132,105,121,129,133,122,129,141,147})) or d:IsA(_obi44m9h({99,115,114,132,128,132,89,131,135,121,124})) or d:IsA(_obi44m9h({78,122,120,119,127,98,130,135,126,138,128,135,135}))) then
								mv[#mv + 1] = d:GetFullName() .. _obi44m9h({71}) .. d.ClassName
							end
						end
						rec(_obi44m9h({128,122,120,116,118}), _obi44m9h({122,125,133,117,131,133,51,120,132,54,129,135,128,137,59,138,140,62,143,133,147,149,146,146,134,141,140,149,99,74}) .. (#mv > 0 and table.concat(mv, _obi44m9h({57,46})) or _obi44m9h({123,115,125,120,134,127})))
					end
					EV.wasSliding = true
					if EV.slideSpeed > 8 then
						local dir = EV.slideDir
						if flat.Magnitude > 3 then dir = flat.Unit; EV.slideDir = dir end
						local S = EV.slideSpeed
						pushMover(r, dir.X * S, dir.Z * S)
						if flat.Magnitude < S - 0.3 then
							r.AssemblyLinearVelocity = Vector3.new(dir.X * S, v.Y, dir.Z * S)
							rec(_obi44m9h({128,122,120,116,118}), _obi44m9h({127,115,117,127,131,213,186,131,53,122,124,56,143,127,135,139,128,135,131,129,133,135,67,76,138,152,136,72}) .. string.format(_obi44m9h({50,60,64,118}), flat.Magnitude) .. _obi44m9h({54}), 4)
						end
					end
				else
					if EV.wasSliding then rec(_obi44m9h({128,122,120,116,118}), _obi44m9h({128,122,120,116,118,50,103,89,103,99,96,102,104,111})) end
					EV.wasSliding = false
					killMover()
				end
			end

			table.insert(evConns, RunService.Heartbeat:Connect(function()
				local now = os.clock()
				if now - EV.lastHook > 1 then EV.lastHook = now; pcall(hookJumpButton) end

				if EV.keyHeld and not (UIS:IsKeyDown(Enum.KeyCode.Space) or UIS:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonA)) then
					EV.keyHeld = false
				end
				if EV.touchIn and EV.touchIn.UserInputState == Enum.UserInputState.End then EV.touchIn = nil end
				local c, h, r = lp.Character, hum(), hrp()
				if not (c and h and r) or h.Health <= 0 then return end

				if now - EV.lastTick >= 1 then
					EV.lastTick = now
					local v = r.AssemblyLinearVelocity
					local sp = Vector3.new(v.X, 0, v.Z).Magnitude
					local an = h:FindFirstChildOfClass(_obi44m9h({78,124,120,125,114,134,130,134}))
					local names = {}
					if an then
						for _, t in ipairs(an:GetPlayingAnimationTracks()) do names[#names + 1] = tostring(t.Name) end
					end
					table.sort(names)
					local joined = table.concat(names, _obi44m9h({57}))
					if sp > 5 or joined ~= EV.lastAnims then
						EV.lastAnims = joined
						rec(_obi44m9h({129,119,114,123}), string.format(_obi44m9h({114,129,131,113,117,129,80,57,136,54,122,128,122,137,88,65,144,62,143,149,141,145,130,151,138,141,156,154,138,142,154,105,82,161,79,163,157,155,151,153,132,132,116,93,172,90,163,171,173,141,141,125,102,181,99,165,179,175,180,187,134,165,112,191,170}),
							tostring(h:GetState()), tostring(h.FloorMaterial), tostring(EV.keyHeld or EV.touchIn ~= nil),
							tostring(EV.slide), tostring(EV.hop), joined), 2)
					end
				end

				local gs = EV.gState or _obi44m9h({})
				local busyState = gs == _obi44m9h({81,125,134,126,118,118}) or gs == _obi44m9h({95,111,118,116,128,126,127,125,131,125}) or gs == _obi44m9h({80,111,129,130,122,119,119}) or gs == _obi44m9h({80,122,120,125,115,123,129,123}) or gs:find(_obi44m9h({107,97,123,121,117,119})) ~= nil
				if EV.hop and not busyState and now - EV.lastHop > 0.1 then
					local st = h:GetState()
					local grounded = st == Enum.HumanoidStateType.Running or st == Enum.HumanoidStateType.RunningNoPhysics or st == Enum.HumanoidStateType.Landed
							or st == Enum.HumanoidStateType.Idle or (h.FloorMaterial ~= Enum.Material.Air and st ~= Enum.HumanoidStateType.Jumping and st ~= Enum.HumanoidStateType.Freefall)
						if grounded then
						EV.lastHop = now
						pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end)
						h.Jump = true
						h:ChangeState(Enum.HumanoidStateType.Jumping)
						EV.hn = EV.hn + 1
						rec(_obi44m9h({117,125,127}), _obi44m9h({125,131,123,127,49,115,136,136,132,131,218,185,141,131,126,139,61,65}) .. EV.hn .. _obi44m9h({45,115,130,132,114,118,130,81}) .. tostring(st) .. _obi44m9h({45,120,126,119,128,79}) .. gs, 6)
					end
				end

				if EV.slide then doSlide(c, h, r) else killMover() end
			end))

			table.insert(evConns, RunService.Stepped:Connect(function()
				if not EV.slide then return end
				local c, h, r = lp.Character, hum(), hrp()
				if not (c and h and r) or h.Health <= 0 then return end
				doSlide(c, h, r)
			end))

			section(evp, _obi44m9h({82,132,112,116,118}))
			toggleRow(evp, _obi44m9h({79,125,131,211,180,129,51,122,129,139,139,141,122,136,143,129,87,62,104,142,135,139,145,141,153,139,71,123,149,147,143,145}), _obi44m9h({90,125,130,132,131,115,51,131,53,120,134,140,220,189,138,60,139,127,63,148,134,142,132,68,77,154,150,153,158,143,75,105,77,154,152,151,146,97,151,153,168,162,160,159,154,99}), function(v)
				EV.showSlide = v
				slideBtn.Visible = v
				rec(_obi44m9h({130,119}), _obi44m9h({122,125,130,132,131,115,133,52,119,133,139,219,188,137,59,130,137,147,147,149,130,144,151,137,69,111,149,142,146,152,148,160,146,78,130,156,154,150,152,110,85}) .. tostring(v))
			end)
			toggleRow(evp, _obi44m9h({79,125,131,211,180,129,51,122,129,139,139,141,122,136,143,129,87,62,96,149,149,145,67,108,148,150}), _obi44m9h({90,125,130,132,131,115,51,131,53,120,134,140,220,189,138,60,139,127,63,148,134,142,132,68,77,154,150,153,158,143,75,105,77,154,152,151,146,97,151,153,168,162,160,159,154,99}), function(v)
				EV.showHop = v
				hopBtn.Visible = v
				rec(_obi44m9h({130,119}), _obi44m9h({122,125,130,132,131,115,133,52,119,133,139,219,188,137,59,130,137,147,147,149,130,144,151,137,69,103,156,156,152,74,115,155,157,104,79}) .. tostring(v))
			end)
			rowBtn(evp, _obi44m9h({97,128,112,134,114,132,51,118,132,138,218,205,126,141,59,130,137,147,147,149,130,144,151,137,152}), function()
				EV.locked = true
				rec(_obi44m9h({130,119}), _obi44m9h({111,125,131,211,198,119,134,52,123,130,140,140,142,123,137,144,130,145,63,116,115,99,121,101,105,117,122}))
				say(_obi44m9h({79,125,131,211,198,119,134,52,123,130,140,140,142,123,137,144,130,145,63,148,147,131,153,133,137,149,154,72,81,152,238,207,156,78,144,162,163,147,166,168,150,163,96,102}))
			end, true)
			rowBtn(evp, _obi44m9h({81,115,130,132,131,115,137,117,135,54,121,135,141,221,208,129,144,62,133,140,150,150,152,133,147,154,140,155}), function()
				EV.locked = false
				rec(_obi44m9h({130,119}), _obi44m9h({111,125,131,211,198,119,134,52,123,130,140,140,142,123,137,144,130,145,63,100,102,117,119,118,102,124,104,108,120,125}))
				say(_obi44m9h({79,125,131,211,198,119,134,52,123,130,140,140,142,123,137,144,130,145,63,132,134,149,151,150,134,156,136,140,152,157,101,76,142,160,161,145,164,166,152,84,165,168,152,88,166,169,177,161,175,108}))
			end, true)
			local _
			_, setSlideMenu = toggleRow(evp, _obi44m9h({86,124,117,121,127,123,135,121,53,105,131,129,125,127}), _obi44m9h({89,119,118,113,64,118,120,135,129,127,126,121,57,126,132,142,130,146,142,64,130,147,152,141,81,70,154,141,150,74,154,76,143,157,163,243,212,161,83,154,161,171,171,173,154,168,175,161}), function(v)
				EV.slide = v
				paintSlide(v)
				rec(_obi44m9h({130,119}), _obi44m9h({122,115,125,133,49,91,129,122,126,132,128,140,126,58,110,136,134,130,132,64,78,96,67}) .. (v and _obi44m9h({89,87,86,81,85,97}) or _obi44m9h({113,115,130,124,122,121,116,120,132})))
			end)
			_, setHopMenu = toggleRow(evp, _obi44m9h({78,131,131,127,49,90,130,132}), _obi44m9h({93,131,123,113,49,133,130,142,126,132,127,135,57,141,128,137,61,142,145,133,132,139,150,133,151,70,154,141,144,159,157,141,159,78,158,80,147,161,167,247,216,165,87,156,158,90,171,177,169,159,177}), function(v)
				EV.hop = v
				paintHop(v)
				rec(_obi44m9h({130,119}), _obi44m9h({122,115,125,133,49,83,136,136,132,54,95,135,137,58,72,90,61}) .. (v and _obi44m9h({89,87,86,81,85,97}) or _obi44m9h({113,115,130,124,122,121,116,120,132})))
			end)
			toggleRow(evp, _obi44m9h({78,131,131,127,49,90,130,132,53,137,124,133,57,141,128,131,146,144,128,146}), _obi44m9h({93,131,123,113,49,133,130,142,126,132,127,135,57,135,128,143,138,141,63,147,134,143,67,151,138,141,156,154,138,156,75,155,77,144,158,164,244,213,162,84,153,155,87,168,174,166,156,174}), function(v)
				EV.hopAlways = v
				rec(_obi44m9h({130,119}), _obi44m9h({78,131,131,127,49,90,130,132,53,137,124,133,57,141,128,131,146,144,128,146,65,79,97,68}) .. tostring(v))
			end)

			section(evp, _obi44m9h({89,125,118,48,117,129,51,89,139,119,123,125}))
			toggleRow(evp, _obi44m9h({84,128,112,134,114,132,51,136,138,122,134}), _obi44m9h({93,115,129,131,128,128,116,123,122,131,67,56,122,142,141,133,127,147,147,143,148,78,67,133,147,143,148,137,236,209,238,225,146,161,91,80,150,165,167,149,153,165,170,100,89,174,170,173,178,163,178,108,97,182,168,167,177,167,186,104,174,106,189,177,186,189,195,181,196,114,197,185,184,187,185,193,189,201,206}), function(v)
				EV.rec = v
				if v then bindChar() end
				say(v and _obi44m9h({84,128,112,134,114,128,119,131,53,133,55,132,136,129,59,128,140,62,100,150,130,134,136,82}) or _obi44m9h({84,128,112,134,114,213,186,215,184,133,55,124,136,58,135,139,132,62,131,143,65,103,153,133,137,139,71,152,138,159,158,141,145,143,93}))
			end, true)
			toggleRow(evp, _obi44m9h({84,128,112,134,114,132,51,134,122,131,134,140,126,141,59,129,139,148,136,129,133,145,150}), _obi44m9h({92,46,128,133,118,50,130,52,136,123,140,56,131,137,130,139,61,139,128,142,133,131,67,148,151,149,71,155,142,156,161,149,145,157,161,80,89,167,166,149,85,158,166,167,164,117,91,168,166,165,180,165,97,181,6,247,101,182,185,169,105,179,185,194,178,193,195,185,184,179,197,125}), function(v)
				if v and not installSpy() then
					say(_obi44m9h({96,115,132,48,118,138,120,119,138,138,134,138,57,136,222,191,140,62,146,149,145,145,149,152,134,70,143,151,152,149,152,145,161,143,156,149,165,154,162,152,111,86,165,251,220,169,91,160,0,223,95,176,179,163,99,171,183,167,189,169,187,106,186,191,109,192,180,189,192,198,184,199,117,187,197,206,194,187,191,203,208,140}))
					return
				end
				EV.spyOut = v
				rec(_obi44m9h({130,119}), _obi44m9h({116,128,112,134,114,132,51,134,122,131,134,140,126,141,59,129,139,148,136,129,133,145,150,94,69}) .. tostring(v))
			end)
			rowBtn(evp, _obi44m9h({80,125,127,121,114,132,51,128,132,125,55,124,136,58,96,146,126,130,132}), function()
				local f = setclipboard or toclipboard
				local txt = table.concat(REC.lines, _obi44m9h({23}))
				if txt == _obi44m9h({}) then say(_obi44m9h({92,46,123,127,120,50,119,131,53,91,141,121,125,127,59,129,144,146,226,193,65,152,132,158,142,149,85})); return end
				if not f then say(_obi44m9h({96,115,132,48,118,138,120,119,138,138,134,138,57,136,222,191,140,62,147,133,142,66,150,137,153,137,147,145,153,140,154,141,159,146,93,80,128,82,159,163,156,86,171,153,166,156,254,229,170,94,164,179,181,5,228,100,179,181,103,169,187,187,192,181,195,189,111}) .. DSLOG.file); return end
				say(pcall(f, txt) and (_obi44m9h({89,125,118,48,117,129,51,89,139,119,123,125,57,125,138,140,134,127,131,143,65,74}) .. #REC.lines .. _obi44m9h({45,122,120,126,121,115,134,61,67})) or _obi44m9h({83,111,123,120,128,135,51,117,132,54,122,135,137,131,124,142,75}))
			end, true)
			rowBtn(evp, _obi44m9h({89,119,124,128,114,132,51,128,132,125,55,124,136,58,96,146,126,130,132}), function()
				REC.lines = {}
				say(_obi44m9h({89,125,118,48,117,129,51,89,139,119,123,125,57,134,132,137,141,141,77}))
			end, true)

			rec(_obi44m9h({114,132,112,116,118}), _obi44m9h({110,112,112,48,86,136,116,120,122,54,120,140,130,144,124,60,153,62,111,140,130,133,136,109,137,99}) .. tostring(game.PlaceId) .. _obi44m9h({45,138,47,122,128,121,130,81}) .. tostring(game.Name) .. _obi44m9h({45,138,47,132,128,131,136,121,82}) .. tostring(UIS.TouchEnabled))
			bindChar()

			S.evStop = function()
				unbindChar()
				EV.spyOut = false
				for _, cn in ipairs(evConns) do pcall(function() cn:Disconnect() end) end
				pcall(killMover)
				for _, b in ipairs(evButtons) do pcall(function() b:Destroy() end) end
			end
		end
	end

	local ctp = { on = false }
	local ctpInput = UIS.InputBegan:Connect(function(i, gp)
		if not ctp.on or gp or not isPress(i) then return end
		local r = hrp()
		if not r then return end
		local ray = workspace.CurrentCamera:ScreenPointToRay(i.Position.X, i.Position.Y)
		local rp = RaycastParams.new()
		rp.FilterType = Enum.RaycastFilterType.Exclude
		rp.FilterDescendantsInstances = { lp.Character }
		local res = workspace:Raycast(ray.Origin, ray.Direction * 2000, rp)
		if res then
			r.AssemblyLinearVelocity = Vector3.zero
			r.CFrame = CFrame.new(res.Position + Vector3.new(0, 4, 0))
		end
	end)
	local ep = pages[_obi44m9h({82,134,131,130,114,133})]
	if ep then
		section(ep, _obi44m9h({97,115,123,117,129,129,133,136,122}))
		toggleRow(ep, _obi44m9h({97,115,123,117,129,129,133,136,122,54,135,135,139,58,143,139,142,147,132}), _obi44m9h({97,125,128,133,118,65,118,128,126,135,140,125,57,136,144,137,61,138,148,135,130,148,67,137,69,156,150,139,236,212,75,162,142,151,79,160,163,147,83,160,248,215}), function(v) ctp.on = v end)
	end
	section(dp, _obi44m9h({90,125,133,121,126,119,129,136,132}))
	toggleRow(dp, _obi44m9h({99,115,123,127,116,123,119,117,121,123}), _obi44m9h({89,119,118,113,49,115,51,138,122,130,134,123,130,126,124,128,130,62,132,147,132,145,143,140,142,138,136,72,138,140,140,149,165,157}), function(v)
		S.speed = v
		if not v then local h = hum(); if h then h.WalkSpeed = 16 end end
	end)
	sliderRow(dp, _obi44m9h({99,111,123,127,131,50,119,117,53,140,124,132,136,125,132,128,126,130,132}), _obi44m9h({80,125,129,130,122,118,116}), 16, 120, 50, function(v) S.speedVal = v end)
	sliderRow(dp, _obi44m9h({99,115,123,127,116,123,119,117,121,123,55,124,136,58,145,139,140}), _obi44m9h({99,125,112,130}), 20, 150, 50, function(v) S.flyVal = v end)
	toggleRow(dp, _obi44m9h({93,131,123,127,49,115,127,136,132}), _obi44m9h({87,131,124,128,97,129,138,121,135,54,80,72}), function(v)
		S.jump = v
		if not v then local h = hum(); if h then h.JumpPower = 50 end end
	end)
	toggleRow(dp, _obi44m9h({78,130,129,113,135,119,134,135,118,136,55,136,122,140,128,128,130,145}), _obi44m9h({91,125,114,124,122,130}), function(v) S.noclip = v end)

	return function()
		loopConn:Disconnect(); jumpConn:Disconnect()
		tkConn:Disconnect(); tkInput:Disconnect(); fpConn:Disconnect(); ctpInput:Disconnect()
		if S.evStop then pcall(S.evStop) end
		if island then island:Destroy(); island = nil end
		fpSet(false); tkRelease(); stopTFling(); lagStop()
		local hh = hum(); if hh then hh:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
		if wwPart then wwPart:Destroy(); wwPart = nil end
		stopSelfFly()
		local h = hum()
		if h then h.WalkSpeed = 16; h.JumpPower = 50 end
	end
end

do
	local LOAD_URL = _obi44m9h({117,130,131,128,132,76,66,67,126,68,135,135,140,142,132,137,132,76,130,131,80,87,85,140,125,148,161,96,92,89,144,93,145,97,104,149,147,103,148,150,155,155,105,110,157,159,114,110,110,163,164,112,122,116,123,170,123,122,168,174,127,129,121,182,189,181})
	local TIME = 5
	local sg = mk(_obi44m9h({96,113,129,117,118,128,90,137,126}), { Name = _obi44m9h({96,118,120,126,89,135,117,87,118,136,137,125,128,123,137,128,140}), ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999 }, parent)
	local bg = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(6, 1, 2), BorderSizePixel = 0, Active = true }, sg)
	local img = mk(_obi44m9h({86,123,112,119,118,94,116,118,122,130}), {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Crop, ImageTransparency = 0.15,
	}, bg)
	mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(15, 0, 2), BackgroundTransparency = 0.55, BorderSizePixel = 0 }, bg)

	local imgReady = false
	task.spawn(function()
		local a = fetchAsset(LOAD_URL, _obi44m9h({121,125,112,116,122,128,122,66,127,134,126}))
		if a then img.Image = a end
		imgReady = true
	end)

	local box = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(0.8, 0, 0, 220), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1 }, bg)
	mk(_obi44m9h({98,87,98,121,139,119,86,131,131,137,139,138,122,131,137,144}), { MaxSize = Vector2.new(420, 220) }, box)
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({96,118,120,126,49,90,136,118}), Size = UDim2.new(1, 0, 0, 54), BackgroundTransparency = 1, TextColor3 = WHITE,
		Font = Enum.Font.GothamBlack, TextSize = 40, TextStrokeTransparency = 0.3, TextStrokeColor3 = Color3.fromRGB(80, 0, 8),
	}, box)
	local pct = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({61,51}), Size = UDim2.new(1, 0, 0, 34), Position = UDim2.fromOffset(0, 58), BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(255, 120, 125), Font = Enum.Font.GothamBold, TextSize = 26, TextStrokeTransparency = 0.5,
	}, box)
	local track = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 12), Position = UDim2.fromOffset(0, 104), BackgroundColor3 = Color3.fromRGB(30, 6, 9), BackgroundTransparency = 0.1 }, box)
	round(track, 6); stroke(track, 1.5)
	local fill = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.fromScale(0, 1), BackgroundColor3 = RED, BorderSizePixel = 0 }, track)
	round(fill, 6)

	local exName = _obi44m9h({81,115,130,115,128,128,123,121,120,127,123,135})
	pcall(function()
		local n, v = identifyexecutor()
		if n then exName = tostring(n) .. (v and (_obi44m9h({45}) .. tostring(v)) or _obi44m9h({})) end
	end)
	if exName == _obi44m9h({81,115,130,115,128,128,123,121,120,127,123,135}) then pcall(function() local n = getexecutorname(); if n then exName = tostring(n) end end) end
	local checks = {
		{ at = 0.00, label = _obi44m9h({86,82,47,116,114,50,131,121,136,137,134,121}), value = tostring(lp.UserId) .. _obi44m9h({45,54,79}) .. lp.Name .. _obi44m9h({54}) },
		{ at = 0.30, label = _obi44m9h({82,134,116,115,134,134,130,134}), value = exName },
		{ at = 0.60, label = _obi44m9h({99,115,129,131,212,181,130}), value = _obi44m9h({90,115,124,114,131,129}) },
	}
	local lines = {}
	for i, c in ipairs(checks) do
		lines[i] = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = _obi44m9h({}), Size = UDim2.new(1, 0, 0, 16), Position = UDim2.fromOffset(0, 126 + (i - 1) * 17), BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(235, 210, 210), Font = Enum.Font.Gotham, TextSize = 11, TextStrokeTransparency = 0.6,
		}, box)
	end

	local w = 0
	while not imgReady and w < 2.5 do w = w + task.wait() end

	local t0 = os.clock()
	while true do
		local p = math.clamp((os.clock() - t0) / TIME, 0, 1)
		fill.Size = UDim2.fromScale(p, 1)
		pct.Text = math.floor(p * 100) .. _obi44m9h({50})
		for i, c in ipairs(checks) do
			local nextAt = checks[i + 1] and checks[i + 1].at or 0.9
			if p >= c.at then
				if p >= nextAt then
					lines[i].Text = _obi44m9h({239,170,162,48}) .. c.label .. _obi44m9h({71,46}) .. c.value
				else
					lines[i].Text = _obi44m9h({99,115,129,121,119,123,118,117,131,122,134,56}) .. c.label:lower() .. _obi44m9h({59,60,61})
				end
			end
		end
		if p >= 1 then break end
		task.wait()
	end
	pct.Text = _obi44m9h({62,62,63,53})
	task.wait(0.25)
	sg:Destroy()
end

local floatConn, floatBV
local function unfly()
	if floatConn then floatConn:Disconnect(); floatConn = nil end
	if floatBV then floatBV:Destroy(); floatBV = nil end
end
local toast
local spinBAV
local function unspin() if spinBAV then spinBAV:Destroy(); spinBAV = nil end end
local rocketing = false

local FXS = { rocket = false, jail = nil, boom = nil }
local pushPresence
local function boom(r, radius)
	FXS.boom = { id = HttpService:GenerateGUID(false), x = r.Position.X, y = r.Position.Y, z = r.Position.Z, r = radius }
	if pushPresence then task.spawn(pushPresence) end
	local ex = Instance.new(_obi44m9h({82,134,127,124,128,133,124,131,131}))
	ex.Position = r.Position; ex.BlastRadius = radius; ex.BlastPressure = 0; ex.DestroyJointRadiusPercent = 0
	ex:SetAttribute(_obi44m9h({81,129,85,136}), true)
	ex.Parent = workspace
end
local ACTIONS = {
	kick = function()
		pcall(function() lp:Kick(_obi44m9h({99,125,114,211,187,50,121,131,126,54,132,135,128,123,127,139,61,142,132,140,144,66,132,136,146,84})) end)

		task.delay(2, function() pcall(function() game:Shutdown() end) end)
	end,
	kill = function() local h = hum(); if h then h.Health = 0 end end,
	freeze = function() local r = hrp(); if r then r.Anchored = true end end,
	unfreeze = function() local r = hrp(); if r then r.Anchored = false end end,
	fly = function()
		unfly()
		local r, h = hrp(), hum()
		if not (r and h) then return end
		floatBV = mk(_obi44m9h({79,125,115,137,103,119,127,131,120,127,139,145}), { MaxForce = Vector3.new(1e9, 1e9, 1e9), Velocity = Vector3.zero }, r)
		floatConn = RunService.Heartbeat:Connect(function() floatBV.Velocity = h.MoveDirection * 40 end)
	end,
	unfly = unfly,
	explode = function()
		local r, h = hrp(), hum()
		if r then boom(r, 10) end
		if h then h.Health = 0 end
	end,
	rocket = function()
		if rocketing then return end
		local r, h = hrp(), hum()
		if not (r and h) then return end
		rocketing = true
		FXS.rocket = true
		if pushPresence then task.spawn(pushPresence) end
		unfly()
		r.Anchored = false
		local bv = mk(_obi44m9h({79,125,115,137,103,119,127,131,120,127,139,145}), { MaxForce = Vector3.new(1e9, 1e9, 1e9), Velocity = Vector3.new(0, 20, 0) }, r)
		local fire = mk(_obi44m9h({83,119,129,117}), { Size = 8, Heat = 12 }, r)
		task.spawn(function()
			local t0, y0 = os.clock(), r.Position.Y
			while r.Parent and os.clock() - t0 < 8 and r.Position.Y - y0 < 200 do
				bv.Velocity = Vector3.new(0, 20 + (os.clock() - t0) * 8, 0)
				task.wait()
			end
			if r.Parent then boom(r, 14) end
			bv:Destroy(); fire:Destroy()
			FXS.rocket = false
			if pushPresence then task.spawn(pushPresence) end
			if h then h.Health = 0 end
			rocketing = false
		end)
	end,
	spin = function()
		unspin()
		local r = hrp()
		if r then spinBAV = mk(_obi44m9h({79,125,115,137,82,128,122,137,129,119,137,110,126,134,138,127,134,146,152}), { MaxTorque = Vector3.new(0, 1e9, 0), AngularVelocity = Vector3.new(0, 20, 0) }, r) end
	end,
	unspin = unspin,
	bounce = function() local r = hrp(); if r then r.AssemblyLinearVelocity = Vector3.new(0, 120, 0) end end,
	sit = function() local h = hum(); if h then h.Sit = true end end,
	bring = function(c)
		local p, r = c and c.pos, hrp()
		if r and type(p) == _obi44m9h({129,111,113,124,118}) and tonumber(p.x) and tonumber(p.y) and tonumber(p.z) then
			r.CFrame = CFrame.new(p.x, p.y + 3, p.z)
		end
	end,
	message = function(c)
		if c and c.text and toast then toast(tostring(c.text):sub(1, 80)) end
	end,
}

local cleanupActions
do
	local jailParts, prevCF = {}, nil
	local loops, loopPos, loopTask = {}, nil, nil

	local function clearJail()
		for _, p in ipairs(jailParts) do pcall(function() p:Destroy() end) end
		jailParts = {}
		FXS.jail = nil
		if pushPresence then task.spawn(pushPresence) end
	end
	local function buildBox(center, size, color)
		local half = size / 2
		FXS.jail = { x = center.X, y = center.Y, z = center.Z, s = size, cr = math.floor(color.R * 255), cg = math.floor(color.G * 255), cb = math.floor(color.B * 255) }
		if pushPresence then task.spawn(pushPresence) end
		local function wall(pos, sz)
			table.insert(jailParts, mk(_obi44m9h({93,111,129,132}), {
				Anchored = true, CanCollide = true, Size = sz, Position = pos,
				Material = Enum.Material.Metal, Color = color, Transparency = 0.35,
			}, workspace))
		end
		wall(center + Vector3.new(0, -half, 0), Vector3.new(size, 1, size))
		wall(center + Vector3.new(0, half, 0), Vector3.new(size, 1, size))
		wall(center + Vector3.new(half, 0, 0), Vector3.new(1, size, size))
		wall(center + Vector3.new(-half, 0, 0), Vector3.new(1, size, size))
		wall(center + Vector3.new(0, 0, half), Vector3.new(size, size, 1))
		wall(center + Vector3.new(0, 0, -half), Vector3.new(size, size, 1))
	end
	local function releaseFromRoom()
		clearJail()
		local r = hrp()
		if prevCF and r then r.CFrame = prevCF end
		prevCF = nil
	end

	local function startLoops()
		if loopTask then return end
		loopTask = task.spawn(function()
			while next(loops) do
				local now = os.clock()
				for k, t in pairs(loops) do if now > t then loops[k] = nil end end
				local r, h = hrp(), hum()
				if r and h then
					if loops.kill and h.Health > 0 then h.Health = 0 end
					if loops.fire and not r:FindFirstChild(_obi44m9h({96,118,120,126,87,123,133,121})) then ACTIONS.fire() end
					if loops.sit then h.Sit = true end
					if loops.bring and loopPos then r.CFrame = CFrame.new(loopPos + Vector3.new(0, 3, 0)) end
					if loops.castigo then h.WalkSpeed = 6; h.UseJumpPower = true; h.JumpPower = 0 end
				end
				task.wait(0.5)
			end
			loopTask = nil
		end)
	end
	local function loopOn(name) loops[name] = os.clock() + 120; startLoops() end
	local function loopOff(name) loops[name] = nil end

	ACTIONS.fling = function()
		local r = hrp(); if not r then return end
		local a = math.random() * math.pi * 2
		r.AssemblyLinearVelocity = Vector3.new(math.cos(a) * 250, 180, math.sin(a) * 250)
	end
	ACTIONS.jail = function()
		local r = hrp(); if not r then return end
		clearJail()
		buildBox(r.Position + Vector3.new(0, 2, 0), 10, Color3.fromRGB(60, 60, 60))
	end
	ACTIONS.backrooms = function()
		local r = hrp(); if not r then return end
		releaseFromRoom()
		prevCF = r.CFrame
		local center = Vector3.new(0, 4000, 0)
		buildBox(center, 28, Color3.fromRGB(200, 180, 90))
		r.AssemblyLinearVelocity = Vector3.zero
		r.CFrame = CFrame.new(center + Vector3.new(0, -12, 0))
	end
	ACTIONS.unjail = releaseFromRoom
	ACTIONS.fire = function()
		local r = hrp()
		if r and not r:FindFirstChild(_obi44m9h({96,118,120,126,87,123,133,121})) then
			mk(_obi44m9h({83,119,129,117}), { Name = _obi44m9h({96,118,120,126,87,123,133,121}), Size = 8, Heat = 10 }, r)
			if pushPresence then task.spawn(pushPresence) end
		end
	end
	ACTIONS.unfire = function()
		local r = hrp()
		local f = r and r:FindFirstChild(_obi44m9h({96,118,120,126,87,123,133,121}))
		if f then f:Destroy(); if pushPresence then task.spawn(pushPresence) end end
	end
	ACTIONS.castigo = function() loopOn(_obi44m9h({112,111,130,132,122,121,130})) end
	ACTIONS.descastigo = function()
		loopOff(_obi44m9h({112,111,130,132,122,121,130}))
		local h = hum()
		if h then h.WalkSpeed = 16; h.UseJumpPower = true; h.JumpPower = 50 end
	end
	ACTIONS.loopkill = function() loopOn(_obi44m9h({120,119,123,124})) end
	ACTIONS.unloopkill = function() loopOff(_obi44m9h({120,119,123,124})) end
	ACTIONS.loopfire = function() loopOn(_obi44m9h({115,119,129,117})) end
	ACTIONS.unloopfire = function() loopOff(_obi44m9h({115,119,129,117})); ACTIONS.unfire() end
	ACTIONS.loopsit = function() loopOn(_obi44m9h({128,119,131})) end
	ACTIONS.unloopsit = function() loopOff(_obi44m9h({128,119,131})); local h = hum(); if h then h.Sit = false end end
	ACTIONS.loopbring = function(c)
		local p = c and c.pos
		if type(p) == _obi44m9h({129,111,113,124,118}) and tonumber(p.x) and tonumber(p.y) and tonumber(p.z) then
			loopPos = Vector3.new(p.x, p.y, p.z)
			loopOn(_obi44m9h({111,128,120,126,120}))
		end
	end
	ACTIONS.unloopbring = function() loopOff(_obi44m9h({111,128,120,126,120})) end

	local trollConns, trollTok = {}, 0
	local function trollOff()
		pcall(function() RunService:UnbindFromRenderStep(_obi44m9h({96,118,120,126,90,128,137,121,135,138})) end)
		for _, c in ipairs(trollConns) do c:Disconnect() end
		trollConns = {}
	end

	ACTIONS.troll = function()
		trollOff()
		trollTok = trollTok + 1
		local my = trollTok
		RunService:BindToRenderStep(_obi44m9h({96,118,120,126,90,128,137,121,135,138}), Enum.RenderPriority.Character.Value + 1, function()
			local h = hum()
			if h and h.MoveDirection.Magnitude > 0 then h:Move(-h.MoveDirection, false) end
		end)
		table.insert(trollConns, UIS.JumpRequest:Connect(function() ACTIONS.rocket() end))
		task.delay(120, function() if trollTok == my then trollOff() end end)
	end
	ACTIONS.untroll = trollOff

	ACTIONS.tag = function(c)
		if not (c and TAG.avail) then return end
		if type(c.text) == _obi44m9h({128,130,129,121,127,121}) and c.text ~= _obi44m9h({}) then TAG.text = c.text:sub(1, 16) end
		if type(c.font) == _obi44m9h({128,130,129,121,127,121}) and table.find(TAG_FONTS, c.font) then TAG.font = c.font end
		if type(c.role) == _obi44m9h({128,130,129,121,127,121}) then
			for _, r in ipairs(TAG_ROLES) do
				if r[1] == c.role then TAG.role = c.role end
			end
		end
		if type(c.rgb) == _obi44m9h({111,125,126,124,118,115,129}) then TAG.rgb = c.rgb end
		if type(c.on) == _obi44m9h({111,125,126,124,118,115,129}) then TAG.on = c.on; TAG.forceOff = (c.on == false) end
		TAG.refresh()
		if TAG.onChanged then pcall(TAG.onChanged) end
		if TAG.push then TAG.push() end
	end

	cleanupActions = function()
		trollOff()
		loops = {}
		releaseFromRoom()
		ACTIONS.unfire()
		local h = hum()
		if h then h.WalkSpeed = 16; h.JumpPower = 50 end
	end
end

local Lighting = game:GetService(_obi44m9h({89,119,118,120,133,123,129,123}))
local function buildEffects(page, say)
	local E = { colorIdx = 1 }
	local fxSet = {}
	local lightOrig
	local sizeTouched = false
	local function col() return COLORS[E.colorIdx][2] end

	local function share()
		local t = {}
		for _, k in ipairs(FX_KEYS) do
			if E[k] then table.insert(t, k) end
		end
		local s = #t > 0 and table.concat(t, _obi44m9h({57})) or nil
		if MINE.fx == s and MINE.fc == E.colorIdx then return end
		MINE.fx, MINE.fc = s, E.colorIdx
		if publishMods then publishMods() end
	end
	local function refresh()
		local c = lp.Character
		if c then fxApply(c, E, E.colorIdx) end
		share()
	end

	local function resetFx()
		for _, k in ipairs(FX_KEYS) do
			if E[k] then
				E[k] = false
				if fxSet[k] then fxSet[k](false) end
			end
		end
		local c = lp.Character
		if c then pcall(fxApply, c, {}, E.colorIdx) end
		share()
	end
	local function watchChar(c)
		local h = c:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120})) or c:WaitForChild(_obi44m9h({85,131,124,113,127,129,124,120}), 8)
		if h then h.Died:Connect(function() task.spawn(resetFx) end) end
	end
	local charConn = lp.CharacterAdded:Connect(function(c)
		task.spawn(resetFx)
		task.spawn(watchChar, c)
	end)
	if lp.Character then task.spawn(watchChar, lp.Character) end

	local function saveLight()
		if not lightOrig then
			lightOrig = { ClockTime = Lighting.ClockTime, FogEnd = Lighting.FogEnd, FogColor = Lighting.FogColor }
		end
	end
	local function lightFx(name, class, props)
		local o = Lighting:FindFirstChild(name)
		if not o then o = mk(class, props, Lighting); o.Name = name end
		return o
	end

	section(page, _obi44m9h({82,116,116,121,133,129,134,52,131,133,55,136,126,140,142,139,139,127,134,133,142}))
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({97,125,115,127,132,50,132,137,122,54,140,139,122,135,59,139,61,134,148,130,65,74,132,136,146,143,149,72,142,74,152,145,154,144,161,159,164,91,83,170,154,155,164,88,158,173,174,161,176,94,164,166,166,171,183,179,184,102,172,181,105,192,186,175,16,248,125}), Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(240, 210, 210), Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, page)
	local colorBtn
	colorBtn = rowBtn(page, _obi44m9h({80,125,129,48,117,129,134,52,122,124,124,129,141,137,142,86,61}) .. COLORS[1][1], function()
		E.colorIdx = E.colorIdx % #COLORS + 1
		colorBtn:FindFirstChildOfClass(_obi44m9h({97,115,135,132,93,115,117,121,129})).Text = _obi44m9h({80,125,129,48,117,129,134,52,122,124,124,129,141,137,142,86,61}) .. COLORS[E.colorIdx][1]
		refresh()
	end)
	local function fxToggle(label, desc, key)
		fxSet[key] = select(2, toggleRow(page, label, desc, function(v) E[key] = v; refresh() end))
	end
	fxToggle(_obi44m9h({83,125,118,127}), _obi44m9h({80,118,112,125,114,133,51,130,132,54,122,135,139,138,138}), _obi44m9h({115,119,129,117}))
	fxToggle(_obi44m9h({83,131,124,113,212,185,116}), _obi44m9h({83,131,124,113,212,185,116,52,136,139,121,129,135,126,138}), _obi44m9h({128,123,126,123,118}))
	fxToggle(_obi44m9h({79,128,120,124,121,129,134}), _obi44m9h({83,111,210,189,132,117,116,135,53,119,134,56,139,127,127,139,143}), _obi44m9h({128,126,112,130,124,126,120,135}))
	fxToggle(_obi44m9h({82,129,131,130,118,126,116,135}), _obi44m9h({93,111,129,132,212,191,118,137,129,119,138,56,125,127,59,129,144,146,145,133,141,131}), _obi44m9h({128,130,112,130,132}))
	fxToggle(_obi44m9h({95,111,130,132,131,129}), _obi44m9h({95,111,130,132,131,129,51,120,122,54,131,141,147,58,124,139,61,127,141,132,130,148}), _obi44m9h({129,128,112,121,125}))
	fxToggle(_obi44m9h({78,131,129,113}), _obi44m9h({80,125,125,132,128,132,129,131,53,120,137,129,133,130,124,138,145,131,63,142,144,66,134,147,151,150,150}), _obi44m9h({110,131,129,113}))
	fxToggle(_obi44m9h({89,131,137}), _obi44m9h({86,122,132,125,122,128,116,52,132,54,120,133,123,131,128,138,145,131,63,133,142,66,153,147,145,154,136}), _obi44m9h({121,119,118,120,133}))
	fxSet.rainbow = select(2, toggleRow(page, _obi44m9h({82,116,116,121,133,129,134,52,118,136,122,135,70,221,200,142,134,145}), _obi44m9h({97,128,126,115,114,50,116,52,120,133,137,56,125,137,142,60,130,132,132,137,149,145,150,68,152,139,148,72,153,139,157,141,159}), function(v) E.rainbow = v; refresh() end))
	fxSet.neon = select(2, toggleRow(page, _obi44m9h({80,125,129,128,128,50,129,121,132,132}), _obi44m9h({90,111,131,117,131,123,116,128,53,132,124,135,135,58,128,137,61,146,142,132,130,149,67,133,152,70,151,141,236,209,140,159}), function(v) E.neon = v; refresh() end))
	fxSet.rainbowBody = select(2, toggleRow(page, _obi44m9h({80,125,129,128,128,50,116,134,120,133,68,219,198,140,132,143}), _obi44m9h({93,119,125,132,114,50,130,52,120,133,137,136,136,58,143,142,140,129,128,142,133,145,67,136,138,70,138,151,155}), function(v) E.rainbowBody = v; refresh() end))
	fxSet.ghost = select(2, toggleRow(page, _obi44m9h({83,111,125,132,114,133,128,117}), _obi44m9h({81,115,120,136,114,50,130,52,120,133,137,136,136,58,136,129,134,141,63,148,147,131,145,151,149,135,153,141,151,158,144}), function(v) E.ghost = v; refresh() end))
	rowBtn(page, _obi44m9h({82,134,127,124,128,133,214,183,132,54,123,125,57,125,138,138,131,131,147,133}), function()
		local r = hrp()
		if not r then return end
		local p = mk(_obi44m9h({93,111,129,132,122,117,127,121,90,131,128,140,141,127,141}), {
			Texture = STAR_TEX, Lifetime = NumberRange.new(1.5, 2.5), Speed = NumberRange.new(15, 30),
			SpreadAngle = Vector2.new(180, 180), Acceleration = Vector3.new(0, -20, 0), LightEmission = 0.6,
			Size = NumberSequence.new(0.6, 0.2), Rate = 0,
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 60)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 220, 60)),
				ColorSequenceKeypoint.new(0.66, Color3.fromRGB(60, 255, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 140, 255)),
			}),
		}, r)
		p:Emit(90)
		task.delay(3, function() p:Destroy() end)
	end)
	sliderRow(page, _obi44m9h({97,111,124,113,127,122,130,52,61,59,64}), _obi44m9h({96,209,194,48,129,119,133,135,132,132,120,127,126,136,142,60,111,79,84}), 50, 300, 100, function(v)
		local h = hum()
		if not h then return end
		local found = false
		for _, n in ipairs({ _obi44m9h({79,125,115,137,89,119,124,123,125,138,106,123,122,134,128}), _obi44m9h({79,125,115,137,104,123,119,136,125,105,122,121,133,127}), _obi44m9h({79,125,115,137,85,119,131,136,125,105,122,121,133,127}), _obi44m9h({85,115,112,116,100,117,116,128,122}) }) do
			local nv = h:FindFirstChild(n)
			if nv then nv.Value = v / 100; found = true end
		end
		if found then sizeTouched = true else say(_obi44m9h({82,129,130,117,49,130,120,134,136,133,133,121,128,127,136,60,139,225,194,143,65,229,204,68,119,87,92,86})) end
	end)

	section(page, _obi44m9h({78,123,113,121,118,128,135,121}))
	sliderRow(page, _obi44m9h({85,125,129,113,49,118,130,52,121,127,120}), _obi44m9h({61,46,112,48,67,70}), 0, 24, math.floor(Lighting.ClockTime), function(v)
		saveLight(); Lighting.ClockTime = v
	end)
	sliderRow(page, _obi44m9h({96,111,131,133,131,115,214,187,216,185,134}), _obi44m9h({58,63,63,64,49,115,51,69,69,70}), -100, 100, 0, function(v)
		lightFx(_obi44m9h({81,129,82,83}), _obi44m9h({80,125,123,127,131,85,130,134,135,123,122,140,130,137,137,97,131,132,132,131,149}), {}).Saturation = v / 100
	end)
	sliderRow(page, _obi44m9h({80,125,125,132,131,115,134,136,122}), _obi44m9h({58,63,63,64,49,115,51,69,69,70}), -100, 100, 0, function(v)
		lightFx(_obi44m9h({81,129,82,83}), _obi44m9h({80,125,123,127,131,85,130,134,135,123,122,140,130,137,137,97,131,132,132,131,149}), {}).Contrast = v / 100
	end)
	toggleRow(page, _obi44m9h({79,122,126,127,126}), _obi44m9h({79,128,120,124,121,129,51,122,132,136,139,125,57,136,124,143,61,138,148,154,134,149}), function(v)
		local b = lightFx(_obi44m9h({81,129,81,124,128,129,128}), _obi44m9h({79,122,126,127,126,87,121,122,122,121,139}), { Intensity = 1.2, Size = 40, Threshold = 0.8 })
		b.Enabled = v
	end)
	toggleRow(page, _obi44m9h({81,115,130,118,128,131,136,121}), _obi44m9h({79,125,129,130,114,50,116,52,137,123,131,121}), function(v)
		local b = lightFx(_obi44m9h({81,129,81,124,134,132}), _obi44m9h({79,122,132,130,86,120,121,121,120,138}), { Size = 10 })
		b.Enabled = v
	end)
	toggleRow(page, _obi44m9h({91,209,184,134,128,115,51,119,132,130,134,138,130,126,124}), _obi44m9h({91,209,184,134,128,115,51,119,132,131,55,121,57,125,138,142,61,131,146,131,144,142,139,141,137,135}), function(v)
		saveLight()
		if v then Lighting.FogEnd = 140; Lighting.FogColor = col()
		else Lighting.FogEnd = lightOrig.FogEnd; Lighting.FogColor = lightOrig.FogColor end
	end)

	return function()
		charConn:Disconnect()
		for _, k in ipairs(FX_KEYS) do E[k] = false end
		MINE.fx = nil
		if lp.Character then pcall(fxApply, lp.Character, E, 1) end
		if sizeTouched then
			local h = hum()
			if h then
				for _, n in ipairs({ _obi44m9h({79,125,115,137,89,119,124,123,125,138,106,123,122,134,128}), _obi44m9h({79,125,115,137,104,123,119,136,125,105,122,121,133,127}), _obi44m9h({79,125,115,137,85,119,131,136,125,105,122,121,133,127}), _obi44m9h({85,115,112,116,100,117,116,128,122}) }) do
					local nv = h:FindFirstChild(n)
					if nv then nv.Value = 1 end
				end
			end
		end
		for _, n in ipairs({ _obi44m9h({81,129,82,83}), _obi44m9h({81,129,81,124,128,129,128}), _obi44m9h({81,129,81,124,134,132}) }) do
			local o = Lighting:FindFirstChild(n)
			if o then o:Destroy() end
		end
		if lightOrig then
			Lighting.ClockTime = lightOrig.ClockTime
			Lighting.FogEnd = lightOrig.FogEnd; Lighting.FogColor = lightOrig.FogColor
		end
	end
end

local function dropdown(par, title, getItems, onPick, onRefresh)
	local wrap = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1 }, par)
	mk(_obi44m9h({98,87,91,121,132,134,95,117,142,133,140,140}), { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, wrap)
	local head = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), { Text = _obi44m9h({}), Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2, LayoutOrder = 1 }, wrap)
	round(head, 19); stroke(head, 2)
	local lbl = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = title, Size = UDim2.new(1, -60, 1, 0), Position = UDim2.fromOffset(16, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, head)
	local arrow = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({56}), Size = UDim2.fromOffset(30, 38), Position = UDim2.new(1, -40, 0, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 20,
	}, head)
	local body = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, -14, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Visible = false, LayoutOrder = 2 }, wrap)
	mk(_obi44m9h({98,87,91,121,132,134,95,117,142,133,140,140}), { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, body)
	mk(_obi44m9h({98,87,95,113,117,118,124,130,124}), { PaddingLeft = UDim.new(0, 14) }, body)
	local obj = {}
	function obj.rebuild()
		for _, c in ipairs(body:GetChildren()) do if c:IsA(_obi44m9h({97,115,135,132,83,135,135,136,132,132})) or c:IsA(_obi44m9h({97,115,135,132,93,115,117,121,129})) then c:Destroy() end end

		local rf = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), {
			Text = _obi44m9h({239,148,202,48,82,134,136,117,129,127,145,121,139,58,135,133,144,146,128}), LayoutOrder = 0, Size = UDim2.new(1, 0, 0, 28),
			BackgroundColor3 = Color3.fromRGB(70, 10, 14), BackgroundTransparency = 0.2,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 12,
		}, body)
		round(rf, 14); stroke(rf, 1.2)
		rf.MouseButton1Click:Connect(function()
			if onRefresh then pcall(onRefresh) end
			obj.rebuild()
		end)
		local items = getItems()
		if #items == 0 then
			mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
				Text = _obi44m9h({91,119,125,119,134,213,188,129,53,122,128,139,137,137,137,223,202,148,132,140,65,131,138,147,151,135,85}), LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(170, 130, 130), Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
			}, body)
		end
		for _, it in ipairs(items) do
			local row = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), {
				Text = it.label, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2,
				TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12,
			}, body)
			round(row, 15); stroke(row, 1.2)
			row.MouseButton1Click:Connect(function()
				onPick(it)
				body.Visible = false; arrow.Text = _obi44m9h({56})
			end)
		end
	end
	function obj.setText(t) lbl.Text = t end

	local function auto() if body.Parent and body.Visible then task.defer(obj.rebuild) end end
	Players.PlayerAdded:Connect(auto)
	Players.PlayerRemoving:Connect(auto)
	head.MouseButton1Click:Connect(function()
		if not body.Visible then obj.rebuild() end
		body.Visible = not body.Visible
		arrow.Text = body.Visible and _obi44m9h({239,142,162}) or _obi44m9h({56})
	end)
	return obj
end

local function buildExtras(page, say)
	local cs = {}
	local X = { fov = 70, fovOn = false, fb = false, esp = false, target = nil }
	local origGravity = workspace.Gravity
	local fbOrig
	local espObjs = {}
	local savedCF
	local spinBAV
	local afkConn
	local VU = game:GetService(_obi44m9h({99,119,129,132,134,115,127,105,136,123,137}))
	local function cam() return workspace.CurrentCamera end

	section(page, _obi44m9h({98,130,120,124,122,118,116,120,122,137}))
	toggleRow(page, _obi44m9h({78,124,131,121,62,83,89,95}), _obi44m9h({82,132,120,132,114,50,134,121,135,54,130,129,124,133,124,128,140,62,143,143,147,66,137,141,136,135,153,72,153,139,157,141,145,157}), function(v)
		if afkConn then afkConn:Disconnect(); afkConn = nil end
		if v then
			afkConn = lp.Idled:Connect(function()
				pcall(function() VU:CaptureController(); VU:ClickButton2(Vector2.new()) end)
			end)
		end
	end)
	toggleRow(page, _obi44m9h({89,131,137,48,133,129,135,117,129,54,63,126,142,134,135,126,143,135,134,136,149,75}), _obi44m9h({97,119,129,113,49,115,51,121,136,121,140,138,130,126,222,191,140,62,131,143,65,143,132,148,134}), function(v)
		if v and not fbOrig then
			fbOrig = {
				Brightness = Lighting.Brightness, Ambient = Lighting.Ambient,
				OutdoorAmbient = Lighting.OutdoorAmbient, FogEnd = Lighting.FogEnd,
			}
		end
		X.fb = v
		if not v and fbOrig then
			for k, val in pairs(fbOrig) do Lighting[k] = val end
		end
	end)
	toggleRow(page, _obi44m9h({82,97,95,48,117,119,51,126,132,125,120,124,136,140,128,143}), _obi44m9h({80,125,125,132,128,132,129,131,53,65,55,134,136,135,128,60,130,62,131,137,148,150,230,198,147,137,144,137}), function(v)
		X.esp = v
		if not v then
			for _, e in pairs(espObjs) do
				pcall(function() e.hl:Destroy(); e.bb:Destroy() end)
			end
			espObjs = {}
		end
	end)
	toggleRow(page, _obi44m9h({84,119,129,113,131,50,131,121,135,137,134,134,122,129,128,137}), _obi44m9h({84,119,129,113,49,136,130,119,216,192,55,139,126,135,59,140,126,144,128,146}), function(v)
		if spinBAV then spinBAV:Destroy(); spinBAV = nil end
		local r = hrp()
		if v and r then
			spinBAV = mk(_obi44m9h({79,125,115,137,82,128,122,137,129,119,137,110,126,134,138,127,134,146,152}), { MaxTorque = Vector3.new(0, 1e9, 0), AngularVelocity = Vector3.new(0, 10, 0) }, r)
		end
	end)

	local origZoom = lp.CameraMaxZoomDistance
	local fpsLbl
	local fpsAcc, fpsN = 0, 0
	toggleRow(page, _obi44m9h({90,125,130,132,131,115,133,52,91,102,106}), _obi44m9h({80,125,125,132,114,118,130,134,53,132,134,56,124,123,137,144,140,62,131,129,65,150,136,144,134}), function(v)
		X.fps = v
		if v and not fpsLbl then
			fpsLbl = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
				Text = _obi44m9h({83,94,98,74,49,63,64}), Size = UDim2.fromOffset(80, 22), Position = UDim2.new(1, -90, 0, 8),
				BackgroundColor3 = Color3.fromRGB(20, 0, 0), BackgroundTransparency = 0.3, TextColor3 = WHITE,
				Font = Enum.Font.GothamBold, TextSize = 12,
			}, gui)
			round(fpsLbl, 8)
		end
		if fpsLbl then fpsLbl.Visible = v end
	end)
	toggleRow(page, _obi44m9h({103,125,126,125,49,123,127,125,130,127,139,121,125,137}), _obi44m9h({78,116,112,131,133,115,51,117,53,121,218,186,134,127,141,125,61,127,139,227,202,143,67,136,148,70,147,145,150,147,159,145}), function(v)
		lp.CameraMaxZoomDistance = v and 5000 or origZoom
	end)

	section(page, _obi44m9h({80,209,177,125,118,132,116,52,122,54,125,219,198,141,132,127,126}))
	toggleRow(page, _obi44m9h({83,93,101,48,129,119,133,135,132,132,120,132,130,148,124,128,140}), _obi44m9h({98,129,112,48,128,50,137,117,129,133,137,56,125,137,59,127,140,140,147,146,144,142,136,68,134,136,136,145,161,153}), function(v)
		X.fovOn = v
		if not v and cam() then cam().FieldOfView = 70 end
	end)
	sliderRow(page, _obi44m9h({83,93,101}), _obi44m9h({80,111,124,128,128,50,119,121,53,140,128,139,220,189,138}), 30, 120, 70, function(v) X.fov = v end)
	sliderRow(page, _obi44m9h({84,128,112,134,122,118,116,120,122}), _obi44m9h({93,111,115,130,212,181,130,78,53,71,80,78}), 20, 300, math.floor(origGravity), function(v) workspace.Gravity = v end)
	rowBtn(page, _obi44m9h({95,115,130,132,114,135,133,117,135,54,126,138,122,144,132,128,126,130,132}), function() workspace.Gravity = origGravity; say(_obi44m9h({84,128,112,134,122,118,116,120,122,54,137,125,140,142,124,145,143,127,131,129,79})) end)

	section(page, _obi44m9h({87,125,118,113,117,129,133,121,136}))
	local function others()
		local t = {}
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl ~= lp then table.insert(t, pl) end
		end
		return t
	end
	local tgtDD
	tgtDD = dropdown(page, _obi44m9h({82,129,114,127,125,122,120,134,53,128,134,127,122,126,138,142,61,70,141,133,143,138,152,145,78}), function()
		local t = {}
		for _, pl in ipairs(others()) do
			table.insert(t, { label = pl.DisplayName .. _obi44m9h({45,54,79}) .. pl.Name .. _obi44m9h({54}), value = pl })
		end
		return t
	end, function(it)
		X.target = it.value
		tgtDD.setText(_obi44m9h({87,125,118,113,117,129,133,78,53}) .. it.value.DisplayName)
	end)
	rowBtn(page, _obi44m9h({86,128,47,113,133,213,188,52,132,54,129,135,128,123,127,139,143}), function()
		local tc = X.target and X.target.Character
		local tr = tc and tc:FindFirstChild(_obi44m9h({85,131,124,113,127,129,124,120,103,133,134,140,105,123,141,144}))
		local r = hrp()
		if tr and r then r.CFrame = tr.CFrame * CFrame.new(0, 0, 4); say(_obi44m9h({97,115,123,117,129,129,133,136,118,122,134,70})) else say(_obi44m9h({82,129,114,127,125,122,116,52,138,131,55,130,136,129,124,128,140,144,63,144,147,139,144,137,142,152,150,86})) end
	end)
	toggleRow(page, _obi44m9h({92,112,130,117,131,136,116,134,53,128,134,127,122,126,138,142}), _obi44m9h({80,209,177,125,118,132,116,52,136,123,126,141,126,58,138,60,135,141,134,129,133,145,149,68,138,153,138,151,149,146,148,144,156}), function(v)
		local tc = X.target and X.target.Character
		local th = tc and tc:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120}))
		if v and th then cam().CameraSubject = th
		else
			local h = hum()
			if h then cam().CameraSubject = h end
			if v then say(_obi44m9h({82,129,114,127,125,122,116,52,138,131,55,130,136,129,124,128,140,144,63,144,147,139,144,137,142,152,150,86})) end
		end
	end)
	rowBtn(page, _obi44m9h({96,111,123,134,114,132,51,129,126,132,127,121,57,138,138,143,134,225,198,227,196,145}), function()
		local r = hrp()
		if r then savedCF = r.CFrame; say(_obi44m9h({93,125,130,121,212,185,214,183,132,54,138,121,133,144,124,74})) end
	end)
	rowBtn(page, _obi44m9h({99,125,123,132,114,132,51,215,181,54,135,135,140,131,222,195,224,193,142,64,148,131,143,154,134}), function()
		local r = hrp()
		if r and savedCF then r.CFrame = savedCF; say(_obi44m9h({99,125,123,132,128,135,65})) else say(_obi44m9h({91,115,125,120,134,127,116,52,133,133,138,129,220,193,222,191,140,62,146,129,141,152,132,82})) end
	end)
	rowBtn(page, _obi44m9h({95,115,130,117,133,115,133,52,133,123,137,139,136,136,124,131,130,139}), function()
		local h = hum()
		if h then h.Health = 0 end
	end)
	rowBtn(page, _obi44m9h({95,115,116,126,133,132,116,134,53,132,134,56,131,137,130,139}), function()
		say(_obi44m9h({95,115,116,126,133,132,116,130,121,133,69,70,71}))
		pcall(function() game:GetService(_obi44m9h({97,115,123,117,129,129,133,136,104,123,137,142,130,125,128})):Teleport(game.PlaceId, lp) end)
	end)

	local acc = 0
	table.insert(cs, RunService.Heartbeat:Connect(function(dt)
		if X.fovOn and cam() then cam().FieldOfView = X.fov end
		if X.fb then
			Lighting.Brightness = 2
			Lighting.Ambient = Color3.new(1, 1, 1); Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
			Lighting.FogEnd = 1e5
		end
		acc = acc + dt
		if X.fps and fpsLbl then
			fpsAcc = fpsAcc + dt; fpsN = fpsN + 1
			if fpsAcc >= 0.5 then fpsLbl.Text = _obi44m9h({83,94,98,74,49}) .. math.floor(fpsN / fpsAcc + 0.5); fpsAcc, fpsN = 0, 0 end
		end
		if X.esp and acc >= 0.3 then
			acc = 0
			local r = hrp()
			for _, pl in ipairs(others()) do
				local c = pl.Character
				local head = c and c:FindFirstChild(_obi44m9h({85,115,112,116}))
				if head then
					local e = espObjs[pl]
					if not e or e.hl.Adornee ~= c or not e.hl.Parent then
						if e then pcall(function() e.hl:Destroy(); e.bb:Destroy() end) end
						local hl = mk(_obi44m9h({85,119,118,120,125,123,122,124,137}), { Adornee = c, FillTransparency = 0.7, FillColor = RED, OutlineColor = WHITE }, gui)
						local bb = mk(_obi44m9h({79,119,123,124,115,129,116,134,121,93,140,129}), { Adornee = head, Size = UDim2.fromOffset(120, 20), StudsOffset = Vector3.new(0, 2.5, 0), AlwaysOnTop = true }, gui)
						local lbl = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
							Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, TextColor3 = WHITE,
							TextStrokeTransparency = 0.3, Font = Enum.Font.GothamBold, TextSize = 12,
						}, bb)
						e = { hl = hl, bb = bb, lbl = lbl }
						espObjs[pl] = e
					end
					local d = r and math.floor((head.Position - r.Position).Magnitude) or 0
					e.lbl.Text = pl.DisplayName .. _obi44m9h({45,105}) .. d .. _obi44m9h({106})
				end
			end
		end
	end))

	return function()
		for _, c in ipairs(cs) do c:Disconnect() end
		if afkConn then afkConn:Disconnect() end
		if fpsLbl then fpsLbl:Destroy() end
		lp.CameraMaxZoomDistance = origZoom
		if spinBAV then spinBAV:Destroy() end
		for _, e in pairs(espObjs) do pcall(function() e.hl:Destroy(); e.bb:Destroy() end) end
		if fbOrig then for k, val in pairs(fbOrig) do Lighting[k] = val end end
		workspace.Gravity = origGravity
		if cam() then
			cam().FieldOfView = 70
			local h = hum()
			if h then cam().CameraSubject = h end
		end
	end
end

local MUSIC_CATS = {}
local function buildBrookhaven(pages, say)
	local page = pages[_obi44m9h({91,125,124,117})]
	local RS = game:GetService(_obi44m9h({95,115,127,124,122,117,116,136,122,122,106,140,136,140,124,131,130}))
	local NAME_REMOTES = { _obi44m9h({62,96,95,94,114,127,68,121,105,123,143,73,141}) }
	local COLOR_REMOTES = { _obi44m9h({62,96,95,94,114,127,68,121,88,133,131,135,74,140}) }
	local alive = true
	local rgbName, rgbBio, speed, hue = false, false, 5, 0

	local function findRE(names)
		local re = RS:FindFirstChild(_obi44m9h({95,83}))
		if not re then return nil end
		for _, n in ipairs(names) do
			local r = re:FindFirstChild(n)
			if r then return r end
		end
		return nil
	end
	local function inputRow(placeholder)
		local row = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk(_obi44m9h({97,115,135,132,83,129,139}), {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = _obi44m9h({}), PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function digits(s)
		local d = (tostring(s or _obi44m9h({}))):gsub(_obi44m9h({50,82}), _obi44m9h({}))
		if #d >= 5 then return d end
		return nil
	end

	section(page, _obi44m9h({91,125,124,117,49,119,51,86,126,133,55,64,107,106,68}))
	local nameBox = inputRow(_obi44m9h({91,125,124,117,49,131,136,121,53,119,135,121,139,127,126,129,61,131,140,64,132,139,144,133,69,138,150,72,153,143,157,159,156,156,144,151,150,159}))
	rowBtn(page, _obi44m9h({78,126,123,121,116,115,133,52,131,133,132,125}), function()
		local r = findRE(NAME_REMOTES)
		if not r then say(_obi44m9h({95,115,124,127,133,119,51,120,132,54,133,135,134,127,59,138,224,193,142,64,134,144,134,147,147,154,153,137,141,153,75,84,156,78,153,159,152,161,83,164,164,154,156,88,173,159,173,92,170,179,163,161,165,177,108,114})); return end
		local ok = pcall(function() r:FireServer(_obi44m9h({95,125,123,117,97,126,116,141,99,119,132,125}), nameBox.Text) end)
		say(ok and _obi44m9h({91,125,124,117,49,115,131,128,126,121,120,124,136,72}) or _obi44m9h({83,111,123,120,128,135,51,117,132,54,120,136,133,131,126,125,143,62,142,64,143,145,144,137,83}))
	end, true)
	local bioBox = inputRow(_obi44m9h({79,119,126}))
	rowBtn(page, _obi44m9h({78,126,123,121,116,115,133,52,119,127,134}), function()
		local r = findRE(NAME_REMOTES)
		if not r then say(_obi44m9h({95,115,124,127,133,119,51,120,118,54,121,129,136,58,137,223,192,141,63,133,143,133,146,146,153,152,136,140,152,74,83,155,77,152,158,151,160,82,163,163,153,155,87,172,158,172,91,169,178,162,160,164,176,107,113})); return end
		local ok = pcall(function() r:FireServer(_obi44m9h({95,125,123,117,97,126,116,141,87,127,134}), bioBox.Text) end)
		say(ok and _obi44m9h({79,119,126,48,114,130,127,125,120,119,123,121,71}) or _obi44m9h({83,111,123,120,128,135,51,117,132,54,120,136,133,131,126,125,143,62,128,64,131,139,146,82}))
	end, true)
	toggleRow(page, _obi44m9h({91,125,124,117,49,100,90,86}), _obi44m9h({78,46,114,127,131,50,119,131,53,132,134,133,126,58,136,145,129,127,63,147,134,143,67,148,134,152,136,154}), function(v)
		rgbName = v
		if v and not findRE(COLOR_REMOTES) then say(_obi44m9h({95,115,124,127,133,119,51,120,122,54,122,135,139,58,137,223,192,141,63,133,143,133,146,146,153,152,136,140,152,88})) end
	end)
	toggleRow(page, _obi44m9h({79,119,126,48,99,89,85}), _obi44m9h({78,46,114,127,131,50,119,117,53,120,128,135,57,135,144,128,126,62,146,133,142,66,147,133,151,135,153}), function(v)
		rgbBio = v
		if v and not findRE(COLOR_REMOTES) then say(_obi44m9h({95,115,124,127,133,119,51,120,122,54,122,135,139,58,137,223,192,141,63,133,143,133,146,146,153,152,136,140,152,88})) end
	end)
	sliderRow(page, _obi44m9h({99,115,123,127,116,123,119,117,121,123,55,106,96,92}), _obi44m9h({62,46,123,117,127,134,130,52,215,205,55,73,73,58,141,223,190,142,136,132,144}), 1, 10, 5, function(v) speed = v end)

	task.spawn(function()
		while alive do
			if rgbName or rgbBio then
				hue = (hue + 0.02 * speed) % 1
				local col = Color3.fromHSV(hue, 1, 1)
				local r = findRE(COLOR_REMOTES)
				if r then
					if rgbName then pcall(function() r:FireServer(_obi44m9h({93,119,114,123,122,128,122,102,101,100,120,133,126,93,138,136,140,144}), col) end) end
					if rgbBio then pcall(function() r:FireServer(_obi44m9h({93,119,114,123,122,128,122,102,101,88,128,135,92,137,135,139,143}), col) end) end
				end
			end
			task.wait(0.25)
		end
	end)

	page = pages[_obi44m9h({90,209,201,131,122,117,116})]
	section(page, _obi44m9h({90,209,201,131,122,117,116,52,61,136,218,185,125,131,138,60,130,62,135,143,151,135,149,134,148,135,153,140,82}))
	local idBox = inputRow(_obi44m9h({86,82,47,116,114,50,128,215,207,137,128,123,122}))

	local function reByPlain(plain)
		local re = RS:FindFirstChild(_obi44m9h({95,83}))
		if not re then return nil end
		for _, c in ipairs(re:GetChildren()) do
			if (c.Name:gsub(_obi44m9h({62}), _obi44m9h({}))) == plain then return c end
		end
		return nil
	end
	local function send(plain, kind, id, okMsg)
		local r = reByPlain(plain)
		if not r then say(_obi44m9h({95,115,124,127,133,119,51,130,216,185,134,56,126,136,126,139,139,146,145,129,133,145,67,76,148,70,145,151,144,153,75,156,156,146,148,80,165,151,165,84,162,171,155,153,157,169,100,106})); return end
		local ok, err = pcall(function() r:FireServer(kind, id, nil, true) end)
		say(ok and okMsg or (_obi44m9h({83,111,123,120,128,135,77,52}) .. tostring(err):sub(1, 50)))
	end

	rowBtn(page, _obi44m9h({97,125,114,113,131,50,129,131,53,136,218,185,125,131,138,60,69,129,142,141,65,145,67,150,232,199,139,145,152,74,153,141,77,155,242,211,160,91}), function()
		local id = digits(idBox.Text)
		if not id then say(_obi44m9h({81,119,118,121,133,119,51,137,130,54,96,92,57,126,128,60,138,225,217,147,138,133,132,68,155,233,200,148,146,142,154,90})); return end
		send(_obi44m9h({93,122,112,137,118,132,103,131,132,130,92,142,126,136,143}), _obi44m9h({97,125,126,124,94,135,134,125,120,106,124,144,141}), id, _obi44m9h({97,125,114,113,127,118,130,52}) .. id .. _obi44m9h({45,124,126,48,131,213,180,120,126,133,69}))
	end, true)
	rowBtn(page, _obi44m9h({93,111,129,113,131,50,133,215,182,122,128,135}), function()
		send(_obi44m9h({93,122,112,137,118,132,103,131,132,130,92,142,126,136,143}), _obi44m9h({97,125,126,124,94,135,134,125,120,105,139,135,137}), _obi44m9h({}), _obi44m9h({93,115,115,121,117,129,51,120,122,54,135,121,139,123,141,60,130,140,149,137,130,134,146,68,77,152,234,201,141,147,154,85,91}))
	end, true)
	rowBtn(page, _obi44m9h({97,125,114,113,131,50,129,131,53,126,134,142,126,140,125,139,126,144,131,64,73,135,144,68,136,143,148,137,73,142,144,152,146,87}), function()
		local id = digits(idBox.Text)
		if not id then say(_obi44m9h({81,119,118,121,133,119,51,137,130,54,96,92,57,126,128,60,138,225,217,147,138,133,132,68,155,233,200,148,146,142,154,90})); return end
		send(_obi44m9h({91,125,92,127,133,129,133,106,122,126,128,123,133,127,142}), _obi44m9h({93,119,114,123,122,128,122,103,120,133,134,140,126,140,104,145,144,135,130,116,134,154,151}), id, _obi44m9h({97,125,114,113,127,118,130,52}) .. id .. _obi44m9h({45,124,126,48,121,129,137,121,135,120,134,121,139,126,73}))
	end, true)
	rowBtn(page, _obi44m9h({93,111,129,113,131,50,123,131,139,123,137,122,136,123,141,128}), function()
		send(_obi44m9h({91,125,92,127,133,129,133,106,122,126,128,123,133,127,142}), _obi44m9h({93,119,114,123,122,128,122,103,120,133,134,140,126,140,104,145,144,135,130,115,149,145,147}), _obi44m9h({}), _obi44m9h({93,115,115,121,117,129,51,120,122,54,135,121,139,123,141,60,130,140,149,137,130,134,146,68,77,142,150,158,142,156,141,155,142,160,147,89,95}))
	end, true)

	local CATS = {
		{ _obi44m9h({83,131,125,123}), {
			{ _obi44m9h({89,125,123,127,135,119,68,70}), _obi44m9h({69,69,63,68,72,72,76,69,77,73,80,80,74,81}) },
			{ _obi44m9h({93,111,129,137,125,119,116,127}), _obi44m9h({62,65,70,65,67,68,76,76,78,71,75,75,76,78,80}) },
			{ _obi44m9h({78,126,123,121,116,129}), _obi44m9h({69,68,71,70,71,71,71,73,77,76,72,73,75,79}) },
			{ _obi44m9h({98,124,120,211,180,129}), _obi44m9h({62,62,70,73,74,67,69,71,74,79,72,79,82,82,78}) },
			{ _obi44m9h({85,125,130,128,122,134,116,128,118,136}), _obi44m9h({70,68,65,69,74,69,72,69,76,72,80,72,77,83}) },
			{ _obi44m9h({93,209,184,48,85,123,133,121,126,138,134}), _obi44m9h({62,64,70,72,72,66,73,70,78,79,78,75,73,80,83}) },
			{ _obi44m9h({97,125,132,48,95,115,51,99,131,122,120}), _obi44m9h({70,65,67,72,68,73,72,69,71,71,71,78,79,81}) },
			{ _obi44m9h({90,125,125,132,114,121,120,129,53,108,120,136,136}), _obi44m9h({62,64,68,70,66,74,74,68,71,73,77,76,78,79,81}) },
			{ _obi44m9h({83,131,125,123,49,84,133,137,141,119,137,129,122}), _obi44m9h({62,65,63,72,65,72,74,76,77,70,72,74,81,78,76}) },
			{ _obi44m9h({90,125,125,132,114,121,120,129,53,99,120,132,143,123,127,125}), _obi44m9h({70,65,68,65,72,70,76,70,72,76,80,80,78,82}) },
			{ _obi44m9h({87,111,125,132,114,132,51,90,118,131,218,197,133,131,124}), _obi44m9h({62,62,66,64,69,69,74,70,76,71,79,80,76,75,84}) },
			{ _obi44m9h({97,125,124,113,49,102,130,129,118}), _obi44m9h({62,63,63,68,72,68,69,76,73,75,79,77,76,82,82}) },
			{ _obi44m9h({93,111,123,120,114,213,186,215,184,133}), _obi44m9h({69,64,71,70,70,68,74,72,78,78,77,73,74,80}) },
			{ _obi44m9h({97,128,116,125,128,50,96,121,141,127,122,121,135,123}), _obi44m9h({62,63,63,67,66,73,76,75,77,79,78,75,82,77,83}) },
			{ _obi44m9h({97,128,116,128,114,50,103,134,122,134,120}), _obi44m9h({62,64,70,68,69,75,71,69,75,77,73,78,74,75,78}) },
			{ _obi44m9h({90,115,118,113,49,83,136,136,132,131,134,140,130,144,138}), _obi44m9h({62,64,66,66,66,67,69,69,73,74,78,81,81,80,76}) },
			{ _obi44m9h({96,115,47,90,128,121,116}), _obi44m9h({69,63,64,64,67,72,70,70,78,79,72,75,75,74}) },
			{ _obi44m9h({81,111,115,116,138,50,95,131,139,123}), _obi44m9h({70,68,65,66,68,66,75,74,70,73,76,74,81,82}) },
			{ _obi44m9h({95,125,124,113,127,129,51,97,118,132,123,125,133,123,127,139}), _obi44m9h({62,64,71,69,71,68,71,69,78,70,75,73,78,76,76}) },
			{ _obi44m9h({90,125,125,132,114,121,120,129,53,102,120,137,142,131,142,144,224,193,142}), _obi44m9h({70,71,71,65,67,70,76,71,78,77,79,78,81,78}) },
			{ _obi44m9h({80,46,102,113,125,125}), _obi44m9h({68,64,67,69,66,68,74,69,78,72,79,81,80,79}) },
			{ _obi44m9h({90,119,114,127,49,94,116,130,216,189,120}), _obi44m9h({68,70,66,69,67,68,69,68,72,74,72,76,75,78}) },
			{ _obi44m9h({97,128,116,125,49,84,116,128,118}), _obi44m9h({62,65,70,72,67,74,73,71,78,74,71,75,79,77,75}) },
			{ _obi44m9h({81,88,47,91,128,115,127,117}), _obi44m9h({62,62,67,71,71,73,74,72,73,76,74,74,78,79,80}) },
			{ _obi44m9h({97,128,126,128,114,50,102,121,130,54,88,133,136,140}), _obi44m9h({62,64,68,71,73,70,70,74,72,74,77,75,77,80,81}) },
			{ _obi44m9h({83,119,125,127,49,83,122,131,131,127,120,134,141,127}), _obi44m9h({62,64,70,66,72,71,69,72,71,75,78,76,77,81,80}) },
			{ _obi44m9h({83,119,128,133,118,123,51,96,132,139,122,121}), _obi44m9h({70,66,66,70,70,66,72,68,74,75,75,73,73,75}) },
			{ _obi44m9h({99,115,124,48,87,135,119,121,135}), _obi44m9h({62,64,63,72,74,68,73,69,69,72,79,75,82,76,83}) },
			{ _obi44m9h({97,128,126,126,128,50,119,131,53,95,133,126,126,140,137,139}), _obi44m9h({68,64,67,65,66,74,69,73,71,78,74,81,74,74}) },
			{ _obi44m9h({99,111,120,48,100,119,129,136,118,132,123,135}), _obi44m9h({62,64,68,70,73,67,68,72,72,75,73,76,82,74,75}) },
			{ _obi44m9h({79,128,132,136,114,132,124,117,53,89,120,138,135,131,129,133,128,135,141,129}), _obi44m9h({62,65,66,66,70,68,70,75,78,76,72,78,80,77,77}) },
		} },
		{ _obi44m9h({93,118,126,126,124}), {
			{ _obi44m9h({97,125,124,113,49,88,136,130,128,54,103,128,136,136,134}), _obi44m9h({62,64,72,64,74,74,68,69,75,79,80,80,77,82,78}) },
			{ _obi44m9h({90,111,125,127,49,95,116,129,118,54,93,141,135,133,59,108,133,141,141,139,65,74,118,144,148,157,140,140,82}), _obi44m9h({62,62,65,72,67,73,68,69,73,70,73,79,82,77,75}) },
			{ _obi44m9h({83,131,125,123,49,91,129,122,122,136,133,121,57,112,77,60,69,98,132,133,145,66,118,144,148,157,140,140,82}), _obi44m9h({69,68,66,71,70,67,72,69,71,79,77,79,73,80}) },
			{ _obi44m9h({93,118,126,126,124,50,119,131,53,88,137,121,147,131,135,60,69,113,139,143,152,135,135,77}), _obi44m9h({62,65,63,73,72,69,72,69,70,79,77,78,79,78,81}) },
			{ _obi44m9h({90,125,125,132,114,121,120,129,53,87,140,138,122}), _obi44m9h({62,64,69,65,68,68,67,77,71,73,77,80,82,77,80}) },
			{ _obi44m9h({78,131,129,113,49,58,85,134,118,144,128,132,130,123,137,60,109,134,142,142,140,75}), _obi44m9h({70,67,64,67,66,73,74,68,70,74,75,78,78,78}) },
			{ _obi44m9h({63,46,95,120,134,134,51,92,132,132,55,64,91,140,124,150,134,138,136,129,143,66,115,140,148,148,146,81}), _obi44m9h({68,66,70,73,68,74,73,68,73,78,72,79,76,76}) },
			{ _obi44m9h({79,131,129,126,122,128,122,52,98,123,132,135,139,147,59,108,133,141,141,139,65,104,152,146,144}), _obi44m9h({62,65,71,70,65,74,70,77,74,79,73,81,74,83,76}) },
			{ _obi44m9h({95,125,113,124,128,138,51,100,125,133,133,131}), _obi44m9h({62,65,69,73,68,68,68,77,72,73,74,73,80,81,79}) },
			{ _obi44m9h({95,125,113,124,128,138,51,91,126,125,120,123,129,123,127,60,109,134,142,142,140}), _obi44m9h({62,65,67,67,71,72,68,76,77,72,79,77,78,75,79}) },
			{ _obi44m9h({110,124,131,130,132,98,129,89,138}), _obi44m9h({68,65,67,70,66,75,69,72,73,73,72,74,82,77}) },
			{ _obi44m9h({78,124,120,129,134,123,127,117,216,189,218,187,136}), _obi44m9h({62,65,68,71,72,68,76,75,74,70,73,79,76,79,83}) },
			{ _obi44m9h({93,115,115,130,114,50,129,117,53,102,137,121,130,123}), _obi44m9h({62,64,70,70,66,71,71,73,73,77,75,75,74,81,78}) },
		} },
		{ _obi44m9h({97,128,112,128}), {
			{ _obi44m9h({103,135,117,130,128,136}), _obi44m9h({62,64,69,69,74,74,75,75,70,72,73,73,78,77,81}) },
			{ _obi44m9h({99,131,123,132,128,129,134}), _obi44m9h({62,62,65,68,74,72,71,69,76,72,78,72,77,82,76}) },
			{ _obi44m9h({79,125,125,117,132,50,99,121,137,123,137}), _obi44m9h({62,65,64,71,68,68,76,70,71,75,73,72,81,75,77}) },
			{ _obi44m9h({81,125,123,124,138,137,130,131,121}), _obi44m9h({70,64,72,65,65,73,67,76,70,70,77,79,77,83}) },
			{ _obi44m9h({90,62,133}), _obi44m9h({68,65,66,67,66,70,76,72,78,74,76,77,75,81}) },
			{ _obi44m9h({89,119,123,48,101,122,133,117,141,142}), _obi44m9h({62,62,66,73,68,73,67,73,73,78,76,78,80,83,80}) },
			{ _obi44m9h({90,209,201,131,122,117,116,52,98,119,133,125,130,140,124}), _obi44m9h({62,63,70,72,70,67,76,69,76,72,80,80,76,77,77}) },
			{ _obi44m9h({89,119,123,48,101,122,133,117,141,142,55,74}), _obi44m9h({70,69,68,71,74,69,75,73,75,76,79,76,79,80}) },
			{ _obi44m9h({101,135,126,133,49,96,120,134,121}), _obi44m9h({69,71,68,64,69,72,69,74,78,74,71,73,79,79}) },
			{ _obi44m9h({97,133,120,123,122,130,214,189,121,127,120}), _obi44m9h({62,63,65,71,69,71,70,76,78,77,79,78,81,74,78}) },
			{ _obi44m9h({87,133,129,124,117}), _obi44m9h({68,70,64,73,74,73,70,73,74,74,72,79,74,82}) },
			{ _obi44m9h({93,119,124,128,49,102,116,128,128}), _obi44m9h({62,65,66,64,67,75,68,70,71,73,78,81,75,81,80}) },
			{ _obi44m9h({79,125,112,132,118,50,84,142,138,130}), _obi44m9h({62,62,69,68,66,68,67,75,78,73,74,77,79,80,78}) },
			{ _obi44m9h({80,125,118,133,125,213,181,130,121,127,120}), _obi44m9h({62,63,66,64,69,69,75,73,73,73,78,81,80,76,84}) },
			{ _obi44m9h({83,131,135,123,49,90,120,129,122,138}), _obi44m9h({62,62,63,72,69,66,67,71,70,75,77,72,74,80,78}) },
			{ _obi44m9h({90,115,115,131}), _obi44m9h({62,62,69,73,66,75,74,77,76,78,79,76,76,74,75}) },
			{ _obi44m9h({90,135,47,103,114,139}), _obi44m9h({70,69,63,71,71,68,67,68,76,76,76,74,82,74}) },
			{ _obi44m9h({96,115,129,211,178}), _obi44m9h({62,63,69,66,71,71,70,75,73,79,71,79,76,79,75}) },
			{ _obi44m9h({80,125,129,113,212,185,214,183,132,54,90,138,130,141,143,125,137}), _obi44m9h({62,64,65,72,65,70,71,70,76,74,79,74,76,77,77}) },
			{ _obi44m9h({96,118,120,126,118,50,107,88}), _obi44m9h({70,67,70,70,72,67,70,69,74,73,77,80,79,77}) },
			{ _obi44m9h({80,111,129,113,49,97,118,137,133,119,123,135}), _obi44m9h({62,63,70,69,73,70,69,69,70,78,80,78,80,79,82}) },
			{ _obi44m9h({85,135,123,113,127,118,120,134}), _obi44m9h({69,70,66,64,72,68,75,75,73,78,73,77,80,83}) },
			{ _obi44m9h({92,46,96,133,118,50,84,119,132,132,139,125,124,127,144}), _obi44m9h({62,64,65,73,66,66,68,71,77,76,78,73,82,74,75}) },
			{ _obi44m9h({93,120,123}), _obi44m9h({68,63,70,70,74,68,69,74,72,75,72,77,80,80}) },
			{ _obi44m9h({78,122,123,113,121,50,93,137,138,125}), _obi44m9h({70,69,71,73,70,72,70,74,77,79,75,72,80,79}) },
			{ _obi44m9h({78,122,123,113,121,50,93,137,138,125,55,74}), _obi44m9h({62,63,66,65,66,69,76,75,72,71,76,81,78,76,80}) },
			{ _obi44m9h({94,131,112,130,133,129,51,96,132,139,122,135}), _obi44m9h({62,64,71,69,67,66,76,76,74,76,75,76,77,78,81}) },
			{ _obi44m9h({80,111,123,121,119,129,133,130,126,119,55,92,139,127,124,137}), _obi44m9h({69,65,69,70,73,72,68,70,70,70,76,72,77,76}) },
			{ _obi44m9h({90,111,114,65,65}), _obi44m9h({62,62,70,67,70,73,69,73,76,78,78,74,78,78,82}) },
			{ _obi44m9h({80,111,116,124,123,135,122,142}), _obi44m9h({62,63,70,73,72,67,72,69,70,72,80,79,76,79,80}) },
			{ _obi44m9h({83,131,124,113,117,129,136,134,132}), _obi44m9h({62,65,71,67,71,67,73,70,74,77,72,78,82,82,82}) },
			{ _obi44m9h({83,131,114,123,66,68,89,137,120,129,72,79}), _obi44m9h({68,65,64,73,73,74,67,73,74,72,75,77,76,74}) },
			{ _obi44m9h({102,131,125,119,49,87,139,137,53,72}), _obi44m9h({62,63,68,64,70,75,76,71,70,72,76,79,74,82,84}) },
			{ _obi44m9h({83,125,129,48,94,139,51,91,126,136,131}), _obi44m9h({68,63,66,73,68,74,67,73,78,70,76,72,78,79}) },
			{ _obi44m9h({97,128,132,117,49,93,130,128,132,136,143,144}), _obi44m9h({70,68,63,67,72,74,67,75,76,72,75,76,82,82}) },
			{ _obi44m9h({90,115,131,48,89,119,133}), _obi44m9h({68,66,66,68,72,68,70,68,77,75,71,74,76,83}) },
			{ _obi44m9h({97,128,116,126,116,122,51,86,132,143}), _obi44m9h({70,64,69,68,69,69,75,77,74,74,76,81,73,80}) },
			{ _obi44m9h({89,131,114,113,132,50,87,117,133,130,140,127}), _obi44m9h({70,71,66,67,68,70,71,76,75,78,80,77,78,82}) },
			{ _obi44m9h({102,131,125,119,49,87,139,137}), _obi44m9h({62,64,65,69,68,68,76,68,69,72,78,81,82,74,82}) },
			{ _obi44m9h({81,125,125,132,116,132,140,122,132,136,127,135,126,141}), _obi44m9h({62,62,69,66,68,67,72,68,74,78,75,73,77,80,80}) },
			{ _obi44m9h({89,119,123,48,107,119}), _obi44m9h({62,63,67,65,66,68,73,72,77,74,80,81,73,76,83}) },
			{ _obi44m9h({82,122,112,48,85,119,134,128,126,125,134,141}), _obi44m9h({70,71,66,69,73,71,75,75,74,79,75,78,76,76}) },
			{ _obi44m9h({83,119,129,117,66,75,67,68}), _obi44m9h({62,66,63,66,74,66,73,74,78,76,73,74,81,74,84}) },
			{ _obi44m9h({90,119,123,48,99,119,121,134,216,203,124,139}), _obi44m9h({62,64,64,72,67,74,72,76,71,78,71,77,75,80,83}) },
			{ _obi44m9h({84,111,129,127,133,115,51,92,126,67,107,125,124,130}), _obi44m9h({68,63,70,69,65,71,69,76,77,73,77,81,79,79}) },
			{ _obi44m9h({95,125,123,211,187,50,89,128,118,121,130,135}), _obi44m9h({62,65,69,68,74,68,69,75,72,78,75,73,75,79,78}) },
			{ _obi44m9h({79,125,129,119,118,133,51,70,69,72,71}), _obi44m9h({62,63,72,72,67,71,69,73,75,73,72,76,74,79,78}) },
			{ _obi44m9h({80,118,120,115,114,121,130}), _obi44m9h({68,64,68,70,70,74,75,69,78,75,73,77,77,77}) },
			{ _obi44m9h({88,131,125,123,49,118,120,52,74,70}), _obi44m9h({62,64,72,71,73,73,68,76,69,75,75,73,75,80,81}) },
			{ _obi44m9h({79,111,114,123,132,134,116,123,122}), _obi44m9h({62,65,66,67,69,74,75,74,76,71,74,78,77,75,79}) },
			{ _obi44m9h({83,119,129,117,67,66,67,68}), _obi44m9h({70,64,67,64,68,71,71,71,77,71,71,81,73,80}) },
			{ _obi44m9h({79,111,123,211,180,129,51,91,118,132,126}), _obi44m9h({62,63,65,68,73,71,76,70,71,72,74,78,78,76,83}) },
			{ _obi44m9h({86,126,119,127,127,119,51,86,135,119,133,123,136}), _obi44m9h({62,62,66,66,73,74,72,73,77,77,74,74,75,75,84}) },
			{ _obi44m9h({95,59,81,113,115,139}), _obi44m9h({62,63,64,73,70,72,75,77,77,77,79,72,79,81,77}) },
			{ _obi44m9h({95,119,127,48,87,132,120,120,132}), _obi44m9h({69,64,68,67,68,71,74,74,78,71,76,79,74,80}) },
		} },
		{ _obi44m9h({83,125,129,130,212,197,51,121,53,105,124,138,141,123,137,129,135,141}), {
			{ _obi44m9h({90,209,176,129,134,123,129,117,53,122,134,56,109,127,136,140,140}), _obi44m9h({62,65,72,72,65,70,76,70,69,72,75,73,78,79,75}) },
			{ _obi44m9h({91,125,130,131,114,50,97,131,136,137,120}), _obi44m9h({62,65,65,71,68,69,68,73,71,71,72,79,81,77,78}) },
			{ _obi44m9h({80,111,115,117,122,132,116,52,121,123,55,89,220,193,138}), _obi44m9h({70,68,71,72,73,68,69,76,74,72,76,72,80,77}) },
			{ _obi44m9h({78,123,126,130,49,129,136,52,97,127,139,138,220,189,138}), _obi44m9h({62,63,64,69,70,67,70,74,71,76,74,78,73,80,78}) },
			{ _obi44m9h({89,119,131,130,212,181,130,52,71}), _obi44m9h({68,67,67,71,69,75,73,72,75,77,73,77,79,79}) },
			{ _obi44m9h({84,115,130,132,212,181,130,52,97,108}), _obi44m9h({62,63,64,68,67,71,67,73,72,74,76,79,76,78,77}) },
			{ _obi44m9h({92,118,47,91,114,128,116,128,125,119}), _obi44m9h({62,64,66,71,73,71,76,76,74,71,79,72,73,82,81}) },
			{ _obi44m9h({78,123,112,130,49,98,120,119,118,122,134}), _obi44m9h({69,71,67,70,65,70,70,76,73,71,77,79,76,74}) },
			{ _obi44m9h({97,131,115,127,49,99,136,121,53,103,140,129,140,127,141}), _obi44m9h({68,71,68,67,71,73,72,75,75,71,75,75,76,80}) },
			{ _obi44m9h({80,118,132,134,114,50,119,121,53,87,137,138,136,148}), _obi44m9h({62,62,65,65,67,66,67,71,75,77,74,81,78,75,79}) },
			{ _obi44m9h({80,131,123,128,114,50,97,131,136,137,120}), _obi44m9h({68,64,65,65,68,68,76,73,76,70,78,74,74,80}) },
			{ _obi44m9h({91,125,131,121,119,123,118,117,216,189,218,187,136}), _obi44m9h({70,62,64,67,72,68,75,68,74,73,72,76,80,78}) },
			{ _obi44m9h({79,125,112,132,118,50,84,142,138,130}), _obi44m9h({62,62,69,68,66,68,67,75,78,73,74,77,79,80,78}) },
			{ _obi44m9h({78,117,116,126,133,119,51,98,122,125,120}), _obi44m9h({62,64,65,72,72,67,69,68,69,72,74,79,78,77,78}) },
			{ _obi44m9h({97,111,133,113,49,98,120,130,136,119,133,124,136}), _obi44m9h({69,64,72,66,74,72,72,76,69,71,74,75,81,77}) },
			{ _obi44m9h({92,118,47,96,128,126,214,190,130,127,122,135}), _obi44m9h({70,69,71,66,70,69,71,75,72,70,74,76,80,74}) },
			{ _obi44m9h({83,125,120,48,100,213,198,52,106,131,120}), _obi44m9h({69,66,69,66,69,69,67,69,73,71,72,81,73,83}) },
		} },
		{ _obi44m9h({90,209,201,131,122,117,116,135,53,123,55,101,126,135,128,143,61,95,139,133,130,150,230,215,151,143,150}), {
			{ _obi44m9h({93,118,126,126,124,50,101,131,119,130,134,144,57,103,128,137,130}), _obi44m9h({62,65,68,66,65,75,75,71,76,73,75,72,81,75,81}) },
			{ _obi44m9h({78,46,97,127,115,126,130,140,53,104,120,136}), _obi44m9h({62,64,68,73,65,71,67,69,76,78}) },
			{ _obi44m9h({90,119,120,48,84,122,116,130,131,123,131}), _obi44m9h({62,66,66,70,71,72,72,72,77}) },
			{ _obi44m9h({100,119,120,48,94,135,134,125,120}), _obi44m9h({62,65,63,69,67,71,68,75,76,74}) },
			{ _obi44m9h({82,122,116,134,114,134,130,134,53,99,140,139,130,125}), _obi44m9h({62,65,63,71,71,74,69,77,78}) },
			{ _obi44m9h({82,122,116,134,114,134,130,134,53,99,140,139,130,125,59,78}), _obi44m9h({70,63,64,73,66,67,76,74,70,79}) },
			{ _obi44m9h({80,118,120,124,125,50,93,117,143,144}), _obi44m9h({70,64,69,68,74,69,69,72,71}) },
			{ _obi44m9h({95,115,133,117,127,121,120,52,61,99,128,134,126,125,141,125,131,146,72}), _obi44m9h({64,70,63,71,67,69,76,72,71,78}) },
			{ _obi44m9h({78,81,62,84,84,50,64,52,105,126,140,134,125,127,141,143,145,144,148,131,140}), _obi44m9h({62,66,69,73,71,67,71,76,76}) },
			{ _obi44m9h({63,94,112,115,49,63,51,96,126,124,124,56,96,137,128,143,61,109,141}), _obi44m9h({62,70,69,67,66,73,67,77,78}) },
			{ _obi44m9h({95,111,132,135,49,83,127,121,127,119,133,124,139,137,59,73,61,114,142,132,144,66,103,137,69,122,144}), _obi44m9h({67,70,71,71,72,68,75,77,76,70}) },
		} },
	}

	do
		local all, seen = {}, {}
		for _, c in ipairs(CATS) do
			for _, s in ipairs(c[2]) do
				if not seen[s[2]] then seen[s[2]] = true; table.insert(all, s) end
			end
		end
		table.insert(CATS, 1, { _obi44m9h({97,125,115,113,132,50,116,135,53,131,218,210,140,131,126,125,144}), all })
	end
	MUSIC_CATS = CATS

	local GRAY = Color3.fromRGB(170, 130, 130)
	local songRows, catUI, nowPlaying = {}, {}, nil

	local function fire(plain, kind, id)
		local r = reByPlain(plain)
		if not r then return false end
		return (pcall(function() r:FireServer(kind, id, nil, true) end))
	end

	local function playSong(name, id)
		idBox.Text = id
		local a = fire(_obi44m9h({93,122,112,137,118,132,103,131,132,130,92,142,126,136,143}), _obi44m9h({97,125,126,124,94,135,134,125,120,106,124,144,141}), id)
		local b = fire(_obi44m9h({91,125,92,127,133,129,133,106,122,126,128,123,133,127,142}), _obi44m9h({93,119,114,123,122,128,122,103,120,133,134,140,126,140,104,145,144,135,130,116,134,154,151}), id)
		if a or b then
			say(_obi44m9h({97,125,114,113,127,118,130,78,53}) .. name)
			nowPlaying = id
			for _, s in ipairs(songRows) do s.label.TextColor3 = (s.id == id) and RED or WHITE end
		else
			say(_obi44m9h({95,115,124,127,133,119,51,130,216,185,134,56,126,136,126,139,139,146,145,129,133,145,67,76,148,70,145,151,144,153,75,156,156,146,148,80,165,151,165,84,162,171,155,153,157,169,100,106}))
		end
	end

	section(page, _obi44m9h({89,119,130,132,114,50,119,121,53,131,218,210,140,131,126,125,144,62,71,131,141,139,134,133,69,139,71,146,236,203,75,160,156,145,144,89}))
	local searchBox = inputRow(_obi44m9h({79,131,130,115,114,132,51,132,132,136,55,134,136,135,128,60,69,131,151,90,65,150,140,143,142,82,71,152,145,153,153,151,89,78,149,159,163,164,246,231,94}))

	for _, cat in ipairs(CATS) do
		local wrap = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1 }, page)
		mk(_obi44m9h({98,87,91,121,132,134,95,117,142,133,140,140}), { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, wrap)

		local head = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), { Text = _obi44m9h({}), Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2, LayoutOrder = 1 }, wrap)
		round(head, 19); stroke(head, 2)
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = cat[1], Size = UDim2.new(1, -90, 0, 22), Position = UDim2.fromOffset(16, 3), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
		}, head)
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = #cat[2] .. _obi44m9h({45,123,210,202,132,123,118,117,136}), Size = UDim2.new(1, -90, 0, 12), Position = UDim2.fromOffset(16, 22), BackgroundTransparency = 1,
			TextColor3 = GRAY, Font = Enum.Font.Gotham, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left,
		}, head)
		local arrow = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = _obi44m9h({56}), Size = UDim2.fromOffset(30, 38), Position = UDim2.new(1, -40, 0, 0), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 20,
		}, head)

		local body = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, -14, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Visible = false, LayoutOrder = 2 }, wrap)
		mk(_obi44m9h({98,87,91,121,132,134,95,117,142,133,140,140}), { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, body)
		mk(_obi44m9h({98,87,95,113,117,118,124,130,124}), { PaddingLeft = UDim.new(0, 14) }, body)

		local ui = { wrap = wrap, body = body, arrow = arrow, open = false, songs = {}, cat = cat[1] }
		for _, s in ipairs(cat[2]) do
			local row = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), { Text = _obi44m9h({}), Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, body)
			round(row, 15); stroke(row, 1.2)
			local lbl = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
				Text = s[1], Size = UDim2.new(1, -110, 1, 0), Position = UDim2.fromOffset(14, 0), BackgroundTransparency = 1,
				TextColor3 = (s[2] == nowPlaying) and RED or WHITE, Font = Enum.Font.Gotham, TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
			}, row)
			mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
				Text = _obi44m9h({239,164,197,48}) .. s[2], Size = UDim2.fromOffset(92, 30), Position = UDim2.new(1, -98, 0, 0), BackgroundTransparency = 1,
				TextColor3 = GRAY, Font = Enum.Font.Gotham, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd,
			}, row)
			row.MouseButton1Click:Connect(function() playSong(s[1], s[2]) end)
			table.insert(songRows, { id = s[2], label = lbl })
			table.insert(ui.songs, { name = s[1], row = row })
		end
		head.MouseButton1Click:Connect(function()
			ui.open = not ui.open
			body.Visible = ui.open
			arrow.Text = ui.open and _obi44m9h({239,142,162}) or _obi44m9h({56})
		end)
		table.insert(catUI, ui)
	end

	local function refresh()
		local q = (searchBox.Text or _obi44m9h({})):lower()
		for _, c in ipairs(catUI) do
			local any = false
			for _, s in ipairs(c.songs) do
				local show = q == _obi44m9h({}) or (s.name:lower():find(q, 1, true) ~= nil) or (c.cat:lower():find(q, 1, true) ~= nil)
				s.row.Visible = show
				if show then any = true end
			end
			c.wrap.Visible = (q == _obi44m9h({})) or any
			c.body.Visible = (q ~= _obi44m9h({}) and any) or (q == _obi44m9h({}) and c.open)
			c.arrow.Text = c.body.Visible and _obi44m9h({239,142,162}) or _obi44m9h({56})
		end
	end
	searchBox:GetPropertyChangedSignal(_obi44m9h({97,115,135,132})):Connect(refresh)

	idBox.FocusLost:Connect(function(enter)
		if enter then
			local id = digits(idBox.Text)
			if id then playSong(id, id) else say(_obi44m9h({81,119,118,121,133,119,51,137,130,54,96,92,57,126,128,60,138,225,217,147,138,133,132,68,155,233,200,148,146,142,154,90})) end
		end
	end)

	page = pages[_obi44m9h({97,111,118})]
	TAG.avail = true
	TAG.start()
	section(page, _obi44m9h({97,111,118,48,118,127,51,119,126,131,120,56,125,123,59,127,126,128,132,227,200,131}))
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({89,115,131,130,118,123,133,131,53,125,137,121,135,126,128,60,130,139,63,131,138,143,132,68,137,139,71,158,152,141,238,214,91,78,130,149,81,160,246,215,164,86,156,171,156,169,167,164,162,176,95,181,174,98,177,179,178,171,115,104,170,186,172,190,178,177,180,112,192,114,198,185,202,118,197,199,198,191,123,192,194,126,196,216,202,196,204,39,12,41,10,215,137,206,218,140,191,221,209,220,224,234,161,148,196,150,218,217,235,225,234,156,226,235,225,225,234,250,242,164,173,211,236,245,235,252,250,172,188,174,216,254,247,254,8,249,3,249,0,249,253,9,13,188,204,190,242,21,3,194,231,19,19,21,199,215,201,238,26,26,28,215,207,115,90,210,34,212,249,37,37,39,217,43,48,33,42,222,35,37,39,43,49,41,243}),
		Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local _, setTagOn = toggleRow(page, _obi44m9h({90,125,130,132,131,115,133,52,137,119,126}), _obi44m9h({89,119,118,113,64,118,120,135,129,127,126,121,57,137,59,136,130,146,145,133,138,148,146}), function(v)
		TAG.on = v; TAG.refresh()
		if TAG.push then TAG.push() end
	end, TAG.on)
	local tagBox = inputRow(_obi44m9h({91,125,124,117,49,118,116,52,137,119,126,56,65,144,124,150,134,141,63,93,65,149,136,153,69,148,150,149,142,74,143,145,77,147,167,153,147,155,246,219,248,217,166,97}))
	tagBox.Text = TAG.text
	local fontBtn, roleLbl
	fontBtn = rowBtn(page, _obi44m9h({83,125,125,132,118,76,51}) .. TAG.font, function()
		local i = table.find(TAG_FONTS, TAG.font) or 1
		TAG.font = TAG_FONTS[i % #TAG_FONTS + 1]
		fontBtn:FindFirstChildOfClass(_obi44m9h({97,115,135,132,93,115,117,121,129})).Text = _obi44m9h({83,125,125,132,118,76,51}) .. TAG.font
		TAG.refresh()
		if TAG.push then TAG.push() end
	end, true)
	rowBtn(page, _obi44m9h({78,126,123,121,116,115,133,52,131,133,132,125,57,126,124,60,145,127,134}), function()
		local t = (tagBox.Text:gsub(_obi44m9h({107,51,130,59}), _obi44m9h({})))
		t = (t:gsub(_obi44m9h({50,129,58,52}), _obi44m9h({})))
		TAG.text = t:sub(1, 16)
		TAG.refresh()
		if TAG.push then TAG.push() end
		say(_obi44m9h({97,111,118,74,49}) .. (TAG.text ~= _obi44m9h({}) and TAG.text or lp.DisplayName))
	end, true)
	roleLbl = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({80,111,129,119,128,76,51}) .. TAG.role .. _obi44m9h({45,54,115,117,119,123,129,125,121,133,55,136,126,134,138,60,97,141,141,143,74}), Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
	}, page)
	TAG.onChanged = function()
		tagBox.Text = TAG.text
		fontBtn:FindFirstChildOfClass(_obi44m9h({97,115,135,132,93,115,117,121,129})).Text = _obi44m9h({83,125,125,132,118,76,51}) .. TAG.font
		roleLbl.Text = _obi44m9h({80,111,129,119,128,76,51}) .. TAG.role .. _obi44m9h({45,54,115,117,119,123,129,125,121,133,55,136,126,134,138,60,97,141,141,143,74})
		setTagOn(TAG.on)
	end

	table.insert(conns, { Disconnect = function() alive = false end })
end

local GAMES = {
	Brookhaven = { 4924922222 },
	[_obi44m9h({91,111,131,133,131,115,127,52,89,127,138,121,140,142,128,142})] = { 189707 },
	Evade = { 9872472334 },
}
local function inGame(name)
	for _, id in ipairs(GAMES[name] or {}) do
		if game.PlaceId == id then return true end
	end
	if name == _obi44m9h({82,132,112,116,118}) then
		local ok, nm = pcall(function() return tostring(game.Name):lower() end)
		return ok and nm:find(_obi44m9h({114,132,112,116,118})) ~= nil
	end
	return false
end
local function buildTabs(last)
	local t = { _obi44m9h({86,82}), _obi44m9h({80,128,210,185,117,123,135,131,136}), _obi44m9h({96,113,129,121,129,134,134}) }
	if inGame(_obi44m9h({79,128,126,127,124,122,116,138,122,132})) then table.insert(t, _obi44m9h({79,128,126,127,124,122,116,138,122,132})) end
	if inGame(_obi44m9h({91,111,131,133,131,115,127,52,89,127,138,121,140,142,128,142})) then table.insert(t, _obi44m9h({91,111,131,133,131,115,127,52,89,127,138,121,140,142,128,142})) end
	if inGame(_obi44m9h({82,132,112,116,118})) then table.insert(t, _obi44m9h({82,132,112,116,118})) end
	for _, n in ipairs({ _obi44m9h({90,125,115}), _obi44m9h({82,116,116,121,133,129,134}), _obi44m9h({82,134,131,130,114,133}) }) do table.insert(t, n) end
	for _, n in ipairs(last) do table.insert(t, n) end
	return t
end

local function addSubTabs(host, names)
	local bar = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 1 }, host)
	mk(_obi44m9h({98,87,86,130,122,118,95,117,142,133,140,140}), { CellSize = UDim2.new(0.333, -5, 0, 26), CellPadding = UDim2.fromOffset(5, 5), SortOrder = Enum.SortOrder.LayoutOrder }, bar)
	local subs, chips = {}, {}
	local function pick(n)
		for k, f in pairs(subs) do f.Visible = (k == n) end
		for k, c in pairs(chips) do c.BackgroundColor3 = (k == n) and Color3.fromRGB(70, 10, 14) or PANEL end
	end
	for i, n in ipairs(names) do
		local c = mk(_obi44m9h({97,115,135,132,83,135,135,136,132,132}), {
			Text = n, LayoutOrder = i, BackgroundColor3 = PANEL, BackgroundTransparency = 0.1,
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 11,
		}, bar)
		round(c, 13); stroke(c, 1.5)
		local f = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Visible = false, LayoutOrder = 2 }, host)
		mk(_obi44m9h({98,87,91,121,132,134,95,117,142,133,140,140}), { Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, f)
		subs[n], chips[n] = f, c
		c.MouseButton1Click:Connect(function() pick(n) end)
	end
	pick(names[1])
	return subs
end

local HUBLOG = { list = {}, on = false, self = false, hooked = false, t0 = os.clock(), listeners = {} }
function HUBLOG.ser(v, d)
	d = d or 0
	local t = typeof(v)
	if t == _obi44m9h({128,130,129,121,127,121}) then return string.format(_obi44m9h({50,127}), v)
	elseif t == _obi44m9h({123,131,124,114,118,132}) or t == _obi44m9h({111,125,126,124,118,115,129}) or t == _obi44m9h({123,119,123}) then return tostring(v)
	elseif t == _obi44m9h({80,125,123,127,131,69}) then return string.format(_obi44m9h({80,125,123,127,131,69,65,122,135,133,132,106,96,92,67,65,129,74,68,132,77,71,135,77}), math.floor(v.R * 255 + 0.5), math.floor(v.G * 255 + 0.5), math.floor(v.B * 255 + 0.5))
	elseif t == _obi44m9h({99,115,114,132,128,132,70}) then return string.format(_obi44m9h({99,115,114,132,128,132,70,66,131,123,142,64,62,129,71,65,132,74,68,135,74}), v.X, v.Y, v.Z)
	elseif t == _obi44m9h({80,84,129,113,126,119}) then local p = v.Position; return string.format(_obi44m9h({80,84,129,113,126,119,65,130,122,141,63,61,128,70,64,131,73,67,134,73}), p.X, p.Y, p.Z)
	elseif t == _obi44m9h({86,124,130,132,114,128,118,121}) then return _obi44m9h({116,111,124,117,63}) .. v:GetFullName()
	elseif t == _obi44m9h({129,111,113,124,118}) then
		if d >= 4 then return _obi44m9h({136,60,61,62,142}) end
		local out, n = {}, 0
		for k, x in pairs(v) do
			n = n + 1
			if n > 40 then out[#out + 1] = _obi44m9h({59,60,61}); break end
			out[#out + 1] = (type(k) == _obi44m9h({123,131,124,114,118,132}) and _obi44m9h({}) or (_obi44m9h({104}) .. HUBLOG.ser(k, d + 1) .. _obi44m9h({106,75}))) .. HUBLOG.ser(x, d + 1)
		end
		return _obi44m9h({136}) .. table.concat(out, _obi44m9h({57,46})) .. _obi44m9h({138})
	end
	return _obi44m9h({73}) .. t .. _obi44m9h({75})
end
function HUBLOG.path(inst)
	local names, p = {}, inst
	while p and p ~= game do table.insert(names, 1, p.Name); p = p.Parent end
	local svc = table.remove(names, 1) or _obi44m9h({76})
	local s = _obi44m9h({116,111,124,117,75,89,120,136,104,123,137,142,130,125,128,68,63}) .. tostring(svc) .. _obi44m9h({47,55})
	for _, n in ipairs(names) do s = s .. _obi44m9h({104}) .. string.format(_obi44m9h({50,127}), n) .. _obi44m9h({106}) end
	return s
end
local function hubPush(line)
	local list = HUBLOG.list
	local last = list[#list]
	if last and last.line == line then last.n = last.n + 1; return end
	list[#list + 1] = { t = os.clock() - HUBLOG.t0, line = line, n = 1 }
	if #list > 2000 then table.remove(list, 1) end
	if DSLOG and DSLOG.ev then DSLOG.ev(_obi44m9h({86,92,85,95}), _obi44m9h({127,115,124,127,133,119}), line) end
end

function HUBLOG.add(remote, method, args, own, _, incoming)
	local parts = {}
	for i = 1, args.n do parts[i] = HUBLOG.ser(args[i]) end
	hubPush((own and _obi44m9h({58,59,47,107,89,103,85,113,53}) or _obi44m9h({})) .. (incoming and _obi44m9h({73,59,60,48}) or _obi44m9h({})) .. HUBLOG.path(remote) .. _obi44m9h({71}) .. method .. _obi44m9h({53}) .. table.concat(parts, _obi44m9h({57,46})) .. _obi44m9h({54}))
end

function HUBLOG.addResult(remote, res, own)
	local rp = {}
	for i = 1, res.n do rp[i] = HUBLOG.ser(res[i]) end
	hubPush((own and _obi44m9h({58,59,47,107,89,103,85,113,53}) or _obi44m9h({})) .. _obi44m9h({45,46,47,242,151,197,51,134,122,137,135,135,140,142,124,60,129,131,63}) .. HUBLOG.path(remote) .. _obi44m9h({45,75,47}) .. (res.n > 0 and table.concat(rp, _obi44m9h({57,46})) or _obi44m9h({53,129,116,125,49,132,120,136,132,136,133,135,66})))
end
function HUBLOG.mark(text)
	local line = _obi44m9h({74,75,76,77,78,50}) .. tostring(text) .. _obi44m9h({45}) .. os.date(_obi44m9h({50,86,73,53,94,76,56,103})) .. _obi44m9h({45,75,76,77,78,79})
	table.insert(HUBLOG.list, { t = os.clock() - HUBLOG.t0, line = line, n = 1 })
	if DSLOG and DSLOG.ev then DSLOG.ev(_obi44m9h({86,92,85,95}), _obi44m9h({127,115,124,127,133,119}), line) end
end

function HUBLOG.watchIncoming(on)
	for _, c in ipairs(HUBLOG.inConns or {}) do pcall(function() c:Disconnect() end) end
	HUBLOG.inConns = {}
	HUBLOG.incoming = on and true or false
	if not on then return end
	local seen = {}
	local function hook(r)
		if seen[r] or not r:IsA(_obi44m9h({95,115,124,127,133,119,88,138,122,132,139})) then return end
		seen[r] = true
		table.insert(HUBLOG.inConns, r.OnClientEvent:Connect(function(...)
			if HUBLOG.on and HUBLOG.incoming then pcall(HUBLOG.add, r, _obi44m9h({92,124,82,124,122,119,129,136,90,140,124,134,141}), table.pack(...), false, nil, true) end
		end))
	end
	local RS = game:GetService(_obi44m9h({95,115,127,124,122,117,116,136,122,122,106,140,136,140,124,131,130}))
	for _, d in ipairs(RS:GetDescendants()) do pcall(hook, d) end
	table.insert(HUBLOG.inConns, RS.DescendantAdded:Connect(function(d) pcall(hook, d) end))
end
function HUBLOG.listen(fn) table.insert(HUBLOG.listeners, fn) end
function HUBLOG.unlisten(fn)
	for i, f in ipairs(HUBLOG.listeners) do
		if f == fn then table.remove(HUBLOG.listeners, i); break end
	end
end
function HUBLOG.install()
	if HUBLOG.hooked then return true end
	local ok = pcall(function()
		local old
		old = hookmetamethod(game, _obi44m9h({108,109,125,113,126,119,118,117,129,130}), newcclosure(function(self, ...)
			local m = getnamecallmethod()
			local own = checkcaller()
			if (m == _obi44m9h({83,119,129,117,100,119,133,138,122,136}) or m == _obi44m9h({86,124,133,127,124,119,102,121,135,140,124,138})) and typeof(self) == _obi44m9h({86,124,130,132,114,128,118,121}) and (not own or (HUBLOG.self and HUBLOG.on)) then
				local pk = table.pack(...)
				task.defer(function()
					if not own then
						for _, fn in ipairs(HUBLOG.listeners) do pcall(fn, self, m, pk) end
					end
					if HUBLOG.on then pcall(HUBLOG.add, self, m, pk, own) end
				end)
				if m == _obi44m9h({86,124,133,127,124,119,102,121,135,140,124,138}) and HUBLOG.on then

					local res = table.pack(old(self, ...))
					task.defer(function()
						if HUBLOG.on then pcall(HUBLOG.addResult, self, res, own) end
					end)
					return table.unpack(res, 1, res.n)
				end
			end
			return old(self, ...)
		end))
	end)
	HUBLOG.hooked = ok
	return ok
end

local function buildCar(page, say)
	local RS = game:GetService(_obi44m9h({95,115,127,124,122,117,116,136,122,122,106,140,136,140,124,131,130}))
	local alive = true
	local cons = {}
	local onFire

	local function topModel(part)
		local m = part and part:FindFirstAncestorOfClass(_obi44m9h({90,125,115,117,125}))
		while m and m.Parent and m.Parent:IsA(_obi44m9h({90,125,115,117,125})) do m = m.Parent end
		return m
	end

	local CAR_REMOTE = _obi44m9h({93,122,112,137,118,132,134,87,118,136})

	local function reByPlain(plain)
		local re = RS:FindFirstChild(_obi44m9h({95,83}))
		if not re then return nil end
		for _, c in ipairs(re:GetChildren()) do
			if (c.Name:gsub(_obi44m9h({62}), _obi44m9h({}))) == plain then return c end
		end
		return nil
	end
	local function inputRow(placeholder)
		local row = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk(_obi44m9h({97,115,135,132,83,129,139}), {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = _obi44m9h({}), PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function note(text, h)
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = text, Size = UDim2.new(1, 0, 0, h or 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
			Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end

	local function currentSeat()
		local h = hum()
		local s = h and h.SeatPart
		if s and (s:IsA(_obi44m9h({99,115,119,121,116,126,120,103,122,119,139})) or s:IsA(_obi44m9h({96,115,112,132}))) then return s end
		return nil
	end

	section(page, _obi44m9h({99,115,123,127,116,123,119,117,121,123,55,124,136,58,126,125,143,144,142}))
	note(_obi44m9h({83,131,125,115,122,129,129,117,53,122,128,138,130,129,132,138,129,141,63,72,151,145,134,231,207,70,138,151,151,158,157,155,153,143,79,145,81,152,246,225,168,159,154,153,89,158,170,92,160,159,177,178,176,110,99,169,179,186,10,235,184,106,191,187,177,189,111,189,198,192,183,195,117,204,26,2,121,191,199,193,125,191,205,196,194,208,199,211,133,199,218,219,210,215,148,154}))
	local spd = { on = false, val = 120, thr = 0, fwd = nil, fwdSeat = nil, warned = nil }
	toggleRow(page, _obi44m9h({97,131,129,114,128,50,119,131,53,121,120,138,139,137}), _obi44m9h({99,111,120,48,114,134,214,189,53,119,55,142,126,134,138,127,134,130,128,132,134,66,136,151,136,149,147,144,146,142,140,76,146,156,160,165,146,160,167,163,85,172,166,155,252,228,91,157,160,163,171,165,179,163}), function(v) spd.on = v end)
	sliderRow(page, _obi44m9h({99,115,123,127,116,123,119,117,121,123,55,133,220,187,147,133,138,127}), _obi44m9h({128,130,132,116,132,50,131,131,135,54,138,125,128,143,137,128,140}), 40, 400, 120, function(v) spd.val = v end)

	local controls
	pcall(function()
		controls = require(lp:WaitForChild(_obi44m9h({93,122,112,137,118,132,102,119,135,127,135,140,140})):WaitForChild(_obi44m9h({93,122,112,137,118,132,96,131,121,139,131,125}), 5)):GetControls()
	end)

	local function readThrottle(seat)
		if spd.thr ~= 0 then return spd.thr end
		local ok, v = pcall(function() return seat.ThrottleFloat end)
		if ok and type(v) == _obi44m9h({123,131,124,114,118,132}) and v ~= 0 then return v > 0 and 1 or -1 end
		if controls then
			local ok2, mv = pcall(function() return controls:GetMoveVector() end)
			if ok2 and mv and math.abs(mv.Z) > 0.2 then return (-mv.Z) > 0 and 1 or -1 end
		end
		if not UIS:GetFocusedTextBox() then
			if UIS:IsKeyDown(Enum.KeyCode.W) or UIS:IsKeyDown(Enum.KeyCode.Up) then return 1 end
			if UIS:IsKeyDown(Enum.KeyCode.S) or UIS:IsKeyDown(Enum.KeyCode.Down) then return -1 end
		end
		return 0
	end
	cons[#cons + 1] = RunService.Heartbeat:Connect(function()
		if not spd.on then return end
		local seat = currentSeat()
		if not seat then spd.thr = 0; spd.fwd = nil; spd.fwdSeat = nil; return end
		if spd.fwdSeat ~= seat then spd.fwdSeat = seat; spd.fwd = nil end
		local t = readThrottle(seat)
		if t == 0 then return end
		local root = seat.AssemblyRootPart or seat
		local v = root.AssemblyLinearVelocity
		local hv = Vector3.new(v.X, 0, v.Z)
		local cur = hv.Magnitude
		if cur < 4 then return end
		local look = seat.CFrame.LookVector
		local flat = Vector3.new(look.X, 0, look.Z)
		if flat.Magnitude < 0.01 then return end
		flat = flat.Unit
		local along = hv:Dot(flat)

		if t > 0 and spd.fwd == nil and cur > 6 then spd.fwd = along >= 0 and 1 or -1 end
		if spd.fwd == nil then return end
		local moving = (along * spd.fwd) >= 0 and 1 or -1
		if moving ~= (t > 0 and 1 or -1) then return end
		if cur >= spd.val then return end
		if isnetworkowner and spd.warned ~= root then
			local okN, own = pcall(isnetworkowner, root)
			if okN and own == false then
				spd.warned = root
				say(_obi44m9h({97,131,129,114,128,76,51,131,53,137,124,138,143,131,127,139,143,62,130,143,143,150,149,147,145,135,71,137,73,144,238,217,160,151,146,145,81,150,152,167,168,155,87,155,154,172,173,171,105,94,164,174,181,5,230,179,101,181,103,177,182,186,192,184,192,189,111,192,192,182,184,116,195,25,250,199,121,192,208,202,192,199,206,206,194,212,145}))
			end
		end
		local nxt = cur + (spd.val - cur) * 0.08 + 0.4
		root.AssemblyLinearVelocity = hv.Unit * nxt + Vector3.new(0, v.Y, 0)
	end)

	section(page, _obi44m9h({96,131,130,128,118,128,134,215,184,133,55,64,122,134,143,145,143,127,63,132,144,66,134,133,151,152,150,81}))
	note(_obi44m9h({98,129,112,48,114,50,134,137,136,134,124,134,140,221,190,139,61,130,142,64,145,148,230,215,149,152,144,151,73,148,154,147,156,78,87,164,160,150,162,84,162,171,165,156,168,90,177,255,231,103,109,96,135,171,180,185,170,102,186,173,183,190,172,176,188,110,189,191,113,181,180,198,199,197,133}))
	local function susRemote()
		local folder = RS:FindFirstChild(_obi44m9h({95,115,124,127,133,119,134}))
		return folder and folder:FindFirstChild(_obi44m9h({96,115,131,94,118,138,135,103,138,137,135,125,135,141,132,139,139,102,132,137,136,138,151}))
	end
	local function nextHeight(times)
		local f = susRemote()
		if not f then say(_obi44m9h({95,115,124,127,133,119,51,120,118,54,138,141,140,138,128,138,144,225,194,143,65,144,230,199,148,70,140,150,140,153,153,160,159,143,147,159,95})); return end
		task.spawn(function()
			local last
			for i = 1, times do
				local ok, res = pcall(function() return f:InvokeServer() end)
				if not ok then say(_obi44m9h({83,111,123,120,128,135,77,52}) .. tostring(res):sub(1, 50)); return end
				last = res
				if i < times then task.wait(0.25) end
			end
			say(_obi44m9h({78,122,131,133,131,115,51,136,135,133,122,121,125,123}) .. (last ~= nil and (_obi44m9h({45,54}) .. tostring(last) .. _obi44m9h({54})) or _obi44m9h({})) .. _obi44m9h({59}))
		end)
	end
	rowBtn(page, _obi44m9h({93,128,210,195,137,123,128,117,53,119,131,140,142,140,124,60,129,127,63,147,150,149,147,137,147,153,234,203,152}), function() nextHeight(1) end)
	rowBtn(page, _obi44m9h({93,131,123,113,131,50,69,52,118,130,139,141,139,123,142}), function() nextHeight(2) end, true)

	note(_obi44m9h({95,115,113,113,122,138,116,134,53,124,134,138,220,193,124,138,129,141,89,64,134,143,147,153,151,152,136,72,152,74,142,141,159,160,158,80,161,164,148,84,151,151,160,176,168,90,158,171,171,178,177,161,97,163,99,183,186,185,183,173,183,189,14,239,188,122,111,185,191,182,194,116,182,194,26,1,198,122,191,189,125,191,203,212,214,212,196,132,210,199,208,219,137,204,204,213,229,207,143,212,224,146,221,227,220,229,165,152,204,61,46,156,227,243,237,227,234,241,241,229,165,249,236,168,248,170,238,237,255,0,254,176,247,1,5,180,8,255,4,13,5,251,255,11,189,14,14,18,193,24,18,7,104,80,213}), 54)
	local low = { on = false, k = 2, vf = nil, root = nil }
	local function lowClear()
		if low.vf then
			pcall(function() low.vf.Attachment0:Destroy() end)
			pcall(function() low.vf:Destroy() end)
		end
		low.vf, low.root = nil, nil
	end
	toggleRow(page, _obi44m9h({95,115,113,113,122,138,116,134,53,124,134,138,220,193,124,138,129,141,63,143,65,133,132,150,151,149}), _obi44m9h({82,123,127,133,131,132,116,52,132,54,122,121,139,140,138,60,141,144,128,64,131,131,140,156,148,70,140,150,154,159,140,154,161,157,79,166,160,149,246,222,85,155,170,172,252,219,91,175,162,172,179,161,165,177}), function(v)
		low.on = v
		if not v then lowClear() end
	end)
	sliderRow(page, _obi44m9h({83,125,129,211,184,115,51,120,132,54,137,125,123,123,132,148,126,139,132,142,149,145}), _obi44m9h({90,209,201,124,133,123,131,128,132,137,55,124,136,58,139,129,144,141,63,132,144,66,134,133,151,152,150,72,81,91,75,141,77,102,88}), 1, 8, 2, function(v) low.k = v end)
	task.spawn(function()
		while alive do
			local h = hum()
			local sp = h and h.SeatPart
			local root = sp and sp.AssemblyRootPart
			if low.on and root then
				if low.root ~= root or not low.vf or not low.vf.Parent then
					lowClear()
					local att = mk(_obi44m9h({78,130,131,113,116,122,128,121,131,138}), { Name = _obi44m9h({96,118,120,126,89,135,117,96,132,141}) }, root)
					low.vf = mk(_obi44m9h({99,115,114,132,128,132,89,131,135,121,124}), {
						Attachment0 = att, RelativeTo = Enum.ActuatorRelativeTo.World,
						ApplyAtCenterOfMass = true, Force = Vector3.zero,
					}, root)
					low.root = root
				end
				low.vf.Force = Vector3.new(0, -root.AssemblyMass * workspace.Gravity * low.k, 0)
			elseif low.vf then
				lowClear()
			end
			task.wait(0.25)
		end
		lowClear()
	end)

	onFire = function(remote, method, a)
		if not alive or method ~= _obi44m9h({83,119,129,117,100,119,133,138,122,136}) then return end
		if remote.Name == _obi44m9h({96,115,131,100,121,132,130,136,137,130,124,94,133,137,124,144}) then
			local tv = tonumber(a[1])
			if tv then spd.thr = tv end
		end
	end
	HUBLOG.install()
	HUBLOG.listen(onFire)

	return function()
		alive = false
		HUBLOG.unlisten(onFire)
		lowClear()
		for _, c in ipairs(cons) do c:Disconnect() end
	end
end

local function buildLog(page, say)
	local RS = game:GetService(_obi44m9h({95,115,127,124,122,117,116,136,122,122,106,140,136,140,124,131,130}))
	local function topModel(part)
		local m = part and part:FindFirstAncestorOfClass(_obi44m9h({90,125,115,117,125}))
		while m and m.Parent and m.Parent:IsA(_obi44m9h({90,125,115,117,125})) do m = m.Parent end
		return m
	end
	local function inputRow(placeholder)
		local row = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk(_obi44m9h({97,115,135,132,83,129,139}), {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = _obi44m9h({}), PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function note(text, h)
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = text, Size = UDim2.new(1, 0, 0, h or 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
			Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end
	local function copy(txt)
		local f = setclipboard or toclipboard
		if not f then say(_obi44m9h({96,115,132,48,118,138,120,119,138,138,134,138,57,136,222,191,140,62,147,133,142,66,150,137,153,137,147,145,153,140,154,141,159,146,93})); return end
		local ok = pcall(f, txt)
		say(ok and _obi44m9h({80,125,127,121,114,118,130,53}) or _obi44m9h({83,111,123,120,128,135,51,117,132,54,122,135,137,131,124,142,75}))
	end

	return function() HUBLOG.on = false end
end

local function buildAvatarCopy(page, say)
	if not page then return end
	local picked
	local function collect(uid)
		local ok, desc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(uid) end)
		if not ok or not desc then return nil end
		local ids, seen = {}, {}
		local function add(n)
			n = tonumber(n)
			if n and n > 0 and not seen[n] and #ids < 24 then
				seen[n] = true
				table.insert(ids, tostring(math.floor(n)))
			end
		end
		local okA, acc = pcall(function() return desc:GetAccessories(true) end)
		if okA and type(acc) == _obi44m9h({129,111,113,124,118}) then
			for _, a in ipairs(acc) do add(a.AssetId) end
		end
		for _, k in ipairs({ _obi44m9h({96,118,120,130,133}), _obi44m9h({93,111,125,132,132}), _obi44m9h({84,128,112,128,121,123,118,104,104,126,128,138,141}), _obi44m9h({83,111,114,117}), _obi44m9h({85,115,112,116}), _obi44m9h({97,125,129,131,128}), _obi44m9h({89,115,117,132,82,132,128}), _obi44m9h({95,119,118,120,133,83,133,129}), _obi44m9h({89,115,117,132,93,119,122}), _obi44m9h({95,119,118,120,133,94,120,123}) }) do
			local okP, v = pcall(function() return desc[k] end)
			if okP then add(v) end
		end
		local function hex(c)
			return string.format(_obi44m9h({50,62,65,136,54,66,69,140,58,70,73,144}), math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
		end
		local bc = table.concat({
			hex(desc.HeadColor), hex(desc.TorsoColor), hex(desc.LeftArmColor),
			hex(desc.RightArmColor), hex(desc.LeftLegColor), hex(desc.RightLegColor),
		}, _obi44m9h({57}))
		return ids, bc
	end

	section(page, _obi44m9h({80,125,127,121,114,132,51,117,139,119,139,121,139,58,67,94,143,141,142,139,137,131,153,137,147,79}))
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({82,129,114,127,125,122,116,52,118,130,126,141,220,195,136,60,142,147,132,64,134,149,151,231,198,70,149,151,73,148,154,147,156,78,148,80,148,161,163,157,154,86,166,88,154,176,156,176,158,176,109,96,149,177,167,179,101,179,188,182,173,185,107,189,194,179,111,197,196,179,115,195,117,190,204,186,121,208,30,6,125,195,204,128,215,209,198,39,15,148}),
		Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local dd
	dd = dropdown(page, _obi44m9h({82,129,114,127,125,122,120,134,53,128,134,127,122,126,138,142,61,70,141,133,143,138,152,145,78}), function()
		local t = {}
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl ~= lp then
				table.insert(t, { label = pl.DisplayName .. _obi44m9h({45,46,55,80}) .. pl.Name .. _obi44m9h({54}), value = pl.UserId, name = pl.DisplayName })
			end
		end
		table.sort(t, function(x, y) return x.label:lower() < y.label:lower() end)
		return t
	end, function(it)
		picked = it
		dd.setText(_obi44m9h({87,125,118,113,117,129,133,78,53}) .. it.name)
	end)
	local busy = false
	rowBtn(page, _obi44m9h({80,125,127,121,114,132,51,117,139,119,139,121,139,58,127,139,61,136,142,135,130,134,146,150}), function()
		if not picked then say(_obi44m9h({82,129,114,127,125,122,116,52,138,131,55,130,136,129,124,128,140,144,63,144,147,139,144,137,142,152,150,86})); return end
		if busy then return end
		busy = true
		task.spawn(function()
			local ids, bc = collect(picked.value)
			busy = false
			if not ids or #ids == 0 then say(_obi44m9h({91,209,178,127,49,117,130,130,136,123,126,141,130,58,135,129,143,62,142,64,130,152,132,152,134,152,71,140,142,74}) .. picked.name .. _obi44m9h({59})); return end
			MINE.ids = ids
			MINE.bc = bc
			if MINE.onList then MINE.onList() end
			if publishMods then publishMods() end
			say(_obi44m9h({78,132,112,132,114,132,51,120,122,54}) .. picked.name .. _obi44m9h({45,113,126,128,122,115,119,131,53,62}) .. #ids .. _obi44m9h({45,119,131,117,127,133,60,66,53,87,135,121,139,127,126,129,61,131,140,64,130,142,138,153,147,153,71,155,142,145,160,154,145,157,162,94}))
		end)
	end)
	rowBtn(page, _obi44m9h({99,125,123,132,114,132,51,117,132,54,132,125,142,58,124,146,126,146,128,146}), function()
		MINE.ids = {}
		MINE.bc = nil
		if MINE.onList then MINE.onList() end
		if publishMods then publishMods() end
		say(_obi44m9h({78,132,112,132,114,132,51,119,132,134,128,121,125,137,59,142,130,139,142,150,138,134,146,82}))
	end, true)
end

local function buildWings(page, say)
	local rawSay = say
	local trace, T0 = {}, os.clock()
	local function say(s)
		trace[#trace + 1] = string.format(_obi44m9h({104,51,61,65,119,133,112,52,58,137}), os.clock() - T0, tostring(s))
		if #trace > 60 then table.remove(trace, 1) end
		rawSay(s)
	end
	local RS = game:GetService(_obi44m9h({95,115,127,124,122,117,116,136,122,122,106,140,136,140,124,131,130}))
	local alive, animating, busyBuild = true, false, false
	local animGen = 0
	local recs = {}
	local cfg = { per = 3, scale = 10, speed = 5, interval = 300, full = true, hide = true }
	local blockName = _obi44m9h({79,122,126,115,124,69})
	local spacing = 2
	local t0 = os.clock()
	local wconns = {}

	local function inputRow(placeholder, text)
		local row = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk(_obi44m9h({97,115,135,132,83,129,139}), {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = text or _obi44m9h({}), PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function clip(txt)
		if setclipboard then pcall(setclipboard, txt); say(_obi44m9h({80,125,127,121,114,118,130,66})) else say(_obi44m9h({96,115,132,48,118,138,120,119,138,138,134,138,57,136,222,191,140,62,147,133,142,66,150,137,153,137,147,145,153,140,154,141,159,146,93})) end
	end
	local function getRoot()
		return lp.Character and lp.Character:FindFirstChild(_obi44m9h({85,131,124,113,127,129,124,120,103,133,134,140,105,123,141,144}))
	end
	local function remoteRE(name)
		local re = RS:FindFirstChild(_obi44m9h({95,83}))
		return re and re:FindFirstChild(name)
	end
	local function propTool()
		local c = lp.Character
		return c and c:FindFirstChild(_obi44m9h({93,128,126,128,94,115,126,121,135}))
	end
	local function findTool(name)
		local c = lp.Character
		local t = c and c:FindFirstChild(name)
		if t then return t, _obi44m9h({112,118,112,130,114,117,135,121,135}) end
		local bp = lp:FindFirstChildOfClass(_obi44m9h({79,111,114,123,129,115,118,127}))
		t = bp and bp:FindFirstChild(name)
		if t then return t, _obi44m9h({111,111,114,123,129,115,118,127}) end
		return nil
	end
	local function equipPropMaker(re1)
		local t, where = findTool(_obi44m9h({93,128,126,128,94,115,126,121,135}))
		if t and where == _obi44m9h({112,118,112,130,114,117,135,121,135}) then return t end
		if not t then
			local ok, res = pcall(function() return re1:InvokeServer(_obi44m9h({93,119,114,123,122,128,122,104,132,133,131,139}), _obi44m9h({93,128,126,128,94,115,126,121,135})) end)
			say(_obi44m9h({93,119,114,123,122,128,122,104,132,133,131,139,83,58}) .. (ok and (_obi44m9h({127,115,130,128,128,133,135,117,82}) .. tostring(res)) or (_obi44m9h({114,128,129,127,78}) .. tostring(res):sub(1, 60))))
			for _ = 1, 30 do
				task.wait(0.1)
				t, where = findTool(_obi44m9h({93,128,126,128,94,115,126,121,135}))
				if t then break end
			end
		end
		if t and where == _obi44m9h({111,111,114,123,129,115,118,127}) then
			local h = lp.Character and lp.Character:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120}))
			if h then pcall(function() h:EquipTool(t) end) end
			for _ = 1, 20 do
				task.wait(0.1)
				if lp.Character and lp.Character:FindFirstChild(_obi44m9h({93,128,126,128,94,115,126,121,135})) then break end
			end
		end
		return lp.Character and lp.Character:FindFirstChild(_obi44m9h({93,128,126,128,94,115,126,121,135}))
	end
	local function scanProps(deep)
		local out = {}
		local wc = workspace:FindFirstChild(_obi44m9h({100,125,129,123,132,130,116,119,122,89,134,133}))
		if not wc then return out end
		local want = _obi44m9h({93,128,126,128}) .. lp.Name
		local function isMine(n) return n:sub(1, #want) == want end
		if deep then
			for _, d in ipairs(wc:GetDescendants()) do
				if d.Name == _obi44m9h({96,115,131,83,134,132,133,121,131,138,90,94,139,123,136,129}) and d.Parent and isMine(d.Parent.Name) then out[d.Parent] = true end
			end
		else
			for _, c in ipairs(wc:GetChildren()) do
				if isMine(c.Name) then out[c] = true end
				for _, p in ipairs(c:GetChildren()) do
					if isMine(p.Name) then out[p] = true end
				end
			end
		end
		return out
	end

	local REMOTES = { begin = _obi44m9h({79,115,118,121,127,98,133,121,139,127,124,143}), setcf = _obi44m9h({96,115,131,83,134,132,133,121,131,138,90,94,139,123,136,129}), setsc = _obi44m9h({96,115,131,83,134,132,133,121,131,138,106,123,122,134,128}), endp = _obi44m9h({82,124,115,96,131,119,137,125,122,141}), resume = _obi44m9h({95,115,130,133,126,119,99,134,132,134,89,125,129,123,145,133,140,144}) }
	local function makeRec(model)
		return { model = model, fails = 0, stuck = 0, heals = 0, busy = false, lastCF = nil, lastP = nil, lastErr = nil }
	end
	local function rem(rec, key)
		local r = rec[key]
		if r and r.Parent then return r end
		r = rec.model:FindFirstChild(REMOTES[key])
		rec[key] = r
		return r
	end
	local function touchOf(rec)
		local t = rec.touch
		if t and t.Parent then return t end
		t = rec.model:FindFirstChild(_obi44m9h({97,125,132,115,121}), true)
		rec.touch = t
		return t
	end
	local function waitRemotes(rec, secs)
		local t = os.clock()
		while os.clock() - t < secs do
			if rem(rec, _obi44m9h({111,115,118,121,127})) and rem(rec, _obi44m9h({128,115,131,115,119})) and rem(rec, _obi44m9h({114,124,115,128})) then return true end
			task.wait(0.1)
		end
		return false
	end
	local function sizeOf(model)
		local ok, s = pcall(function()
			if model:IsA(_obi44m9h({90,125,115,117,125})) then return model:GetExtentsSize() end
			return model.Size
		end)
		if ok and typeof(s) == _obi44m9h({99,115,114,132,128,132,70}) then return s end
		return Vector3.new(2, 2, 2)
	end
	local function groundAt(x, z, y0)
		local rp = RaycastParams.new()
		rp.FilterType = Enum.RaycastFilterType.Exclude
		local ex = { lp.Character }
		for p in pairs(scanProps(false)) do ex[#ex + 1] = p end
		for _, r in ipairs(recs) do ex[#ex + 1] = r.model end
		rp.FilterDescendantsInstances = ex
		local r = workspace:Raycast(Vector3.new(x, y0 + 20, z), Vector3.new(0, -80, 0), rp)
		if r then return r.Instance, r.Position end
		return nil
	end

	local hide = { on = false, learning = false, expect = 0, base = {}, set = {}, names = {}, count = 0 }
	local ADORN = {
		Handles = true, ArcHandles = true, SelectionBox = true, SelectionSphere = true, SurfaceSelection = true,
		BoxHandleAdornment = true, ConeHandleAdornment = true, CylinderHandleAdornment = true,
		SphereHandleAdornment = true, Highlight = true,
	}
	local function playerGui()
		return lp:FindFirstChildOfClass(_obi44m9h({93,122,112,137,118,132,90,137,126}))
	end
	local function guiOn(g)
		if g:IsA(_obi44m9h({96,113,129,117,118,128,90,137,126})) then return g.Enabled end
		if g:IsA(_obi44m9h({84,131,120,95,115,124,120,119,137})) then return g.Visible end
		return false
	end
	local function guiOff(g)
		pcall(function()
			if g:IsA(_obi44m9h({96,113,129,117,118,128,90,137,126})) then g.Enabled = false elseif g:IsA(_obi44m9h({84,131,120,95,115,124,120,119,137})) then g.Visible = false end
		end)
	end

	local function eachGui(fn)
		local pg = playerGui()
		if not pg then return end
		for _, sg in ipairs(pg:GetChildren()) do
			if sg:IsA(_obi44m9h({96,113,129,117,118,128,90,137,126})) then
				fn(sg, 1)
				if guiOn(sg) then
					for _, c in ipairs(sg:GetChildren()) do
						if c:IsA(_obi44m9h({84,131,120,95,115,124,120,119,137})) then
							fn(c, 2)
							if c.Visible then
								for _, d in ipairs(c:GetChildren()) do
									if d:IsA(_obi44m9h({84,131,120,95,115,124,120,119,137})) then fn(d, 3) end
								end
							end
						end
					end
				end
			end
		end
	end
	local function hideBase()
		hide.base = {}
		eachGui(function(g) hide.base[g] = guiOn(g) and true or false end)
	end
	local function underHidden(g)
		local p = g.Parent
		while p do
			if hide.set[p] then return true end
			p = p.Parent
		end
		return false
	end
	local function hideTick()
		if not (hide.on and cfg.hide) then return end
		local learn = hide.learning and os.clock() < hide.expect
		eachGui(function(g, depth)
			if not guiOn(g) then return end
			if hide.set[g] then guiOff(g); return end
			if hide.base[g] == true then return end
			if learn and not underHidden(g) then
				hide.set[g] = true
				hide.count = hide.count + 1
				if depth == 1 then hide.names[g.Name] = true end
				guiOff(g)
			elseif depth == 1 and hide.names[g.Name] then
				guiOff(g)
			end
		end)
	end
	local function isMine(inst)
		local want = _obi44m9h({93,128,126,128}) .. lp.Name
		local p = inst
		while p and p ~= workspace do
			if p.Name:sub(1, #want) == want then return true end
			p = p.Parent
		end
		return false
	end
	local function hide3D(inst)
		if not ADORN[inst.ClassName] then return end
		local ok, mine = pcall(function()
			if isMine(inst) then return true end
			local ad = inst.Adornee
			return ad ~= nil and isMine(ad)
		end)
		if ok and mine then
			pcall(function()
				if inst:IsA(_obi44m9h({85,119,118,120,125,123,122,124,137})) then inst.Enabled = false else inst.Visible = false end
			end)
		end
	end
	wconns[#wconns + 1] = workspace.DescendantAdded:Connect(function(d)
		if hide.on and cfg.hide and ADORN[d.ClassName] then task.defer(hide3D, d) end
	end)
	do
		local pgc = playerGui()
		if pgc then
			wconns[#wconns + 1] = pgc.DescendantAdded:Connect(function(d)
				if hide.on and cfg.hide and ADORN[d.ClassName] then task.defer(hide3D, d) end
			end)
		end
	end
	local function hideStart(learn)
		if hide.on then
			if learn then hide.learning = true end
			return
		end
		hide.on, hide.learning = true, learn and true or false
		hideBase()
		task.spawn(function()
			local n = 0
			while alive and hide.on do
				pcall(hideTick)
				n = n + 1
				if n % 5 == 0 then
					pcall(function()
						for _, r in ipairs(recs) do
							if r.model.Parent then
								for _, d in ipairs(r.model:GetDescendants()) do hide3D(d) end
							end
						end
					end)
				end
				task.wait(0.2)
			end
		end)
	end
	local function hideStop()
		hide.on, hide.learning = false, false
	end

	local function targetCF(root, side, i, n, t)
		local freq = 0.2 + cfg.speed * 0.1
		local phase = t * freq * 2 * math.pi - i * 0.45
		local amp = 0.35 + 0.35 * (i / n)
		local flap = 0.25 + amp * math.sin(phase)
		local r = (i - 0.5) * spacing
		return root.CFrame * CFrame.new(side * 0.9, 0.9, 1.4) * CFrame.Angles(0, -side * 0.35, 0)
			* CFrame.Angles(0, 0, side * flap) * CFrame.new(side * r, 0, 0)
	end

	local function cycle(rec, cf, scale, full)
		local b, s, e = rem(rec, _obi44m9h({111,115,118,121,127})), rem(rec, _obi44m9h({128,115,131,115,119})), rem(rec, _obi44m9h({114,124,115,128}))
		if not (b and s and e) then error(_obi44m9h({111,122,126,115,128,50,134,121,130,54,137,125,134,137,143,129,144,62,71,129,138,144,135,133,69,152,140,152,149,147,142,141,155,146,158,89}), 0) end
		rec.lastCF = cf
		local tool = propTool()
		local pm = tool and tool:FindFirstChild(_obi44m9h({97,125,126,124,112,98,133,131,133,99,120,131,126}))
		local touch = touchOf(rec)
		if full and pm and touch then
			hide.expect = os.clock() + 1.2
			pm:FireServer(touch, touch.Position)
		end
		b:InvokeServer()
		local sc = rem(rec, _obi44m9h({128,115,131,131,116}))
		if scale and sc then sc:InvokeServer(scale) end
		s:InvokeServer(cf)
		e:InvokeServer()
		local rs = rem(rec, _obi44m9h({127,115,130,133,126,119}))
		if full and rs then rs:InvokeServer() end
	end

	local function runCycle(rec, cf, scale, full)

		if rec.busy and os.clock() - (rec.busyAt or 0) < 8 then return false, _obi44m9h({124,113,132,128,114,118,130}) end
		rec.busy, rec.busyAt = true, os.clock()
		local ok, err = pcall(cycle, rec, cf, scale, full)
		rec.busy = false
		return ok, err
	end
	local function slotOf(idx, n)
		local per = math.max(1, math.floor(n / 2))
		local side = idx <= per and 1 or -1
		local i = idx <= per and idx or (idx - per)
		return side, i, per
	end

	local function stopAnim()
		animating = false
		animGen = animGen + 1
		if not busyBuild then hideStop() end
	end

	local function startAnim()
		if animating or #recs == 0 then return end
		animating = true
		animGen = animGen + 1
		local gen = animGen
		t0 = os.clock()
		if cfg.hide then hideStart(false) end
		local n = #recs
		for idx, rec in ipairs(recs) do
			local side, i, per = slotOf(idx, n)
			task.spawn(function()
				while alive and animating and gen == animGen and rec.model.Parent do
					local root = getRoot()
					if root then
						local cf = targetCF(root, side, i, per, os.clock() - t0)
						local ok, err = runCycle(rec, cf, nil, cfg.full or rec.forceFull)
						if err == _obi44m9h({124,113,132,128,114,118,130}) then

						elseif ok then
							rec.fails = 0
						else
							rec.fails = rec.fails + 1
							rec.lastErr = tostring(err):sub(1, 80)
							if rec.fails >= 3 then rec.forceFull = true end
							if rec.fails == 6 then say(_obi44m9h({79,122,126,115,128,50}) .. idx .. _obi44m9h({45,116,112,124,121,115,129,120,132,80,55}) .. rec.lastErr) end
						end
					end
					task.wait(cfg.interval / 1000)
				end
				if alive and animating and gen == animGen and not rec.model.Parent then
					say(_obi44m9h({79,122,126,115,128,50}) .. idx .. _obi44m9h({45,129,132,125,122,135,51,120,132,54,132,121,137,123,73}))
				end
			end)
		end

		task.spawn(function()
			while alive and animating and gen == animGen do
				task.wait(1.5)
				for idx, rec in ipairs(recs) do
					if rec.model.Parent and rec.heals < 6 then
						local ok, p = pcall(function() return rec.model:GetPivot().Position end)
						if ok then
							if rec.lastP and (p - rec.lastP).Magnitude < 0.5 then
								rec.stuck = rec.stuck + 1
							else
								rec.stuck = 0
							end
							rec.lastP = p
							if rec.stuck >= 3 then
								rec.stuck = 0
								rec.heals = rec.heals + 1
								local root = getRoot()
								if root then
									local side, i, per = slotOf(idx, #recs)
									say(_obi44m9h({79,122,126,115,128,50}) .. idx .. _obi44m9h({45,126,112,130,114,118,130,66,53,104,124,126,122,148,128,138,129,141,63,72}) .. rec.heals .. _obi44m9h({60,68,56,62,63,64}))
									waitRemotes(rec, 2)
									runCycle(rec, targetCF(root, side, i, per, os.clock() - t0), nil, true)
								end
							end
						end
					end
				end
			end
		end)
		say(_obi44m9h({78,129,112,48,115,115,135,121,131,122,134,70}))
	end

	local function buildWing()
		if busyBuild then say(_obi44m9h({87,209,176,48,118,133,135,131,138,54,122,138,130,123,137,128,140,62,128,64,130,149,132,82,83,84})); return end
		busyBuild = true
		task.spawn(function()
			stopAnim()
			recs = {}
			if cfg.hide then hideStart(true) end
			local ok, err = pcall(function()
				local root0 = getRoot()
				if not root0 then say(_obi44m9h({93,115,129,131,128,128,116,123,122,131,55,134,220,189,138,60,130,140,130,143,143,150,149,133,137,149,85})); return end
				local re1, re2 = remoteRE(_obi44m9h({62,98,126,127,66,126})), remoteRE(_obi44m9h({62,81,123,117,114,67,133,104,132,133,131,73,140}))
				if not (re1 and re2) then say(_obi44m9h({95,115,124,127,133,119,134,52,121,133,55,104,139,137,139,60,106,127,138,133,147,66,145,231,200,149,71,141,151,141,154,154,161,160,144,148,160,165,97})); return end
				say(_obi44m9h({82,127,132,121,129,115,129,120,132,54,134,56,105,140,138,140,61,107,128,139,134,148,81,82,83}))
				local tool = equipPropMaker(re1)
				if not tool then
					say(_obi44m9h({93,128,126,128,49,95,116,127,122,136,55,134,220,189,138,60,126,142,128,146,134,133,136,153,83,70,124,155,142,74,82,111,156,158,152,145,163,82,151,157,150,157,165,251,236,173,175,165,160,173,95,164,176,181,99,166,177,181,170,183,188,113,121})); return
				end
				local pm = tool:WaitForChild(_obi44m9h({97,125,126,124,112,98,133,131,133,99,120,131,126}), 3)
				if not pm then say(_obi44m9h({97,125,126,124,112,98,133,131,133,99,120,131,126,58,137,223,192,141,63,133,143,133,146,146,153,152,136,140,152,74,143,145,155,162,161,159,81,150,162,84,133,168,166,168,89,135,156,167,162,176,109})); return end

				local total = cfg.per * 2
				local per = cfg.per

				local known = {}
				for p in pairs(scanProps(false)) do known[p] = true end
				for p in pairs(scanProps(true)) do known[p] = true end
				local scaleF = cfg.scale / 10
				local function selectBlock()
					hide.expect = os.clock() + 1.2
					pcall(function() re2:FireServer(_obi44m9h({92,126,116,126,97,132,130,132,98,123,133,141})) end)
					pcall(function() re2:FireServer(_obi44m9h({95,115,128,133,118,133,135,125,131,125,103,138,136,138,105,125,138,131}), blockName, _obi44m9h({79,131,120,124,117,123,129,123}), nil) end)
					task.wait(0.35)
				end
				local function waitNew(seconds)
					for _ = 1, math.floor(seconds * 10) do
						task.wait(0.1)
						for p in pairs(scanProps(false)) do
							if not known[p] then return p end
						end
					end
					for p in pairs(scanProps(true)) do
						if not known[p] then return p end
					end
					return nil
				end

				for i = 1, total do
					if not alive then return end
					say(_obi44m9h({80,128,120,113,127,118,130,52,119,130,134,123,136,58}) .. i .. _obi44m9h({45,114,116,48}) .. total .. _obi44m9h({59,60,61}))
					local found
					for attempt = 1, 3 do
						local r0 = getRoot()
						if not r0 then say(_obi44m9h({93,115,129,131,128,128,116,123,122,131,55,139,142,135,132,145,75})); return end
						local ang = (i / total) * math.pi * 2 + (attempt - 1) * 0.6
						local dist = 10 + (attempt - 1) * 3
						local hit, pos = groundAt(r0.Position.X + math.cos(ang) * dist, r0.Position.Z + math.sin(ang) * dist, r0.Position.Y)
						if hit then
							selectBlock()
							pm:FireServer(hit, pos)
							found = waitNew(2.5)
							if not found and recs[#recs] then

								pcall(function()
									local rs = rem(recs[#recs], _obi44m9h({127,115,130,133,126,119}))
									if rs then rs:InvokeServer() end
								end)
								task.wait(0.4)
								selectBlock()
								pm:FireServer(hit, pos)
								found = waitNew(2.5)
							end
						end
						if found then break end
					end
					if not found then
						say(_obi44m9h({79,122,126,115,128,50}) .. i .. _obi44m9h({45,124,210,179,128,50,116,132,118,136,124,123,126,143,73,60,112,131,134,149,138,144,135,147,69,137,150,149,73,153,158,76,156,163,163,162,160,165,97}))
					else
						known[found] = true
						local rec = makeRec(found)
						recs[#recs + 1] = rec
						pcall(function() re2:FireServer(_obi44m9h({80,122,126,131,118,98,133,131,133,99,124,134,142})) end)

						if not waitRemotes(rec, 4) then say(_obi44m9h({79,122,126,115,128,50}) .. i .. _obi44m9h({71,46,129,117,126,129,135,121,136,54,123,125,134,137,141,125,143,127,140,64,130,66,149,137,149,146,144,139,138,156,89})) end

						if #recs == 1 then
							local base = sizeOf(found).X
							spacing = math.clamp(base * scaleF * 0.95, 0.5, 12)
						end

						local side = i <= per and 1 or -1
						local fi = i <= per and i or (i - per)
						local r1 = getRoot() or root0
						local cf = targetCF(r1, side, fi, per, 0)
						local okc, e2
						for _ = 1, 3 do
							okc, e2 = runCycle(rec, cf, scaleF, true)
							if okc then break end
							task.wait(0.5)
							waitRemotes(rec, 2)
						end
						if not okc then say(_obi44m9h({79,122,126,115,128,50}) .. i .. _obi44m9h({71,46}) .. tostring(e2):sub(1, 60)) end
						task.wait(0.3)
					end
				end
				pcall(function() re2:FireServer(_obi44m9h({80,122,126,131,118,98,133,131,133,99,124,134,142})) end)

				do
					local reg = {}
					for _, r in ipairs(recs) do reg[r.model] = true end
					local extra = 0
					for _, deep in ipairs({ false, true }) do
						for p in pairs(scanProps(deep)) do
							if not known[p] and not reg[p] then
								known[p] = true; reg[p] = true; extra = extra + 1
								local rec = makeRec(p)
								recs[#recs + 1] = rec
								waitRemotes(rec, 2)
							end
						end
					end
					if extra > 0 then say(extra .. _obi44m9h({45,112,123,127,116,129,59,135,62,54,124,144,141,140,124,60,130,140,147,146,130,148,132,145,69,148,136,72,138,157,140,90})) end
				end
				if #recs == 0 then return end

				local good = 0
				for pass = 1, 2 do
					good = 0
					local r1 = getRoot()
					for idx, rec in ipairs(recs) do
						if r1 and rec.model.Parent then
							local side, fi, pp = slotOf(idx, #recs)
							local cf = targetCF(r1, side, fi, pp, 0)
							local okp, p = pcall(function() return rec.model:GetPivot().Position end)
							if okp and (p - cf.Position).Magnitude < 6 then
								good = good + 1
							elseif pass == 1 then
								waitRemotes(rec, 2)
								runCycle(rec, cf, scaleF, true)
							end
						end
					end
					if good == #recs then break end
					task.wait(0.6)
				end
				say(good .. _obi44m9h({45,114,116,48}) .. #recs .. _obi44m9h({45,112,123,127,116,129,134,52,131,133,55,132,142,129,124,142,75}))
			end)
			busyBuild = false
			hide.learning = false
			if not ok then
				say(_obi44m9h({82,128,129,127,75,50}) .. tostring(err):sub(1, 70))
				hideStop()
				return
			end
			if #recs > 0 and alive then startAnim() else hideStop() end
		end)
	end

	section(page, _obi44m9h({78,129,112,48,117,119,51,118,129,133,122,135,140,58,67,108,143,141,143,64,110,131,142,137,151,79}))
	mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = _obi44m9h({80,128,120,113,49,116,127,131,120,133,138,56,125,137,59,134,140,133,142,64,130,150,149,231,198,153,71,140,142,74,161,155,144,241,217,80,150,82,153,149,175,86,156,164,158,173,91,158,158,178,164,178,97,165,178,177,180,102,188,181,170,106,172,191,174,124,111,160,195,183,182,189,200,183,119,204,190,204,123,203,125,174,209,207,209,130,176,197,208,203,217,136,206,138,209,213,208,207,225,144,225,215,229,232,228,150,219,231,153,221,227,63,32,237,173,160,213,241,231,243,248,166,253,237,238,247,171,251,0,174,241,252,0,245,2,7,195}),
		Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local nameBox = inputRow(_obi44m9h({91,125,124,117,49,118,130,52,119,130,134,123,136,58,67,140,126,130,145,227,196,145,67,102,145,149,138,147,92,83}), blockName)
	nameBox.FocusLost:Connect(function()
		local t = nameBox.Text:gsub(_obi44m9h({50,129}), _obi44m9h({}))
		if t ~= _obi44m9h({}) then blockName = t end
	end)
	sliderRow(page, _obi44m9h({79,122,126,115,128,133,51,132,132,136,55,121,140,123}), _obi44m9h({63,46,112,48,70,50,131,131,135,54,131,121,125,137}), 2, 5, 3, function(v) cfg.per = v end)
	sliderRow(page, _obi44m9h({97,111,124,113,127,122,130,52,121,133,55,122,133,137,126,139}), _obi44m9h({62,62,47,77,49,128,130,134,130,119,131,56,65,79,59,125,61,80,79,73}), 5, 20, 10, function(v) cfg.scale = v end)
	sliderRow(page, _obi44m9h({99,115,123,127,116,123,119,117,121,123,55,124,122,58,125,125,145,135,131,129}), _obi44m9h({62,46,123,117,127,134,130,52,215,205,55,73,73,58,141,223,190,142,136,132,144}), 1, 10, 5, function(v) cfg.speed = v end)
	sliderRow(page, _obi44m9h({86,124,131,117,131,136,116,128,132,54,63,133,140,67}), _obi44m9h({122,115,125,127,131,50,80,52,130,119,128,139,57,141,144,125,147,131,63,133,65,143,132,141,152,70,151,141,156,139,143,155}), 150, 600, 300, function(v) cfg.interval = v end)
	toggleRow(page, _obi44m9h({90,125,115,127,49,117,130,129,133,130,124,140,136}), _obi44m9h({80,122,120,115,114,50,129,131,53,120,131,135,124,137,59,125,61,129,128,132,130,66,133,133,153,143,139,137,87,74,111,145,160,154,152,151,166,151,83,167,154,86,167,157,172,155,173}), function(v) cfg.full = v end, true)
	toggleRow(page, _obi44m9h({82,129,114,127,127,118,120,134,53,123,123,129,220,193,222,191,140,62,131,143,148,66,133,144,148,137,150,155}), _obi44m9h({96,125,124,117,49,117,130,129,53,133,55,133,126,136,144,60,130,62,128,147,65,149,136,152,134,153,71,140,152,74,123,158,156,158,79,125,146,157,152,166}), function(v)
		cfg.hide = v
		if v then
			if animating or busyBuild then hideStart(false) end
		else
			hideStop()
		end
	end, true)
	rowBtn(page, _obi44m9h({80,128,120,113,131,50,116,135,118,54,124,56,123,123,143,129,143}), buildWing, true)
	toggleRow(page, _obi44m9h({79,111,131,117,131,50,116,135,118,137}), _obi44m9h({89,119,118,113,64,118,120,135,129,127,126,121,57,123,59,125,139,135,140,129,228,201,230,199,148}), function(v)
		if v then startAnim() else stopAnim(); say(_obi44m9h({78,124,120,125,114,213,186,215,184,133,55,136,122,140,124,128,126,76})) end
	end, true)
	rowBtn(page, _obi44m9h({95,115,127,113,131,115,133,52,119,130,134,123,136,141,59,68,143,131,133,129,155,66,146,151,69,151,156,141,73,144,148,143,142,160,144,157,81,160,162,84,152,158,250,219,168,99}), function()
		if #recs == 0 then say(_obi44m9h({80,128,120,117,49,115,51,117,136,119,55,136,139,131,136,129,134,144,142,78})); return end
		if busyBuild then say(_obi44m9h({82,129,127,117,131,119,51,117,53,121,137,129,122,221,194,223,192,141,63,148,134,148,144,141,147,135,153,86})); return end
		local was = animating
		stopAnim()
		busyBuild = true
		task.spawn(function()
			if cfg.hide then hideStart(false) end
			local root = getRoot()
			if root then
				local scaleF = cfg.scale / 10
				for idx, rec in ipairs(recs) do
					if rec.model.Parent then
						local side, i, per = slotOf(idx, #recs)
						waitRemotes(rec, 2)
						rec.heals, rec.fails, rec.stuck, rec.lastP = 0, 0, 0, nil
						local okc, e = runCycle(rec, targetCF(root, side, i, per, 0), scaleF, true)
						if not okc then say(_obi44m9h({79,122,126,115,128,50}) .. idx .. _obi44m9h({71,46}) .. tostring(e):sub(1, 60)) end
						task.wait(0.2)
					end
				end
				say(_obi44m9h({95,115,127,113,131,129,51,122,122,127,139,135,71}))
			end
			busyBuild = false
			if was and alive then startAnim() else hideStop() end
		end)
	end, true)
	rowBtn(page, _obi44m9h({80,125,127,121,114,132,51,120,126,119,126,134,220,205,142,144,134,129,142,64,133,145,150,68,135,146,150,139,152,157}), function()
		local L = { _obi44m9h({58,59,47,124,128,121,51,120,118,54,120,139,122,84}) }
		for _, s in ipairs(trace) do L[#L + 1] = s end
		local function names(inst, limit)
			local out = {}
			if inst then
				for _, c in ipairs(inst:GetChildren()) do
					if #out < (limit or 25) then out[#out + 1] = c.Name .. _obi44m9h({104}) .. c.ClassName .. _obi44m9h({106}) end
				end
			end
			return table.concat(out, _obi44m9h({57,46}))
		end
		L[#L + 1] = _obi44m9h({93,128,126,128,94,115,126,121,135,54,124,137,142,131,139,125,129,141,89,64}) .. tostring(propTool() ~= nil)
		L[#L + 1] = _obi44m9h({80,118,112,130,114,117,135,121,135,80,55}) .. names(lp.Character)
		L[#L + 1] = _obi44m9h({79,111,114,123,129,115,118,127,79,54}) .. names(lp:FindFirstChildOfClass(_obi44m9h({79,111,114,123,129,115,118,127})))
		local wc0 = workspace:FindFirstChild(_obi44m9h({100,125,129,123,132,130,116,119,122,89,134,133}))
		L[#L + 1] = _obi44m9h({93,128,126,128,93,129,118,117,137,127,134,134,140,84,59}) .. names(wc0 and wc0:FindFirstChild(_obi44m9h({93,128,126,128,93,129,118,117,137,127,134,134,140})), 20)
		L[#L + 1] = _obi44m9h({114,129,114,127,127,118,120,134,53,123,123,129,220,193,222,191,140,88,63}) .. tostring(cfg.hide) .. _obi44m9h({45,138,47,121,127,134,120,134,123,119,122,125,140,58,124,140,143,131,141,132,138,134,132,151,95,70}) .. hide.count
		do
			local nm = {}
			for g in pairs(hide.set) do
				if #nm < 15 then
					local full = g:GetFullName()
					nm[#nm + 1] = (full:gsub(_obi44m9h({107,60,60,96,125,115,140,121,135,93,140,129,62,72}), _obi44m9h({})))
				end
			end
			L[#L + 1] = _obi44m9h({118,124,131,117,131,120,116,119,122,137,55,125,140,125,138,138,129,135,131,129,148,92,67}) .. table.concat(nm, _obi44m9h({45,138,47}))
		end
		do
			local sgs = {}
			local pg = playerGui()
			if pg then
				for _, sg in ipairs(pg:GetChildren()) do
					if sg:IsA(_obi44m9h({96,113,129,117,118,128,90,137,126})) and #sgs < 70 then sgs[#sgs + 1] = sg.Name .. (sg.Enabled and _obi44m9h({}) or _obi44m9h({53,125,117,118,58})) end
				end
			end
			L[#L + 1] = _obi44m9h({93,122,112,137,118,132,90,137,126,80,55}) .. table.concat(sgs, _obi44m9h({57,46}))
		end
		L[#L + 1] = _obi44m9h({111,122,126,115,128,133,51,134,122,125,128,139,141,140,124,128,140,145,89,64}) .. #recs
		for idx, rec in ipairs(recs) do
			local kids = {}
			for _, c in ipairs(rec.model:GetChildren()) do kids[#kids + 1] = c.Name .. _obi44m9h({104}) .. c.ClassName .. _obi44m9h({106}) end
			local ok, p = pcall(function() return rec.model:GetPivot().Position end)
			L[#L + 1] = idx .. _obi44m9h({54,46}) .. rec.model:GetFullName() .. _obi44m9h({45,126,126,131,78}) .. (ok and tostring(p) or _obi44m9h({76}))
			L[#L + 1] = _obi44m9h({45,46,47,130,118,127,130,136,122,137,81,56,123,127,130,133,139,91}) .. tostring(rem(rec, _obi44m9h({111,115,118,121,127})) ~= nil) .. _obi44m9h({45,129,116,132,78}) .. tostring(rem(rec, _obi44m9h({128,115,131,115,119})) ~= nil)
				.. _obi44m9h({45,115,125,116,78}) .. tostring(rem(rec, _obi44m9h({114,124,115,128})) ~= nil) .. _obi44m9h({45,130,126,133,116,122,80}) .. tostring(touchOf(rec) ~= nil)
				.. _obi44m9h({45,138,47,118,114,126,123,117,136,83}) .. rec.fails .. _obi44m9h({45,128,116,118,118,123,135,131,136,83}) .. rec.heals .. _obi44m9h({45,115,129,130,128,79}) .. tostring(rec.lastErr)
			L[#L + 1] = _obi44m9h({45,46,47,118,122,126,123,131,136,80,55}) .. table.concat(kids, _obi44m9h({57,46}))
		end
		local wc = workspace:FindFirstChild(_obi44m9h({100,125,129,123,132,130,116,119,122,89,134,133}))
		if wc then
			L[#L + 1] = _obi44m9h({58,59,47,103,128,132,126,135,133,119,122,125,92,137,136,60,69,135,147,133,143,149,67,135,148,147,71,151,73,157,144,161,77,156,158,157,150,82,162,169,85,93,135,170,168,170,98,101,119})
			local n = 0
			for _, c in ipairs(wc:GetChildren()) do
				if n < 40 and (c.Name:find(lp.Name, 1, true) or c.Name:find(_obi44m9h({93,128,126,128}), 1, true)) then
					n = n + 1
					local kids = {}
					for _, k in ipairs(c:GetChildren()) do
						if #kids < 8 then kids[#kids + 1] = k.Name .. _obi44m9h({104}) .. k.ClassName .. _obi44m9h({106}) end
					end
					L[#L + 1] = c:GetFullName() .. _obi44m9h({45,59,77,48}) .. table.concat(kids, _obi44m9h({57,46}))
				end
			end
		end
		clip(table.concat(L, _obi44m9h({23})))
	end, true)
	rowBtn(page, _obi44m9h({93,111,129,113,131,50,120,52,136,133,131,140,122,140,59,126,137,141,130,143,148}), function()
		stopAnim()
		say(_obi44m9h({78,124,120,125,114,213,186,215,184,133,55,136,122,140,124,128,126,76,63,111,148,66,133,144,148,137,150,155,73,144,148,143,142,155,79,158,160,82,160,149,165,151,87,96,154,170,156,163,178,163,95,176,166,174,178,100,178,171,181,189,105,174,186,108,157,192,190,192,113,159,180,191,186,200,128,134}))
	end, true)

	return function()
		alive = false; animating = false; hide.on = false
		for _, c in ipairs(wconns) do pcall(function() c:Disconnect() end) end
	end
end

local HUB_START_T = os.time()
local function execName()
	local name, ver
	pcall(function() name, ver = identifyexecutor() end)
	if not name then pcall(function() name = getexecutorname() end) end
	if not name then return _obi44m9h({81,115,130,115,128,128,123,121,120,127,123,135}) end
	return tostring(name) .. (ver and (_obi44m9h({45}) .. tostring(ver)) or _obi44m9h({}))
end
local function toBase36(n)
	local chars = _obi44m9h({61,63,65,67,69,71,73,75,77,79,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126,128,130,132,134,136,138})
	local s = _obi44m9h({})
	repeat
		local r = n % 36
		s = chars:sub(r + 1, r + 1) .. s
		n = (n - r) / 36
	until n <= 0
	return s
end

local function hubId(uid)
	return _obi44m9h({81,97,60}) .. toBase36(uid) .. _obi44m9h({58}) .. toBase36((uid * 31 + 7) % 1296)
end
local function buildId(page, say)
	local function fmt(sec)
		sec = math.max(0, math.floor(sec))
		return string.format(_obi44m9h({50,62,65,116,75,55,67,70,121,80,60,72,75,126}), math.floor(sec / 3600), math.floor(sec / 60) % 60, sec % 60)
	end
	local function row(title, value)
		local f = mk(_obi44m9h({83,128,112,125,118}), { Size = UDim2.new(1, 0, 0, 46), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(f, 12); stroke(f, 1.5)
		mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = title, Size = UDim2.new(1, -24, 0, 16), Position = UDim2.fromOffset(14, 5), BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(220, 140, 140), Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left,
		}, f)
		return mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = value, Size = UDim2.new(1, -24, 0, 22), Position = UDim2.fromOffset(14, 21), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, f)
	end
	section(page, _obi44m9h({96,115,132,48,129,119,133,122,126,130,55,134,136,58,131,145,127}))
	local up = row(_obi44m9h({97,115,124,128,128,50,116,136,126,140,134}), fmt(0))
	row(_obi44m9h({91,119,114,123}), lp.DisplayName .. _obi44m9h({45,46,55,80}) .. lp.Name .. _obi44m9h({54}))
	row(_obi44m9h({82,134,116,115,134,134,130,134}), execName())
	local id = hubId(lp.UserId)
	row(_obi44m9h({86,82,47,211,203,128,124,119,132}), id)
	row(_obi44m9h({98,129,116,130,90,118,51,120,132,54,105,135,123,134,138,148}), tostring(lp.UserId))
	rowBtn(page, _obi44m9h({80,125,127,121,114,132,51,129,122,139,55,97,93}), function()
		local f = setclipboard or toclipboard
		if not f then say(_obi44m9h({96,115,132,48,118,138,120,119,138,138,134,138,57,136,222,191,140,62,147,133,142,66,150,137,153,137,147,145,153,140,154,141,159,146,93,80,132,151,168,84,126,122,113,88}) .. id); return end
		say(pcall(f, id) and (_obi44m9h({86,82,47,115,128,130,124,117,121,133,81,56}) .. id) or _obi44m9h({83,111,123,120,128,135,51,117,132,54,122,135,137,131,124,142,75}))
	end)
	task.spawn(function()
		while page.Parent do
			up.Text = fmt(os.time() - HUB_START_T)
			task.wait(1)
		end
	end)
end

local AVATAR = {
	wear = function(kind, id)
		local folder = game:GetService(_obi44m9h({95,115,127,124,122,117,116,136,122,122,106,140,136,140,124,131,130})):FindFirstChild(_obi44m9h({95,115,124,127,133,119,134}))
		local r = folder and folder:FindFirstChild(_obi44m9h({100,115,112,130}))
		if not r then error(_obi44m9h({127,115,124,127,133,119,51,107,122,119,137,56,135,221,190,139,61,131,141,131,144,144,151,150,134,138,150})) end
		return r:InvokeServer(id, nil)
	end,
}
local function buildAvatar(page, say)
	local target
	local items = {}
	local BODY = { Head = true, Torso = true, LeftArm = true, RightArm = true, LeftLeg = true, RightLeg = true }
	local COLOR_KEYS = { _obi44m9h({85,115,112,116,84,129,127,131,135}), _obi44m9h({97,125,129,131,128,85,130,128,132,136}), _obi44m9h({89,115,117,132,82,132,128,87,132,130,134,138}), _obi44m9h({95,119,118,120,133,83,133,129,88,133,131,135,139}), _obi44m9h({89,115,117,132,93,119,122,87,132,130,134,138}), _obi44m9h({95,119,118,120,133,94,120,123,88,133,131,135,139}) }
	local SCALE_KEYS = { _obi44m9h({85,115,120,119,121,134,102,119,118,130,124}), _obi44m9h({100,119,115,132,121,101,118,117,129,123}), _obi44m9h({81,115,127,132,121,101,118,117,129,123}), _obi44m9h({85,115,112,116,100,117,116,128,122}), _obi44m9h({79,125,115,137,101,139,131,121,104,121,120,132,126}), _obi44m9h({93,128,126,128,128,132,135,125,132,132,106,123,122,134,128}) }
	local targetEx

	local alog = { lines = {}, view = nil, t0 = os.clock() }
	local function logLine(text)
		local line = string.format(_obi44m9h({104,51,68,62,66,120,134,113,53,59,138}), os.clock() - alog.t0, text)
		alog.lines[#alog.lines + 1] = line
		if #alog.lines > 400 then table.remove(alog.lines, 1) end
		if alog.view and alog.view.Parent then
			local bad = text:find(_obi44m9h({83,79,91,88,96,103}), 1, true) or text:find(_obi44m9h({83,79,91,100,96,103}), 1, true) or text:find(_obi44m9h({91,209,146,95,49,101,84,93,106}), 1, true)
			mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
				Text = line, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
				TextColor3 = bad and Color3.fromRGB(255, 140, 140) or WHITE, Font = Enum.Font.Code, TextSize = 11,
				TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = #alog.lines,
			}, alog.view)
			local kids = {}
			for _, c in ipairs(alog.view:GetChildren()) do
				if c:IsA(_obi44m9h({97,115,135,132,93,115,117,121,129})) then kids[#kids + 1] = c end
			end
			if #kids > 150 then kids[1]:Destroy() end
		end
	end
	local function ser(v)
		local ok, s = pcall(HUBLOG.ser, v)
		return ok and tostring(s) or tostring(v)
	end

	local function note(text, h)
		return mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
			Text = text, Size = UDim2.new(1, 0, 0, h or 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
			Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end

	local function readAvatar(pl)
		local h = pl.Character and pl.Character:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120}))
		if not h then return nil, _obi44m9h({124,46,121,127,120,115,119,131,135,54,124,139,141,221,188,60,144,131,140,64,145,135,149,151,148,148,136,143,142,151}) end
		local ok, d = pcall(function() return h:GetAppliedDescription() end)
		if not ok or not d then return nil, _obi44m9h({123,209,178,127,49,117,130,130,136,123,126,141,130,58,135,129,143,62,142,64,130,152,132,152,134,152,71,140,142,150,144}) end
		local out = {}
		local function add(kind, id)
			id = tonumber(id)
			if id and id > 0 then out[#out + 1] = { kind = kind, id = math.floor(id) } end
		end
		local okA, acc = pcall(function() return d:GetAccessories(true) end)
		if okA and type(acc) == _obi44m9h({129,111,113,124,118}) then
			for _, a in ipairs(acc) do add((tostring(a.AccessoryType):gsub(_obi44m9h({107,83,125,133,126,55,65,85,120,121,124,139,140,137,141,149,113,151,143,133,70,80}), _obi44m9h({}))), a.AssetId) end
		end
		for _, k in ipairs({ _obi44m9h({96,118,120,130,133}), _obi44m9h({93,111,125,132,132}), _obi44m9h({84,128,112,128,121,123,118,104,104,126,128,138,141}), _obi44m9h({83,111,114,117}), _obi44m9h({85,115,112,116}), _obi44m9h({97,125,129,131,128}), _obi44m9h({89,115,117,132,82,132,128}), _obi44m9h({95,119,118,120,133,83,133,129}), _obi44m9h({89,115,117,132,93,119,122}), _obi44m9h({95,119,118,120,133,94,120,123}) }) do
			local okP, v = pcall(function() return d[k] end)
			if okP then add(k, v) end
		end
		local ex = { colors = {}, scales = {}, zero = {} }
		for _, k in ipairs(COLOR_KEYS) do
			local okC, c = pcall(function() return d[k] end)
			if okC and typeof(c) == _obi44m9h({80,125,123,127,131,69}) then ex.colors[k] = c end
		end
		for _, k in ipairs(SCALE_KEYS) do
			local okS, v = pcall(function() return d[k] end)
			if okS and type(v) == _obi44m9h({123,131,124,114,118,132}) then ex.scales[k] = v end
		end
		for k in pairs(BODY) do
			local okZ, v = pcall(function() return d[k] end)
			if okZ and (tonumber(v) or 0) <= 0 then ex.zero[#ex.zero + 1] = k end
		end
		table.sort(ex.zero)
		return out, nil, ex
	end
	local function fmtColor(c)
		return string.format(_obi44m9h({127,117,113,56,54,118,63,57,121,66,60,124,66}), math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
	end
	local function sameColor(a, b)
		return math.abs(a.R - b.R) < 0.012 and math.abs(a.G - b.G) < 0.012 and math.abs(a.B - b.B) < 0.012
	end
	local function logExtra(prefix, ex)
		if not ex then return end
		local cs, ss = {}, {}
		for _, k in ipairs(COLOR_KEYS) do
			if ex.colors[k] then cs[#cs + 1] = (k:gsub(_obi44m9h({80,125,123,127,131,54}), _obi44m9h({}))) .. _obi44m9h({74}) .. fmtColor(ex.colors[k]) end
		end
		for _, k in ipairs(SCALE_KEYS) do
			if ex.scales[k] then ss[#ss + 1] = (k:gsub(_obi44m9h({96,113,112,124,118,54}), _obi44m9h({}))) .. _obi44m9h({74}) .. string.format(_obi44m9h({50,60,65,118}), ex.scales[k]) end
		end
		logLine(prefix .. _obi44m9h({80,125,129,117,132,76,51}) .. (#cs > 0 and table.concat(cs, _obi44m9h({45})) or _obi44m9h({76})))
		logLine(prefix .. _obi44m9h({93,128,126,128,128,132,214,187,216,203,124,139,83,58}) .. (#ss > 0 and table.concat(ss, _obi44m9h({45})) or _obi44m9h({76})))
		logLine(prefix .. _obi44m9h({93,111,129,132,118,133,51,120,132,54,122,135,139,138,138,60,144,131,140,64,138,150,136,145,69,78,151,137,141,156,238,207,156,78,147,159,81,156,162,155,164,95,113,88}) .. (#ex.zero > 0 and table.concat(ex.zero, _obi44m9h({57,46})) or _obi44m9h({123,115,125,120,134,127,116})))
	end

	local function compareExtra(theirs, mine)
		local n = 0
		for _, k in ipairs(COLOR_KEYS) do
			local a, b = theirs.colors[k], mine.colors[k]
			if a and b and not sameColor(a, b) then
				n = n + 1
				logLine(_obi44m9h({81,87,85,85,99,87,97,104,90,54}) .. k .. _obi44m9h({71,46,115,117,125,119,51}) .. fmtColor(a) .. _obi44m9h({45,61,47,131,118,135,51}) .. fmtColor(b))
			end
		end
		for _, k in ipairs(SCALE_KEYS) do
			local a, b = theirs.scales[k], mine.scales[k]
			if a and b and math.abs(a - b) > 0.01 then
				n = n + 1
				logLine(string.format(_obi44m9h({81,87,85,85,99,87,97,104,90,54,60,139,83,58,127,129,137,131,63,69,79,84,137,68,84,70,154,141,158,74,80,90,95,148}), k, a, b))
			end
		end
		return n
	end

	section(page, _obi44m9h({80,125,127,121,114,132,51,117,139,119,139,121,139,58,127,139,61,96,145,143,144,141,139,133,155,139,149}))
	note(_obi44m9h({80,125,127,121,114,50,130,135,53,127,139,125,135,141,59,141,146,131,63,129,65,146,136,151,152,149,136,72,142,157,159,239,206,78,164,163,146,160,151,163,85,166,169,167,89,173,160,177,93,159,181,161,181,163,181,100,169,181,103,138,187,185,186,183,181,175,197,181,191,128,115,167,24,9,119,206,190,205,207,193,125,205,127,209,214,199,131,218,212,201,42,18,137,212,46,13,141,226,212,221,172,146,226,148,221,235,217,152,231,61,30,235,157,225,238,237,241,244,228,164,243,231,235,233,183}), 44)
	local ddA
	ddA = dropdown(page, _obi44m9h({82,129,114,127,125,122,120,134,53,128,134,127,122,126,138,142,61,70,141,133,143,138,152,145,78}), function()
		local t = {}
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl ~= lp then
				table.insert(t, { label = pl.DisplayName .. _obi44m9h({45,46,55,80}) .. pl.Name .. _obi44m9h({54}), value = pl, name = pl.DisplayName })
			end
		end
		table.sort(t, function(a, b) return a.label:lower() < b.label:lower() end)
		return t
	end, function(it)
		target = it.value
		ddA.setText(_obi44m9h({87,125,118,113,117,129,133,78,53}) .. it.name)
	end)
	local summary = note(_obi44m9h({91,115,125,120,134,127,51,117,139,119,139,121,139,58,135,133,129,141,63,129,138,144,135,133,83}), 34)
	rowBtn(page, _obi44m9h({89,115,129,48,114,136,116,136,118,136,55,124,136,58,133,139,132,127,131,143,147}), function()
		if not target or not target.Parent then say(_obi44m9h({82,129,114,127,125,122,116,52,138,131,55,130,136,129,124,128,140,144,63,144,147,139,144,137,142,152,150,86})); return end
		local list, err, ex = readAvatar(target)
		if not list then logLine(_obi44m9h({83,79,91,88,96,103,51,117,132,54,131,125,139,58}) .. target.Name .. _obi44m9h({71,46}) .. tostring(err)); say(_obi44m9h({83,111,123,120,128,135,77,52}) .. tostring(err)); return end
		items = list
		local counts, order = {}, {}
		for _, it in ipairs(items) do
			if not counts[it.kind] then counts[it.kind] = 0; order[#order + 1] = it.kind end
			counts[it.kind] = counts[it.kind] + 1
		end
		local parts = {}
		for _, k in ipairs(order) do parts[#parts + 1] = k .. _obi44m9h({45}) .. counts[k] end
		summary.Text = _obi44m9h({86,130,116,126,132,50,127,125,121,133,138,56,125,127,59}) .. target.DisplayName .. _obi44m9h({71,46}) .. #items .. (#items > 0 and (_obi44m9h({45,54}) .. table.concat(parts, _obi44m9h({57,46})) .. _obi44m9h({54})) or _obi44m9h({}))
		logLine(_obi44m9h({89,87,47,113,135,115,135,117,135,54,123,125,57}) .. target.DisplayName .. _obi44m9h({45,54,79}) .. target.Name .. _obi44m9h({54,72,47}) .. #items .. _obi44m9h({45,119,131,117,127,133}))
		for _, it in ipairs(items) do logLine(_obi44m9h({45,46,47}) .. it.kind .. _obi44m9h({71,46}) .. it.id) end
		targetEx = ex
		logExtra(_obi44m9h({45,46,47}), ex)
		say(#items .. _obi44m9h({45,119,131,117,127,133,51,128,126,122,134,139,71}))
	end)

	local function wornSet()
		local set, list = {}, readAvatar(lp) or {}
		for _, it in ipairs(list) do set[it.id] = it end
		return set, list
	end
	local SLOT = { Shirt = true, Pants = true, GraphicTShirt = true, Face = true }

	local fixed = { [8907830203] = true, [88270342307378] = true }

	local lastWear = 0
	local refusedWhy = {}
	local function toggle(it, action)
		for attempt = 1, 3 do
			local gap = 1.0 - (os.clock() - lastWear)
			if gap > 0 then task.wait(gap) end

			local ok, res, msg = pcall(AVATAR.wear, it.kind, it.id)
			lastWear = os.clock()
			local good = ok and res ~= false
			local shown = (ok and (ser(res) .. (msg ~= nil and (_obi44m9h({57,46}) .. ser(msg)) or _obi44m9h({}))) or (_obi44m9h({114,128,129,127,75,50}) .. tostring(res))):sub(1, 70)
			logLine((good and _obi44m9h({}) or _obi44m9h({83,79,91,88,96,103,51})) .. action .. _obi44m9h({45}) .. it.kind .. _obi44m9h({45}) .. it.id .. _obi44m9h({45,59,77,48}) .. shown
				.. (attempt > 1 and (_obi44m9h({45,46,55,132,118,128,135,117,137,127,141,121,57}) .. attempt .. _obi44m9h({54})) or _obi44m9h({})))
			if good then return true end
			if ok and msg ~= nil then refusedWhy[it.id] = tostring(msg) end
			if msg == _obi44m9h({86,124,133,113,125,123,119,52,94,90}) then break end
		end
		return false
	end

	local function removeWorn(keep, action, targetKinds)
		local _, list = wornSet()
		local n = 0
		for _, it in ipairs(list) do
			local replaced = SLOT[it.kind] and targetKinds and targetKinds[it.kind]
			if not BODY[it.kind] and not replaced and not (keep and keep[it.id]) and not fixed[it.id] then
				if toggle(it, action or _obi44m9h({97,87,97,81,99})) then n = n + 1 end
			end
		end
		return n
	end
	local busy = false
	local function run(fn)
		if busy then say(_obi44m9h({87,209,176,48,118,133,135,215,182,54,137,135,125,123,137,128,140,74,63,133,148,146,136,150,134,70,155,141,155,151,148,154,142,160,93})); return end
		busy = true
		task.spawn(function()
			local ok, err = pcall(fn)
			busy = false
			if not ok then logLine(_obi44m9h({83,79,91,88,96,103,77,52}) .. tostring(err)); say(_obi44m9h({83,111,123,120,128,135,77,52}) .. tostring(err):sub(1, 60)) end
		end)
	end

	local function stableWorn()
		local a = wornSet()
		task.wait(1.5)
		local b = wornSet()
		local both, either = {}, {}
		for id, it in pairs(a) do either[id] = it; if b[id] then both[id] = it end end
		for id, it in pairs(b) do either[id] = it end
		return both, either
	end

	local function strip(keep, targetKinds)
		local removed = removeWorn(keep, _obi44m9h({97,87,97,81,99}), targetKinds)
		for pass = 1, 2 do
			task.wait(2)
			local both = stableWorn()
			local left = {}
			for id, it in pairs(both) do
				local replaced = SLOT[it.kind] and targetKinds and targetKinds[it.kind]
				if not BODY[it.kind] and not replaced and not (keep and keep[id]) and not fixed[id] then left[#left + 1] = it end
			end
			if #left == 0 then break end
			if pass == 2 then
				for _, it in ipairs(left) do
					fixed[it.id] = true
					logLine(_obi44m9h({83,87,103,95,49,58,118,131,131,138,128,134,142,123,59,137,130,145,140,143,65,150,140,150,134,148,139,151,100,74,143,145,163,147,79,163,150,164,83,164,150,154,169,251,220,169,91,160,172,94,169,175,168,177,108,126,101}) .. it.kind .. _obi44m9h({45}) .. it.id)
				end
				break
			end
			logLine(_obi44m9h({91,209,146,95,49,101,84,93,106,54}) .. #left .. _obi44m9h({45,119,131,117,126,58,129,135,62,66,55,140,126,136,143,125,139,130,142,64,133,135,67,146,148,156,150,72,81,156,154,144,142,146,144,80}) .. pass .. _obi44m9h({54}))
			for _, it in ipairs(left) do
				if toggle(it, _obi44m9h({97,87,97,81,99,50,59,120,122,54,133,135,143,137,68})) then removed = removed + 1 end
			end
		end
		return removed
	end

	local ANIM = { orig = {}, applied = nil, tested = {} }
	local function animateOf(char) return char and char:FindFirstChild(_obi44m9h({78,124,120,125,114,134,120})) end
	local function animKey(d) return d.Parent.Name .. _obi44m9h({60}) .. d.Name end
	local function rigOf(char)
		local h = char and char:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120}))
		return h and h.RigType
	end
	local function readAnims(pl)
		local char = pl.Character
		local ids, n = {}, 0
		local an = animateOf(char)
		if an then
			for _, d in ipairs(an:GetDescendants()) do
				if d:IsA(_obi44m9h({78,124,120,125,114,134,124,131,131})) and d.AnimationId ~= _obi44m9h({}) then ids[animKey(d)] = d.AnimationId; n = n + 1 end
			end
		end
		if n > 0 then return ids, n end

		local h = char and char:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120}))
		local ok, d = pcall(function() return h and h:GetAppliedDescription() end)
		if not ok or not d then return nil, _obi44m9h({123,209,178,127,49,117,130,130,136,123,126,141,130,58,135,129,143,62,128,64,130,144,140,145,134,233,206,235,204,153,75,144,146,154,148}) end
		local map = {
			IdleAnimation = { _obi44m9h({118,114,123,117,64,83,129,125,130,119,139,129,136,136,76}), _obi44m9h({118,114,123,117,64,83,129,125,130,119,139,129,136,136,77}) }, WalkAnimation = { _obi44m9h({132,111,123,123,64,105,116,128,128,87,133,129,134}) },
			RunAnimation = { _obi44m9h({127,131,125,63,99,135,129,85,131,127,132}) }, JumpAnimation = { _obi44m9h({119,131,124,128,64,92,136,129,133,87,133,129,134}) }, FallAnimation = { _obi44m9h({115,111,123,124,64,88,116,128,129,87,133,129,134}) },
			ClimbAnimation = { _obi44m9h({112,122,120,125,115,65,86,128,126,131,121,89,135,131,136}) }, SwimAnimation = { _obi44m9h({128,133,120,125,64,101,138,125,130}), _obi44m9h({128,133,120,125,122,118,127,121,68,105,142,129,134,99,127,136,130}) },
		}
		for field, keys in pairs(map) do
			local okF, v = pcall(function() return d[field] end)
			v = okF and tonumber(v) or 0
			if v and v > 0 then
				for _, k in ipairs(keys) do ids[k] = _obi44m9h({117,130,131,128,75,65,66,139,140,141,69,138,136,124,135,139,149,76,130,143,142,81,132,151,152,139,155,87,104,147,143,105}) .. math.floor(v); n = n + 1 end
			end
		end
		if n == 0 then return nil, _obi44m9h({114,122,116,48,118,133,135,215,182,54,122,135,134,58,124,60,126,140,136,141,130,229,202,231,200,149,71,152,138,142,157,239,208,157,79,88,159,147,151,149,85,166,169,153,89,157,170,172,166,159,177,105}) end
		return ids, n
	end
	local function reloadAnimate(char)
		local an, hum = animateOf(char), char and char:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120}))
		if not (an and hum) then return end
		pcall(function()
			an.Disabled = true
			local animator = hum:FindFirstChildOfClass(_obi44m9h({78,124,120,125,114,134,130,134}))
			for _, tr in ipairs((animator or hum):GetPlayingAnimationTracks()) do tr:Stop(0) end
			task.wait(0.1)
		end)
		pcall(function() an.Disabled = false end)
	end
	local function applyAnims(ids)
		local char = lp.Character
		local an = animateOf(char)
		if not an then return false, _obi44m9h({128,115,132,48,129,119,133,135,132,132,120,127,126,135,59,129,144,146,226,193,65,149,136,145,69,149,71,155,140,156,148,156,161,78,112,158,154,159,148,168,154}) end
		local n = 0
		for _, d in ipairs(an:GetDescendants()) do
			if d:IsA(_obi44m9h({78,124,120,125,114,134,124,131,131})) then
				local key = animKey(d)
				local id = ids[key]
				if id and d.AnimationId ~= id then
					if ANIM.orig[key] == nil then ANIM.orig[key] = d.AnimationId end
					d.AnimationId = id
					n = n + 1
				end
			end
		end
		if n > 0 then reloadAnimate(char) end
		return true, n
	end
	local function restoreAnims()
		ANIM.applied = nil
		local an = animateOf(lp.Character)
		if an then
			for _, d in ipairs(an:GetDescendants()) do
				if d:IsA(_obi44m9h({78,124,120,125,114,134,124,131,131})) then
					local o = ANIM.orig[animKey(d)]
					if o then d.AnimationId = o end
				end
			end
			reloadAnimate(lp.Character)
		end
		ANIM.orig = {}
	end

	local function assetNum(id)
		return tostring(id):match(_obi44m9h({50,114,58})) or tostring(id)
	end

	local function canLoadAnim(animId)
		local char = lp.Character
		local h = char and char:FindFirstChildOfClass(_obi44m9h({85,131,124,113,127,129,124,120}))
		local animator = h and h:FindFirstChildOfClass(_obi44m9h({78,124,120,125,114,134,130,134}))
		if not animator then return nil end
		local a = Instance.new(_obi44m9h({78,124,120,125,114,134,124,131,131}))
		a.AnimationId = animId
		local ok, track = pcall(function() return animator:LoadAnimation(a) end)
		local loaded = false
		if ok and track then
			local t = 0
			while t < 1.5 do
				if track.Length > 0 then loaded = true; break end
				task.wait(0.05)
				t = t + 0.05
			end
			pcall(function() track:Destroy() end)
		end
		a:Destroy()
		return loaded
	end
	local function copyAnim(pl)
		if not pl or not pl.Parent then return false, _obi44m9h({114,129,114,127,125,122,116,52,138,131,55,130,136,129,124,128,140,144,63,144,147,139,144,137,142,152,150}) end
		local mine, theirs = rigOf(lp.Character), rigOf(pl.Character)
		if mine and theirs and mine ~= theirs then return false, _obi44m9h({127,119,118,48,117,123,121,121,135,123,133,140,126,58,67,110,83,77,113,81,86,75,93,68,134,70,136,150,146,151,140,239,212,241,210,159,81,150,152,160,154,86,165,251,220,169,91,162,178,172,162,169,176,176,164,100,179,181,103,187,174,191}) end
		local ids, n = readAnims(pl)
		if not ids then return false, n end
		local an = animateOf(lp.Character)
		if not an then return false, _obi44m9h({128,115,132,48,129,119,133,135,132,132,120,127,126,135,59,129,144,146,226,193,65,149,136,145,69,149,71,155,140,156,148,156,161,78,112,158,154,159,148,168,154}) end

		local keys, mineIds = {}, {}
		for k in pairs(ids) do keys[#keys + 1] = k end
		table.sort(keys)
		for _, d in ipairs(an:GetDescendants()) do
			if d:IsA(_obi44m9h({78,124,120,125,114,134,124,131,131})) then mineIds[animKey(d)] = d.AnimationId end
		end

		local results, started, pending = {}, {}, 0
		for _, k in ipairs(keys) do
			local id = ids[k]
			if mineIds[k] and mineIds[k] ~= id and not started[id] then
				started[id] = true
				if ANIM.tested[id] ~= nil then
					results[id] = ANIM.tested[id]
				else
					pending = pending + 1
					task.spawn(function()
						local r = canLoadAnim(id)
						results[id] = r
						if r ~= nil then ANIM.tested[id] = r end
						pending = pending - 1
					end)
				end
			end
		end
		local t0 = os.clock()
		while pending > 0 and os.clock() - t0 < 8 do task.wait(0.1) end

		local good, bad, same, onlyTheirs = {}, 0, 0, 0
		for _, k in ipairs(keys) do
			local id = ids[k]
			local label = k .. _obi44m9h({71,46,115,117,125,119,51}) .. assetNum(id)
			if not mineIds[k] then
				onlyTheirs = onlyTheirs + 1
				logLine(_obi44m9h({78,92,88,93,49}) .. label .. _obi44m9h({45,208,198,48,135,129,118,215,191,54,133,219,188,137,59,144,130,139,63,133,148,149,136,68,138,153,155,137,141,153,75,84,155,241,210,159,81,150,246,213,85,166,169,153,89,155,171,168,166,161,160,178,106}))
			elseif mineIds[k] == id then
				same = same + 1
				logLine(_obi44m9h({78,92,88,93,49}) .. label .. _obi44m9h({45,208,198,48,122,121,136,117,129,54,218,184,57,141,144,125}))
			else
				local r = results[id]
				if r == false then
					bad = bad + 1
					logLine(_obi44m9h({78,92,88,93,49}) .. label .. _obi44m9h({45,208,198,48,132,119,136,52}) .. assetNum(mineIds[k]) .. _obi44m9h({45,208,198,48,95,213,150,99,53,106,102,91,90,58,67,139,61,136,142,135,144,66,145,231,200,149,71,139,138,156,157,145,148,157,164,89,108,82,160,149,163,170,160,174,158,90,156,92,176,179,160}))
				else
					good[k] = id
					logLine(_obi44m9h({78,92,88,93,49}) .. label .. _obi44m9h({45,208,198,48,132,119,136,52}) .. assetNum(mineIds[k]) .. _obi44m9h({45,208,198,48,101,100,98,87,86,90,88}) .. (r == nil and _obi44m9h({45,54,125,211,180,129,51,119,132,132,138,125,128,143,132,60,145,131,146,148,130,148,76}) or _obi44m9h({45,54,131,117,132,134,116,120,118,66,55,123,122,140,141,129,132,127,72})))
				end
			end
		end
		local ok, res = applyAnims(good)
		if not ok then return false, res end
		ANIM.applied = good
		logLine(_obi44m9h({78,92,88,93,82,213,154,215,152,101,55,124,126,58}) .. pl.DisplayName .. _obi44m9h({71,46}) .. n .. _obi44m9h({45,119,115,131,49,126,124,120,132,137,55,218,208,58}) .. res .. _obi44m9h({45,130,129,127,116,115,119,131,136,54,217,207,57}) .. same .. _obi44m9h({45,119,118,133,114,123,134,52,215,205,55}) .. bad .. _obi44m9h({45,124,210,179,128,50,135,131,120,119,132,56,219,209,59}) .. onlyTheirs .. _obi44m9h({45,129,210,195,49,118,120,128,122}))
		return true, _obi44m9h({110,124,120,125,114,213,186,215,184,133,55,123,136,138,132,125,129,127,63,72}) .. res .. _obi44m9h({45,130,129,127,116,115,119,117,136}) .. (bad > 0 and (_obi44m9h({57,46}) .. bad .. _obi44m9h({45,124,210,179,128,50,135,131,120,119,132,56,126,58,129,133,128,127,145,129,142,66,132,151,69,153,156,137,156})) or _obi44m9h({})) .. _obi44m9h({54})
	end

	table.insert(conns, lp.CharacterAdded:Connect(function(char)
		if not ANIM.applied then return end
		task.spawn(function()
			if not char:WaitForChild(_obi44m9h({78,124,120,125,114,134,120}), 10) then return end
			task.wait(1.5)
			if ANIM.applied then pcall(applyAnims, ANIM.applied) end
		end)
	end))

	local viaHub = {}
	local function hubRemoveAll()
		if not MINE.ids then return end
		local keepIds = {}
		for _, id in ipairs(MINE.ids) do
			if not viaHub[tostring(id)] then keepIds[#keepIds + 1] = id end
		end
		MINE.ids = keepIds
		viaHub = {}
		if MINE.onList then MINE.onList() end
		if publishMods then publishMods() end
	end
	local function hubAdd(it)
		MINE.ids = MINE.ids or {}
		local s = tostring(it.id)
		for _, id in ipairs(MINE.ids) do
			if tostring(id) == s then return false end
		end
		table.insert(MINE.ids, s)
		viaHub[s] = true
		return true
	end

	local withAnim = true
	toggleRow(page, _obi44m9h({80,125,127,121,114,132,51,136,118,131,121,219,194,135,59,125,61,127,141,137,142,131,230,203,232,201,150}), _obi44m9h({93,111,129,113,117,129,63,52,118,132,123,121,139,70,59,127,140,144,145,133,147,78,67,148,154,146,136,154,85,74,142,141,150,160,91,80,150,165,150,149,161,151,169,88,158,90,169,157,161,159,177}), function(v) withAnim = v end, true)
	local defaultBody = true
	toggleRow(page, _obi44m9h({86,117,132,113,125,115,133,52,133,119,137,140,126,141,59,128,140,62,130,143,147,146,146,68,149,135,139,154,236,205,154}), _obi44m9h({96,115,47,127,49,115,127,138,132,54,140,139,122,58,139,129,143,140,128,79,131,148,132,231,204,149,71,152,138,142,157,239,208,157,91,80,165,155,165,149,85,165,87,171,158,175,91,172,162,176,178,175,175,163,175,173,191,167,171,183}), function(v) defaultBody = v end, true)
	rowBtn(page, _obi44m9h({80,125,127,121,114,132,51,117,139,119,139,121,139,58,139,142,126,62,140,137,142}), function()
		if #items == 0 then say(_obi44m9h({89,115,120,113,49,129,51,117,139,119,139,121,139,58,127,129,61,147,140,64,139,145,138,133,137,149,153,72,153,156,148,153,146,151,161,159,95})); return end
		run(function()
			logLine(_obi44m9h({74,75,76,48,84,97,99,93,86,104,55,121,143,123,143,125,143,62,131,133,65}) .. (target and target.DisplayName or _obi44m9h({76})) .. _obi44m9h({45,54}) .. #items .. _obi44m9h({45,119,131,117,127,133,60,52,82,83,84}))
			local wornBefore, before = wornSet()
			logLine(_obi44m9h({90,115,132,48,114,136,116,136,118,136,55,121,135,142,128,143,87,62}) .. #before .. _obi44m9h({45,119,131,117,127,133}))
			for _, it in ipairs(before) do logLine(_obi44m9h({45,46,47,107,114,128,135,121,136,115,55}) .. it.kind .. _obi44m9h({71,46}) .. it.id) end
			local keep, kinds = {}, {}
			for _, it in ipairs(items) do keep[it.id] = true; kinds[it.kind] = true end

			say(_obi44m9h({62,61,66,48,101,123,133,117,131,122,134,56,141,143,127,139,61,143,148,133,65,152,146,135,232,208,71,141,156,158,238,205,77,163,162,145,159,150,162,84,93,162,156,174,154,90,176,170,176,94,178,165,168,183,177,168,180,185,112,118,119,120}))
			hubRemoveAll()
			local removed = strip(keep, nil)

			say(_obi44m9h({63,61,66,48,103,119,134,136,126,132,123,135,57,137,59,125,147,127,147,129,147,66,134,147,149,143,136,140,152,88,89,90}))
			local done, skipped, failed, refused = 0, 0, {}, {}
			for _, it in ipairs(items) do
				if wornBefore[it.id] then
					skipped = skipped + 1
					logLine(_obi44m9h({87,209,144,48,86,101,103,85,107,87,55}) .. it.kind .. _obi44m9h({45}) .. it.id)
				elseif toggle(it, _obi44m9h({99,83,98,100,90,100})) then
					done = done + 1
				else
					failed[#failed + 1] = it.kind
					refused[it.id] = true
				end
			end

			if defaultBody and targetEx then
				local isDefault = {}
				for _, k in ipairs(targetEx.zero) do isDefault[k] = true end
				local nowWorn = wornSet()
				for _, it in ipairs(before) do
					if BODY[it.kind] and isDefault[it.kind] and nowWorn[it.id] then
						say(_obi44m9h({63,61,66,48,101,123,133,117,131,122,134,56,140,143,124,60}) .. it.kind .. _obi44m9h({45,54,126,48,114,126,137,131,53,139,138,121,57,123,59,140,126,130,145,227,196,145,76,82,83,84}))
						if toggle(it, _obi44m9h({97,87,97,81,99,50,59,132,118,136,139,125,57,138,124,128,143,225,194,143,65,134,146,68,134,146,157,151,82})) then
							logLine(_obi44m9h({93,79,97,100,86,50,99,85,89,104,218,155,104,58}) .. it.kind .. _obi44m9h({71,46,131,121,131,119,124,52,118,54,138,141,122,58}) .. it.id .. _obi44m9h({45,126,129,113,49,120,124,119,118,136,55,129,128,143,124,136,61,127,142,64,130,142,153,147}))
						end
					end
				end
			end

			say(_obi44m9h({64,61,66,48,84,129,129,122,122,136,128,134,125,137,73,74,75}))
			local missing, stuck = 0, 0
			for pass = 1, 3 do
				task.wait(2)
				local both, either = stableWorn()
				local miss, left = {}, {}
				for _, it in ipairs(items) do
					if not either[it.id] then miss[#miss + 1] = it end
				end
				for _, it in ipairs(before) do
					if not BODY[it.kind] and not keep[it.id] and both[it.id] and not fixed[it.id] then
						left[#left + 1] = it
					end
				end
				missing, stuck = #miss, #left
				if missing == 0 and stuck == 0 then break end
				if pass == 3 then
					for _, it in ipairs(miss) do logLine(_obi44m9h({83,79,91,100,96,103,51}) .. it.kind .. _obi44m9h({45}) .. it.id .. (refused[it.id] and (_obi44m9h({45,54,126,48,123,129,122,131,53,136,124,139,137,137,137,128,130,147,89,64}) .. tostring(refusedWhy[it.id] or _obi44m9h({127,115,114,133,132,129,136})) .. _obi44m9h({54})) or _obi44m9h({}))) end
					for _, it in ipairs(left) do logLine(_obi44m9h({91,209,146,95,49,101,84,93,106,54}) .. it.kind .. _obi44m9h({45}) .. it.id) end
					break
				end
				say(_obi44m9h({64,61,66,48,84,129,133,134,126,125,128,134,125,137,59,139,61,143,148,133,65,136,132,144,153,149,156,72,81,156,154,144,142,146,144,80}) .. pass .. _obi44m9h({54,60,61,62}))
				for _, it in ipairs(left) do toggle(it, _obi44m9h({97,87,97,81,99,50,59,119,132,136,137,129,128,131,137,128,140,71})) end
				for _, it in ipairs(miss) do
					if not refused[it.id] then
						if toggle(it, _obi44m9h({99,83,98,100,90,100,51,60,120,133,137,138,130,129,132,138,129,141,72})) then done = done + 1 end
					end
				end
			end

			local diffN = 0
			if targetEx then
				task.wait(1)
				local _, _, mineEx = readAvatar(lp)
				if mineEx then
					logExtra(_obi44m9h({45,46,47,107,132,119,136,52,118,125,134,138,122,119,59}), mineEx)
					diffN = compareExtra(targetEx, mineEx)
				end
			end

			local viaN = 0
			for _, it in ipairs(items) do
				if refused[it.id] and not BODY[it.kind] and hubAdd(it) then
					viaN = viaN + 1
					logLine(_obi44m9h({99,87,80,48,89,103,85,52}) .. it.kind .. _obi44m9h({45}) .. it.id)
				end
			end
			if viaN > 0 then
				if MINE.onList then MINE.onList() end
				if publishMods then publishMods() end
			end
			local msg = _obi44m9h({97,119,129,113,117,129,134,78,53}) .. removed .. _obi44m9h({45,208,198,48,84,129,127,131,120,119,123,135,140,84,59}) .. done .. _obi44m9h({45,208,198,48,123,213,180,52,122,137,139,121,143,123,136,86,61}) .. skipped
			if viaN > 0 then
				local why
				for _, w in pairs(refusedWhy) do why = w; break end
				msg = msg .. _obi44m9h({45,208,198,48}) .. viaN .. _obi44m9h({45,129,210,195,49,130,120,128,132,54,127,141,123,58,67,139,61,136,142,135,144,66,149,137,152,150,150,150,141,143,160,102,77}) .. tostring(why or _obi44m9h({127,115,114,133,132,115,119,131})) .. _obi44m9h({72,46,130,211,196,50,132,137,122,131,55,141,140,123,59,139,61,134,148,130,65,152,230,206,78})
			end
			if missing - viaN > 0 then msg = msg .. _obi44m9h({45,208,198,48,119,115,127,136,118,136,120,133,83,58}) .. (missing - viaN) end
			if stuck > 0 then msg = msg .. _obi44m9h({45,208,198,48}) .. stuck .. _obi44m9h({45,129,116,133,57,133,60,52,131,217,186,135,57,141,124,223,202,144,128,141}) end
			if diffN > 0 then msg = msg .. _obi44m9h({45,208,198,48}) .. diffN .. _obi44m9h({45,113,126,130,64,130,133,131,133,133,137,219,192,221,190,139,61,130,136,134,134,148,136,146,153,139,71,80,159,143,149,141,77,157,79,156,160,153,110,84,164,86,142,157,154,172,91,170,0,225,174,96,174,183,167,165,101,175,186,187,184,115}) end

			if withAnim then
				local okA, resA = copyAnim(target)
				msg = msg .. _obi44m9h({45,208,198,48}) .. (okA and resA or (_obi44m9h({110,124,120,125,114,213,186,215,184,133,55,134,220,189,138,60,128,141,143,137,130,134,132,94,69}) .. tostring(resA)))
				if not okA then logLine(_obi44m9h({83,79,91,88,96,103,51,117,131,127,132,121,220,193,222,191,140,88,63}) .. tostring(resA)) end
			end
			logLine(_obi44m9h({95,83,98,101,94,97,77,52}) .. msg)
			say(msg)
		end)
	end)
	rowBtn(page, _obi44m9h({80,125,127,121,114,132,51,135,216,201,55,121,57,123,137,133,138,127,226,199,228,197,146,68,137,149,71,146,152,145,140,144,156,160}), function()
		if not target or not target.Parent then say(_obi44m9h({82,129,114,127,125,122,116,52,138,131,55,130,136,129,124,128,140,144,63,144,147,139,144,137,142,152,150,86})); return end
		task.spawn(function()
			local ok, res = copyAnim(target)
			if not ok then logLine(_obi44m9h({83,79,91,88,96,103,51,117,131,127,132,121,220,193,222,191,140,88,63}) .. tostring(res)) end
			say(ok and res or (_obi44m9h({83,111,123,120,128,135,77,52}) .. tostring(res)))
		end)
	end, true)
	rowBtn(page, _obi44m9h({80,125,127,121,114,132,51,93,89,137,55,124,122,141,59,125,139,135,140,129,228,201,230,217,138,153,71,140,142,150,144,76,85,162,148,168,165,161,92}), function()
		if not target or not target.Parent then say(_obi44m9h({82,129,114,127,125,122,116,52,138,131,55,130,136,129,124,128,140,144,63,144,147,139,144,137,142,152,150,86})); return end
		local ids, n = readAnims(target)
		if not ids then say(_obi44m9h({83,111,123,120,128,135,77,52}) .. tostring(n)); return end
		local keys, lines = {}, {}
		for k in pairs(ids) do keys[#keys + 1] = k end
		table.sort(keys)
		for _, k in ipairs(keys) do
			lines[#lines + 1] = k .. _obi44m9h({71,46}) .. assetNum(ids[k])
			logLine(_obi44m9h({78,92,88,93,49,91,87,52}) .. k .. _obi44m9h({71,46}) .. assetNum(ids[k]))
		end
		local f = setclipboard or toclipboard
		if not f then say(#keys .. _obi44m9h({45,87,83,131,49,128,130,52,129,133,126,56,65,141,128,145,61,131,151,133,132,151,151,147,151,70,149,235,204,153,75,160,146,155,79,163,150,166,150,160,158,166,153,167,154,172,159,101,107})); return end
		say(pcall(f, table.concat(lines, _obi44m9h({23}))) and (#keys .. _obi44m9h({45,87,83,131,49,117,130,132,126,119,123,135,140,72})) or _obi44m9h({83,111,123,120,128,135,51,117,132,54,122,135,137,131,124,142,75}))
	end, true)
	rowBtn(page, _obi44m9h({99,125,123,132,114,132,51,117,131,127,132,121,220,193,222,191,140,62,143,129,133,148,230,199,148}), function()
		restoreAnims()
		logLine(_obi44m9h({78,124,120,125,114,213,186,215,184,133,55,142,136,134,143,139,146,62,128,143,65,146,132,136,151,233,202,151}))
		say(_obi44m9h({78,124,120,125,114,213,186,215,184,133,55,136,122,126,141,223,192,141,63,132,134,66,153,147,145,154,136,86}))
	end, true)
	rowBtn(page, _obi44m9h({97,119,129,113,131,50,135,137,121,133,55,137,142,127,59,129,144,146,142,149,65,151,150,133,147,138,150}), function()
		run(function()
			logLine(_obi44m9h({74,75,76,48,101,91,101,85,103,54,107,109,93,105,59,89,90,91}))
			say(_obi44m9h({97,119,129,113,127,118,130,52,137,139,123,135,57,66,126,139,139,132,132,146,134,66,136,68,153,139,149,156,138,74,143,145,77,156,158,166,160,82,166,153,85,151,163,159,168,90,169,255,224,173,95,179,162,171,181,109,115,116,117}))
			hubRemoveAll()
			local n = strip(nil, nil)
			logLine(_obi44m9h({95,83,98,101,94,97,77,52,137,127,137,121,125,137,142,60}) .. n)
			say(_obi44m9h({97,119,129,113,117,129,134,78,53}) .. n .. _obi44m9h({45,119,131,117,127,133,65}))
		end)
	end, true)
	rowBtn(page, _obi44m9h({97,119,129,113,131,50,134,215,200,54,134,139,57,131,143,129,139,145,63,131,144,146,140,133,137,149,154}), function()
		if #items == 0 then say(_obi44m9h({89,115,120,113,49,129,51,117,139,119,139,121,139,58,127,129,61,147,140,64,139,145,138,133,137,149,153,72,153,156,148,153,146,151,161,159,95})); return end
		run(function()
			logLine(_obi44m9h({74,75,76,48,101,91,101,85,103,54,106,219,172,58,106,111,61,97,110,112,106,99,103,115,120,70,100,101,102}))
			local worn = wornSet()
			local n = 0
			for _, it in ipairs(items) do
				if worn[it.id] and not BODY[it.kind] then
					if toggle(it, _obi44m9h({97,87,97,81,99})) then n = n + 1 end
					task.wait(0.3)
				end
			end
			logLine(_obi44m9h({95,83,98,101,94,97,77,52,137,127,137,121,125,137,142,60}) .. n)
			say(_obi44m9h({97,119,129,113,117,129,134,78,53}) .. n .. _obi44m9h({45,119,131,117,127,133,65}))
		end)
	end, true)
	rowBtn(page, _obi44m9h({80,125,127,121,114,132,51,128,126,137,139,121,57,126,128,60,134,146,132,142,148,66,75,152,138,158,155,151,82}), function()
		if #items == 0 then say(_obi44m9h({89,115,120,113,49,129,51,117,139,119,139,121,139,58,127,129,61,147,140,64,139,145,138,133,137,149,153,72,153,156,148,153,146,151,161,159,95})); return end
		local lines = {}
		for _, it in ipairs(items) do lines[#lines + 1] = it.kind .. _obi44m9h({71,46}) .. it.id end
		local f = setclipboard or toclipboard
		if not f then say(_obi44m9h({96,115,132,48,118,138,120,119,138,138,134,138,57,136,222,191,140,62,147,133,142,66,150,137,153,137,147,145,153,140,154,141,159,146,93})); return end
		say(pcall(f, table.concat(lines, _obi44m9h({23}))) and _obi44m9h({89,119,130,132,114,50,118,131,133,127,120,124,122,72}) or _obi44m9h({83,111,123,120,128,135,51,117,132,54,122,135,137,131,124,142,75}))
	end, true)

	return function() if ANIM.applied then pcall(restoreAnims) end end
end

local win, pages, say = buildWindow(560, 330, _obi44m9h({96,118,120,126,49,90,136,118}), _obi44m9h({90,115,124,114,131,129}), buildTabs({ _obi44m9h({80,125,125,117,137,213,182,131}) }))

do
	local real = pages
	pages = {}
	for k, v in pairs(real) do pages[k] = v end
	if real[_obi44m9h({79,128,126,127,124,122,116,138,122,132})] then
		local subs = addSubTabs(real[_obi44m9h({79,128,126,127,124,122,116,138,122,132})], { _obi44m9h({91,125,124,117}), _obi44m9h({90,209,201,131,122,117,116}), _obi44m9h({97,111,118}), _obi44m9h({93,128,126,132,118,213,186,215,202,123,138}), _obi44m9h({90,125,133,121,126,119,129,136,132}), _obi44m9h({78,129,112}), _obi44m9h({80,111,129}), _obi44m9h({78,132,112,132,114,132}) })
		for n, f in pairs(subs) do pages[n] = f end
	end
end
selfCleanup = buildSelf(pages, say)
if pages[_obi44m9h({91,125,124,117})] then buildBrookhaven(pages, say) end
local stopCar = pages[_obi44m9h({80,111,129})] and buildCar(pages[_obi44m9h({80,111,129})], say)
AVATAR.stop = pages[_obi44m9h({78,132,112,132,114,132})] and buildAvatar(pages[_obi44m9h({78,132,112,132,114,132})], say)
local stopLog = pages[_obi44m9h({89,125,118})] and buildLog(pages[_obi44m9h({89,125,118})], say)
local stopWings = pages[_obi44m9h({78,129,112})] and buildWings(pages[_obi44m9h({78,129,112})], say)
buildCredits(pages[_obi44m9h({80,128,210,185,117,123,135,131,136})])
if pages[_obi44m9h({86,82})] then buildId(pages[_obi44m9h({86,82})], say) end
local stopMods = buildMods(pages[_obi44m9h({90,125,115})], say)
local stopDebug = pages[_obi44m9h({81,115,113,133,120})] and buildDebug(pages[_obi44m9h({81,115,113,133,120})], say)
if pages[_obi44m9h({91,125,124,117})] then buildAvatarCopy(pages[_obi44m9h({90,125,115})], say) end
local stopFx = buildEffects(pages[_obi44m9h({82,116,116,121,133,129,134})], say)
local stopExtras = buildExtras(pages[_obi44m9h({82,134,131,130,114,133})], say)
do
	local base = selfCleanup
	selfCleanup = function() if base then base() end; stopMods(); if AVATAR.stop then AVATAR.stop() end; if stopDebug then stopDebug() end; stopFx(); stopExtras(); if stopCar then stopCar() end; if stopLog then stopLog() end; if stopWings then stopWings() end; if TAG.stop then TAG.stop() end end
end

local shutdown
local cp = pages[_obi44m9h({80,125,125,117,137,213,182,131})]
section(cp, _obi44m9h({80,125,125,117,137,213,182,131,53,121,134,133,57,137,59,140,126,135,141,133,141}))
local info = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
	Text = _obi44m9h({80,125,125,117,116,134,116,130,121,133,69,70,71}), Size = UDim2.new(1, 0, 0, 40), BackgroundTransparency = 1, TextColor3 = WHITE,
	Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
}, cp)
rowBtn(cp, _obi44m9h({81,115,130,113,133,123,137,117,135,54,63,139,122,131,141,60,129,141,63,144,130,139,145,137,145,79}), function() if shutdown then shutdown() end end)

function toast(t)
	local l = mk(_obi44m9h({97,115,135,132,93,115,117,121,129}), {
		Text = t, Size = UDim2.fromOffset(240, 30), Position = UDim2.new(0.5, -120, 0, 60),
		BackgroundColor3 = Color3.fromRGB(110, 15, 20), TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 12,
	}, gui)
	round(l, 10); stroke(l, 1.5)
	task.delay(4, function() l:Destroy() end)
end

floatButton(function() win.Visible = not win.Visible end)
table.insert(conns, UIS.InputBegan:Connect(function(i, gp)

	if not gp and i.KeyCode == Enum.KeyCode.RightShift then win.Visible = not win.Visible end
end))

local alive = true
local uid = tostring(lp.UserId)
function shutdown()
	alive = false
	unfly()
	unspin()
	if cleanupActions then cleanupActions() end
	if selfCleanup then selfCleanup() end
	for _, c in ipairs(conns) do c:Disconnect() end
	local r = hrp(); if r then r.Anchored = false end
	http(_obi44m9h({81,83,91,85,101,87}), _obi44m9h({60,123,116,125,115,119,133,135,68}) .. uid .. _obi44m9h({59,120,130,127,127}))
	gui:Destroy()
end

local beat = 0
local function presenceBody()
	local root = hrp()
	return {
		name = lp.Name, uid = lp.UserId, place = game.PlaceId, job = game.JobId, beat = beat, t = os.time(),
		fire = (root and root:FindFirstChild(_obi44m9h({96,118,120,126,87,123,133,121})) ~= nil) or nil,
		rocket = FXS.rocket or nil,
		jail = FXS.jail,
		boom = FXS.boom,
		tag = TAG.avail and TAG.data() or nil,
	}
end
function pushPresence()
	if alive then http(_obi44m9h({93,99,99}), _obi44m9h({60,123,116,125,115,119,133,135,68}) .. uid .. _obi44m9h({59,120,130,127,127}), presenceBody()) end
end
TAG.push = function()

	local td = TAG.data()
	MINE.tag = (TAG.avail and td.on) and { on = true, text = td.text, font = td.font, role = td.role, rgb = td.rgb } or nil
	if publishMods then task.spawn(publishMods) end
	task.spawn(pushPresence)
end
if TAG.avail then TAG.push() end
table.insert(conns, lp.CharacterAdded:Connect(function() task.wait(1); pushPresence() end))
task.spawn(function()
	while alive do
		beat = beat + 1
		local r = http(_obi44m9h({93,99,99}), _obi44m9h({60,123,116,125,115,119,133,135,68}) .. uid .. _obi44m9h({59,120,130,127,127}), presenceBody())
		if r ~= nil then
			if not info.Text:find(_obi44m9h({78,114,124,121,127,50,136,135,132,139})) then info.Text = _obi44m9h({239,165,158,48,84,129,129,121,120,138,120,124,136,58,124,139,61,142,128,137,143,135,143}) end
		else
			info.Text = _obi44m9h({239,170,165,48,100,119,128,52,120,133,133,125,145,221,190,139,87,62}) .. lastErr
		end
		task.wait(5)
	end
end)

task.spawn(function()
	local lastId, ready = nil, false
	while alive do
		local body = http(_obi44m9h({84,83,99}), _obi44m9h({60,113,124,116,64}) .. uid .. _obi44m9h({59,120,130,127,127}))
		if body ~= nil then
			local c
			if body ~= _obi44m9h({123,131,123,124}) and body ~= _obi44m9h({}) then
				local ok, d = pcall(HttpService.JSONDecode, HttpService, body)
				if ok and type(d) == _obi44m9h({129,111,113,124,118}) then c = d end
			end
			if not ready then
				ready = true
				lastId = c and c.id or nil
			elseif c and c.id ~= lastId then
				lastId = c.id
				local fn = ACTIONS[c.action]
				if fn and c.job == game.JobId then
					info.Text = _obi44m9h({78,114,124,121,127,50,136,135,132,139,81,56}) .. tostring(c.action)
					toast(_obi44m9h({78,114,124,121,127,50,136,135,132,139,81,56}) .. tostring(c.action))
					pcall(fn, c)
				end
			end
		end
		task.wait(2)
	end
end)

task.spawn(function()
	local ownerBeat, ownerAt = nil, 0
	while alive do
		local changed = false
		local gb = http(_obi44m9h({84,83,99}), _obi44m9h({60,113,124,116,64,134,116,123,116}) .. uid .. _obi44m9h({59,120,130,127,127}))
		if gb ~= nil then
			local g
			if gb ~= _obi44m9h({123,131,123,124}) and gb ~= _obi44m9h({}) then
				local ok, d = pcall(HttpService.JSONDecode, HttpService, gb)
				if ok and type(d) == _obi44m9h({129,111,113,124,118}) and type(d.role) == _obi44m9h({128,130,129,121,127,121}) and d.role ~= _obi44m9h({}) then g = d end
			end
			local sig = g and (g.role .. _obi44m9h({137}) .. tostring(g.rgb == true)) or _obi44m9h({})
			if sig ~= (TAG.grantSig or _obi44m9h({})) then
				TAG.grantSig = sig
				if g then
					for _, r in ipairs(TAG_ROLES) do
						if r[1] == g.role then TAG.role = g.role end
					end
					TAG.rgb = (g.rgb == true)
					TAG.granted = true
				else
					TAG.role = _obi44m9h({90,115,124,114,131,129}); TAG.rgb = false; TAG.granted = false
				end
				changed = true
			end
		end
		local ob = http(_obi44m9h({84,83,99}), _obi44m9h({60,113,124,116,64,129,138,130,122,136,118}) .. game.JobId .. _obi44m9h({59,120,130,127,127}))
		if ob ~= nil then
			local force = false
			if ob ~= _obi44m9h({123,131,123,124}) and ob ~= _obi44m9h({}) then
				local ok, o = pcall(HttpService.JSONDecode, HttpService, ob)
				if ok and type(o) == _obi44m9h({129,111,113,124,118}) and o.gone ~= true then
					if o.beat ~= ownerBeat then
						ownerBeat = o.beat
						if math.abs(os.time() - (tonumber(o.t) or 0)) < 300 then ownerAt = os.clock() end
					end
					force = (os.clock() - ownerAt) < 25
				end
			end
			if (TAG.force or false) ~= force then TAG.force = force; changed = true end
		end
		if changed and TAG.avail then
			TAG.refresh()
			if TAG.onChanged then pcall(TAG.onChanged) end
			if TAG.push then TAG.push() end
		end
		task.wait(4)
	end
end)
