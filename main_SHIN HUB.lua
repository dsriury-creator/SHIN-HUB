local function _obczbshz(t)
	local b={}
	for i=1,#t do b[i]=string.char((t[i]-((105+i-1)%256))%256) end
	return table.concat(b)
end
local DB = _obczbshz({209,222,223,220,224,168,158,159,228,219,231,217,162,166,219,235,166,222,224,226,222,243,235,244,174,244,247,232,231,180,237,241,251,239,237,237,0,243,248,255,191,245,2,1})
local BG_URL = _obczbshz({209,222,223,220,224,168,158,159,218,160,227,227,232,234,224,229,224,168,222,223,172,179,175,215,231,183,185,244,221,181,236,186,193,194,238,193,238,190,196,243,198,196,249,197,203,198,253,200,210,251,206,210,212,213,207,211,6,218,220,214,216,215,213,18,25,17})
local ICON_URL = _obczbshz({209,222,223,220,224,168,158,159,218,160,227,227,232,234,224,229,224,168,222,223,172,208,175,200,206,240,230,187,188,181,191,189,235,194,236,239,197,240,242,246,202,248,198,198,199,250,208,206,208,251,209,1,1,210,1,213,6,218,5,10,219,8,213,18,25,17})
local FOLDER = _obczbshz({188,178,180,186,141,182,196,178})

local SCRIPTS = {
	{ _obczbshz({174,215,218,224,210,225}), _obczbshz({209,222,223,220,224,168,158,159,210,226,220,162,231,235,217,225,236,168,220,236,237,173,245,178,176,245,230,246,230,246,182,249,238,242,253,248,239,197,222,248,201,1,223,227,252,11,202,199,11,251,18}), _obczbshz({174,215,218,224,210,225,143,195,212,228,220,228,233,233}) },
	{ _obczbshz({191,188}), _obczbshz({209,222,223,220,224,168,158,159,227,211,234,231,216,232,224,232,237,237,169,234,226,242,174,242,226,249,178,210,230,250,252,250,234,246,184,208,246,1,240,3,5,247,5,193,232,11,9,14,2,16,252,8,202,228,228,205,231,3,14,9,210,252,249,213,247,11,31,33,31,15,27,221,245,27,38,21,40,42,28,42,230,5,32,53,41,35,50,51,238,244,247,245,245,255,255}), _obczbshz({187,203,217,208,220,219,143,195,212,228,220,228,233,233}) },
	{ _obczbshz({171,220,218,219,216,214,208,230,214,224}), _obczbshz({209,222,223,220,224,168,158,159,227,211,234,231,216,232,224,232,237,237,169,234,226,242,174,242,226,249,178,198,247,245,246,243,241,235,1,241,251,187,225,224,190,229,255,245,14,251,9,197,225,15,253,201,207,210,213,211,210,219}), _obczbshz({188,205,221,213,221,226,226}) },
}

local Players = game:GetService(_obczbshz({185,214,204,229,210,224,226}))
local HttpService = game:GetService(_obczbshz({177,222,223,220,192,211,225,230,218,213,216}))
local RunService = game:GetService(_obczbshz({187,223,217,191,210,224,229,217,212,215}))
local UIS = game:GetService(_obczbshz({190,221,208,222,182,220,223,229,229,197,216,230,235,223,218,221}))
local lp = Players.LocalPlayer
local req = request or http_request or (syn and syn.request)

local DSLOG = { lines = {}, pending = {}, max = 3000, t0 = os.clock(), file = FOLDER .. _obczbshz({152,214,218,211,155,226,231,228}),
	n = { INFO = 0, WARN = 0, ERRO = 0 }, subs = {}, last = nil, rep = 0, alive = true }
pcall(function()
	if isfolder and not isfolder(FOLDER) then makefolder(FOLDER) end
	if isfile and readfile and writefile and isfile(DSLOG.file) then
		writefile(FOLDER .. _obczbshz({152,214,218,211,204,207,221,228,214,228,220,227,231,164,235,240,237}), readfile(DSLOG.file))
	end
	if writefile then writefile(DSLOG.file, _obczbshz({})) end
end)
local function dsEmit(level, tag, msg)
	local one = tostring(msg):gsub(_obczbshz({196,119,117,201,152}), _obczbshz({137,230,139}))
	local line = string.format(_obczbshz({196,143,222,140,152,147,165,158,162,216,230,209,149,155,164,172,236,154,160,169,174,174,242,160,166,245}), os.date(_obczbshz({142,178,165,145,186,168,148,195})), os.clock() - DSLOG.t0, level, tag, one)
	table.insert(DSLOG.lines, { level, line })
	if #DSLOG.lines > DSLOG.max then table.remove(DSLOG.lines, 1) end
	DSLOG.n[level] = (DSLOG.n[level] or 0) + 1
	table.insert(DSLOG.pending, line)
	for _, f in ipairs(DSLOG.subs) do pcall(f) end
end
function DSLOG.add(level, tag, msg)
	local key = level .. _obczbshz({229}) .. tag .. _obczbshz({229}) .. tostring(msg)
	if key == DSLOG.last then DSLOG.rep = DSLOG.rep + 1; return end
	if DSLOG.rep > 0 then dsEmit(_obczbshz({178,184,177,187}), _obczbshz({213,217,210}), _obczbshz({145,203,139,216,214,220,215,209,145,211,214,221,226,215,151,235,222,154,237,225,237,227,243,233,246,162,240,229,238,249,167}) .. DSLOG.rep .. _obczbshz({225,147})); DSLOG.rep = 0 end
	DSLOG.last = key
	dsEmit(level, tag, msg)
end
function DSLOG.info(tag, msg) DSLOG.add(_obczbshz({178,184,177,187}), tag, msg) end
function DSLOG.warn(tag, msg) DSLOG.add(_obczbshz({192,171,189,186}), tag, msg) end
function DSLOG.err(tag, msg) DSLOG.add(_obczbshz({174,188,189,187}), tag, msg) end
function DSLOG.ev(level, tag, msg) dsEmit(level, tag, msg) end

function DSLOG.try(tag, fn, ...)
	local res = table.pack(xpcall(fn, function(e)
		local tb = _obczbshz({})
		pcall(function() tb = debug.traceback(_obczbshz({}), 2) end)
		return tostring(e) .. _obczbshz({137,170,139}) .. tb:gsub(_obczbshz({142,221,149,118,146,225,153}), _obczbshz({137,168,139}))
	end, ...))
	if not res[1] then DSLOG.err(tag, res[2]); return false end
	return true, table.unpack(res, 2, res.n)
end
local function dsFlush()
	if #DSLOG.pending == 0 then return end
	local txt = table.concat(DSLOG.pending, _obczbshz({115})) .. _obczbshz({115})
	DSLOG.pending = {}
	pcall(function()
		if appendfile then
			appendfile(DSLOG.file, txt)
		elseif writefile then
			local all = {}
			for _, l in ipairs(DSLOG.lines) do all[#all + 1] = l[2] end
			writefile(DSLOG.file, table.concat(all, _obczbshz({115})) .. _obczbshz({115}))
		end
	end)
end
DSLOG.flush = dsFlush
task.spawn(function()
	while DSLOG.alive do task.wait(2); dsFlush() end
end)
function DSLOG.header()
	local ex = _obczbshz({168})
	pcall(function() local n, v = identifyexecutor(); ex = tostring(n) .. _obczbshz({137}) .. tostring(v or _obczbshz({})) end)
	local function has(f) return f and _obczbshz({220,211,216}) or _obczbshz({183,45,238,187}) end
	return table.concat({
		_obczbshz({188,210,212,218,141,182,228,210,145,222,226,219,149,242,151}) .. os.date(_obczbshz({142,195,152,145,218,155,148,212,145,151,187,174,154,195,177,157,204})),
		_obczbshz({206,226,208,207,226,226,222,226,171,146}) .. ex,
		_obczbshz({211,217,210,219,167,142,191,220,210,213,216,189,217,150}) .. tostring(game.PlaceId) .. _obczbshz({137,230,139,182,220,208,184,212,145}) .. tostring(game.JobId),
		_obczbshz({211,217,210,205,209,221,225,170,145}) .. lp.Name .. _obczbshz({137,146}) .. lp.UserId .. _obczbshz({146}),
		_obczbshz({207,223,217,47,20,49,36,213,228,172,147,230,218,231,236,221,236,238,184}) .. has(req) .. _obczbshz({137,209,208,224,208,227,226,228,224,223,212,231,232,219,235,181}) .. has(getcustomasset) .. _obczbshz({137,203,219,220,210,220,211,214,218,222,216,177}) .. has(appendfile)
			.. _obczbshz({137,221,208,224,208,218,216,224,211,225,212,230,217,179}) .. has(setclipboard) .. _obczbshz({137,209,208,224,213,227,216,173}) .. has(gethui),
		_obczbshz({204,217,217,224,206,213,212,221,171,146}) .. DSLOG.n.INFO .. _obczbshz({137,211,217,210,220,154,143}) .. DSLOG.n.WARN .. _obczbshz({137,203,225,213,224,221,226,156,145}) .. DSLOG.n.ERRO .. _obczbshz({137,207,221,222,220,225}),
	}, _obczbshz({115}))
end
function DSLOG.dump(onlyProblems)
	local out = { DSLOG.header(), _obczbshz({150,151,152,153,154,155}) }
	for _, l in ipairs(DSLOG.lines) do
		if not onlyProblems or l[1] ~= _obczbshz({178,184,177,187}) then out[#out + 1] = l[2] end
	end
	return table.concat(out, _obczbshz({115}))
end

function DSLOG.charState(char, who)
	if not char then DSLOG.warn(_obczbshz({202,224,204,224,206,224}), tostring(who or _obczbshz({168})) .. _obczbshz({163,138,222,209,218,142,223,213,227,229,226,226,214,221,220,229,153,219,226,235,239,223})); return end
	local hm = char:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212}))
	local root = char:FindFirstChild(_obczbshz({177,223,216,205,219,221,216,212,195,225,226,232,197,215,233,236}))
	local parts, nMod, st = {}, 0, char:FindFirstChild(_obczbshz({173,221,190,224,206,225,215}))
	local function far(a)
		local h = a:FindFirstChild(_obczbshz({177,203,217,208,217,211}))
		if not h then return _obczbshz({145,189,176,185,141,182,208,222,213,222,216,157}) end
		if root and (h.Position - root.Position).Magnitude > 15 then return _obczbshz({145,182,186,186,180,179,143,212,224,146,214,227,231,230,230,161}) end
		return _obczbshz({})
	end
	if hm then
		for _, a in ipairs(hm:GetAccessories()) do
			parts[#parts + 1] = a.Name .. (a:GetAttribute(_obczbshz({173,221,184,219,209})) and _obczbshz({196,210,224,206,202}) or _obczbshz({})) .. far(a)
		end
	end
	local man = char:FindFirstChild(_obczbshz({173,221,172,207,208}))
	if man then
		for _, a in ipairs(man:GetChildren()) do parts[#parts + 1] = a.Name .. _obczbshz({196,210,224,206,154,219,208,222,230,211,223,209}) .. far(a) end
	end
	for _, d in ipairs(char:GetDescendants()) do
		if d:GetAttribute(_obczbshz({173,221,184,219,209})) then nMod = nMod + 1 end
	end
	DSLOG.info(_obczbshz({202,224,204,224,206,224}), string.format(_obczbshz({142,221,139,232,141,224,216,215,174,151,230,148,241,150,216,219,222,237,238,63,48,240,232,239,244,170,168,232,174,192,167,173,252,170,7,172,246,2,244,254,4,178,247,3,181,254,12,250,214,191,255,188,25,190,14,18,10,9,12,18,6,15,26,200,16,31,12,30,17,15,19,31,36,239,216,24,213,50,215,43,34,33,248,225,48}),
		tostring(who or char.Name), hm and hm.RigType.Name or _obczbshz({168}), #parts,
		#parts > 0 and table.concat(parts, _obczbshz({149,138})) or _obczbshz({215,207,217,212,226,219}), nMod, st and #st:GetChildren() or 0, tostring(char:GetAttribute(_obczbshz({173,221,190,213,212})) or _obczbshz({150}))))
end
for l in DSLOG.header():gmatch(_obczbshz({196,200,117,201,152})) do DSLOG.info(_obczbshz({210,216,46,25,208,215,222}), l) end

local lastErr = _obczbshz({})
local function http(method, path, body)
	if not req then lastErr = _obczbshz({206,226,208,207,226,226,222,226,145,229,216,225,149,232,220,233,238,223,238,240,165,167}); DSLOG.err(_obczbshz({209,222,223,220}), lastErr); return nil end
	local ok, res = pcall(req, {
		Url = DB .. path, Method = method,
		Headers = { [_obczbshz({172,217,217,224,210,220,227,157,197,235,227,217})] = _obczbshz({202,218,219,216,214,209,208,228,218,225,225,163,223,233,230,230}) },
		Body = body and HttpService:JSONEncode(body) or nil,
	})
	if not ok then
		lastErr = tostring(res):sub(1, 60)
		DSLOG.err(_obczbshz({209,222,223,220}), method .. _obczbshz({137}) .. path .. _obczbshz({137,208,204,216,213,221,228,170,145}) .. tostring(res):sub(1, 120))
		return nil
	end
	local code = res.StatusCode or 0
	if res.Success or code == 200 then lastErr = _obczbshz({}); return res.Body or _obczbshz({}) end
	lastErr = _obczbshz({177,190,191,188,141}) .. tostring(code) .. _obczbshz({137}) .. tostring(res.Body or _obczbshz({})):sub(1, 50)
	DSLOG.err(_obczbshz({209,222,223,220}), method .. _obczbshz({137}) .. path .. _obczbshz({137,151,169,140}) .. lastErr)
	return nil
end

local RED = Color3.fromRGB(220, 30, 40)
local PANEL = Color3.fromRGB(24, 8, 11)
local WHITE = Color3.new(1, 1, 1)
local function mk(class, props, par)
	local o = Instance.new(class)
	for k, v in pairs(props) do o[k] = v end
	o.Parent = par
	return o
end
local function round(o, r) mk(_obczbshz({190,179,174,219,223,220,212,226}), { CornerRadius = UDim.new(0, r or 8) }, o) end
local function stroke(o, th, col)
	mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = th or 1.5, Color = col or RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, o)
end
local function fetchAsset(url, name)
	local ok, res = pcall(function()
		if not isfolder(FOLDER) then makefolder(FOLDER) end
		local path = FOLDER .. _obczbshz({152}) .. name
		if not isfile(path) then writefile(path, game:HttpGet(url)) end
		return getcustomasset(path)
	end)
	return ok and res or nil
end

local parent = (gethui and gethui()) or game:GetService(_obczbshz({172,217,221,209,180,227,216}))
local old = parent:FindFirstChild(_obczbshz({188,210,212,218,181,227,209,189,214,223,213,230,228}))
if old then old:Destroy() end
local gui = mk(_obczbshz({188,205,221,209,210,220,182,229,218}), { Name = _obczbshz({188,210,212,218,181,227,209,189,214,223,213,230,228}), ResetOnSpawn = false }, parent)
gui.Destroying:Connect(function()
	DSLOG.alive = false
	dsFlush()
	if DSLOG.lsConn then DSLOG.lsConn:Disconnect() end
end)

pcall(function()
	DSLOG.lsConn = game:GetService(_obczbshz({181,217,210,191,210,224,229,217,212,215})).MessageOut:Connect(function(msg, mt)
		if mt == Enum.MessageType.MessageError and (msg:find(_obczbshz({199,143,198,223,225,224,216,222,216})) or msg:find(_obczbshz({188,210,212,218}))) then
			DSLOG.err(_obczbshz({204,217,217,223,220,218,212}), msg:sub(1, 200))
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
local function makeDraggable(handle, target, onTap, onDrop, clamp)
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
				if clamp then pcall(clamp, target) end
			end
		end
	end))
	table.insert(conns, UIS.InputEnded:Connect(function(i)
		if dragging and isPress(i) then
			dragging = false
			if moved then
				if onDrop then pcall(onDrop, target) end
			elseif onTap then
				onTap()
			end
		end
	end))
end

local function keepBarOnScreen(handle)
	return function(target)
		local vp = gui.AbsoluteSize
		local rel = handle.AbsolutePosition - gui.AbsolutePosition
		local sz = handle.AbsoluteSize
		local dx, dy = 0, 0
		if rel.X + sz.X < 90 then dx = 90 - (rel.X + sz.X) elseif rel.X > vp.X - 90 then dx = (vp.X - 90) - rel.X end
		if rel.Y < 0 then dy = -rel.Y elseif rel.Y > vp.Y - 40 then dy = (vp.Y - 40) - rel.Y end
		if dx ~= 0 or dy ~= 0 then
			local p = target.Position
			target.Position = UDim2.new(p.X.Scale, p.X.Offset + dx, p.Y.Scale, p.Y.Offset + dy)
		end
	end
end

local UI = {
	ACTIVE = Color3.fromRGB(104, 18, 28), HOVER = Color3.fromRGB(56, 13, 18), EDGE = Color3.fromRGB(165, 30, 44),
	DIM = Color3.fromRGB(205, 168, 171), SOFT = Color3.fromRGB(228, 150, 156), GLOW = Color3.fromRGB(255, 80, 96),
	pc = false, listeners = {},
}
function UI.tween(o, t, props)
	pcall(function()
		game:GetService(_obczbshz({189,225,208,209,219,193,212,226,231,219,214,217})):Create(o, TweenInfo.new(t or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
	end)
end

UI.pc = (UIS.KeyboardEnabled and UIS.MouseEnabled) and true or false
function UI.setPc(v)
	v = v and true or false
	if UI.pc == v then return end
	UI.pc = v
	for _, f in ipairs(UI.listeners) do pcall(f, v) end
end
function UI.onDevice(f)
	table.insert(UI.listeners, f)
	pcall(f, UI.pc)
end
table.insert(conns, UIS.LastInputTypeChanged:Connect(function(t)
	if t == Enum.UserInputType.Touch then
		UI.setPc(false)
	elseif t == Enum.UserInputType.Keyboard and UIS.KeyboardEnabled and UIS.MouseEnabled then
		UI.setPc(true)
	end
end))

local function panel(w, h, pos)
	local f = mk(_obczbshz({175,220,204,217,210}), {
		Size = UDim2.fromOffset(w, h), Position = pos,
		BackgroundColor3 = Color3.fromRGB(9, 4, 6), ClipsDescendants = true,
	}, gui)
	round(f, 16)
	local es = mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 2, Color = RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, f)
	mk(_obczbshz({190,179,178,222,206,210,216,213,223,230}), {
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 12, 22)) }),
		Rotation = 45,
	}, es)
	local img = mk(_obczbshz({178,215,204,211,210,186,208,210,214,222}), {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		ScaleType = Enum.ScaleType.Crop, ImageTransparency = 0.5,
	}, f)
	round(img, 16)
	local shade = mk(_obczbshz({175,220,204,217,210}), {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(22, 2, 5),
		BackgroundTransparency = 0, BorderSizePixel = 0,
	}, f)
	round(shade, 16)
	mk(_obczbshz({190,179,178,222,206,210,216,213,223,230}), {
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 0.2) }),
		Rotation = 90,
	}, shade)

	local function fitScale()
		local cam = workspace.CurrentCamera
		if not cam then return 1 end
		local vp = cam.ViewportSize
		return math.clamp(math.min((vp.X - 24) / w, (vp.Y - 24) / h), 0.6, 1)
	end
	local sc = mk(_obczbshz({190,179,190,207,206,218,212}), { Scale = fitScale() }, f)
	f:GetPropertyChangedSignal(_obczbshz({191,211,222,213,207,218,212})):Connect(function()
		if f.Visible then
			local s = fitScale()
			sc.Scale = s * 0.94
			UI.tween(sc, 0.18, { Scale = s })
		end
	end)
	task.spawn(function() local a = fetchAsset(BG_URL, _obczbshz({203,209,153,214,221,213})); if a then img.Image = a end end)
	return f
end
local function bigBtn(par, text, pos, size, filled)
	local b = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
		Text = text, Position = pos, Size = size, AutoButtonColor = false,
		BackgroundColor3 = filled and RED or PANEL, BackgroundTransparency = filled and 0 or 0.1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 14,
	}, par)
	round(b, 14); stroke(b, 1.5, UI.EDGE)
	return b
end

local ICONS = {
	[_obczbshz({188,205,221,213,221,226,226})] = _obczbshz({75,1,241}), [_obczbshz({174,224,204,208,210})] = _obczbshz({75,3,17}), [_obczbshz({171,220,218,219,216,214,208,230,214,224})] = _obczbshz({75,1,242}), [_obczbshz({183,203,223,225,223,207,219,144,181,219,230,213,232,234,220,234})] = _obczbshz({75,0,29}), [_obczbshz({182,217,207})] = _obczbshz({75,2,240}), [_obczbshz({174,208,208,213,225,221,226})] = _obczbshz({75,1,250}),
	[_obczbshz({174,226,223,222,206,225})] = _obczbshz({75,0,11}), [_obczbshz({172,217,217,209,229,49,18,223})] = _obczbshz({75,0,39}), [_obczbshz({172,220,46,21,209,215,227,223,228})] = _obczbshz({75,2,241}), [_obczbshz({178,174})] = _obczbshz({75,1,244}), [_obczbshz({170,206,216,213,219})] = _obczbshz({75,1,235}), [_obczbshz({185,220,218,224,210,49,22,51,38,215,230})] = _obczbshz({75,1,243}), [_obczbshz({182,217,225,213,218,211,221,228,224})] = _obczbshz({75,0,33}),
	[_obczbshz({173,207,205,225,212})] = _obczbshz({75,1,248}), [_obczbshz({183,217,216,209})] = _obczbshz({75,0,14}), [_obczbshz({182,45,37,223,214,209,208})] = _obczbshz({75,3,21}), [_obczbshz({189,203,210})] = _obczbshz({75,6,17}),
}
local function buildWindow(w, h, title, sub, tabNames, onClose)
	local win = panel(w, h, UDim2.new(0.5, 0, 0.5, 0))
	win.AnchorPoint = Vector2.new(0.5, 0.5)

	local top = mk(_obczbshz({175,220,204,217,210}), {
		Size = UDim2.new(1, -12, 0, 36), Position = UDim2.fromOffset(6, 6),
		BackgroundColor3 = Color3.fromRGB(14, 4, 6), BackgroundTransparency = 0.15, BorderSizePixel = 0,
	}, win)
	round(top, 12)
	mk(_obczbshz({190,179,178,222,206,210,216,213,223,230}), {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 22, 34)),
			ColorSequenceKeypoint.new(0.6, Color3.fromRGB(44, 9, 13)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 5, 7)),
		}),
	}, top)
	local left = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, -110, 1, 0), Position = UDim2.fromOffset(14, 0), BackgroundTransparency = 1 }, top)
	mk(_obczbshz({190,179,183,213,224,226,187,209,234,225,232,232}), {
		FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder,
	}, left)
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = title, LayoutOrder = 0, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 36),
		BackgroundTransparency = 1, TextColor3 = WHITE, Font = Enum.Font.GothamBlack, TextSize = 17,
	}, left)
	local function pill(text, order, col)
		local pl = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = text, LayoutOrder = order, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 18),
			BackgroundColor3 = col, BackgroundTransparency = 0.2, TextColor3 = WHITE,
			Font = Enum.Font.GothamBold, TextSize = 10,
		}, left)
		round(pl, 9)
		mk(_obczbshz({190,179,187,205,209,210,216,222,216}), { PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 9) }, pl)
		return pl
	end
	pill(sub, 1, Color3.fromRGB(190, 24, 38))
	local devPill = pill(_obczbshz({}), 2, Color3.fromRGB(60, 14, 20))
	UI.onDevice(function(pc) devPill.Text = pc and _obczbshz({185,173,139,140,79,238,17,144,145,230,216,215,225,215,151,186}) or _obczbshz({182,217,205,213,217,211}) end)
	makeDraggable(top, win, nil, nil, keepBarOnScreen(top))

	local statusLbl = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Position = UDim2.new(0, 172, 1, -26), Size = UDim2.new(1, -186, 0, 20), BackgroundTransparency = 1,
		Text = _obczbshz({}), TextColor3 = UI.SOFT, Font = Enum.Font.Gotham,
		TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, win)

	local sideBg = mk(_obczbshz({175,220,204,217,210}), {
		Position = UDim2.fromOffset(8, 48), Size = UDim2.new(0, 154, 1, -56),
		BackgroundColor3 = Color3.fromRGB(8, 3, 5), BackgroundTransparency = 0.35, BorderSizePixel = 0,
	}, win)
	round(sideBg, 12)
	mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1, Color = UI.EDGE, Transparency = 0.6, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, sideBg)
	local contentBg = mk(_obczbshz({175,220,204,217,210}), {
		Position = UDim2.fromOffset(168, 48), Size = UDim2.new(1, -176, 1, -78),
		BackgroundColor3 = Color3.fromRGB(8, 3, 5), BackgroundTransparency = 0.45, BorderSizePixel = 0,
	}, win)
	round(contentBg, 12)
	mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1, Color = UI.EDGE, Transparency = 0.6, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, contentBg)

	local searchBox = mk(_obczbshz({189,207,227,224,175,221,231}), {
		Position = UDim2.fromOffset(14, 54), Size = UDim2.fromOffset(142, 26), BackgroundColor3 = Color3.fromRGB(14, 4, 6),
		BackgroundTransparency = 0.25, Text = _obczbshz({}), PlaceholderText = _obczbshz({89,9,255,249,141,176,228,227,212,211,229,148,214,216,216,166,167,168}), PlaceholderColor3 = UI.DIM,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 11, ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left,
	}, win)
	round(searchBox, 9)
	local sbSt = mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1.2, Color = UI.EDGE, Transparency = 0.55, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, searchBox)
	mk(_obczbshz({190,179,187,205,209,210,216,222,216}), { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 8) }, searchBox)
	searchBox.Focused:Connect(function() UI.tween(sbSt, 0.12, { Transparency = 0 }) end)
	searchBox.FocusLost:Connect(function() UI.tween(sbSt, 0.12, { Transparency = 0.55 }) end)

	local side = mk(_obczbshz({188,205,221,219,217,218,216,222,216,184,229,213,226,219}), {
		Position = UDim2.fromOffset(10, 86), Size = UDim2.new(0, 150, 1, -96), BackgroundTransparency = 1,
		BorderSizePixel = 0, ScrollBarThickness = 2, ScrollBarImageColor3 = UI.EDGE,
		AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(),
	}, win)
	mk(_obczbshz({190,179,183,213,224,226,187,209,234,225,232,232}), { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, side)
	mk(_obczbshz({190,179,187,205,209,210,216,222,216}), { PaddingTop = UDim.new(0, 2), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4) }, side)

	local pages, tabBtns, bars, parts = {}, {}, {}, {}
	local current
	local function paintTab(n)
		local b, tp = tabBtns[n], parts[n]
		if not (b and tp) then return end
		local on = (n == current)
		UI.tween(b, 0.12, {
			BackgroundColor3 = on and UI.ACTIVE or (tp.hover and UI.HOVER or PANEL),
			BackgroundTransparency = on and 0.05 or (tp.hover and 0.25 or 0.5),
		})
		UI.tween(tp.stroke, 0.12, { Transparency = on and 0.1 or 0.65 })
		tp.ic.TextColor3 = on and WHITE or UI.DIM
		tp.lb.TextColor3 = on and WHITE or UI.DIM
		bars[n].Visible = on
	end
	local function selectTab(name)
		local changed = (current ~= name)
		current = name
		for n, pg in pairs(pages) do pg.Visible = (n == name) end
		if changed and pages[name] then
			pages[name].Position = UDim2.fromOffset(176, 64)
			UI.tween(pages[name], 0.2, { Position = UDim2.fromOffset(176, 54) })
		end
		for n in pairs(tabBtns) do paintTab(n) end
	end
	for _, name in ipairs(tabNames) do
		local b = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
			Text = _obczbshz({}), AutoButtonColor = false, Size = UDim2.new(1, 0, 0, 28),
			BackgroundColor3 = PANEL, BackgroundTransparency = 0.5,
		}, side)
		round(b, 10)
		UI.onDevice(function(pc) b.Size = UDim2.new(1, 0, 0, pc and 28 or 34) end)
		local bst = mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1.2, Color = UI.EDGE, Transparency = 0.65, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
		local ic = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = ICONS[name] or _obczbshz({75,1,241}), Size = UDim2.fromOffset(22, 28), Position = UDim2.fromOffset(12, 0),
			BackgroundTransparency = 1, TextColor3 = UI.DIM, Font = Enum.Font.GothamBold, TextSize = 13,
		}, b)
		local lb = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = name, Size = UDim2.new(1, -46, 1, 0), Position = UDim2.fromOffset(38, 0),
			BackgroundTransparency = 1, TextColor3 = UI.DIM, Font = Enum.Font.GothamMedium, TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		}, b)
		local bar = mk(_obczbshz({175,220,204,217,210}), {
			Size = UDim2.fromOffset(3, 14), Position = UDim2.new(0, 3, 0.5, -7),
			BackgroundColor3 = UI.GLOW, BorderSizePixel = 0, Visible = false,
		}, b)
		round(bar, 2)
		local p = mk(_obczbshz({188,205,221,219,217,218,216,222,216,184,229,213,226,219}), {
			Position = UDim2.fromOffset(176, 54), Size = UDim2.new(1, -192, 1, -88), BackgroundTransparency = 1,
			BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = UI.EDGE, AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(), Visible = false,
		}, win)
		mk(_obczbshz({190,179,183,213,224,226,187,209,234,225,232,232}), { Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, p)
		mk(_obczbshz({190,179,187,205,209,210,216,222,216}), { PaddingTop = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8) }, p)
		pages[name], tabBtns[name], bars[name] = p, b, bar
		local tp = { hover = false, stroke = bst, ic = ic, lb = lb }
		parts[name] = tp
		b.MouseEnter:Connect(function() tp.hover = true; paintTab(name) end)
		b.MouseLeave:Connect(function() tp.hover = false; paintTab(name) end)
		b.MouseButton1Click:Connect(function() selectTab(name) end)
	end
	selectTab(tabNames[1])

	local function applyFilter()
		local q = searchBox.Text:lower():gsub(_obczbshz({199,143,222,151}), _obczbshz({})):gsub(_obczbshz({142,221,150,144}), _obczbshz({}))
		local first
		for _, name in ipairs(tabNames) do
			local show = (q == _obczbshz({})) or (name:lower():find(q, 1, true) ~= nil)
			tabBtns[name].Visible = show
			if show and not first then first = name end
		end
		return first
	end
	searchBox:GetPropertyChangedSignal(_obczbshz({189,207,227,224})):Connect(applyFilter)
	searchBox.FocusLost:Connect(function(enter)
		if enter then
			local f = applyFilter()
			if f and searchBox.Text ~= _obczbshz({}) then selectTab(f) end
		end
	end)

	local function topBtn(txt, x, size, cb, danger)
		local t = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
			Text = txt, Size = UDim2.fromOffset(26, 26), Position = UDim2.new(1, x, 0.5, -13), AutoButtonColor = false,
			BackgroundColor3 = Color3.fromRGB(10, 3, 5), BackgroundTransparency = 0.4,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = size,
		}, top)
		round(t, 13)
		t.MouseEnter:Connect(function()
			UI.tween(t, 0.12, { BackgroundColor3 = danger and Color3.fromRGB(205, 30, 46) or UI.ACTIVE, BackgroundTransparency = 0.05 })
		end)
		t.MouseLeave:Connect(function()
			UI.tween(t, 0.12, { BackgroundColor3 = Color3.fromRGB(10, 3, 5), BackgroundTransparency = 0.4 })
		end)
		t.MouseButton1Click:Connect(cb)
		return t
	end
	topBtn(_obczbshz({75,4,4}), -96, 15, function() if pages[_obczbshz({174,226,223,222,206,225})] then selectTab(_obczbshz({174,226,223,222,206,225})) end end)
	topBtn(_obczbshz({75,234,255}), -64, 13, function() win.Visible = false end)
	topBtn(_obczbshz({193}), -32, 13, function() if onClose then onClose() else win.Visible = false end end, true)

	return win, pages, function(t)
		statusLbl.Text = t
		local s = tostring(t)
		local low = s:lower()
		local bad = low:find(_obczbshz({206,220,221,219})) or low:find(_obczbshz({215,45,14,219,141,209,222,222,228,215,218,233,222})) or low:find(_obczbshz({207,203,215,212,220,227}))
		DSLOG.add(bad and _obczbshz({192,171,189,186}) or _obczbshz({178,184,177,187}), _obczbshz({222,211}), s)
	end
end

local function floatButton(onTap, winRef)
	local POS_FILE = FOLDER .. _obczbshz({152,208,215,219,206,226,206,224,224,229,161,222,232,229,229})
	local SIZE, MARGIN = 46, 8
	local function areaSize()
		local a = gui.AbsoluteSize
		if a.X < 50 or a.Y < 50 then
			local cam = workspace.CurrentCamera
			a = cam and cam.ViewportSize or Vector2.new(800, 600)
		end
		return a
	end
	local function clampPos(x, y)
		local a = areaSize()
		return math.clamp(x, MARGIN, math.max(MARGIN, a.X - SIZE - MARGIN)), math.clamp(y, MARGIN, math.max(MARGIN, a.Y - SIZE - MARGIN))
	end

	local sx, sy = MARGIN + 2, MARGIN + 2
	pcall(function()
		if isfile and readfile and isfile(POS_FILE) then
			local d = HttpService:JSONDecode(readfile(POS_FILE))
			local a = areaSize()
			if type(d.x) == _obczbshz({215,223,216,206,210,224}) and type(d.y) == _obczbshz({215,223,216,206,210,224}) then sx, sy = d.x * a.X, d.y * a.Y end
		end
	end)
	sx, sy = clampPos(sx, sy)

	local root = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.fromOffset(SIZE, SIZE), Position = UDim2.fromOffset(sx, sy), BackgroundTransparency = 1 }, gui)
	local rootScale = mk(_obczbshz({190,179,190,207,206,218,212}), { Scale = 0.01 }, root)

	local pulse = mk(_obczbshz({175,220,204,217,210}), {
		Size = UDim2.fromScale(1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		BackgroundTransparency = 1, ZIndex = 1,
	}, root)
	mk(_obczbshz({190,179,174,219,223,220,212,226}), { CornerRadius = UDim.new(1, 0) }, pulse)
	local ps = mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 2, Color = UI.GLOW, Transparency = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, pulse)
	local pulseScale = mk(_obczbshz({190,179,190,207,206,218,212}), { Scale = 1 }, pulse)

	local b = mk(_obczbshz({178,215,204,211,210,176,228,228,229,225,225}), {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = PANEL, AutoButtonColor = false,
		ScaleType = Enum.ScaleType.Crop, Image = _obczbshz({}), ZIndex = 2,
	}, root)
	mk(_obczbshz({190,179,174,219,223,220,212,226}), { CornerRadius = UDim.new(1, 0) }, b)
	local press = mk(_obczbshz({190,179,190,207,206,218,212}), { Scale = 1 }, b)
	local fs = mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 2.5, Color = WHITE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
	local ring = mk(_obczbshz({190,179,178,222,206,210,216,213,223,230}), {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 104)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(110, 10, 20)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 90, 104)),
		}),
	}, fs)

	pcall(function()
		game:GetService(_obczbshz({189,225,208,209,219,193,212,226,231,219,214,217})):Create(ring, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), { Rotation = 360 }):Play()
	end)

	local tint = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(20, 2, 5), BackgroundTransparency = 0.78, BorderSizePixel = 0, ZIndex = 2 }, b)
	mk(_obczbshz({190,179,174,219,223,220,212,226}), { CornerRadius = UDim.new(1, 0) }, tint)
	local fallback = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({188}), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 3,
		TextColor3 = WHITE, Font = Enum.Font.GothamBlack, TextSize = 20,
	}, b)
	if ICON_URL:find(_obczbshz({199,210,223,224,221})) then
		task.spawn(function()
			local a = fetchAsset(ICON_URL, _obczbshz({210,205,218,218,155,222,221,215}))
			if a then b.Image = a; fallback.Visible = false; tint.BackgroundTransparency = 0.9 end
		end)
	end

	local badge = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({171}), Size = UDim2.fromOffset(17, 17), Position = UDim2.new(1, -14, 1, -14), ZIndex = 5,
		BackgroundColor3 = Color3.fromRGB(190, 24, 38), TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 10, Visible = false,
	}, root)
	round(badge, 9)
	mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1.5, Color = Color3.fromRGB(9, 4, 6), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, badge)
	UI.onDevice(function(pc) badge.Visible = pc end)

	local dot = mk(_obczbshz({175,220,204,217,210}), {
		Size = UDim2.fromOffset(11, 11), Position = UDim2.new(1, -11, 0, 0), ZIndex = 5,
		BackgroundColor3 = Color3.fromRGB(70, 220, 110), BorderSizePixel = 0, Visible = false,
	}, root)
	round(dot, 6)
	mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1.5, Color = Color3.fromRGB(9, 4, 6), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, dot)

	local tip = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({188,210,212,218,141,182,228,210}), Size = UDim2.fromOffset(0, 24), AutomaticSize = Enum.AutomaticSize.X, Visible = false, ZIndex = 6,
		BackgroundColor3 = Color3.fromRGB(14, 4, 6), BackgroundTransparency = 0.05, TextColor3 = WHITE,
		Font = Enum.Font.GothamMedium, TextSize = 11,
	}, root)
	round(tip, 12)
	mk(_obczbshz({190,179,187,205,209,210,216,222,216}), { PaddingLeft = UDim.new(0, 11), PaddingRight = UDim.new(0, 11) }, tip)
	mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1.2, Color = UI.EDGE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, tip)
	local function showTip(on)
		if not UI.pc then tip.Visible = false; return end
		local open = winRef and winRef.Visible
		tip.Text = (open and _obczbshz({182,211,217,213,218,215,233,209,227}) or _obczbshz({170,204,221,213,223,142,220,213,223,231})) .. _obczbshz({137,138,77,236,15,142,143,178})
		local a = areaSize()
		local leftSide = (root.Position.X.Offset + SIZE / 2) < a.X / 2
		tip.AnchorPoint = Vector2.new(leftSide and 0 or 1, 0.5)
		tip.Position = UDim2.new(leftSide and 1 or 0, leftSide and 8 or -8, 0.5, 0)
		tip.Visible = on
	end

	local pulseTween
	local pulseId = 0
	local function stopPulse()
		pulseId = pulseId + 1
		if pulseTween then pcall(function() pulseTween:Cancel() end); pulseTween = nil end
		pulseScale.Scale = 1; ps.Transparency = 1
	end
	local function startPulse()
		stopPulse()
		pulseId = pulseId + 1
		local my = pulseId
		task.spawn(function()
			while root.Parent and winRef and not winRef.Visible and my == pulseId do
				pulseScale.Scale = 1; ps.Transparency = 0.25
				UI.tween(pulseScale, 1.4, { Scale = 1.55 })
				UI.tween(ps, 1.4, { Transparency = 1 })
				task.wait(2.2)
			end
		end)
	end
	local function syncState()
		local open = winRef and winRef.Visible
		dot.Visible = open and true or false
		fs.Thickness = open and 3 or 2.5
		if not open then startPulse() else stopPulse() end
	end
	if winRef then
		winRef:GetPropertyChangedSignal(_obczbshz({191,211,222,213,207,218,212})):Connect(syncState)
		syncState()
	end

	b.MouseEnter:Connect(function()
		UI.tween(press, 0.14, { Scale = 1.1 }); showTip(true)
	end)
	b.MouseLeave:Connect(function()
		UI.tween(press, 0.14, { Scale = 1 }); showTip(false)
	end)
	b.InputBegan:Connect(function(i) if isPress(i) then UI.tween(press, 0.08, { Scale = 0.88 }); tip.Visible = false end end)
	b.InputEnded:Connect(function(i) if isPress(i) then UI.tween(press, 0.14, { Scale = 1 }) end end)

	local function clampBtn(t)
		local p = t.Position
		local x, y = clampPos(p.X.Offset, p.Y.Offset)
		t.Position = UDim2.fromOffset(x, y)
	end
	local function snap(t)
		local a = areaSize()
		local x, y = clampPos(t.Position.X.Offset, t.Position.Y.Offset)
		local toLeft = (x + SIZE / 2) < a.X / 2
		x = toLeft and MARGIN or (a.X - SIZE - MARGIN)
		UI.tween(t, 0.22, { Position = UDim2.fromOffset(x, y) })
		pcall(function()
			if writefile then
				if not (isfolder and isfolder(FOLDER)) and makefolder then makefolder(FOLDER) end
				writefile(POS_FILE, HttpService:JSONEncode({ x = x / a.X, y = y / a.Y }))
			end
		end)
	end
	makeDraggable(b, root, function()
		UI.tween(rootScale, 0.08, { Scale = 0.94 })
		task.delay(0.08, function() UI.tween(rootScale, 0.12, { Scale = 1 }) end)
		onTap()
	end, snap, clampBtn)

	table.insert(conns, gui:GetPropertyChangedSignal(_obczbshz({170,204,222,219,217,227,227,213,196,219,237,217})):Connect(function()
		pcall(function() clampBtn(root); snap(root) end)
	end))

	pcall(function()
		game:GetService(_obczbshz({189,225,208,209,219,193,212,226,231,219,214,217})):Create(rootScale, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	end)
	return root
end

local function section(par, text)
	local f = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1 }, par)
	local acc = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.fromOffset(3, 15), Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = UI.GLOW, BorderSizePixel = 0 }, f)
	round(acc, 2)
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = text, Size = UDim2.new(1, -14, 1, 0), Position = UDim2.fromOffset(12, 0), BackgroundTransparency = 1, TextColor3 = WHITE,
		Font = Enum.Font.GothamBold, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, f)
	local ln = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, -4, 0, 1), Position = UDim2.new(0, 2, 1, -2), BackgroundColor3 = UI.EDGE, BorderSizePixel = 0 }, f)
	mk(_obczbshz({190,179,178,222,206,210,216,213,223,230}), { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) }) }, ln)
end

local function rowHover(b, st)
	b.MouseEnter:Connect(function()
		UI.tween(b, 0.12, { BackgroundColor3 = UI.HOVER, BackgroundTransparency = 0.05 })
		UI.tween(st, 0.12, { Transparency = 0 })
	end)
	b.MouseLeave:Connect(function()
		UI.tween(b, 0.12, { BackgroundColor3 = PANEL, BackgroundTransparency = 0.25 })
		UI.tween(st, 0.12, { Transparency = 0.35 })
	end)

	b.MouseButton1Down:Connect(function()
		UI.tween(b, 0.06, { BackgroundColor3 = UI.ACTIVE, BackgroundTransparency = 0 })
		UI.tween(st, 0.06, { Color = UI.GLOW, Transparency = 0 })
	end)
	local function release()
		UI.tween(b, 0.16, { BackgroundColor3 = PANEL, BackgroundTransparency = 0.25 })
		UI.tween(st, 0.16, { Color = UI.EDGE, Transparency = 0.35 })
	end
	b.MouseButton1Up:Connect(release)
	b.TouchTap:Connect(release)
end
local function rowBtn(par, text, cb, compact)
	local hgt = compact and 32 or 38
	local b = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
		Text = _obczbshz({}), AutoButtonColor = false, Size = UDim2.new(1, 0, 0, hgt), BackgroundColor3 = PANEL, BackgroundTransparency = 0.25,
	}, par)
	round(b, 10)
	local st = mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1.2, Color = UI.EDGE, Transparency = 0.35, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)

	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = text, Size = UDim2.new(1, -44, 1, 0), Position = UDim2.fromOffset(14, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = compact and 12 or 13, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, b)
	local arrow = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({75,234,37}), Size = UDim2.fromOffset(28, hgt), Position = UDim2.new(1, -34, 0, 0), BackgroundTransparency = 1,
		TextColor3 = UI.GLOW, Font = Enum.Font.GothamBold, TextSize = compact and 20 or 24,
	}, b)
	b.MouseEnter:Connect(function() UI.tween(arrow, 0.14, { Position = UDim2.new(1, -28, 0, 0) }) end)
	b.MouseLeave:Connect(function() UI.tween(arrow, 0.14, { Position = UDim2.new(1, -34, 0, 0) }) end)
	rowHover(b, st)
	b.MouseButton1Click:Connect(cb)
	return b
end
local DARK = Color3.fromRGB(40, 8, 10)
local function toggleRow(par, text, desc, onChange, initial)
	if type(desc) == _obczbshz({207,223,217,207,225,215,222,222}) then initial = onChange; onChange, desc = desc, nil end
	local state = initial and true or false
	local b = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
		Text = _obczbshz({}), AutoButtonColor = false, Size = UDim2.new(1, 0, 0, desc and 48 or 38), BackgroundColor3 = PANEL, BackgroundTransparency = 0.25,
	}, par)
	round(b, 10)
	local st = mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1.2, Color = UI.EDGE, Transparency = 0.35, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = text, Size = UDim2.new(1, -78, 0, desc and 26 or 38), Position = UDim2.fromOffset(14, desc and 3 or 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, b)
	if desc then
		mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = desc, Size = UDim2.new(1, -78, 0, 16), Position = UDim2.fromOffset(14, 27), BackgroundTransparency = 1,
			TextColor3 = UI.SOFT, Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		}, b)
	end
	local sw = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.fromOffset(40, 22), Position = UDim2.new(1, -52, 0.5, -11), BackgroundColor3 = DARK, BorderSizePixel = 0 }, b)
	round(sw, 11)
	local sws = mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1.5, Color = UI.EDGE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, sw)
	local knob = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(3, 3), BackgroundColor3 = WHITE, BorderSizePixel = 0 }, sw)
	round(knob, 8)
	local function paint(anim)
		local kp = state and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3)
		local sc = state and RED or DARK
		local kc = state and WHITE or Color3.fromRGB(190, 150, 152)
		local swc = state and UI.GLOW or UI.EDGE
		if anim then
			UI.tween(knob, 0.14, { Position = kp, BackgroundColor3 = kc })
			UI.tween(sw, 0.14, { BackgroundColor3 = sc })
			UI.tween(sws, 0.14, { Color = swc })
		else
			knob.Position, knob.BackgroundColor3, sw.BackgroundColor3, sws.Color = kp, kc, sc, swc
		end
	end
	paint(false)
	rowHover(b, st)
	b.MouseButton1Click:Connect(function()
		state = not state
		paint(true)
		pcall(onChange, state)
	end)
	return b, function(v) state = v and true or false; paint(true) end
end
local function sliderRow(par, text, desc, minV, maxV, defV, onChange)
	local b = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 48), BackgroundColor3 = PANEL, BackgroundTransparency = 0.25 }, par)
	round(b, 10)
	mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1.2, Color = UI.EDGE, Transparency = 0.35, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = text, Size = UDim2.new(0.5, -16, 0, 26), Position = UDim2.fromOffset(14, 3), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, b)
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = desc, Size = UDim2.new(0.5, -16, 0, 16), Position = UDim2.fromOffset(14, 27), BackgroundTransparency = 1,
		TextColor3 = UI.SOFT, Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, b)
	local val = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = tostring(defV), Size = UDim2.fromOffset(34, 48), Position = UDim2.new(0.5, 0, 0, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 13,
	}, b)
	local hit = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(0.5, -58, 0, 28), Position = UDim2.new(0.5, 38, 0.5, -14), BackgroundTransparency = 1 }, b)
	local bar = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 6), Position = UDim2.new(0, 0, 0.5, -3), BackgroundColor3 = DARK, BorderSizePixel = 0 }, hit)
	round(bar, 3)
	local rel0 = (defV - minV) / (maxV - minV)
	local fill = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(rel0, 0, 1, 0), BackgroundColor3 = RED, BorderSizePixel = 0 }, bar)
	round(fill, 3)
	mk(_obczbshz({190,179,178,222,206,210,216,213,223,230}), { Color = ColorSequence.new(Color3.fromRGB(255, 90, 105), Color3.fromRGB(190, 25, 38)) }, fill)
	local knob = mk(_obczbshz({175,220,204,217,210}), {
		Size = UDim2.fromOffset(14, 14), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(rel0, 0, 0.5, 0),
		BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 2,
	}, bar)
	round(knob, 7)
	mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1.5, Color = RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, knob)
	local dragging = false
	local function setFromX(x)
		local rel = math.clamp((x - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), 0, 1)
		local v = math.floor(minV + (maxV - minV) * rel + 0.5)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		knob.Position = UDim2.new(rel, 0, 0.5, 0)
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
		mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = text, Size = UDim2.new(1, 0, 0, h or 24), BackgroundTransparency = 1,
			TextColor3 = col or WHITE, Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham, TextSize = size,
			TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end
	section(page, _obczbshz({172,220,46,21,209,215,227,223,228}))
	lbl(_obczbshz({175,207,212,224,220,142,223,223,227,146,163,184,232}), 15, true)
	lbl(_obczbshz({183,211,206,215,167,142,212,220,218,230,216,218,231,229,234,236,222,236}), 13, false)
	lbl(_obczbshz({}), 8, false, WHITE, 10)
	lbl(_obczbshz({75,4,11,140,174,228,216,227,224,172,147,227,149,222,236,218,153,232,62,31,236,158,228,243,245,69,36,164,182,182,183,173,169,250,253,251,251,2,254,176,246,178,2,180,246,4,251,249,11,186,14,11,255,16,4,192,2,194,102,69,12,27,8,200,23,109,78,27,205,20,36,30,20,27,34,34,22,228}), 12, true, Color3.fromRGB(255, 190, 120), 44)
end

local COLORS = {
	{ _obczbshz({191,207,221,217,210,218,215,223}), Color3.fromRGB(255, 40, 50) }, { _obczbshz({170,228,224,216}), Color3.fromRGB(60, 140, 255) },
	{ _obczbshz({191,207,221,208,210}), Color3.fromRGB(60, 255, 120) }, { _obczbshz({187,217,227,219}), Color3.fromRGB(170, 70, 255) },
	{ _obczbshz({187,217,222,205}), Color3.fromRGB(255, 90, 200) }, { _obczbshz({170,215,204,222,210,218,222}), Color3.fromRGB(255, 220, 60) },
	{ _obczbshz({171,220,204,218,208,221}), Color3.fromRGB(255, 255, 255) },
}
local STAR_TEX = _obczbshz({219,204,227,205,224,225,212,228,171,161,162,232,218,238,235,237,235,223,238,171,237,223,241,244,234,229,239,233,248,181,250,248,234,252,246,248,242,1,238,253,242,251,1,194,249,250,10})
local FX_KEYS = { _obczbshz({207,211,221,209}), _obczbshz({220,215,218,215,210}), _obczbshz({220,218,204,222,216,218,212,227}), _obczbshz({220,222,204,222,224}), _obczbshz({221,220,204,213,217}), _obczbshz({202,223,221,205}), _obczbshz({213,211,210,212,225}), _obczbshz({219,203,212,218,207,221,230}), _obczbshz({215,207,218,218}), _obczbshz({219,203,212,218,207,221,230,178,224,214,236}), _obczbshz({208,210,218,223,225}) }
local FX_REG = setmetatable({}, { __mode = _obczbshz({212}) })
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
	local r = char:FindFirstChild(_obczbshz({177,223,216,205,219,221,216,212,195,225,226,232,197,215,233,236}))
	local function add(inst, par)
		inst:SetAttribute(_obczbshz({173,221,177,228}), true)
		inst.Parent = par
		table.insert(rec.list, inst)
		return inst
	end
	if r then
		if set.fire then add(mk(_obczbshz({175,211,221,209}), { Color = k, SecondaryColor = k, Size = 7, Heat = 9 }), r) end
		if set.smoke then add(mk(_obczbshz({188,215,218,215,210}), { Color = k, Size = 4, Opacity = 0.4, RiseVelocity = 3 }), r) end
		if set.sparkles then add(mk(_obczbshz({188,218,204,222,216,218,212,227}), { SparkleColor = k }), r) end
		if set.stars then
			add(mk(_obczbshz({185,203,221,224,214,209,219,213,182,223,220,232,233,219,233}), {
				Texture = STAR_TEX, Rate = 30, Lifetime = NumberRange.new(1, 2), Speed = NumberRange.new(2, 5),
				SpreadAngle = Vector2.new(180, 180), Color = ColorSequence.new(k), LightEmission = 1,
				Size = NumberSequence.new(0.5, 0),
			}), r)
		end
		if set.trail then
			local a0 = add(mk(_obczbshz({170,222,223,205,208,214,220,213,223,230}), { Position = Vector3.new(0, 1.2, 0) }), r)
			local a1 = add(mk(_obczbshz({170,222,223,205,208,214,220,213,223,230}), { Position = Vector3.new(0, -1.2, 0) }), r)
			add(mk(_obczbshz({189,220,204,213,217}), {
				Attachment0 = a0, Attachment1 = a1, Lifetime = 0.8, LightEmission = 1, Color = ColorSequence.new(k),
				Transparency = NumberSequence.new(0.1, 1),
			}), r)
		end
		if set.light then add(mk(_obczbshz({185,217,212,218,225,186,216,215,217,230}), { Color = k, Range = 18, Brightness = 3 }), r) end
	end
	if set.aura then
		add(mk(_obczbshz({177,211,210,212,217,215,214,216,229}), { Adornee = char, FillColor = k, OutlineColor = k, FillTransparency = 0.65, OutlineTransparency = 0 }), char)
	end

	for _, p in ipairs(char:GetDescendants()) do
		if p:IsA(_obczbshz({171,203,222,209,189,207,225,228})) and p.Name ~= _obczbshz({177,223,216,205,219,221,216,212,195,225,226,232,197,215,233,236}) and not p:GetAttribute(_obczbshz({173,221,177,228})) then
			if set.neon then
				if p:GetAttribute(_obczbshz({173,221,186,185})) == nil then p:SetAttribute(_obczbshz({173,221,186,185}), p.Material.Name) end
				p.Material = Enum.Material.Neon
			elseif p:GetAttribute(_obczbshz({173,221,186,185})) then
				p.Material = Enum.Material[p:GetAttribute(_obczbshz({173,221,186,185}))]; p:SetAttribute(_obczbshz({173,221,186,185}), nil)
			end
			if set.ghost then
				if p:GetAttribute(_obczbshz({173,221,186,192})) == nil then p:SetAttribute(_obczbshz({173,221,186,192}), p.Transparency) end
				p.Transparency = math.max(p:GetAttribute(_obczbshz({173,221,186,192})), 0.65)
			elseif p:GetAttribute(_obczbshz({173,221,186,192})) then
				p.Transparency = p:GetAttribute(_obczbshz({173,221,186,192})); p:SetAttribute(_obczbshz({173,221,186,192}), nil)
			end
			if set.rainbowBody then
				if p:GetAttribute(_obczbshz({173,221,186,175})) == nil then p:SetAttribute(_obczbshz({173,221,186,175}), p.Color) end
				table.insert(rec.body, p)
			elseif p:GetAttribute(_obczbshz({173,221,186,175})) then
				p.Color = p:GetAttribute(_obczbshz({173,221,186,175})); p:SetAttribute(_obczbshz({173,221,186,175}), nil)
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
						if o:IsA(_obczbshz({177,211,210,212,217,215,214,216,229})) then o.FillColor = c; o.OutlineColor = c
						elseif o:IsA(_obczbshz({175,211,221,209})) then o.Color = c; o.SecondaryColor = c
						elseif o:IsA(_obczbshz({188,215,218,215,210})) then o.Color = c
						elseif o:IsA(_obczbshz({188,218,204,222,216,218,212,227})) then o.SparkleColor = c
						elseif o:IsA(_obczbshz({185,217,212,218,225,186,216,215,217,230})) then o.Color = c
						elseif o:IsA(_obczbshz({189,220,204,213,217})) or o:IsA(_obczbshz({185,203,221,224,214,209,219,213,182,223,220,232,233,219,233})) then o.Color = ColorSequence.new(c) end
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
			http(_obczbshz({173,175,183,177,193,179}), _obczbshz({152,215,218,208,224,157}) .. uid .. _obczbshz({151,212,222,219,219}))
		else
			mine.beat = (mine.beat or 0) + 1
			http(_obczbshz({185,191,191}), _obczbshz({152,215,218,208,224,157}) .. uid .. _obczbshz({151,212,222,219,219}), {
				name = lp.Name, ids = table.concat(mine.ids, _obczbshz({149})), headless = mine.headless,
				fx = mine.fx or _obczbshz({}), fc = mine.fc or 1, tag = mine.tag, bc = mine.bc,
				beat = mine.beat, t = os.time(),
			})
		end
	end
	publishMods = publish

	local lastLoadErr = {}
	local function loadAsset(id)
		if cache[id] then return cache[id] end
		local objs
		local ok, res = pcall(function() return game:GetObjects(_obczbshz({219,204,227,205,224,225,212,228,218,214,173,163,164}) .. id) end)
		if ok and type(res) == _obczbshz({221,203,205,216,210}) and #res > 0 then
			objs = res
			DSLOG.info(_obczbshz({202,221,222,209,225}), _obczbshz({178,174,139}) .. id .. _obczbshz({163,138,178,209,225,189,209,218,214,213,231,231,149,229,226,152,161}) .. #res .. _obczbshz({137,217,205,214,210,226,222,152,228,155,156}))
		else
			local why = ok and _obczbshz({223,217,215,224,220,227,143,230,210,236,220,227}) or tostring(res):sub(1, 90)
			DSLOG.warn(_obczbshz({202,221,222,209,225}), _obczbshz({178,174,139}) .. id .. _obczbshz({163,138,178,209,225,189,209,218,214,213,231,231,149,220,216,228,225,233,240,156,165}) .. why .. _obczbshz({146,150,139,224,210,220,227,209,223,214,226,148,190,228,234,221,235,238,206,225,239,244,232,227,230}))
			local ok2, m = pcall(function() return game:GetService(_obczbshz({178,216,222,209,223,226,194,213,227,232,220,215,218})):LoadAsset(id) end)
			if ok2 and m then
				local kids = m:GetChildren()
				if #kids > 0 then
					objs = kids
					DSLOG.info(_obczbshz({202,221,222,209,225}), _obczbshz({178,174,139}) .. id .. _obczbshz({163,138,180,218,224,211,225,228,196,215,229,234,222,217,220,152,232,229,155,164}) .. #kids .. _obczbshz({137,217,205,214,210,226,222,152,228,155,156}))
				else
					lastLoadErr[id] = _obczbshz({214,217,207,209,217,221,143,230,210,236,220,227})
					DSLOG.err(_obczbshz({202,221,222,209,225}), _obczbshz({178,174,139}) .. id .. _obczbshz({163,138,180,218,224,211,225,228,196,215,229,234,222,217,220,152,239,233,231,240,236,243,159,245,238,162,240,243,233,235,243,247,169,0,236,6,246,253}))
				end
			else
				lastLoadErr[id] = ok2 and _obczbshz({223,217,215,224,220,227,143,222,210,214,212}) or tostring(m):sub(1, 70)
				DSLOG.err(_obczbshz({202,221,222,209,225}), _obczbshz({178,174,139}) .. id .. _obczbshz({163,138,180,218,224,211,225,228,196,215,229,234,222,217,220,152,223,219,231,228,236,243,185,160}) .. lastLoadErr[id])
			end
		end
		if objs then
			local removed = 0
			for _, o in ipairs(objs) do
				for _, d in ipairs(o:GetDescendants()) do
					if d:IsA(_obczbshz({181,223,204,191,220,227,225,211,214,181,226,226,233,215,224,230,222,236})) or d:IsA(_obczbshz({188,217,224,218,209})) then d:Destroy(); removed = removed + 1 end
				end
			end
			if removed > 0 then DSLOG.info(_obczbshz({202,221,222,209,225}), _obczbshz({178,174,139}) .. id .. _obczbshz({163,138}) .. removed .. _obczbshz({137,221,206,222,214,222,227,152,228,155,162,231,228,227,159,230,236,163,155,238,226,235,238,246,234,230,242,172,248,175})) end
			cache[id] = objs
		end
		return objs
	end

	local function limb(char, mp)
		if mp:FindFirstAncestorOfClass(_obczbshz({170,205,206,209,224,225,222,226,234})) then return end
		local t = char:FindFirstChild(mp.Name)
		if not (t and t:IsA(_obczbshz({171,203,222,209,189,207,225,228}))) or t:GetAttribute(_obczbshz({173,221,184,219,209})) then return end
		local c = mp:Clone()
		c:ClearAllChildren()
		c.Anchored = false; c.CanCollide = false; c.Massless = true
		c.CFrame = t.CFrame
		c:SetAttribute(_obczbshz({173,221,184,219,209}), true)
		c.Parent = char
		local w = Instance.new(_obczbshz({192,207,215,208,176,221,221,227,229,228,212,221,227,234}))
		w.Part0 = c; w.Part1 = t; w.Parent = c
		t.Transparency = 1
		t:SetAttribute(_obczbshz({173,221,179,213,209,186,216,221,211}), true)
	end

	local EFX = { ParticleEmitter = true, Fire = true, Smoke = true, Sparkles = true, PointLight = true, SpotLight = true, SurfaceLight = true }

	local clearGen = 0
	local HEAD_SLOTS = { Hat = true, Hair = true, Face = true, Eyebrow = true, Eyelash = true }
	local function slotOf(o)
		if o:IsA(_obczbshz({177,203,223})) then return _obczbshz({177,203,223}) end
		local ok, at = pcall(function() return o.AccessoryType end)
		if ok and at and at ~= Enum.AccessoryType.Unknown then
			return HEAD_SLOTS[at.Name] and at.Name or nil
		end
		local h = o:FindFirstChild(_obczbshz({177,203,217,208,217,211}))
		local att = h and h:FindFirstChildOfClass(_obczbshz({170,222,223,205,208,214,220,213,223,230}))
		if att then
			local n = att.Name
			if n == _obczbshz({177,203,223,173,225,226,208,211,217,223,216,226,233}) then return _obczbshz({177,203,223}) end
			if n == _obczbshz({177,203,212,222,174,226,227,209,212,218,224,217,227,234}) then return _obczbshz({177,203,212,222}) end
			if n:match(_obczbshz({199,176,204,207,210})) then return _obczbshz({175,203,206,209}) end
		end
		return nil
	end
	local function isHeadAcc(o) return slotOf(o) ~= nil end

	local function hideStashed(o)
		for _, p in ipairs(o:GetDescendants()) do
			if p:IsA(_obczbshz({171,203,222,209,189,207,225,228})) and p:GetAttribute(_obczbshz({173,221,179,213,209,175,210,211})) == nil then
				p:SetAttribute(_obczbshz({173,221,179,213,209,175,210,211}), p.Transparency)
				p.Transparency = 1
			end
		end
	end
	local function showStashed(o)
		for _, p in ipairs(o:GetDescendants()) do
			if p:IsA(_obczbshz({171,203,222,209,189,207,225,228})) and p:GetAttribute(_obczbshz({173,221,179,213,209,175,210,211})) ~= nil then
				p.Transparency = p:GetAttribute(_obczbshz({173,221,179,213,209,175,210,211}))
				p:SetAttribute(_obczbshz({173,221,179,213,209,175,210,211}), nil)
			end
		end
	end

	local function clearHeadAccessories(char, slot)
		local st = char:FindFirstChild(_obczbshz({173,221,190,224,206,225,215}))
		for _, o in ipairs(char:GetChildren()) do
			if o:IsA(_obczbshz({170,205,206,209,224,225,222,226,234})) or o:IsA(_obczbshz({177,203,223})) then
				local s = slotOf(o)
				if s and (slot == nil or s == slot) then
					if o:GetAttribute(_obczbshz({173,221,184,219,209})) then
						clearGen = clearGen + 1
						o:Destroy()
					else
						if not st then
							st = Instance.new(_obczbshz({175,217,215,208,210,224})); st.Name = _obczbshz({173,221,190,224,206,225,215}); st.Parent = char
						end
						o.Parent = st
						hideStashed(o)
						DSLOG.info(_obczbshz({202,205,208,223,224,49,34,226,218,225}), _obczbshz({216,220,212,211,214,220,208,220,145,153}) .. o.Name .. _obczbshz({144,138,147}) .. s .. _obczbshz({146,138,210,225,206,224,211,209,213,225,147,217,149,219,234,219,232,232,223,229,225,237}))
					end
				end
			end
		end
	end

	local function stash(char, class)
		local st = char:FindFirstChild(_obczbshz({173,221,190,224,206,225,215}))
		if not st then
			st = Instance.new(_obczbshz({175,217,215,208,210,224})); st.Name = _obczbshz({173,221,190,224,206,225,215}); st.Parent = char
		end
		for _, o in ipairs(char:GetChildren()) do
			if o:IsA(class) and not o:GetAttribute(_obczbshz({173,221,184,219,209})) then o.Parent = st end
		end
	end

	local function attachProp(char, src)
		local r = char:FindFirstChild(_obczbshz({177,223,216,205,219,221,216,212,195,225,226,232,197,215,233,236}))
		if not r then return end
		local c = src:Clone()
		for _, d in ipairs(c:GetDescendants()) do
			if d:IsA(_obczbshz({177,223,216,205,219,221,216,212})) or d:IsA(_obczbshz({170,216,212,217,206,226,222,226})) then d:Destroy() end
		end
		local parts = {}
		if c:IsA(_obczbshz({171,203,222,209,189,207,225,228})) then table.insert(parts, c) end
		for _, d in ipairs(c:GetDescendants()) do
			if d:IsA(_obczbshz({171,203,222,209,189,207,225,228})) then table.insert(parts, d) end
		end
		if #parts == 0 or #parts > 200 then c:Destroy(); return end
		for _, p in ipairs(parts) do
			p.Anchored = false; p.CanCollide = false; p.Massless = true
		end
		c:SetAttribute(_obczbshz({173,221,184,219,209}), true)
		c.Parent = char
		if c:IsA(_obczbshz({182,217,207,209,217})) then c:PivotTo(r.CFrame) else c.CFrame = r.CFrame end
		for _, p in ipairs(parts) do
			local w = Instance.new(_obczbshz({192,207,215,208,176,221,221,227,229,228,212,221,227,234}))
			w.Part0 = p; w.Part1 = r; w.Parent = p
		end
	end

	local manualAcc = false
	local function placeManual(char, o)
		local c = o:Clone(); c:SetAttribute(_obczbshz({173,221,184,219,209}), true)
		local h = c:FindFirstChild(_obczbshz({177,203,217,208,217,211}))
		local ha = h and h:FindFirstChildOfClass(_obczbshz({170,222,223,205,208,214,220,213,223,230}))
		if not (h and ha) then
			DSLOG.err(_obczbshz({202,205,208,223,224,49,34,226,218,225}), o.Name .. _obczbshz({163,138,222,209,218,142,183,209,223,214,223,217,149,229,236,152,236,223,232,156,226,236,226,225,234,250,232,164,173,199,251,252,234,237,243,249,242,252,3,185,189,178,1,87,56,5,183,252,92,59,187,12,15,255,191,19,16,14,7,5,23}))
			c:Destroy(); return false
		end
		local target, tAtt
		for _, p in ipairs(char:GetChildren()) do
			if p:IsA(_obczbshz({171,203,222,209,189,207,225,228})) then
				local a = p:FindFirstChild(ha.Name)
				if a and a:IsA(_obczbshz({170,222,223,205,208,214,220,213,223,230})) then target, tAtt = p, a; break end
			end
		end
		if not target then
			DSLOG.err(_obczbshz({202,205,208,223,224,49,34,226,218,225}), o.Name .. _obczbshz({163,138,218,140,224,211,228,144,212,225,229,228,228,150,229,59,28,233,155,240,226,235,159,239,161,231,241,231,230,239,255,237,169,177}) .. ha.Name .. _obczbshz({144,138,147,190,163,157,193,161,166,146,215,221,219,219,233,221,231,238,224,187,166}))
			c:Destroy(); return false
		end
		local folder = char:FindFirstChild(_obczbshz({173,221,172,207,208}))
		if not folder then
			folder = Instance.new(_obczbshz({175,217,215,208,210,224})); folder.Name = _obczbshz({173,221,172,207,208}); folder:SetAttribute(_obczbshz({173,221,184,219,209}), true); folder.Parent = char
		end
		h.Anchored = false; h.CanCollide = false; h.Massless = true
		c.Parent = folder
		local w = Instance.new(_obczbshz({192,207,215,208}))
		w.Name = _obczbshz({173,221,172,207,208,197,212,220,213}); w.Part0 = target; w.Part1 = h; w.C0 = tAtt.CFrame; w.C1 = ha.CFrame
		w.Parent = h
		DSLOG.info(_obczbshz({202,205,208,223,224,49,34,226,218,225}), _obczbshz({144}) .. o.Name .. _obczbshz({144,138,206,219,217,221,210,209,213,225,147,217,226,150,196,199,189,201,155,201,190,204,212,193,205,162,232,241,165}) .. target.Name .. _obczbshz({137,146,208,218,208,207,216,232,214,146}) .. ha.Name .. _obczbshz({146}))
		return true
	end

	local function handle(char, hm, r, o)
		DSLOG.info(_obczbshz({210,222,208,217}), o.ClassName .. _obczbshz({137,145}) .. o.Name .. _obczbshz({144}))
		if o:IsA(_obczbshz({170,205,206,209,224,225,222,226,234})) then
			if not hm then
				DSLOG.warn(_obczbshz({202,205,208,223,224,49,34,226,218,225}), o.Name .. _obczbshz({163,138,222,209,226,142,223,213,227,229,226,226,214,221,220,229,153,223,238,240,64,31,159,243,230,239,163,204,250,243,232,246,248,243,239,172,238,245,254,2,242,190,179,4,10,2,252,1}))
				return true
			end
			local slot = slotOf(o)
			if slot then clearHeadAccessories(char, slot) end
			if manualAcc then placeManual(char, o); return true end
			local c = o:Clone(); c:SetAttribute(_obczbshz({173,221,184,219,209}), true)
			local h = c:FindFirstChild(_obczbshz({177,203,217,208,217,211}))
			local hAtt = h and h:FindFirstChildOfClass(_obczbshz({170,222,223,205,208,214,220,213,223,230}))
			local okT, accType = pcall(function() return o.AccessoryType.Name end)
			local layered = h and (h:FindFirstChildOfClass(_obczbshz({192,220,204,220,185,207,232,213,227})) ~= nil) or false
			local gone, newParent, myGen = false, nil, clearGen
			pcall(function() c.Destroying:Connect(function() gone = true end) end)
			pcall(function() c.AncestryChanged:Connect(function(_, p) newParent = p end) end)
			local okAdd, errAdd = pcall(function() hm:AddAccessory(c) end)
			if not okAdd then
				DSLOG.err(_obczbshz({202,205,208,223,224,49,34,226,218,225}), o.Name .. _obczbshz({163,138,172,208,209,175,210,211,214,229,230,227,231,239,151,222,218,230,227,235,242,184,159}) .. tostring(errAdd):sub(1, 100))
				c:Destroy()
				return true
			end
			DSLOG.info(_obczbshz({202,205,208,223,224,49,34,226,218,225}), string.format(_obczbshz({144,143,222,147,141,209,222,220,224,213,212,216,228,150,243,152,237,227,235,235,186,163,242,160,253,162,232,242,232,231,240,0,238,199,176,255,173,10,175,6,242,249,244,209,186,9,188,11}), o.Name,
				okT and accType or _obczbshz({168}), hAtt and hAtt.Name or _obczbshz({183,175,185,180,194,187}), slot or _obczbshz({204,217,221,220,220}),
				layered and _obczbshz({137,230,139,222,220,227,223,209,145,215,224,148,216,215,228,217,221,219,238,156,165,213,241,225,241,206,228,253,234,248,179,168,249,249,239,241,173,252,82,51,0,178,247,249,251,5,9,5,250,12,196}) or _obczbshz({})))
			if not h then DSLOG.err(_obczbshz({202,205,208,223,224,49,34,226,218,225}), o.Name .. _obczbshz({163,138,217,47,16,221,143,228,214,223,147,188,214,228,219,228,222,166,155,234,64,33,238,160,247,227,236,164,230,246,232,250,238,237,240,254})) end

			task.delay(0.6, function()
				if not c.Parent then
					if clearGen ~= myGen then return end
					DSLOG.warn(_obczbshz({202,205,208,223,224,49,34,226,218,225}), _obczbshz({144}) .. c.Name .. _obczbshz({144,138,209,219,214,142,193,181,190,193,201,189,185,197,151,220,232,154,235,225,239,241,238,238,226,233,232,241,165,235,244,168,246,239,249,251,0,174,243,245,177,194,193,202,8,182,191})
						.. (gone and _obczbshz({173,207,222,224,223,221,232,152,154}) or (_obczbshz({214,217,225,213,209,221,143,224,227,211,147}) .. tostring(newParent and newParent.Name or _obczbshz({215,211,215}))))
						.. _obczbshz({146,152,139,185,226,210,208,222,213,225,147,228,231,229,151,229,232,222,234,156,234,223,237,245,226,238}))
					manualAcc = true
					if char.Parent and char:GetAttribute(_obczbshz({173,221,190,213,212})) ~= nil then
						if placeManual(char, o) then char:SetAttribute(_obczbshz({173,221,185}), 1) end
					end
					return
				end
				local hh = c:FindFirstChild(_obczbshz({177,203,217,208,217,211}))
				local root2 = char:FindFirstChild(_obczbshz({177,223,216,205,219,221,216,212,195,225,226,232,197,215,233,236}))
				if not (hh and root2) then return end
				if (hh.Position - root2.Position).Magnitude < 15 then return end
				local ha = hh:FindFirstChildOfClass(_obczbshz({170,222,223,205,208,214,220,213,223,230}))
				local target, tAtt
				if ha then
					for _, p in ipairs(char:GetChildren()) do
						if p:IsA(_obczbshz({171,203,222,209,189,207,225,228})) then
							local a = p:FindFirstChild(ha.Name)
							if a and a:IsA(_obczbshz({170,222,223,205,208,214,220,213,223,230})) then target, tAtt = p, a; break end
						end
					end
				end
				if target then
					hh.Anchored = false; hh.CanCollide = false; hh.Massless = true
					local w = Instance.new(_obczbshz({192,207,215,208}))
					w.Name = _obczbshz({173,221,172,207,208,197,212,220,213}); w.Part0 = target; w.Part1 = hh; w.C0 = tAtt.CFrame; w.C1 = ha.CFrame
					w.Parent = hh
					DSLOG.warn(_obczbshz({202,205,208,223,224,49,34,226,218,225}), _obczbshz({144}) .. c.Name .. _obczbshz({144,138,217,47,16,221,143,213,223,213,212,221,237,229,236,152,236,233,245,229,235,230,238,187,161,245,242,240,233,235,240,168,247,235,171,249,80,49,254,176,246,255,179}) .. target.Name .. _obczbshz({137,146,208,218,208,207,216,232,214,146}) .. ha.Name .. _obczbshz({146}))
				else
					DSLOG.err(_obczbshz({202,205,208,223,224,49,34,226,218,225}), _obczbshz({144}) .. c.Name .. _obczbshz({144,138,215,219,219,213,212,144,213,225,147,215,228,232,231,231,153,223,155,239,226,235,159,229,239,229,228,237,253,235,167,175}) .. (ha and ha.Name or _obczbshz({168})) .. _obczbshz({144,138,217,219,141,225,212,229,145,213,226,230,229,229,151,160,203,176,170,206,174,179,159,228,234,232,232,246,234,244,251,237,200,179}))
				end
			end)
			return true
		elseif o:IsA(_obczbshz({177,203,223})) then
			DSLOG.info(_obczbshz({204,210,204,220,48,23,228}), _obczbshz({204,210,204,220,48,23,228,144,210,224,231,221,220,229,151,160,220,230,220,239,240,227,159,200,226,246,172,164,172}) .. o.Name .. _obczbshz({144,150,139,223,220,218,211,209,223,214,226,148,227,215,151,219,218,220,224,63,36,223}))

			local head = char:FindFirstChild(_obczbshz({177,207,204,208}))
			local srcHandle = o:FindFirstChild(_obczbshz({177,203,217,208,217,211}))
				if not (head and srcHandle) then DSLOG.warn(_obczbshz({204,210,204,220,48,23,228}), o.Name .. _obczbshz({163,138,222,209,218,142,183,213,210,214,147,227,234,150,234,221,230,154,195,221,235,226,235,229,173,162,236,235,243,245,249,233,237,249})) end
			if head and srcHandle then
				clearHeadAccessories(char, _obczbshz({177,203,223}))
				local c = o:Clone(); c:SetAttribute(_obczbshz({173,221,184,219,209}), true)
				local h = c:FindFirstChild(_obczbshz({177,203,217,208,217,211}))
				h.Anchored = false; h.CanCollide = false; h.Massless = true
				local okPos, pos = pcall(function() return c.AttachmentPos end)
				local offset = (okPos and typeof(pos) == _obczbshz({191,207,206,224,220,224,162})) and CFrame.new(pos) or CFrame.new(0, 0.6, 0)
				h.CFrame = head.CFrame * offset
				c.Parent = char
				local w = Instance.new(_obczbshz({192,207,215,208,176,221,221,227,229,228,212,221,227,234}))
				w.Part0 = head; w.Part1 = h; w.Parent = h
			end
			return true
		elseif o:IsA(_obczbshz({188,210,212,222,225})) or o:IsA(_obczbshz({185,203,217,224,224})) or o:IsA(_obczbshz({188,210,212,222,225,181,225,209,225,218,220,215})) or o:IsA(_obczbshz({171,217,207,229,176,221,219,223,227,229})) then
			stash(char, o.ClassName)
			local c = o:Clone(); c:SetAttribute(_obczbshz({173,221,184,219,209}), true); c.Parent = char
			return true
		elseif o:IsA(_obczbshz({172,210,204,222,206,209,227,213,227,191,216,231,221})) then
			local c = o:Clone(); c:SetAttribute(_obczbshz({173,221,184,219,209}), true); c.Parent = char
			return true
		elseif o:IsA(_obczbshz({173,207,206,205,217})) then
			local head = char:FindFirstChild(_obczbshz({177,207,204,208}))
			if head then
				for _, d in ipairs(head:GetChildren()) do
					if d:IsA(_obczbshz({173,207,206,205,217})) and not d:GetAttribute(_obczbshz({173,221,184,219,209})) and not d:GetAttribute(_obczbshz({173,221,179,213,209,178,212,211,210,222})) then
						d.Transparency = 1; d:SetAttribute(_obczbshz({173,221,179,213,209,178,212,211,210,222}), true)
					end
				end
				local c = o:Clone(); c.Face = Enum.NormalId.Front; c:SetAttribute(_obczbshz({173,221,184,219,209}), true); c.Parent = head
			end
			return true
		elseif EFX[o.ClassName] then
			if r then
				local c = o:Clone(); c:SetAttribute(_obczbshz({173,221,184,219,209}), true); c.Parent = r
			end
			return true
		elseif o:IsA(_obczbshz({182,207,222,212,189,207,225,228})) and char:FindFirstChild(o.Name) and char[o.Name]:IsA(_obczbshz({171,203,222,209,189,207,225,228})) then
			limb(char, o)
			return true
		elseif o:IsA(_obczbshz({182,217,207,209,217})) or o:IsA(_obczbshz({175,217,215,208,210,224})) then
			local any = false
			for _, ch in ipairs(o:GetChildren()) do
				if handle(char, hm, r, ch) then any = true end
			end
			if not any and o:IsA(_obczbshz({182,217,207,209,217})) then
				attachProp(char, o)
				any = true
			end
			return any
		elseif o:IsA(_obczbshz({171,203,222,209,189,207,225,228})) then
			if char:FindFirstChild(o.Name) then return false end
			attachProp(char, o)
			return true
		end
		return false
	end

	local function applyOne(char, id)
		local objs = loadAsset(id)
		if not objs then return false end
		local hm = char:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212}))
		local r = char:FindFirstChild(_obczbshz({177,223,216,205,219,221,216,212,195,225,226,232,197,215,233,236}))
		for _, o in ipairs(objs) do
			local ok, ret = pcall(handle, char, hm, r, o)
			if not ok then
				DSLOG.err(_obczbshz({210,222,208,217}), _obczbshz({178,174,139}) .. id .. _obczbshz({137,146}) .. o.ClassName .. _obczbshz({137,145}) .. o.Name .. _obczbshz({144,147,165,140}) .. tostring(ret):sub(1, 140))
			elseif ret == false then
				DSLOG.warn(_obczbshz({210,222,208,217}), _obczbshz({178,174,139}) .. id .. _obczbshz({137,146}) .. o.ClassName .. _obczbshz({137,145}) .. o.Name .. _obczbshz({144,147,165,140,219,49,18,223,145,229,216,221,149,215,231,228,226,221,220,238,157,227,242,243,230,162,247,237,245,245,167,236,238,170,244,0,242,251}))
			end
		end
		return true
	end

	DSLOG.inspect = function(idText)
		local n = tonumber(tostring(idText or _obczbshz({})):match(_obczbshz({142,206,150})))
		if not n then DSLOG.warn(_obczbshz({210,216,222,220,210,209,216,223,223,211,229}), _obczbshz({205,211,210,213,225,211,143,229,222,146,188,184,149,158,234,59,44,154,233,63,55,235,228,242,240,245,172})); return end
		DSLOG.info(_obczbshz({210,216,222,220,210,209,216,223,223,211,229}), _obczbshz({178,174,139}) .. n .. _obczbshz({163,138,206,205,223,224,212,215,210,224,215,227,163,164,165}))
		local objs = loadAsset(n)
		if not objs then
			DSLOG.err(_obczbshz({210,216,222,220,210,209,216,223,223,211,229}), _obczbshz({178,174,139}) .. n .. _obczbshz({137,184,46,239,188,142,210,209,227,228,216,219,228,235,177,152}) .. tostring(lastLoadErr[n] or _obczbshz({220,207,216,140,210,224,225,223,145,154,233,227,225,234,230,237,153,240,220,246,230,237,168})))
			return
		end
		local shown = 0
		for _, o in ipairs(objs) do
			local extra = _obczbshz({})
			if o:IsA(_obczbshz({170,205,206,209,224,225,222,226,234})) then
				local okT, at = pcall(function() return o.AccessoryType.Name end)
				extra = _obczbshz({137,222,212,220,220,171}) .. (okT and at or _obczbshz({168})) .. _obczbshz({137,224,204,211,206,171}) .. tostring(slotOf(o) or _obczbshz({204,217,221,220,220}))
			end
			DSLOG.info(_obczbshz({210,216,222,220,210,209,216,223,223,211,229}), _obczbshz({178,174,139}) .. n .. _obczbshz({137,220,204,213,231,168,143}) .. o.ClassName .. _obczbshz({137,145}) .. o.Name .. _obczbshz({144}) .. extra)
			for _, d in ipairs(o:GetDescendants()) do
				shown = shown + 1
				if shown > 40 then DSLOG.info(_obczbshz({210,216,222,220,210,209,216,223,223,211,229}), _obczbshz({151,152,153,140,149,219,208,217,228,146,220,232,218,228,234,152,231,61,30,235,157,234,232,243,245,227,231,243,248,175})); return end
				DSLOG.info(_obczbshz({210,216,222,220,210,209,216,223,223,211,229}), _obczbshz({137,138,152,140}) .. d.ClassName .. _obczbshz({137,145}) .. d.Name .. _obczbshz({144,138,208,217,141}) .. d.Parent.Name)
			end
		end
	end

	local function clearMods(char)
		clearGen = clearGen + 1
		local restored, removed = 0, 0
		local st = char:FindFirstChild(_obczbshz({173,221,190,224,206,225,215}))
		if st then
			for _, o in ipairs(st:GetChildren()) do
				showStashed(o)
				o.Parent = char
				restored = restored + 1
			end
			st:Destroy()
		end
		for _, o in ipairs(char:GetDescendants()) do
			if o:GetAttribute(_obczbshz({173,221,184,219,209})) then
				o:Destroy(); removed = removed + 1
			elseif o:GetAttribute(_obczbshz({173,221,179,213,209,186,216,221,211})) then
				o.Transparency = 0; o:SetAttribute(_obczbshz({173,221,179,213,209,186,216,221,211}), nil)
			elseif o:GetAttribute(_obczbshz({173,221,179,213,209,178,212,211,210,222})) then
				o.Transparency = 0; o:SetAttribute(_obczbshz({173,221,179,213,209,178,212,211,210,222}), nil)
			end
		end
		if removed > 0 or restored > 0 then
			DSLOG.info(_obczbshz({213,211,216,220,206,224}), removed .. _obczbshz({137,211,223,209,218,150,221,227,154,146,215,227,149,222,236,218,153,236,224,233,236,244,232,228,240,170,246,173,177,166}) .. restored .. _obczbshz({137,217,221,213,212,215,221,209,221,154,220,231,158,150,219,221,239,233,231,242,230,226,238,168,244,171}))
		end
	end

	local function headless(char)
		local head = char:FindFirstChild(_obczbshz({177,207,204,208}))
		if not head then return end
		head.Transparency = 1; head:SetAttribute(_obczbshz({173,221,179,213,209,186,216,221,211}), true)
		for _, d in ipairs(head:GetChildren()) do
			if d:IsA(_obczbshz({173,207,206,205,217})) then d.Transparency = 1; d:SetAttribute(_obczbshz({173,221,179,213,209,178,212,211,210,222}), true) end
		end
	end

	local function applyBC(char, bc)
		local cols = {}
		for h in tostring(bc):gmatch(_obczbshz({142,226,144,228,146,230,148,232,150,234,152,236})) do
			cols[#cols + 1] = Color3.fromRGB(tonumber(h:sub(1, 2), 16), tonumber(h:sub(3, 4), 16), tonumber(h:sub(5, 6), 16))
		end
		if #cols < 6 then return end
		stash(char, _obczbshz({171,217,207,229,176,221,219,223,227,229}))
		local b = Instance.new(_obczbshz({171,217,207,229,176,221,219,223,227,229}))
		b.HeadColor3, b.TorsoColor3 = cols[1], cols[2]
		b.LeftArmColor3, b.RightArmColor3 = cols[3], cols[4]
		b.LeftLegColor3, b.RightLegColor3 = cols[5], cols[6]
		b:SetAttribute(_obczbshz({173,221,184,219,209}), true)
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
		return { ids = table.concat(mine.ids, _obczbshz({149})), headless = mine.headless, fx = mine.fx or _obczbshz({}), fc = mine.fc or 1, bc = mine.bc }
	end

	local function appearanceReady(pl)
		local ok, v = pcall(function() return pl:HasAppearanceLoaded() end)
		if ok and v == false then return false end
		return true
	end
	local function countMods(char)
		local n = 0
		for _, d in ipairs(char:GetDescendants()) do
			if d:GetAttribute(_obczbshz({173,221,184,219,209})) then n = n + 1 end
		end
		return n
	end
	local reapplied = setmetatable({}, { __mode = _obczbshz({212}) })
	local waitSince = setmetatable({}, { __mode = _obczbshz({212}) })
	local netState = nil

	local function retryFailed(pl, char, want, ids, attempt)
		if attempt > 3 then
			local t = {}
			for _, i in ipairs(ids) do t[#t + 1] = tostring(i) end
			DSLOG.err(_obczbshz({220,227,217,207}), pl.Name .. _obczbshz({163,138,207,209,224,215,226,228,218,146,215,227,232,150,192,188,236,154}) .. table.concat(t, _obczbshz({149,138})) .. _obczbshz({137,146,212,218,227,49,16,220,218,214,226,231,161,150,217,228,232,235,240,225,222,226,238,243,161,241,248,164,244,166,236,0,238,237,0,0,252,0,175,254,84,53,2,180,248,5,5,11,254,1,16,1,189,1,0,18,19,7,10,5,23,207}))
			return
		end
		task.delay(3 * attempt, function()
			if not (char and char.Parent) or char:GetAttribute(_obczbshz({173,221,190,213,212})) ~= want then return end
			local still = {}
			for _, i in ipairs(ids) do
				local ok, applied = pcall(applyOne, char, i)
				if not (ok and applied) then still[#still + 1] = i end
			end
			char:SetAttribute(_obczbshz({173,221,185}), countMods(char))
			if #still > 0 then
				retryFailed(pl, char, want, still, attempt + 1)
			else
				DSLOG.info(_obczbshz({220,227,217,207}), pl.Name .. _obczbshz({163,138,218,223,141,183,179,227,145,227,232,217,149,220,216,228,237,219,241,221,234,158,226,225,243,244,232,235,230,248,232,245,169,248,236,172,1,243,253,4,242,6,252,10,246,182}) .. attempt)
			end
		end)
	end

	local function sync()
		local body = http(_obczbshz({176,175,191}), _obczbshz({152,215,218,208,224,156,217,227,224,224}))
		local netOk = body ~= nil
		if netOk ~= netState then
			netState = netOk
			if netOk then
				DSLOG.info(_obczbshz({220,227,217,207}), _obczbshz({175,211,221,209,207,207,226,213,145,228,216,231,229,229,229,220,222,239,155,164,239,227,227,229,161,209,206,173}))
			else
				DSLOG.err(_obczbshz({220,227,217,207}), _obczbshz({175,211,221,209,207,207,226,213,145,192,54,247,196,150,233,221,236,234,234,234,225,227,244,160,169}) .. tostring(lastErr) .. _obczbshz({146,164,139,205,221,218,216,211,224,146,230,55,40,150,230,235,153,237,224,241,240,158,236,239,229,245,163,240,244,233,232,241,252}))
			end
		end
		local data = {}
		if netOk and body ~= _obczbshz({215,223,215,216}) and body ~= _obczbshz({}) then
			local ok, d = pcall(HttpService.JSONDecode, HttpService, body)
			if ok and type(d) == _obczbshz({221,203,205,216,210}) then
				data = d
			else
				DSLOG.err(_obczbshz({220,227,217,207}), _obczbshz({219,207,222,220,220,225,227,209,145,214,226,148,187,223,233,221,219,219,238,225,157,236,66,35,240,162,70,45,165,208,218,215,215,196,171}) .. tostring(body):sub(1, 60))
			end
		end
		for id, rec in pairs(data) do
			if type(rec) ~= _obczbshz({221,203,205,216,210}) or not isFresh(id, rec) then data[id] = nil end
		end
		local mineRec = localRecord()
		if netOk and mineRec and not data[uid] then
			DSLOG.warn(_obczbshz({220,227,217,207}), _obczbshz({220,207,224,140,223,211,214,217,228,230,229,227,149,228,58,27,232,154,241,235,233,242,238,245,161,230,242,164,203,239,249,237,235,235,254,241,173,182,254,176,225,231,231,180,251,247,3,0,8,15,187,11,18,190,0,19,193,20,8,11,23,7,26,200,11,22,26,29,34,19,16,34,18,31,220,226,213,12,38,27,124,100,219,47,34,222,53,131,107,238,227,49,38,57,231,55,60,234,58,65,65,64,62,67,241,64,150,119,68,246,75,61,249,80,64,65,74}))
		end
		for _, pl in ipairs(Players:GetPlayers()) do
			local isMe = (pl == lp)
			local char = pl.Character
			if (isMe or netOk) and char and char:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212})) and char:FindFirstChild(_obczbshz({177,223,216,205,219,221,216,212,195,225,226,232,197,215,233,236})) then
				local d
				if isMe then d = mineRec else d = data[tostring(pl.UserId)] end
				local want
				if d then
					if isMe then
						want = tostring(d.ids or _obczbshz({})) .. _obczbshz({229}) .. tostring(d.headless == true) .. _obczbshz({229,230,156,232}) .. tostring(d.bc or _obczbshz({}))
					else
						want = tostring(d.ids or _obczbshz({})) .. _obczbshz({229}) .. tostring(d.headless == true) .. _obczbshz({229}) .. tostring(d.fx or _obczbshz({})) .. _obczbshz({229}) .. tostring(d.fc or 1) .. _obczbshz({229}) .. tostring(d.bc or _obczbshz({}))
					end
				end

				if want and char:GetAttribute(_obczbshz({173,221,190,213,212})) == want and (char:GetAttribute(_obczbshz({173,221,185})) or 0) > 0 and countMods(char) == 0 then
					local n = (reapplied[char] or 0) + 1
					reapplied[char] = n
					if n <= 5 then
						DSLOG.warn(_obczbshz({220,227,217,207}), pl.Name .. _obczbshz({163,138,218,223,141,215,227,213,223,229,147,216,228,150,223,237,219,154,238,241,234,231,241,225,238,162,231,243,165,246,236,250,252,249,249,237,244,243,252,176,185,1,179,254,4,253,6,184,11,255,8,11,19,3,20,223,202,206,195,22,10,7,23,20,18,13,12,26,17,29,207,216}) .. n .. _obczbshz({152,159,148}))
						char:SetAttribute(_obczbshz({173,221,190,213,212}), nil)
					end
				end
				if char:GetAttribute(_obczbshz({173,221,190,213,212})) ~= want then
					local ready = (want == nil) or appearanceReady(pl)
					if not ready then
						local t0 = waitSince[char]
						if not t0 then
							t0 = os.clock(); waitSince[char] = t0
							DSLOG.info(_obczbshz({220,227,217,207}), pl.Name .. _obczbshz({163,138,208,223,221,211,225,209,223,214,226,148,228,150,216,238,218,238,220,238,157,242,228,242,238,235,241,229,247,166,235,237,169,237,236,254,255,243,246,241,3,192,193,194}))
						end
						if os.clock() - t0 >= 8 then
							ready = true
							DSLOG.warn(_obczbshz({220,227,217,207}), pl.Name .. _obczbshz({163,138,204,226,206,226,208,226,145,214,216,225,228,232,230,237,153,231,220,229,240,158,227,229,161,186,246,176,165,231,247,244,242,237,236,250,241,253,175,253,246,5,0,3,181,247,10,11,2,7}))
						end
					end
					if ready then
						waitSince[char] = nil
						if d then
							DSLOG.info(_obczbshz({220,227,217,207}), pl.Name .. _obczbshz({163,138,204,220,217,215,210,209,223,214,226,148,226,229,219,235,153,246,155,229,225,241,188}) .. tostring(d.ids or _obczbshz({})) .. (d.headless == true and _obczbshz({137,230,139,212,210,207,211,220,214,229,230}) or _obczbshz({})) .. (d.bc and _obczbshz({137,230,139,207,220,224,212,227}) or _obczbshz({})))
						else
							DSLOG.info(_obczbshz({220,227,217,207}), pl.Name .. _obczbshz({163,138,222,209,218,142,220,223,213,229,159,148,225,223,228,232,218,232,223,235}))
						end
						clearMods(char)
						if not isMe then
							local set = {}
							if d then
								for k in tostring(d.fx or _obczbshz({})):gmatch(_obczbshz({142,203,150})) do set[k] = true end
							end
							local okF, eF = pcall(fxApply, char, set, tonumber(d and d.fc) or 1)
							if not okF then DSLOG.err(_obczbshz({206,208,208,213,225,221,226}), pl.Name .. _obczbshz({163,138}) .. tostring(eF):sub(1, 100)) end
						end
						local failed = {}
						if d then
							if d.headless == true then DSLOG.try(_obczbshz({209,207,204,208,217,211,226,227}), headless, char) end
							if d.bc then DSLOG.try(_obczbshz({204,217,221,209,224}), applyBC, char, d.bc) end
							local n = 0
							for idStr in tostring(d.ids or _obczbshz({})):gmatch(_obczbshz({142,206,150})) do
								n = n + 1
								if n > 24 then DSLOG.warn(_obczbshz({220,227,217,207}), pl.Name .. _obczbshz({163,138,216,205,214,225,143,212,214,146,165,168,149,191,187,235,165,154,228,227,235,237,241,229,234,162,242,164,247,235,250,252,248})); break end
								local idn = tonumber(idStr)
								local ok, applied = pcall(applyOne, char, idn)
								if not (ok and applied) then
									failed[#failed + 1] = idn
									DSLOG.err(_obczbshz({220,227,217,207}), pl.Name .. _obczbshz({163,138,209,205,217,214,222,229,145,225,147,189,185,150}) .. idStr .. (ok and _obczbshz({137,146,217,47,16,221,143,211,210,228,229,217,220,229,236,161}) or (_obczbshz({163,138}) .. tostring(applied):sub(1, 120))))
								end
							end
						end
						char:SetAttribute(_obczbshz({173,221,190,213,212}), want)
						char:SetAttribute(_obczbshz({173,221,185}), countMods(char))
						if #failed > 0 then retryFailed(pl, char, want, failed, 1) end

						if isMe then
							DSLOG.try(_obczbshz({202,224,204,224,206,224}), DSLOG.charState, char, _obczbshz({223,217,206,47,23}))
							local hm2 = char:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212}))
							local accN = hm2 and #hm2:GetAccessories() or -1
							local mf = char:FindFirstChild(_obczbshz({173,221,172,207,208}))
							if mf and #mf:GetChildren() > 0 then accN = tostring(accN) .. _obczbshz({137,149,139}) .. #mf:GetChildren() .. _obczbshz({137,215,204,218,226,207,219}) end
							say((#failed == 0 and _obczbshz({182,217,207,223,141,207,223,220,218,213,212,216,228,233,165,152}) or _obczbshz({170,214,210,225,219,225,143,185,181,229,147,218,214,226,223,217,235,219,232,168,157,242,228,238,245,227,241,232,244,166,235,237,169,248,250,2,252,188,175})) .. _obczbshz({170,205,208,223,224,49,34,226,218,225,230,148,227,229,151,235,222,239,155,196,242,235,224,238,240,235,231,164,230,237,246,250,234,196,171}) .. accN)
						end
					end
				end
				if not isMe then
					local okT, eT = pcall(tagDraw, char, d and type(d.tag) == _obczbshz({221,203,205,216,210}) and d.tag or nil, _obczbshz({173,221,191,205,212,176}))
					if not okT then DSLOG.err(_obczbshz({221,203,210}), tostring(eT):sub(1, 100)) end
				end
			end
		end
	end

	local syncing = false
	local function syncSafe()
		if syncing then return end
		syncing = true
		DSLOG.try(_obczbshz({220,227,217,207}), sync)
		syncing = false
	end
	table.insert(conns, lp.CharacterAdded:Connect(function()
		DSLOG.info(_obczbshz({202,224,204,224,206,224}), _obczbshz({220,207,224,140,221,211,225,227,224,224,212,219,218,227,151,234,222,232,220,239,224,227,244,172,161,244,232,229,245,242,240,235,234,248,239,251,173,253,2,176,254,1,247,7}))
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
	local function goodbye() pcall(http, _obczbshz({173,175,183,177,193,179}), _obczbshz({152,215,218,208,224,157}) .. uid .. _obczbshz({151,212,222,219,219})) end
	table.insert(conns, Players.PlayerRemoving:Connect(function(p) if p == lp then goodbye() end end))
	pcall(function()
		table.insert(conns, lp.OnTeleport:Connect(function(st)
			if st == Enum.TeleportState.Started then goodbye() end
		end))
	end)

	section(page, _obczbshz({182,217,207,140,221,211,225,227,224,224,212,224,222,240,216,220,232}))
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({172,217,215,209,141,221,143,185,181,146,215,217,149,231,236,217,229,235,240,225,239,158,232,244,230,239,163,250,238,249,252,233,245,170,239,251,173,241,240,4,84,51,255,3,252,5,183,192,250,253,0,15,16,97,82,18,10,17,207,196,23,21,28,24,10,214,203,28,14,17,30,36,22,222,211,36,22,40,43,29,44,218,31,43,221,33,46,50,49,49,239,228,55,53,58,60,56,234,58,65,237,51,53,53,58,70,66,253,3,246,42,59,75,67,75,80,80,254,68,0,84,81,81,87,5,89,170,139,88,10,93,81,90,93,101,89,85,97,102,34,21,57,95,89,105,189,164,113,44,97,96,98,102,110,114,51,119,117,122,124,120,42,121,123,131,125,47,132,131,129,118,117,53,133,55,137,142,127,59,146,140,129,226,202,65,140,230,197,69,139,154,156,236,203,75,161,160,143,157,148,160,82,148,169,169,165,164,153,173,163,158,157,170,163,173,180,166,112,99,152,180,170,182,187,105,187,192,177,109,195,194,177,190,114,194,116,189,203,185,120,207,191,192,201,139}),
		Size = UDim2.new(1, 0, 0, 58), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	toggleRow(page, _obczbshz({188,207,216,140,208,207,209,213,52,25,212,148,157,222,220,217,221,230,224,239,240,167}), _obczbshz({174,221,206,219,219,210,212,144,210,146,230,233,214,150,218,217,219,223,62,35,222}), function(v)
		mine.headless = v
		publish()
		say(v and _obczbshz({177,207,204,208,217,211,226,227,145,222,220,219,214,218,230,166}) or _obczbshz({177,207,204,208,217,211,226,227,145,214,216,231,225,223,222,217,221,233,169}))
	end)
	local idRow = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = PANEL, BackgroundTransparency = 0.15 }, page)
	round(idRow, 10); stroke(idRow, 1.5)
	local idBox = mk(_obczbshz({189,207,227,224,175,221,231}), {
		Size = UDim2.new(1, -20, 1, -8), Position = UDim2.fromOffset(10, 4), BackgroundTransparency = 1,
		Text = _obczbshz({}), PlaceholderText = _obczbshz({178,174,139,208,220,142,216,228,214,223,147,156,232,57,42,152,231,61,53,233,226,240,238,243,170}), PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
		TextColor3 = WHITE, Font = Enum.Font.Code, TextSize = 12, ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
	}, idRow)
	local listLbl = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({178,174,222,140,206,226,216,230,224,229,173,148,227,219,229,224,238,231}), Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local function refreshList()
		listLbl.Text = _obczbshz({178,174,222,140,206,226,216,230,224,229,173,148}) .. (#mine.ids > 0 and table.concat(mine.ids, _obczbshz({149,138})) or _obczbshz({215,207,217,212,226,219}))
	end
	mine.onList = refreshList
	rowBtn(page, _obczbshz({170,206,212,207,214,221,221,209,227,146,188,184}), function()
		local n = idBox.Text:match(_obczbshz({142,206,150}))
		if not n then say(_obczbshz({173,211,210,213,225,211,143,223,145,187,183,148,157,233,58,43,153,232,62,54,234,227,241,239,244,171,177})); return end
		if #mine.ids >= 8 then say(_obczbshz({182,45,12,228,214,219,222,144,213,215,147,172,149,191,187,235,167})); return end
		table.insert(mine.ids, n)
		idBox.Text = _obczbshz({})
		refreshList()
		publish()
		say(_obczbshz({178,174,139}) .. n .. _obczbshz({137,203,207,213,208,215,222,222,210,214,226,160,149,217,216,234,235,223,226,221,235,226,238,174,175,176}))
		task.spawn(function()
			local id = tonumber(n)
			local objs = loadAsset(id)
			if objs then
				local cls = {}
				for _, o in ipairs(objs) do cls[#cls + 1] = o.ClassName end
				say(_obczbshz({178,174,139}) .. n .. _obczbshz({137,205,204,222,223,211,214,209,213,225,173,148}) .. table.concat(cls, _obczbshz({149,138})) .. _obczbshz({151,138,172,220,217,215,210,209,223,214,226,148,218,227,151,217,237,61,36,156,176,241,173}))
			else
				say(_obczbshz({183,45,14,219,141,209,222,222,228,215,218,233,222,150,218,217,235,236,224,227,222,240,159,239,161,203,199,164}) .. n .. (lastLoadErr[id] and (_obczbshz({137,146}) .. lastLoadErr[id] .. _obczbshz({146})) or _obczbshz({})) .. _obczbshz({151,138,193,219,226,142,227,213,223,230,212,230,149,218,220,152,231,233,241,235,157,241,238,250,234,240,235,243,192,166,234,247,247,240,244,254,238,174,2,245,177,85,60,180,10,3,183,225,221,186,255,1,189,7,19,5,14,194,7,9,197,7,29,9,29,11,29,204,35,113,80,28,26,22,34,226}))
			end
		end)
	end)
	rowBtn(page, _obczbshz({181,211,216,220,206,224,143,185,181,229}), function()
		mine.ids = {}
		refreshList()
		publish()
		say(_obczbshz({178,174,222,140,223,211,220,223,231,219,215,227,232,164}))
	end)

	return function()
		alive = false
		fxConn:Disconnect()

		for _, pl in ipairs(Players:GetPlayers()) do
			if pl.Character then
				pcall(clearMods, pl.Character)
				pl.Character:SetAttribute(_obczbshz({173,221,190,213,212}), nil)
				pl.Character:SetAttribute(_obczbshz({173,221,185}), nil)
			end
		end
		fxClearAll()
		for _, pl in ipairs(Players:GetPlayers()) do
			local hd = pl.Character and pl.Character:FindFirstChild(_obczbshz({177,207,204,208}))
			local o = hd and hd:FindFirstChild(_obczbshz({173,221,191,205,212,176}))
			if o then o:Destroy() end
		end
		http(_obczbshz({173,175,183,177,193,179}), _obczbshz({152,215,218,208,224,157}) .. uid .. _obczbshz({151,212,222,219,219}))
	end
end

local function buildDebug(page, say)
	if not page then return nil end
	local onlyProblems, dirty, alive = false, true, true
	local function onNew() dirty = true end
	table.insert(DSLOG.subs, onNew)

	section(page, _obczbshz({173,211,204,211,219,49,34,227,229,219,214,227}))
	local info = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({}), Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	rowBtn(page, _obczbshz({172,217,219,213,206,224,143,220,224,217,147,215,228,227,231,228,222,238,234}), function()
		local f = setclipboard or toclipboard
		DSLOG.flush()
		if not f then say(_obczbshz({188,207,224,140,210,230,212,211,230,230,226,230,149,228,58,27,232,154,239,225,234,158,242,229,245,229,239,237,245,232,246,233,251,238,185,172,220,174,251,255,248,178,248,7,9,89,56,184,7,9,187,253,15,15,20,9,23,17,195}) .. DSLOG.file); return end
		pcall(f, DSLOG.dump(false))
		say(_obczbshz({181,217,210,140,208,221,223,217,210,214,226,148,157}) .. #DSLOG.lines .. _obczbshz({137,214,212,218,213,207,226,153,159,146,182,227,225,219,151,230,218,154,222,235,235,244,228,242,244,227,177}))
	end, true)
	rowBtn(page, _obczbshz({172,217,219,213,206,224,143,227,52,37,147,213,235,223,234,231,236,154,224,156,226,240,241,239,244}), function()
		local f = setclipboard or toclipboard
		DSLOG.flush()
		if not f then say(_obczbshz({188,207,224,140,210,230,212,211,230,230,226,230,149,228,58,27,232,154,239,225,234,158,242,229,245,229,239,237,245,232,246,233,251,238,185,172,220,174,251,255,248,178,248,7,9,89,56,184,7,9,187,253,15,15,20,9,23,17,195}) .. DSLOG.file); return end
		pcall(f, DSLOG.dump(true))
		say(_obczbshz({170,224,212,223,220,225,143,213,145,215,229,230,228,233,151,219,232,234,228,221,225,237,242,174}))
	end, true)
	rowBtn(page, _obczbshz({188,203,215,226,206,224,143,209,216,225,229,213,149,228,230,152,218,236,236,241,230,244,238}), function()
		DSLOG.flush()
		say(_obczbshz({188,203,215,226,220,142,212,221,145}) .. DSLOG.file .. _obczbshz({137,146,219,205,224,226,208,144,213,225,147,217,237,219,218,237,237,233,237,165}))
	end, true)
	rowBtn(page, _obczbshz({191,207,221,140,210,225,227,209,213,225,147,216,228,150,228,221,238,154,235,225,239,241,238,238,226,233,232,241}), function()
		DSLOG.try(_obczbshz({202,224,204,224,206,224}), DSLOG.charState, lp.Character, _obczbshz({223,217,206,47,23}))
		say(_obczbshz({174,221,223,205,209,221,143,212,224,146,227,217,231,233,230,230,218,225,224,233,157,240,228,231,234,245,247,246,230,234,246,168,247,249,171,248,252,245,189}))
	end, true)
	toggleRow(page, _obczbshz({188,45,30,140,206,228,216,227,224,229,147,217,149,219,233,234,232,237}), _obczbshz({174,221,206,219,219,210,212,144,210,229,147,224,222,228,223,217,236,154,223,225,157,231,237,230,240,244,240,229,72,45,74,43,248}), function(v)
		onlyProblems = v; dirty = true
	end)
	local idRow = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
	round(idRow, 17); stroke(idRow, 1.5)
	local idBox = mk(_obczbshz({189,207,227,224,175,221,231}), {
		Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
		Text = _obczbshz({}), PlaceholderText = _obczbshz({178,174,139,220,223,207,143,217,223,229,227,217,216,223,230,230,218,236,155,164,240,65,50,160,239,69,61,241,234,248,246,251,178}), PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
		TextColor3 = WHITE, Font = Enum.Font.Code, TextSize = 11, ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
	}, idRow)
	rowBtn(page, _obczbshz({178,216,222,220,210,209,216,223,223,211,229,148,190,186,151,160,231,61,30,235,157,223,239,236,234,229,228,173}), function()
		if not DSLOG.inspect then say(_obczbshz({170,138,204,206,206,142,188,223,213,146,212,221,227,218,216,152,231,61,30,235,157,225,224,242,243,231,234,243,250,180})); return end
		task.spawn(function() DSLOG.try(_obczbshz({210,216,222,220,210,209,216,223,223,211,229}), DSLOG.inspect, idBox.Text) end)
		say(_obczbshz({178,216,222,220,210,209,216,223,223,211,225,216,228,162,151,238,222,228,220,156,236,158,235,239,232,162,228,230,230,239,255,247,183}))
	end, true)
	rowBtn(page, _obczbshz({181,211,216,220,206,224,143,228,214,222,212}), function()
		DSLOG.lines = {}
		dirty = true
	end, true)

	local box = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(10, 2, 3), BackgroundTransparency = 0.15 }, page)
	round(box, 10); stroke(box, 1.5)
	mk(_obczbshz({190,179,187,205,209,210,216,222,216}), { PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }, box)
	local txt = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({}), Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
		RichText = true, TextWrapped = true, Font = Enum.Font.Code, TextSize = 10, TextColor3 = Color3.fromRGB(230, 210, 210),
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, box)

	local COL = { INFO = _obczbshz({140,207,161,208,159,210,161}), WARN = _obczbshz({140,208,209,207,165,164,163}), ERRO = _obczbshz({140,208,209,162,161,164,163}) }
	local function esc(s)
		return (s:gsub(_obczbshz({143}), _obczbshz({143,203,216,220,168})):gsub(_obczbshz({165}), _obczbshz({143,214,223,167})):gsub(_obczbshz({167}), _obczbshz({143,209,223,167})))
	end
	local function render()
		local out, total = {}, 0
		for i = #DSLOG.lines, 1, -1 do
			local l = DSLOG.lines[i]
			if not onlyProblems or l[1] ~= _obczbshz({178,184,177,187}) then
				local s = l[2]
				if #s > 220 then s = s:sub(1, 220) .. _obczbshz({151,152,153}) end
				total = total + #s + 40
				if total > 14000 or #out >= 150 then break end
				out[#out + 1] = _obczbshz({165,208,218,218,225,142,210,223,221,225,229,177,151}) .. (COL[l[1]] or COL.INFO) .. _obczbshz({139,168}) .. esc(s) .. _obczbshz({165,153,209,219,219,226,173})
			end
		end
		txt.Text = #out > 0 and table.concat(out, _obczbshz({115})) or _obczbshz({145,214,218,211,141,228,208,234,218,225,156})
		info.Text = DSLOG.n.INFO .. _obczbshz({137,211,217,210,220,142,49,39,145}) .. DSLOG.n.WARN .. _obczbshz({137,203,225,213,224,221,226,144,51,41,147}) .. DSLOG.n.ERRO .. _obczbshz({137,207,221,222,220,225,143,50,40,146,224,213,222,233,151,234,222,221,224,234,241,227,159,229,238,162,230,237,242,231,145,201,251,251,0,245,3,253,201,176}) .. DSLOG.file
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

local function hrp() return lp.Character and lp.Character:FindFirstChild(_obczbshz({177,223,216,205,219,221,216,212,195,225,226,232,197,215,233,236})) end
local function hum() return lp.Character and lp.Character:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212})) end

local selfCleanup

local TAG_FONTS = { _obczbshz({176,217,223,212,206,219,177,220,210,213,222}), _obczbshz({175,220,208,208,220,217,208,191,223,215}), _obczbshz({171,203,217,211,210,224,226}), _obczbshz({172,220,208,209,221,225,227,213,227}), _obczbshz({170,220,206,205,209,211}), _obczbshz({175,203,217,224,206,225,232}), _obczbshz({188,205,212,178,214}), _obczbshz({181,223,206,215,214,211,226,228,184,231,236}), _obczbshz({185,207,221,217,206,220,212,222,229,191,212,230,224,219,233}), _obczbshz({172,203,221,224,220,221,221}), _obczbshz({172,217,207,209}) }
local TAG_ROLES = {
	{ _obczbshz({182,207,216,206,223,221}), Color3.fromRGB(235, 235, 235) },
	{ _obczbshz({178,216,209,216,226,211,221,211,218,211,215,227,231}), Color3.fromRGB(255, 105, 180) },
	{ _obczbshz({188,223,205,140,177,221,221,223}), Color3.fromRGB(255, 140, 40) },
	{ _obczbshz({173,217,217,219}), Color3.fromRGB(255, 205, 60) },
}
local TAG = { avail = false, on = false, text = _obczbshz({}), font = _obczbshz({176,217,223,212,206,219,177,220,210,213,222}), role = _obczbshz({182,207,216,206,223,221}), rgb = false }
local function tagRoleColor(name)
	for _, r in ipairs(TAG_ROLES) do
		if r[1] == name then return r[2] end
	end
	return TAG_ROLES[1][2]
end

function tagDraw(char, d, nm)
	nm = nm or _obczbshz({173,221,191,205,212})
	local head = char and char:FindFirstChild(_obczbshz({177,207,204,208}))
	if not head then return end
	local old = head:FindFirstChild(nm)
	if not (type(d) == _obczbshz({221,203,205,216,210}) and d.on) then
		if old then old:Destroy() end
		return
	end
	local text = tostring(d.text or _obczbshz({})):sub(1, 16)
	if text == _obczbshz({}) then
		local pl = Players:GetPlayerFromCharacter(char)
		text = tostring(pl and pl.DisplayName or lp.DisplayName):sub(1, 16)
	end
	local role = tostring(d.role or _obczbshz({182,207,216,206,223,221})):sub(1, 14)
	local fontName = table.find(TAG_FONTS, d.font) and d.font or _obczbshz({176,217,223,212,206,219,177,220,210,213,222})
	local g = old
	if not g then
		g = mk(_obczbshz({171,211,215,216,207,221,208,226,213,185,232,221}), {
			Name = nm, Size = UDim2.fromOffset(320, 110), StudsOffset = Vector3.new(0, 3.8, 0),
			AlwaysOnTop = true, LightInfluence = 0, MaxDistance = 1500,
		}, nil)
		g:SetAttribute(_obczbshz({173,221,177,228}), true)
		mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Name = _obczbshz({183}), Size = UDim2.new(1, 0, 0.62, 0), BackgroundTransparency = 1, TextScaled = true,
			TextColor3 = WHITE, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		}, g)
		mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Name = _obczbshz({187}), Size = UDim2.new(1, 0, 0.3, 0), Position = UDim2.new(0, 0, 0.66, 0), BackgroundTransparency = 1,
			TextScaled = true, Font = Enum.Font.GothamBold, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		}, g)
		g.Parent = head
	end
	local n, r = g:FindFirstChild(_obczbshz({183})), g:FindFirstChild(_obczbshz({187}))
	if n then n.Text = text; n.Font = Enum.Font[fontName] end
	if r then r.Text = role end
	if d.rgb == true then
		g:SetAttribute(_obczbshz({187,209,205}), true)
		TAG.rgbStart()
	else
		g:SetAttribute(_obczbshz({187,209,205}), nil)
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
				local hd = pl.Character and pl.Character:FindFirstChild(_obczbshz({177,207,204,208}))
				if hd then
					for _, nm in ipairs({ _obczbshz({173,221,191,205,212}), _obczbshz({173,221,191,205,212,176}) }) do
						local g = hd:FindFirstChild(nm)
						if g and g:GetAttribute(_obczbshz({187,209,205})) then
							any = true
							local n, r = g:FindFirstChild(_obczbshz({183})), g:FindFirstChild(_obczbshz({187}))
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
			local hd = lp.Character and lp.Character:FindFirstChild(_obczbshz({177,207,204,208}))
			local o = hd and hd:FindFirstChild(_obczbshz({173,221,191,205,212}))
			if o then o:Destroy() end
		end)
	end)
end
function TAG.stop() TAG.running = false end

local function buildSelf(pages, say)

	local sp = pages[_obczbshz({188,205,221,213,221,226,226})]
	local function runUrl(name, url)
		say(_obczbshz({174,226,208,207,226,226,208,222,213,225,147}) .. name .. _obczbshz({151,152,153}))
		local ok, err = pcall(function() loadstring(game:HttpGet(url))() end)
		say(ok and (name .. _obczbshz({137,207,227,209,208,227,227,209,213,225,161})) or (_obczbshz({174,220,221,219,167,142}) .. tostring(err):sub(1, 60)))
	end
	if #SCRIPTS == 0 then
		section(sp, _obczbshz({188,205,221,213,221,226,226}))
		mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = _obczbshz({183,207,217,212,226,219,143,227,212,228,220,228,233,150,229,217,153,230,228,239,241,223,173,160,198,230,236,248,234,166,232,168,253,235,237,241,249,239,175,227,212,228,220,228,233,233,183,6,8,186,15,11,13,13,191,4,16,194,4,22,22,27,16,30,24,202,26,33,205,17,30,28,22,210,40,33,213,34,32,38,36,218,28,30,30,39,55,47,239}),
			Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
			Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, sp)
	end
	local lastGroup
	for _, s in ipairs(SCRIPTS) do
		local g = s[3] or _obczbshz({188,205,221,213,221,226,226})
		if g ~= lastGroup then section(sp, g); lastGroup = g end
		rowBtn(sp, s[1], function() runUrl(s[1], s[2]) end, true)
	end
	section(sp, _obczbshz({174,226,208,207,226,226,208,226,145,226,226,230,149,226,224,230,228}))
	local boxRow = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, sp)
	round(boxRow, 17); stroke(boxRow, 1.5)
	local urlBox = mk(_obczbshz({189,207,227,224,175,221,231}), {
		Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
		Text = _obczbshz({}), PlaceholderText = _obczbshz({172,217,215,209,141,221,143,220,218,224,222,148,217,229,151,235,220,236,228,236,241,158,224,241,246,235}), PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
		TextColor3 = WHITE, Font = Enum.Font.Code, TextSize = 11, ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
	}, boxRow)
	rowBtn(sp, _obczbshz({174,226,208,207,226,226,208,226,145,222,220,226,224}), function()
		local u = urlBox.Text
		if not u:find(_obczbshz({199,210,223,224,221})) then say(_obczbshz({172,217,215,209,141,227,220,144,221,219,225,223,149,231,236,221,153,221,234,233,226,225,228,160,228,241,240,164,237,250,251,248,183})); return end
		runUrl(_obczbshz({213,211,217,215}), u)
	end, true)

	local dp = pages[_obczbshz({183,203,223,225,223,207,219,144,181,219,230,213,232,234,220,234})] or mk(_obczbshz({175,220,204,217,210}), {})
	local S = { fly = false, speed = false, jump = false, noclip = false, infjump = false, nofall = false, waterwalk = false, antifling = false, antivoid = false, antisit = false, tfling = false, flingVal = 150, speedVal = 50, flyVal = 50 }
	local selfBV, wwPart, lastSafe, flyGui

	local flyFx = { active = false, gyro = nil, face = nil, tracks = {}, cur = nil, char = nil, hum = nil, states = nil }
	local FLY_FALLBACK = {
		R15 = { walk = _obczbshz({219,204,227,205,224,225,212,228,218,214,173,163,164,171,167,175,176,177,178,180,175,180}), idle = _obczbshz({219,204,227,205,224,225,212,228,218,214,173,163,164,171,167,175,176,176,177,175,181,182}) },
		R6 = { walk = _obczbshz({219,204,227,205,224,225,212,228,218,214,173,163,164,167,175,168,173,172,177,175,178,178}), idle = _obczbshz({219,204,227,205,224,225,212,228,218,214,173,163,164,167,175,168,173,173,176,177,180,175}) },
	}
	local function flyAnimId(h, which)
		local id
		pcall(function()
			local a = lp.Character and lp.Character:FindFirstChild(_obczbshz({170,216,212,217,206,226,212}))
			if a then
				if which == _obczbshz({224,203,215,215}) then id = a.walk.WalkAnim.AnimationId else id = a.idle.Animation1.AnimationId end
			end
		end)
		if not id or id == _obczbshz({}) then id = (FLY_FALLBACK[h.RigType.Name] or FLY_FALLBACK.R15)[which] end
		return id
	end

	local function flyAnim(h, which, spd)
		local animator = h:FindFirstChildOfClass(_obczbshz({170,216,212,217,206,226,222,226}))
		if not animator then return end
		if flyFx.char ~= lp.Character then flyFx.char = lp.Character; flyFx.tracks = {}; flyFx.cur = nil end
		local tr = flyFx.tracks[which]
		if not tr then
			local a = Instance.new(_obczbshz({170,216,212,217,206,226,216,223,223}))
			a.AnimationId = flyAnimId(h, which)
			local ok, t = pcall(function() return animator:LoadAnimation(a) end)
			if not ok or not t then return end
			t.Priority = Enum.AnimationPriority.Action
			t.Looped = true
			tr = t
			flyFx.tracks[which] = t
		end
		if flyFx.cur ~= which then
			for n, t in pairs(flyFx.tracks) do
				if n ~= which then pcall(function() t:Stop(0.15) end) end
			end
			pcall(function() tr:Play(0.15) end)
			flyFx.cur = which
		elseif not tr.IsPlaying then
			pcall(function() tr:Play(0.15) end)
		end
		if spd then pcall(function() tr:AdjustSpeed(spd) end) end
	end
	local function flyStopFx()
		for _, t in pairs(flyFx.tracks) do pcall(function() t:Stop(0.2) end) end
		flyFx.cur = nil; flyFx.face = nil
		if flyFx.gyro then flyFx.gyro:Destroy(); flyFx.gyro = nil end
		local h = hum()
		if h then
			pcall(function() h.AutoRotate = true end)
			if flyFx.states then
				for st, was in pairs(flyFx.states) do pcall(function() h:SetStateEnabled(st, was) end) end
			end
		end
		flyFx.states = nil; flyFx.hum = nil
	end
	local function stopSelfFly()
		if selfBV then selfBV:Destroy(); selfBV = nil end
		if flyFx.active then flyFx.active = false; flyStopFx() end
	end

	local FLY_MAX = 15
	local flyLevel = 4
	S.flyVal = 10 + flyLevel * 10
	local flyPanel, flyOnBtn, flyLvlLbl
	local flyToggles = {}
	local function flyRefresh()
		if not flyPanel then return end
		flyLvlLbl.Text = _obczbshz({191,207,215,219,208,215,211,209,213,215,147}) .. flyLevel
		flyOnBtn.Text = S.fly and _obczbshz({184,184}) or _obczbshz({184,176,177})
		UI.tween(flyOnBtn, 0.12, { BackgroundColor3 = S.fly and Color3.fromRGB(36, 160, 86) or Color3.fromRGB(120, 22, 30) })
	end
	local function setFlyLevel(n)
		flyLevel = math.clamp(n, 1, FLY_MAX)
		S.flyVal = 10 + flyLevel * 10
		flyRefresh()
	end
	local function setFly(v) S.fly = v and true or false; flyRefresh() end
	local function buildFlyPanel()
		flyPanel = mk(_obczbshz({175,220,204,217,210}), {
			Size = UDim2.fromOffset(176, 116), Position = UDim2.new(0, 24, 0.3, 0),
			BackgroundColor3 = Color3.fromRGB(9, 4, 6), BackgroundTransparency = 0.08, ZIndex = 20, Visible = false,
		}, gui)
		round(flyPanel, 14); stroke(flyPanel, 2)
		local title = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = _obczbshz({75,6,243,140,141,196,222,209,227}), Size = UDim2.new(1, -34, 0, 28), Position = UDim2.fromOffset(12, 2), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21,
		}, flyPanel)
		local x = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
			Text = _obczbshz({75,6,0}), Size = UDim2.fromOffset(22, 22), Position = UDim2.new(1, -28, 0, 5), AutoButtonColor = false,
			BackgroundColor3 = Color3.fromRGB(40, 8, 12), TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 11, ZIndex = 21,
		}, flyPanel)
		round(x, 11)
		x.MouseButton1Click:Connect(function()
			setFly(false)
			flyPanel.Visible = false
			for _, set in ipairs(flyToggles) do pcall(set, false) end
		end)
		flyOnBtn = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
			Text = _obczbshz({184,176,177}), Size = UDim2.new(1, -24, 0, 32), Position = UDim2.fromOffset(12, 34), AutoButtonColor = false,
			BackgroundColor3 = Color3.fromRGB(120, 22, 30), TextColor3 = WHITE, Font = Enum.Font.GothamBlack, TextSize = 16, ZIndex = 21,
		}, flyPanel)
		round(flyOnBtn, 10)
		flyOnBtn.MouseButton1Click:Connect(function() setFly(not S.fly) end)
		local function stepBtn(txt, xpos, delta)
			local b = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
				Text = txt, Size = UDim2.fromOffset(38, 32), Position = xpos, AutoButtonColor = false,
				BackgroundColor3 = PANEL, TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 20, ZIndex = 21,
			}, flyPanel)
			round(b, 10); stroke(b, 1.5, UI.EDGE)
			b.MouseButton1Click:Connect(function() setFlyLevel(flyLevel + delta) end)
		end
		stepBtn(_obczbshz({75,242,253}), UDim2.fromOffset(12, 74), -1)
		stepBtn(_obczbshz({148}), UDim2.new(1, -50, 0, 74), 1)
		flyLvlLbl = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = _obczbshz({}), Size = UDim2.new(1, -112, 0, 32), Position = UDim2.fromOffset(56, 74), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamMedium, TextSize = 11, ZIndex = 21,
		}, flyPanel)
		makeDraggable(title, flyPanel, nil, nil, keepBarOnScreen(title))
		flyRefresh()
	end

	local function setFlyPanel(v)
		if v then
			if not flyPanel then buildFlyPanel() end
			flyPanel.Visible = true
			setFly(true)
		else
			setFly(false)
			if flyPanel then flyPanel.Visible = false end
		end
	end

	local loopConn = RunService.Stepped:Connect(function()
		local c, h, r = lp.Character, hum(), hrp()
		if not (c and h and r) then return end
		if S.antisit then
			if h:GetStateEnabled(Enum.HumanoidStateType.Seated) then h:SetStateEnabled(Enum.HumanoidStateType.Seated, false) end
			if h.Sit or h.SeatPart then
				local sp = h.SeatPart
				local w = sp and sp:FindFirstChild(_obczbshz({188,207,204,224,196,211,219,212}))
				if w then w:Destroy() end
				h.Sit = false
			end
		end
		if S.noclip then
			for _, p in ipairs(c:GetDescendants()) do
				if p:IsA(_obczbshz({171,203,222,209,189,207,225,228})) and p.CanCollide then p.CanCollide = false end
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
						if p:IsA(_obczbshz({171,203,222,209,189,207,225,228})) and p.CanCollide then p.CanCollide = false end
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
				local waterish = res.Material == Enum.Material.Water or nm:find(_obczbshz({224,203,223,209,223})) or nm:find(_obczbshz({207,214,218,219,209})) or nm:find(_obczbshz({221,221,224,218,206,219,216}))
					or (not ins.CanCollide and ins.Transparency >= 0.2 and ins.Color.B > ins.Color.R + 0.1)
				if waterish then surfaceY = res.Position.Y end
			end
			if not surfaceY and h:GetState() == Enum.HumanoidStateType.Swimming then
				surfaceY = r.Position.Y - (h.HipHeight + r.Size.Y / 2)
			end
			if surfaceY then
				if not wwPart then
					wwPart = mk(_obczbshz({185,203,221,224}), {
						Name = _obczbshz({188,210,212,218,181,227,209,199,210,230,216,230}), Size = Vector3.new(14, 1, 14), Anchored = true, CanCollide = true,
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
				selfBV = mk(_obczbshz({171,217,207,229,195,211,219,223,212,219,231,237}), { MaxForce = Vector3.new(1e9, 1e9, 1e9), Velocity = Vector3.zero }, r)
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
			local target = mv * S.flyVal + Vector3.new(0, up * S.flyVal, 0)
			selfBV.Velocity = selfBV.Velocity:Lerp(target, 0.35)

			if not flyFx.active or flyFx.hum ~= h then
				flyFx.active = true; flyFx.hum = h; flyFx.states = {}
				for _, st in ipairs({ Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Ragdoll }) do
					flyFx.states[st] = h:GetStateEnabled(st)
					pcall(function() h:SetStateEnabled(st, false) end)
				end
				pcall(function() h.AutoRotate = false end)
			end
			if not flyFx.gyro or flyFx.gyro.Parent ~= r then
				if flyFx.gyro then flyFx.gyro:Destroy() end
				flyFx.gyro = mk(_obczbshz({171,217,207,229,180,231,225,223}), { MaxTorque = Vector3.new(1e9, 1e9, 1e9), P = 30000, D = 800, CFrame = r.CFrame }, r)
			end
			local face = Vector3.new(mv.X, 0, mv.Z)
			if face.Magnitude > 0.05 then
				flyFx.face = face.Unit
			elseif not flyFx.face then
				local lk = r.CFrame.LookVector
				local f2 = Vector3.new(lk.X, 0, lk.Z)
				flyFx.face = f2.Magnitude > 0.05 and f2.Unit or Vector3.new(0, 0, -1)
			end
			flyFx.gyro.CFrame = CFrame.lookAt(r.Position, r.Position + flyFx.face)

			if target.Magnitude > 1 then
				flyAnim(h, _obczbshz({224,203,215,215}), math.clamp(S.flyVal / 14.5, 0.7, 2.2))
			else
				flyAnim(h, _obczbshz({210,206,215,209}), 1)
			end
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
		return o:GetAttribute(_obczbshz({173,221,177,228})) or o.Name == _obczbshz({188,210,212,218,179,215,225,213}) or o.Name == _obczbshz({170,206,216,178,229,180,216,226,214})
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
		elseif o:IsA(_obczbshz({185,203,221,224,214,209,219,213,182,223,220,232,233,219,233})) and o.Rate > 50 then
			o.Rate = 50
		end
	end
	local function lagEmergency()
		for _, o in ipairs(workspace:GetDescendants()) do
			if LAG_LIMITS[o.ClassName] and not lagOwn(o) then
				if o:IsA(_obczbshz({188,217,224,218,209})) then pcall(function() o:Stop() end)
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
			if p:IsA(_obczbshz({171,203,222,209,189,207,225,228})) then
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
		pcall(function() sethiddenproperty(lp, _obczbshz({188,211,216,225,217,207,227,217,224,224,197,213,217,223,236,235}), 1e9) end)
		pcall(function() lp.MaximumSimulationRadius = 1e9 end)
	end
	local function isLoose(p)
		if not (p and p:IsA(_obczbshz({171,203,222,209,189,207,225,228}))) or p.Anchored then return false end
		if p.Name == _obczbshz({177,223,216,205,219,221,216,212,195,225,226,232,197,215,233,236}) or p.Name == _obczbshz({188,210,212,218,181,227,209,199,210,230,216,230}) or p:GetAttribute(_obczbshz({173,221,177,228})) then return false end
		if p:FindFirstAncestorOfClass(_obczbshz({170,205,206,209,224,225,222,226,234})) or p:FindFirstAncestorOfClass(_obczbshz({189,217,218,216})) then return false end
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
		tk.bp = mk(_obczbshz({171,217,207,229,189,221,226,217,229,219,226,226}), { MaxForce = Vector3.new(1e9, 1e9, 1e9), P = 1e5, D = 2e3, Position = part.Position }, part)
		tk.bg = mk(_obczbshz({171,217,207,229,180,231,225,223}), { MaxTorque = Vector3.new(1e9, 1e9, 1e9), P = 1e4, D = 500, CFrame = CFrame.new() }, part)
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
			say(_obczbshz({171,214,218,207,220,142,223,213,216,225,148,148,182,228,219,221,153,223,232,156,224,231,236,225,161,230,232,240,234,180,167,215,245,242,240,172,253,0,240,176,244,251,0,245,196,248,248,1,17,9,187,1,189,255,13,4,6,194,19,22,6,198,29,23,10,28,217}))
		else
			say(_obczbshz({178,221,222,219,141,220,50,19,224,146,54,29,149,235,228,152,219,230,234,223,236,158,242,239,237,246,242,164,173,234,236,251,234,248,238,251,255,239,243,255,186,192}))
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
			if d:IsA(_obczbshz({171,203,222,209,189,207,225,228})) and not d.Anchored and d.Size.Magnitude < 60 and d ~= tk.part and isLoose(d) then
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

	section(dp, _obczbshz({188,217,205,222,210,228,216,230,214,228}))
	do
		local _, st = toggleRow(dp, _obczbshz({191,217,204,222}), _obczbshz({170,204,221,209,141,221,143,224,210,219,225,217,225,150,219,221,153,240,234,235,157,166,206,206,176,209,201,202,165,235,167,254,238,246,250,239,246,242,240,244,246,187,179,118,21,56,183,7,5,2,0,188,13,16,0,192,4,11,16,5,197,209,199,18,24,35,30,32,22,17,26,208,238,210,38,35,23,27}), function(v) setFlyPanel(v) end)
		table.insert(flyToggles, st)
	end
	toggleRow(dp, _obczbshz({170,216,223,213,154,223,228,213,213,211}), _obczbshz({181,211,216,213,225,207,143,209,145,232,216,224,228,217,224,220,218,222,224,156,225,223,159,241,246,231,231,229}), function(v) S.nofall = v end)
	rowBtn(dp, _obczbshz({188,223,205,213,223,142,160,160,161,146,230,232,234,218,234,152,161,224,240,227,230,240,159,228,226,162,70,37,236,251,232,177}), function()
		local r = hrp()
		if r then r.CFrame = r.CFrame + Vector3.new(0, 100, 0); say(_obczbshz({188,223,205,213,226,142,160,160,161,146,230,232,234,218,234,166})) end
	end)
	toggleRow(dp, _obczbshz({175,214,212,218,212,142,151,220,210,224,54,27,214,232,151,231,236,154,234,241,241,240,238,243,170}), _obczbshz({186,223,208,217,141,211,221,211,224,229,231,213,231,150,220,229,153,240,234,223,64,40,159,243,226,235,163,250,244,231,245,236,248,184,171,226,252,241,82,58,177,0,86,55,4,182,254,1,11,251,187,10,2,11,191,99,74,194,15,5,19,105,78,9,13,25}), function(v)
		S.tfling = v
		if v then startTFling() else stopTFling() end
	end)
	sliderRow(dp, _obczbshz({175,217,221,47,20,207,143,212,224,146,217,224,222,228,222}), _obczbshz({178,216,223,209,219,225,216,212,210,214,216,148,217,229,151,228,218,232,62,35,222,235,228,238,245,241}), 50, 300, 150, function(v) S.flingVal = v end)
	toggleRow(dp, _obczbshz({170,216,223,213,154,228,222,217,213}), _obczbshz({191,217,215,224,206,142,223,226,224,146,54,46,225,234,224,229,232,154,231,241,228,223,241,160,244,231,234,249,247,245,167,251,238,170,238,237,246,0,175,254,0,178,9,245,15,255,6}), function(v) S.antivoid = v end)
	toggleRow(dp, _obczbshz({185,223,215,219,141,215,221,214,218,224,220,232,228}), _obczbshz({185,223,215,205,141,220,222,144,210,228,147,229,234,215,229,236,218,237,155,242,226,248,228,243,161,243,248,237,248,235,249}), function(v) S.infjump = v end)
	toggleRow(dp, _obczbshz({170,216,207,205,223,142,226,223,211,228,216,148,214,150,58,25,224,239,220}), _obczbshz({185,214,204,224,206,212,222,226,222,211,147,221,227,236,224,235,60,39,241,225,233,158,237,225,161,245,248,244,234,248,237,75,54,237,244,241}), function(v)
		S.waterwalk = v
		if not v and wwPart then wwPart:Destroy(); wwPart = nil end
	end)
	local island, islandBack
	rowBtn(dp, _obczbshz({178,214,211,205,141,225,212,215,230,228,212,148,157,230,227,217,237,219,225,235,239,235,224,160,239,241,163,231,72,47,252,177}), function()
		local r = hrp()
		if not r then return end
		if not island or not island.Parent then
			island = mk(_obczbshz({185,203,221,224}), {
				Name = _obczbshz({188,210,212,218,181,227,209,185,221,218,212}), Size = Vector3.new(40, 2, 40), Anchored = true, CanCollide = true,
				Material = Enum.Material.SmoothPlastic, Color = Color3.fromRGB(60, 8, 12),
				Position = Vector3.new(r.Position.X, 3500, r.Position.Z),
			}, workspace)
		end
		islandBack = r.CFrame
		r.AssemblyLinearVelocity = Vector3.zero
		r.CFrame = CFrame.new(island.Position + Vector3.new(0, 4, 0))
		say(_obczbshz({183,203,139,213,217,214,208,144,228,215,218,233,231,215,165,152,206,237,224,156,159,212,238,236,245,227,245,164,233,231,167,241,245,242,236,174,173,255,4,241,255,246,2,180,5,247,10,11,250,12,201}))
	end)
	rowBtn(dp, _obczbshz({191,217,215,224,206,224,143,212,210,146,220,224,221,215}), function()
		local r = hrp()
		if r and islandBack then
			r.AssemblyLinearVelocity = Vector3.zero
			r.CFrame = islandBack
			say(_obczbshz({173,207,139,226,220,218,227,209,159}))
		else
			say(_obczbshz({191,217,206,47,23,142,208,217,223,214,212,148,227,57,26,231,153,224,234,229,157,238,241,225,161,235,239,236,230,180}))
		end
	end, true)
	section(dp, _obczbshz({171,214,218,207,220,225,143,227,224,222,231,227,232}))
	rowBtn(dp, _obczbshz({189,207,215,209,208,215,221,213,228,215,173,148,218,233,218,231,229,226,224,238,157,224,235,239,228,241}), function()
		tk.armed = true
		say(_obczbshz({189,217,220,225,210,142,221,229,222,146,213,224,228,217,230,152,236,233,231,240,236,158,167,228,230,245,228,242,232,245,249,233,237,249,180,172,241,253,175,253,242,2,244,192,181,252,6,10,250,186,255,11,189,11,4,14,22,208}))
	end)
	rowBtn(dp, _obczbshz({189,207,215,209,208,215,221,213,228,215,173,148,232,229,227,236,218,236,155,222,233,237,226,239}), function() tkRelease(); say(_obczbshz({171,214,218,207,220,142,226,223,221,230,226,162})) end, true)
	rowBtn(dp, _obczbshz({171,214,218,207,220,168,143,227,230,212,220,230,149,167,167}), function() tk.y = tk.y + 10 end, true)
	rowBtn(dp, _obczbshz({171,214,218,207,220,168,143,212,214,229,214,217,231,150,168,168}), function() tk.y = tk.y - 10 end, true)
	toggleRow(dp, _obczbshz({175,214,212,218,212,142,191,209,227,230,230}), _obczbshz({185,207,46,19,206,225,143,227,224,222,231,213,232,150,222,225,235,219,232,156,226,235,159,246,240,238,247,229,165,234,236,168,255,249,238,79,55}), function(v)
		fpSet(v)
		say(v and _obczbshz({185,220,218,207,226,224,208,222,213,225,147,228,218,57,30,217,236,154,238,235,233,242,224,243,175,176,177}) or _obczbshz({175,214,212,218,212,142,191,209,227,230,230,148,217,219,234,228,226,225,220,224,236,172}))
	end)
	sliderRow(dp, _obczbshz({187,203,212,219,141,210,208,227,145,226,216,55,28,215,234}), _obczbshz({173,211,222,224,48,16,221,211,218,211,147,216,228,150,218,59,38,236,222,241,233,237}), 8, 40, 14, function(v) fp.radius = v end)
	section(dp, _obczbshz({185,220,218,224,210,49,22,51,20,225}))
	toggleRow(dp, _obczbshz({170,216,223,213,154,212,219,217,223,217}), _obczbshz({178,209,217,219,223,207,143,211,224,222,220,231,56,25,230,152,221,223,155,235,242,242,241,239,244,162,237,243,236,231,235,247,251,239,254,172,242,174,9,245,3,243,179,251,254,8,6,199,250,12,13,1,10,3,18,19,16}), function(v) S.antifling = v end)

	local pp = pages[_obczbshz({185,220,218,224,210,49,22,51,38,215,230})]
	if pp then
		section(pp, _obczbshz({185,220,218,224,210,49,22,51,38,215,230}))
		toggleRow(pp, _obczbshz({170,216,223,213,154,212,219,217,223,217}), _obczbshz({178,209,217,219,223,207,143,211,224,222,220,231,56,25,230,152,221,223,155,235,242,242,241,239,244,162,237,243,236,231,235,247,251,239,254,172,242,174,9,245,3,243,179,251,254,8,6,199,250,12,13,1,10,3,18,19,16}), function(v) S.antifling = v end)
		toggleRow(pp, _obczbshz({170,216,223,213,154,228,222,217,213}), _obczbshz({191,217,215,224,206,142,223,226,224,146,54,46,225,234,224,229,232,154,231,241,228,223,241,160,244,231,234,249,247,245,167,251,238,170,238,237,246,0,175,244,0,178,0,245,5,247}), function(v) S.antivoid = v end)
		toggleRow(pp, _obczbshz({188,207,216,140,209,207,221,223,145,214,216,148,230,235,220,220,218}), _obczbshz({187,207,207,225,231,142,208,144,231,215,223,227,216,223,219,217,221,223,155,224,222,158,240,245,230,230,228}), function(v) S.nofall = v end)
		toggleRow(pp, _obczbshz({170,216,223,213,154,225,212,222,229,211,229}), _obczbshz({183,45,14,219,141,210,212,217,233,211,147,231,218,228,235,217,235,154,224,233,157,225,224,242,243,241,175,164,232,231,235,237,242,252,236,172,251,243,252,176,243,243,1,247,4}), function(v)
			S.antisit = v
			if not v then
				local h = hum()
				if h then h:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
			end
		end)
		toggleRow(pp, _obczbshz({170,216,223,213,154,218,208,215}), _obczbshz({188,207,210,225,223,207,143,214,221,225,226,216,149,218,220,152,233,219,237,240,64,43,226,245,237,227,246,176,165,249,246,246,252,170,240,172,242,6,255,252,0,5,86,73,250,9,183,252,254,186,14,255,15,7,15,20,20,194,7,9,197,18,8,15}), function(v)
			if v then lagStart() else lagStop() end
			say(v and _obczbshz({170,216,223,213,154,218,208,215,145,222,220,219,214,218,230,166}) or _obczbshz({170,216,223,213,154,218,208,215,145,214,216,231,225,223,222,217,221,233,169}))
		end)
	end

	local mp = pages[_obczbshz({182,217,225,213,218,211,221,228,224})]
	if mp then
		section(mp, _obczbshz({182,217,225,213,218,211,221,228,224}))
		do
			local _, st = toggleRow(mp, _obczbshz({191,217,204,222}), _obczbshz({170,204,221,209,141,221,143,224,210,219,225,217,225,150,219,221,153,240,234,235,157,166,206,206,176,209,201,202,165,235,167,254,238,246,250,239,246,242,240,244,246,187,179,118,21,56,183,7,5,2,0,188,13,16,0,192,4,11,16,5,197,209,199,18,24,35,30,32,22,17,26,208,238,210,38,35,23,27}), function(v) setFlyPanel(v) end)
			table.insert(flyToggles, st)
		end
		toggleRow(mp, _obczbshz({191,207,215,219,208,215,211,209,213,215}), _obczbshz({181,211,210,205,141,207,143,230,214,222,226,215,222,218,216,220,222,154,224,239,224,237,235,232,234,230,228,164,230,232,232,241,1,249}), function(v)
			S.speed = v
			if not v then local h = hum(); if h then h.WalkSpeed = 16 end end
		end)
		sliderRow(mp, _obczbshz({191,203,215,219,223,142,211,209,145,232,216,224,228,217,224,220,218,222,224}), _obczbshz({172,217,221,222,214,210,208}), 16, 120, 50, function(v) S.speedVal = v end)

		flyGui = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.fromOffset(60, 124), Position = UDim2.new(0, 24, 0.55, -62), BackgroundTransparency = 1, Visible = false, ZIndex = 20 }, gui)
		local function holdBtn(txt, y, key)
			local b = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
				Text = txt, Size = UDim2.fromOffset(60, 56), Position = UDim2.fromOffset(0, y),
				BackgroundColor3 = PANEL, BackgroundTransparency = 0.15, TextColor3 = WHITE,
				Font = Enum.Font.GothamBold, TextSize = 24, ZIndex = 21,
			}, flyGui)
			round(b, 28); stroke(b, 2)
			local function isHold(i) return i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 end
			b.InputBegan:Connect(function(i) if isHold(i) then S[key] = true end end)
			b.InputEnded:Connect(function(i) if isHold(i) then S[key] = false end end)
		end
		holdBtn(_obczbshz({75,0,29}), 0, _obczbshz({207,214,228,193,221}))
		holdBtn(_obczbshz({75,0,39}), 68, _obczbshz({207,214,228,176,220,229,221}))
		toggleRow(mp, _obczbshz({171,217,223,47,34,211,226,144,213,215,147,234,228,229,151,160,236,239,221,229,239,173,227,229,244,229,232,246,174}), _obczbshz({172,217,216,140,220,142,197,223,210,228,147,224,222,221,216,220,232,166,155,233,236,241,243,242,226,162,101,26,55,166,105,30,69,170,249,237,173,2,244,252,242,204,179,7,250,253,12,10,254,186,11,14,254,190,18,21,3,11,21,196,20,27,199,12,14,29,14,17,31,233,207,35,32,30,39,35,213,243,215,30,34,29,28,220,45,31,49,33,37,49,227,50,52,230,40,58}), function(v)
			S.flyBtns = v
			if not v then S.flyUp = false; S.flyDown = false end
		end)
		toggleRow(mp, _obczbshz({185,223,215,219,141,207,219,228,224}), _obczbshz({179,223,216,220,189,221,230,213,227,146,172,164}), function(v)
			S.jump = v
			if not v then local h = hum(); if h then h.JumpPower = 50 end end
		end)
		toggleRow(mp, _obczbshz({185,223,215,219,141,215,221,214,218,224,220,232,228}), _obczbshz({185,223,215,205,141,220,222,144,210,228,147,229,234,215,229,236,218,237,155,242,226,248,228,243,161,243,248,237,248,235,249}), function(v) S.infjump = v end)
		toggleRow(mp, _obczbshz({170,222,221,205,227,211,226,227,210,228,147,228,214,232,220,220,222,237}), _obczbshz({183,217,206,216,214,222}), function(v) S.noclip = v end)
	end

	do
		local evp = pages[_obczbshz({174,224,204,208,210})]
		if evp then
			local EV = {
				slide = false, hop = false, showSlide = false, showHop = false, locked = false,
				keyHeld = false, touchIn = nil, wasSliding = false, slideSpeed = 0, lastHop = 0, lastHook = 0,
				lastTick = 0, lastAnims = _obczbshz({}), hn = 0, rec = true, spyOut = false, gState = _obczbshz({}), gAt = 0, hopAlways = false,
			}
			local evConns, evButtons, recConns = {}, {}, {}
			local setSlideMenu, setHopMenu, paintSlide, paintHop

			local REC = { lines = {}, rate = {}, t0 = os.clock() }
			local function ser(v, d)
				d = d or 0
				local t = typeof(v)
				if t == _obczbshz({220,222,221,213,219,213}) then return string.format(_obczbshz({142,219}), v:sub(1, 60))
				elseif t == _obczbshz({215,223,216,206,210,224}) then return string.format(_obczbshz({142,152,159,211}), v)
				elseif t == _obczbshz({203,217,218,216,210,207,221}) or t == _obczbshz({215,211,215}) then return tostring(v)
				elseif t == _obczbshz({191,207,206,224,220,224,162}) then return string.format(_obczbshz({191,157,147,145,155,159,213,156,150,160,164,218,161,155,165,169,223,163}), v.X, v.Y, v.Z)
				elseif t == _obczbshz({172,176,221,205,218,211}) then local p = v.Position; return string.format(_obczbshz({172,176,147,145,155,159,213,156,150,160,164,218,161,155,165,169,223,163}), p.X, p.Y, p.Z)
				elseif t == _obczbshz({178,216,222,224,206,220,210,213}) then return v:GetFullName()
				elseif t == _obczbshz({221,203,205,216,210}) then
					if d >= 2 then return _obczbshz({228,152,153,154,234}) end
					local out, n = {}, 0
					for k, x in pairs(v) do
						n = n + 1
						if n > 8 then out[#out + 1] = _obczbshz({151,152,153}); break end
						out[#out + 1] = tostring(k) .. _obczbshz({166}) .. ser(x, d + 1)
					end
					return _obczbshz({228}) .. table.concat(out, _obczbshz({149,138})) .. _obczbshz({230})
				end
				return _obczbshz({165}) .. t .. _obczbshz({167})
			end
			local function push(cat, msg)
				local now = os.clock()
				local r = hrp()
				local sp = r and Vector3.new(r.AssemblyLinearVelocity.X, 0, r.AssemblyLinearVelocity.Z).Magnitude or 0
				local line = string.format(_obczbshz({196,143,222,140,152,147,165,158,162,216,230,209,149,155,164,176,236,154,160,239,157,250,159,246,230,238,192,169,179,182,237}), os.date(_obczbshz({142,178,165,145,186,168,148,195})), now - REC.t0, cat, msg, sp)
				REC.lines[#REC.lines + 1] = line
				if #REC.lines > 4000 then table.remove(REC.lines, 1) end
				DSLOG.ev(_obczbshz({178,184,177,187}), _obczbshz({206,224,204,208,210}), cat .. _obczbshz({137}) .. msg)
			end

			local function rec(cat, msg, limit)
				if not EV.rec then return end
				local now = os.clock()
				local r = REC.rate[cat]
				if not r or now - r.t >= 1 then
					if r and r.drop > 0 then push(cat, _obczbshz({145,149}) .. r.drop .. _obczbshz({137,214,212,218,213,207,226,144,224,223,220,232,222,218,216,235,179,154,232,241,230,242,238,160,243,69,36,244,238,234,246,177})) end
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
				if not (c and h) then rec(_obczbshz({204,210,204,222}), _obczbshz({202,211,217,208,206,142,226,213,222,146,227,217,231,233,230,230,218,225,224,233,172,230,244,237,226,240,242,237,233})); return end
				rec(_obczbshz({204,210,204,222}), _obczbshz({217,207,221,223,220,220,208,215,214,223,147}) .. c:GetFullName() .. _obczbshz({137,220,212,211,170}) .. tostring(h.RigType) .. _obczbshz({137,193,204,216,216,193,223,213,214,214,176}) .. tostring(h.WalkSpeed)
					.. _obczbshz({137,180,224,217,221,190,222,231,214,228,176}) .. tostring(h.JumpPower) .. _obczbshz({137,180,224,217,221,182,212,217,216,218,231,177}) .. tostring(h.JumpHeight))
				local names = {}
				for n, x in pairs(c:GetAttributes()) do names[#names + 1] = _obczbshz({204,210,204,222,155}) .. n .. _obczbshz({166}) .. tostring(x) end
				for n, x in pairs(h:GetAttributes()) do names[#names + 1] = _obczbshz({209,223,216,154}) .. n .. _obczbshz({166}) .. tostring(x) end
				for n, x in pairs(lp:GetAttributes()) do names[#names + 1] = _obczbshz({217,214,204,229,210,224,157}) .. n .. _obczbshz({166}) .. tostring(x) end
				rec(_obczbshz({202,222,223,222}), _obczbshz({202,222,221,213,207,227,227,223,228,146,212,219,228,232,216,178,153}) .. (#names > 0 and table.concat(names, _obczbshz({149,138})) or _obczbshz({145,216,208,218,213,227,220,153})))
				local kids = {}
				for _, k in ipairs(c:GetChildren()) do kids[#kids + 1] = k.Name .. _obczbshz({163}) .. k.ClassName end
				rec(_obczbshz({204,210,204,222}), _obczbshz({207,211,215,212,220,225,143,212,224,146,227,217,231,233,230,230,218,225,224,233,183,158}) .. table.concat(kids, _obczbshz({149,138})))
				local function add(cn) recConns[#recConns + 1] = cn end
				local function watch(o, tag)
					add(o.AttributeChanged:Connect(function(n) rec(_obczbshz({202,222,223,222}), tag .. _obczbshz({151}) .. n .. _obczbshz({137,167,139}) .. ser(o:GetAttribute(n)), 20) end))
				end
				watch(c, _obczbshz({204,210,204,222})); watch(h, _obczbshz({209,223,216})); watch(lp, _obczbshz({217,214,204,229,210,224}))
				local root = hrp()
				if root then watch(root, _obczbshz({219,217,218,224})) end
				add(c.ChildAdded:Connect(function(k) rec(_obczbshz({204,210,204,222}), _obczbshz({148,208,212,216,213,221,143}) .. k.Name .. _obczbshz({163}) .. k.ClassName, 10) end))
				add(c.ChildRemoved:Connect(function(k) rec(_obczbshz({204,210,204,222}), _obczbshz({150,208,212,216,213,221,143}) .. k.Name, 10) end))
				for _, prop in ipairs({ _obczbshz({192,203,215,215,192,222,212,213,213}), _obczbshz({179,223,216,220,189,221,230,213,227}), _obczbshz({179,223,216,220,181,211,216,215,217,230}), _obczbshz({177,211,219,180,210,215,214,216,229}), _obczbshz({177,207,204,216,225,214}), _obczbshz({185,214,204,224,211,221,225,221,196,230,212,226,217}), _obczbshz({188,211,223}) }) do
					add(h:GetPropertyChangedSignal(prop):Connect(function() rec(_obczbshz({209,223,216}), prop .. _obczbshz({137,167,139}) .. ser(h[prop]), 6) end))
				end
				add(h.StateChanged:Connect(function(old, new) rec(_obczbshz({206,221,223,205,209,221}), tostring(old) .. _obczbshz({137,151,169,140}) .. tostring(new), 20) end))
				local an = h:FindFirstChildOfClass(_obczbshz({170,216,212,217,206,226,222,226}))
				if an then
					add(an.AnimationPlayed:Connect(function(t)
						rec(_obczbshz({202,216,212,217}), _obczbshz({221,217,206,219,226,142}) .. tostring(t.Name) .. _obczbshz({137,211,207,169}) .. tostring(t.Animation and t.Animation.AnimationId)
							.. _obczbshz({137,206,224,222,170}) .. string.format(_obczbshz({142,152,157,210}), t.Length) .. _obczbshz({137,218,221,213,220,171}) .. tostring(t.Priority), 20)
						t.Stopped:Connect(function() rec(_obczbshz({202,216,212,217}), _obczbshz({217,203,221,219,226,142}) .. tostring(t.Name), 20) end)
					end))
				else
					rec(_obczbshz({204,210,204,222}), _obczbshz({220,207,216,140,174,220,216,221,210,230,226,230,149,228,230,152,225,239,232,221,235,237,232,228}))
				end
			end
			table.insert(evConns, lp.CharacterAdded:Connect(function()
				EV.gState = _obczbshz({}); EV.gSpeed = nil
				rec(_obczbshz({204,210,204,222}), _obczbshz({215,217,225,219,141,222,212,226,228,225,225,213,220,219,228,152,161,236,224,239,237,223,246,238,176,244,242,232,230,234,232,177}))
				task.wait(0.6)
				bindChar()
			end))

			local watched = setmetatable({}, { __mode = _obczbshz({212}) })
			local function watchRemote(r)
				if watched[r] or not r:IsA(_obczbshz({187,207,216,219,225,211,180,230,214,224,231})) then return end
				watched[r] = true
				table.insert(evConns, r.OnClientEvent:Connect(function(...)
					local a = table.pack(...)
					local p = {}
					for k = 1, math.min(a.n, 6) do p[k] = ser(a[k]) end
					rec(_obczbshz({219,207,216,219,225,211,171,157}) .. r.Name, _obczbshz({145}) .. table.concat(p, _obczbshz({149,138})) .. _obczbshz({146}), 5)
				end))
			end
			pcall(function()
				local RS = game:GetService(_obczbshz({187,207,219,216,214,209,208,228,214,214,198,232,228,232,216,223,222}))
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
					old = hookmetamethod(game, _obczbshz({200,201,217,205,218,211,210,209,221,222}), nc(function(self, ...)
						local m = getnamecallmethod()
						if EV.spyOut and (m == _obczbshz({175,211,221,209,192,211,225,230,214,228}) or m == _obczbshz({178,216,225,219,216,211,194,213,227,232,216,230})) then
							local a = table.pack(...)
							local okn, nm = pcall(function() return self.Name end)
							task.defer(function()
								local p = {}
								for k = 1, math.min(a.n, 6) do p[k] = ser(a[k]) end
								rec(_obczbshz({219,207,216,219,225,211,156,174}), (okn and nm or _obczbshz({168})) .. _obczbshz({163}) .. m .. _obczbshz({145}) .. table.concat(p, _obczbshz({149,138})) .. _obczbshz({146}), 15)
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
					old = hookmetamethod(game, _obczbshz({200,201,217,205,218,211,210,209,221,222}), nc(function(self, ...)
						local a1, a2, a3 = ...
						if getnamecallmethod() == _obczbshz({175,211,221,209,192,211,225,230,214,228}) then
							local okn, nm = pcall(function() return self.Name end)
							if okn and nm == _obczbshz({190,218,207,205,225,211,178,216,210,228,212,215,233,219,233,188,218,238,220,206,226,229,232,243,245,244,252}) then
								pcall(function()

									local list = (type(a1) == _obczbshz({221,203,205,216,210})) and a1 or { a1, a2, a3 }
									local st, spd
									for k = 2, 6 do
										local x = list[k]
										if type(x) == _obczbshz({220,222,221,213,219,213}) and not st then st = x
										elseif type(x) == _obczbshz({215,223,216,206,210,224}) and not spd then spd = x end
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
			rec(_obczbshz({206,224,204,208,210}), _obczbshz({209,217,218,215,141,210,222,144,214,229,231,213,217,229,151,220,232,154,229,235,228,237,185,160}) .. tostring(hookOk))

			local function makeFloat(label, pos, onTap)
				local b = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
					Text = label, Size = UDim2.fromOffset(64, 64), Position = pos, Visible = false,
					BackgroundColor3 = PANEL, BackgroundTransparency = 0.15, TextColor3 = WHITE,
					Font = Enum.Font.GothamBold, TextSize = 11, TextWrapped = true, AutoButtonColor = false, ZIndex = 25,
				}, gui)
				round(b, 32)
				local st = mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 2, Color = RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
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
			slideBtn, paintSlide = makeFloat(_obczbshz({188,214,212,208,210,120,81,248,15}), UDim2.new(1, -90, 0.42, 0), function()
				EV.slide = not EV.slide
				paintSlide(EV.slide)
				rec(_obczbshz({222,211}), _obczbshz({203,217,223,47,16,221,143,214,221,231,231,233,214,228,235,221,153,195,233,226,230,236,232,244,230,162,214,240,238,234,236,168,182,200,171}) .. (EV.slide and _obczbshz({181,179,178,173,177,189}) or _obczbshz({205,207,222,216,214,213,208,212,224})))
				if setSlideMenu then setSlideMenu(EV.slide) end
			end)
			local hopBtn
			hopBtn, paintHop = makeFloat(_obczbshz({170,223,223,219,119,182,222,224}), UDim2.new(1, -90, 0.42, 76), function()
				EV.hop = not EV.hop
				paintHop(EV.hop)
				rec(_obczbshz({222,211}), _obczbshz({203,217,223,47,16,221,143,214,221,231,231,233,214,228,235,221,153,187,240,240,236,158,199,239,241,162,176,194,165}) .. (EV.hop and _obczbshz({181,179,178,173,177,189}) or _obczbshz({205,207,222,216,214,213,208,212,224})))
				if setHopMenu then setHopMenu(EV.hop) end
			end)

			local function slideActive(c, h)
				local gs = EV.gState
				if type(gs) == _obczbshz({220,222,221,213,219,213}) and gs ~= _obczbshz({}) then
					if gs:find(_obczbshz({199,189,215,213,209,211})) then return true, _obczbshz({206,221,223,205,209,221,143,212,224,146,221,227,220,229,151}) .. gs end

					if EV.wasSliding and gs:find(_obczbshz({199,173,221,219,226,209,215})) then return true, _obczbshz({220,214,212,208,210,142,212,227,229,215,225,216,222,218,230,152,161}) .. gs .. _obczbshz({146}) end
					return false
				end
				for _, o in ipairs({ c, h }) do
					for n, v in pairs(o:GetAttributes()) do
						local ln = n:lower()
						if (ln:find(_obczbshz({220,214,212,208})) or ln:find(_obczbshz({204,220,218,225,208,214}))) and v == true then return true, _obczbshz({202,222,223,222,141}) .. n end
						if type(v) == _obczbshz({220,222,221,213,219,213}) then
							local lv = v:lower()
							if lv:find(_obczbshz({220,214,212,208})) or lv:find(_obczbshz({204,220,218,225,208,214})) then return true, _obczbshz({202,222,223,222,141}) .. n .. _obczbshz({166}) .. v end
						end
					end
				end
				local an = h:FindFirstChildOfClass(_obczbshz({170,216,212,217,206,226,222,226}))
				local tracks = (an and an:GetPlayingAnimationTracks()) or {}
				for _, t in ipairs(tracks) do
					local nm = (t.Name or _obczbshz({})):lower()
					local anm = (t.Animation and t.Animation.Name or _obczbshz({})):lower()
					if nm:find(_obczbshz({220,214,212,208})) or anm:find(_obczbshz({220,214,212,208})) or nm:find(_obczbshz({204,220,218,225,208,214})) or anm:find(_obczbshz({204,220,218,225,208,214})) then return true, _obczbshz({202,216,212,217,141}) .. t.Name end
				end
				return false
			end

			local hooked = setmetatable({}, { __mode = _obczbshz({212}) })
			local function hookJumpButton()
				local pg = lp:FindFirstChild(_obczbshz({185,214,204,229,210,224,182,229,218}))
				local tg = pg and pg:FindFirstChild(_obczbshz({189,217,224,207,213,181,228,217}))
				local fr = tg and tg:FindFirstChild(_obczbshz({189,217,224,207,213,177,222,222,229,228,226,224,187,232,216,229,222}))
				local jb = fr and fr:FindFirstChild(_obczbshz({179,223,216,220,175,227,227,228,224,224}))
				if jb and not hooked[jb] then
					hooked[jb] = true
					table.insert(evConns, jb.InputBegan:Connect(function(i) if isPress(i) then EV.touchIn = i end end))
					table.insert(evConns, jb.InputEnded:Connect(function(i) if isPress(i) then EV.touchIn = nil end end))
					rec(_obczbshz({217,223,215,219}), _obczbshz({203,217,223,47,16,221,143,212,214,146,227,233,225,215,233,152,233,219,223,238,64,33,238,160,229,241,163,231,234,242,252,244,234,252,171,241,251,241,254,254,5,4,244,248,4,208,183}) .. jb:GetFullName())
				end
			end

			local function isJumpKey(i) return i.KeyCode == Enum.KeyCode.Space or i.KeyCode == Enum.KeyCode.ButtonA end
			table.insert(evConns, UIS.InputBegan:Connect(function(i, gp)
				if i.KeyCode ~= Enum.KeyCode.Unknown then
					rec(_obczbshz({221,207,206,216,206}), _obczbshz({75,240,254,140}) .. tostring(i.KeyCode) .. (gp and _obczbshz({137,146,212,218,225,211,225,214,210,213,216,157}) or _obczbshz({})), 20)
					if isJumpKey(i) and not UIS:GetFocusedTextBox() then EV.keyHeld = true end
				end
				if isPress(i) then
					local pg = lp:FindFirstChild(_obczbshz({185,214,204,229,210,224,182,229,218}))
					if not pg then return end
					local inset = game:GetService(_obczbshz({176,223,212,191,210,224,229,217,212,215})):GetGuiInset()
					local seen, names, isJump = {}, {}, false
					for _, dy in ipairs({ 0, inset.Y }) do
						local ok, objs = pcall(function() return pg:GetGuiObjectsAtPosition(i.Position.X, i.Position.Y - dy) end)
						if ok then
							for _, o in ipairs(objs) do
								if not seen[o] then
									seen[o] = true
									local path = o:GetFullName():gsub(_obczbshz({199,186,215,205,230,211,225,227,150,160,206,210,154,164,212,163,158,168,203,232,222,247,228,242,200,247,236,169,179}), _obczbshz({}))
									names[#names + 1] = path .. _obczbshz({145}) .. o.ClassName .. _obczbshz({146})
									if o.Name:lower():find(_obczbshz({211,223,216,220})) or (o.Parent and o.Parent.Name:lower():find(_obczbshz({211,223,216,220}))) then isJump = true end
								end
							end
						end
					end
					if isJump then EV.touchIn = i end
					rec(_obczbshz({221,217,220,225,210}), _obczbshz({75,240,254,140,149}) .. math.floor(i.Position.X) .. _obczbshz({149}) .. math.floor(i.Position.Y) .. _obczbshz({146,138}) .. (isJump and _obczbshz({196,186,192,184,188,203,143}) or _obczbshz({}))
						.. (#names > 0 and table.concat(names, _obczbshz({137,165,139}), 1, math.min(#names, 5)) or _obczbshz({145,216,208,218,213,227,220,144,211,225,231,55,24,229,151,220,232,154,229,235,228,237,168})), 20)
				end
			end))
			table.insert(evConns, UIS.InputEnded:Connect(function(i)
				if i.KeyCode ~= Enum.KeyCode.Unknown then
					rec(_obczbshz({221,207,206,216,206}), _obczbshz({75,240,252,140}) .. tostring(i.KeyCode), 20)
					if isJumpKey(i) then EV.keyHeld = false end
				end
				if isPress(i) then
					if EV.touchIn and i == EV.touchIn then EV.touchIn = nil end
					rec(_obczbshz({221,217,220,225,210}), _obczbshz({75,240,252}), 20)
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
						local att = Instance.new(_obczbshz({170,222,223,205,208,214,220,213,223,230}))
						att.Name = _obczbshz({174,224,190,216,214,210,212,177,229,230}); att.Parent = r
						local lv = Instance.new(_obczbshz({181,211,217,209,206,224,197,213,221,225,214,221,233,239}))
						lv.Name = _obczbshz({174,224,190,216,214,210,212,188,199})
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
					rec(_obczbshz({220,214,212,208,210}), _obczbshz({181,211,217,209,206,224,197,213,221,225,214,221,233,239,151,219,235,227,220,224,236}))
				end
				pcall(function() EV.mover.PlaneVelocity = Vector2.new(vx, vz) end)
				return true
			end

			local function gameSlideMovers(r)
				local all, pref = {}, {}
				for _, o in ipairs(r:GetChildren()) do
					if o:IsA(_obczbshz({181,211,217,209,206,224,197,213,221,225,214,221,233,239})) and o.Name ~= _obczbshz({174,224,190,216,214,210,212,188,199}) and o.Enabled then
						all[#all + 1] = o
						local an = o.Attachment0 and o.Attachment0.Name or _obczbshz({})
						if an:lower():find(_obczbshz({220,214,212,208})) then pref[#pref + 1] = o end
					end
				end
				return #pref > 0 and pref or all
			end

			local function liftMover(lv, S)
				local mode = lv.VelocityConstraintMode
				local world = lv.RelativeTo == Enum.ActuatorRelativeTo.World
				if mode == Enum.VelocityConstraintMode.Vector then
					local v = lv.VectorVelocity
					local hv = world and Vector3.new(v.X, 0, v.Z) or v
					local dir = (world and hv.Magnitude > 0.5) and hv.Unit or nil
					if hv.Magnitude > 0.5 and hv.Magnitude < S - 0.3 then
						lv.VectorVelocity = world and (hv.Unit * S + Vector3.new(0, v.Y, 0)) or (v.Unit * S)
						return true, dir
					end
					return false, dir
				elseif mode == Enum.VelocityConstraintMode.Line then
					local sp = lv.LineVelocity
					if math.abs(sp) > 0.5 and math.abs(sp) < S - 0.3 then lv.LineVelocity = (sp >= 0 and 1 or -1) * S; return true end
				elseif mode == Enum.VelocityConstraintMode.Plane then
					local pv = lv.PlaneVelocity
					local dir
					if world and pv.Magnitude > 0.5 then
						dir = lv.PrimaryTangentAxis * pv.X + lv.SecondaryTangentAxis * pv.Y
						dir = dir.Magnitude > 0.01 and dir.Unit or nil
					end
					if pv.Magnitude > 0.5 and pv.Magnitude < S - 0.3 then lv.PlaneVelocity = pv.Unit * S; return true, dir end
					return false, dir
				end
				return false
			end
			local function doSlide(c, h, r)
				local ok, sliding, why = pcall(slideActive, c, h)
				if ok and sliding then
					local v = r.AssemblyLinearVelocity
					local flat = Vector3.new(v.X, 0, v.Z)
					if not EV.wasSliding then
						EV.slideSpeed = flat.Magnitude; EV.slideT0 = os.clock()
						killMover()
						local lk = Vector3.new(r.CFrame.LookVector.X, 0, r.CFrame.LookVector.Z)
						EV.slideDir = flat.Magnitude > 1 and flat.Unit or (lk.Magnitude > 0.01 and lk.Unit or Vector3.new(0, 0, -1))
						rec(_obczbshz({220,214,212,208,210}), _obczbshz({220,214,212,208,210,142,179,181,197,183,182,200,182,186,198,152,161}) .. tostring(why) .. _obczbshz({146,138,225,209,217,142,216,222,218,213,220,213,225,179}) .. string.format(_obczbshz({142,152,156,210}), EV.slideSpeed))
						local ch = {}
						for _, d in ipairs(r:GetChildren()) do ch[#ch + 1] = d.Name .. _obczbshz({163}) .. d.ClassName end
						rec(_obczbshz({220,214,212,208,210}), _obczbshz({207,211,215,212,220,225,143,212,224,146,187,233,226,215,229,231,226,222,205,235,236,242,207,225,243,246,189,164}) .. table.concat(ch, _obczbshz({149,138})))
						local mv = {}
						for _, d in ipairs(c:GetDescendants()) do
							if d.Name:sub(1, 7) ~= _obczbshz({174,224,190,216,214,210,212}) and (d:IsA(_obczbshz({171,217,207,229,186,221,229,213,227})) or d:IsA(_obczbshz({181,211,217,209,206,224,197,213,221,225,214,221,233,239})) or d:IsA(_obczbshz({191,207,206,224,220,224,181,223,227,213,216})) or d:IsA(_obczbshz({170,214,212,211,219,190,222,227,218,230,220,227,227}))) then
								mv[#mv + 1] = d:GetFullName() .. _obczbshz({163}) .. d.ClassName
							end
						end
						rec(_obczbshz({220,214,212,208,210}), _obczbshz({214,217,225,209,223,225,143,212,224,146,221,227,220,229,151,230,232,154,235,225,239,241,238,238,226,233,232,241,191,166}) .. (#mv > 0 and table.concat(mv, _obczbshz({149,138})) or _obczbshz({215,207,217,212,226,219})))
							for _, lv in ipairs(r:GetChildren()) do
								if lv:IsA(_obczbshz({181,211,217,209,206,224,197,213,221,225,214,221,233,239})) and lv.Name ~= _obczbshz({174,224,190,216,214,210,212,188,199}) then
									rec(_obczbshz({220,214,212,208,210}), _obczbshz({181,192,139,208,220,142,217,223,216,225,173,148,214,234,235,181}) .. tostring(lv.Attachment0 and lv.Attachment0.Name) .. _obczbshz({137,203,223,213,227,221,172}) .. tostring(lv.Enabled) .. _obczbshz({137,215,218,208,220,171}) .. tostring(lv.VelocityConstraintMode)
										.. _obczbshz({137,220,208,216,170}) .. tostring(lv.RelativeTo) .. _obczbshz({137,224,208,207,170}) .. ser(lv.VectorVelocity) .. _obczbshz({137,214,212,218,213,207,172}) .. ser(lv.LineVelocity) .. _obczbshz({137,218,215,205,219,221,172}) .. tostring(lv.PlaneVelocity), 8)
								end
							end
					end
					EV.wasSliding = true

					if os.clock() - (EV.slideT0 or 0) < 0.25 then
						EV.slideSpeed = math.max(EV.slideSpeed or 0, flat.Magnitude)
					end
					local S = EV.slideSpeed or 0
					local gs = EV.gState or _obczbshz({})
					if S > 8 then
						if type(gs) == _obczbshz({220,222,221,213,219,213}) and gs:find(_obczbshz({199,173,221,219,226,209,215})) then

							local md = h.MoveDirection
							local dd = Vector3.new(md.X, 0, md.Z)
							if dd.Magnitude > 0.1 then EV.slideDir = dd.Unit end
							if EV.slideDir then pushMover(r, EV.slideDir.X * S, EV.slideDir.Z * S) end
							else

								local lifted, gdir = false, nil
							for _, lv in ipairs(gameSlideMovers(r)) do
								local okl, ch, dr = pcall(liftMover, lv, S)
								if okl and ch then lifted = true end
								if okl and dr then gdir = dr end
							end

							local pd = gdir or (flat.Magnitude > 0.5 and flat.Unit) or EV.slideDir
							if pd then EV.slideDir = pd; pushMover(r, pd.X * S, pd.Z * S) end
							if lifted then rec(_obczbshz({220,214,212,208,210}), _obczbshz({181,211,217,209,206,224,197,213,221,225,214,221,233,239,151,220,232,154,229,235,228,237,159,225,235,247,246,248,230,234,246,168,249,252,236,172}) .. string.format(_obczbshz({142,152,156,210}), S), 3) end

							if flat.Magnitude > 0.5 and flat.Magnitude < S - 0.3 then
								local dir = flat.Unit
								r.AssemblyLinearVelocity = Vector3.new(dir.X * S, v.Y, dir.Z * S)
								if not lifted then rec(_obczbshz({220,214,212,208,210}), _obczbshz({220,207,216,140,185,215,221,213,210,228,201,217,225,229,218,225,237,243,155,224,236,158,233,239,232,241,163,244,247,231,167,233,243,255,254,0,238,0,202,176,4,85,70,180,7,251,253,7,11,253,0,5,189,255,191,22,6,14,18,7,14,10,8,12,14,202,211,17,31,15,207}) .. string.format(_obczbshz({142,152,156,210}), flat.Magnitude) .. _obczbshz({146}), 3) end
							end
							end
						end
				else
					if EV.wasSliding then rec(_obczbshz({220,214,212,208,210}), _obczbshz({220,214,212,208,210,142,195,181,195,191,188,194,196,203})) end
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
					local an = h:FindFirstChildOfClass(_obczbshz({170,216,212,217,206,226,222,226}))
					local names = {}
					if an then
						for _, t in ipairs(an:GetPlayingAnimationTracks()) do names[#names + 1] = tostring(t.Name) end
					end
					table.sort(names)
					local joined = table.concat(names, _obczbshz({149}))
					if sp > 5 or joined ~= EV.lastAnims then
						EV.lastAnims = joined
						rec(_obczbshz({221,211,206,215}), string.format(_obczbshz({206,221,223,205,209,221,172,149,228,146,214,220,214,229,180,157,236,154,235,241,233,237,222,243,230,233,248,246,230,234,246,197,174,253,171,255,249,247,243,245,224,224,208,185,8,182,255,7,9,233,233,217,194,17,191,1,15,11,16,23,226,1,204,27,6}),
							tostring(h:GetState()), tostring(h.FloorMaterial), tostring(EV.keyHeld or EV.touchIn ~= nil),
							tostring(EV.slide), tostring(EV.hop), joined), 2)
					end
				end

				local gs = EV.gState or _obczbshz({})
				local busyState = gs == _obczbshz({173,217,226,218,210,210}) or gs == _obczbshz({187,203,210,208,220,218,219,217,223,217}) or gs == _obczbshz({172,203,221,222,214,211,211}) or gs == _obczbshz({172,214,212,217,207,215,221,215}) or gs:find(_obczbshz({199,189,215,213,209,211})) ~= nil
				local held = EV.keyHeld or EV.touchIn ~= nil
				local wantHop = EV.hop or (EV.hopAlways and held)
				if wantHop and not busyState and now - EV.lastHop > 0.1 then
					local st = h:GetState()
					local grounded = st == Enum.HumanoidStateType.Running or st == Enum.HumanoidStateType.RunningNoPhysics or st == Enum.HumanoidStateType.Landed
							or st == Enum.HumanoidStateType.Idle or (h.FloorMaterial ~= Enum.Material.Air and st ~= Enum.HumanoidStateType.Jumping and st ~= Enum.HumanoidStateType.Freefall)
						if grounded then
						EV.lastHop = now
						pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end)
						h.Jump = true
						h:ChangeState(Enum.HumanoidStateType.Jumping)
						EV.hn = EV.hn + 1
						rec(_obczbshz({209,217,219}), _obczbshz({217,223,215,219,141,207,228,228,224,223,54,21,233,223,218,231,153,157}) .. EV.hn .. _obczbshz({137,207,222,224,206,210,222,173}) .. tostring(st) .. _obczbshz({137,212,218,211,220,171}) .. gs, 6)
					end
				end

				if EV.slide then doSlide(c, h, r) else killMover() end
			end))

			table.insert(evConns, RunService.RenderStepped:Connect(function()
				if not EV.slide then return end
				local c, h, r = lp.Character, hum(), hrp()
				if not (c and h and r) or h.Health <= 0 then return end
				doSlide(c, h, r)
			end))

			table.insert(evConns, RunService.Stepped:Connect(function()
				if not EV.slide then return end
				local c, h, r = lp.Character, hum(), hrp()
				if not (c and h and r) or h.Health <= 0 then return end
				doSlide(c, h, r)
			end))

			section(evp, _obczbshz({174,224,204,208,210}))
			toggleRow(evp, _obczbshz({171,217,223,47,16,221,143,214,221,231,231,233,214,228,235,221,179,154,196,234,227,231,237,233,245,231,163,215,241,239,235,237}), _obczbshz({182,217,222,224,223,207,143,223,145,212,226,232,56,25,230,152,231,219,155,240,226,234,224,160,169,246,242,245,250,235,167,197,169,246,244,243,238,189,243,245,4,254,252,251,246,191}), function(v)
				EV.showSlide = v
				slideBtn.Visible = v
				rec(_obczbshz({222,211}), _obczbshz({214,217,222,224,223,207,225,144,211,225,231,55,24,229,151,222,229,239,239,241,222,236,243,229,161,203,241,234,238,244,240,252,238,170,222,248,246,242,244,202,177}) .. tostring(v))
			end)
			toggleRow(evp, _obczbshz({171,217,223,47,16,221,143,214,221,231,231,233,214,228,235,221,179,154,188,241,241,237,159,200,240,242}), _obczbshz({182,217,222,224,223,207,143,223,145,212,226,232,56,25,230,152,231,219,155,240,226,234,224,160,169,246,242,245,250,235,167,197,169,246,244,243,238,189,243,245,4,254,252,251,246,191}), function(v)
				EV.showHop = v
				hopBtn.Visible = v
				rec(_obczbshz({222,211}), _obczbshz({214,217,222,224,223,207,225,144,211,225,231,55,24,229,151,222,229,239,239,241,222,236,243,229,161,195,248,248,244,166,207,247,249,196,171}) .. tostring(v))
			end)
			rowBtn(evp, _obczbshz({189,220,204,226,206,224,143,210,224,230,54,41,218,233,151,222,229,239,239,241,222,236,243,229,244}), function()
				EV.locked = true
				rec(_obczbshz({222,211}), _obczbshz({203,217,223,47,34,211,226,144,215,222,232,232,234,215,229,236,222,237,155,208,207,191,213,193,197,209,214}))
				say(_obczbshz({171,217,223,47,34,211,226,144,215,222,232,232,234,215,229,236,222,237,155,240,239,223,245,225,229,241,246,164,173,244,74,43,248,170,236,254,255,239,2,4,242,255,188,194}))
			end, true)
			rowBtn(evp, _obczbshz({173,207,222,224,223,207,229,209,227,146,213,227,233,57,44,221,236,154,225,232,242,242,244,225,239,246,232,247}), function()
				EV.locked = false
				rec(_obczbshz({222,211}), _obczbshz({203,217,223,47,34,211,226,144,215,222,232,232,234,215,229,236,222,237,155,192,194,209,211,210,194,216,196,200,212,217}))
				say(_obczbshz({171,217,223,47,34,211,226,144,215,222,232,232,234,215,229,236,222,237,155,224,226,241,243,242,226,248,228,232,244,249,193,168,234,252,253,237,0,2,244,176,1,4,244,180,2,5,13,253,11,200}))
			end, true)
			local _
			_, setSlideMenu = toggleRow(evp, _obczbshz({178,216,209,213,219,215,227,213,145,197,223,221,217,219}), _obczbshz({181,211,210,205,156,210,212,227,221,219,218,213,149,218,224,234,222,238,234,156,222,239,244,233,173,162,246,233,242,166,246,168,235,249,255,79,48,253,175,246,253,7,7,9,246,4,11,253}), function(v)
				EV.slide = v
				paintSlide(v)
				rec(_obczbshz({222,211}), _obczbshz({214,207,217,225,141,183,221,214,218,224,220,232,218,150,202,228,226,222,224,156,170,188,159}) .. (v and _obczbshz({181,179,178,173,177,189}) or _obczbshz({205,207,222,216,214,213,208,212,224})))
			end)
			_, setHopMenu = toggleRow(evp, _obczbshz({170,223,223,219,141,182,222,224}), _obczbshz({185,223,215,205,141,225,222,234,218,224,219,227,149,229,151,236,222,231,235,235,157,242,238,228,240,174,163,247,234,243,167,251,238,241,0,254,238,0,175,254,242,246,244}), function(v)
				EV.hop = v
				paintHop(v)
				rec(_obczbshz({222,211}), _obczbshz({214,207,217,225,141,175,228,228,224,146,187,227,229,150,164,182,153}) .. (v and _obczbshz({181,179,178,173,177,189}) or _obczbshz({205,207,222,216,214,213,208,212,224})))
			end)
			toggleRow(evp, _obczbshz({170,223,223,219,141,182,222,224,145,229,216,219,234,232,216,230,221,233,155,235,157,238,244,236,240}), _obczbshz({188,45,30,140,211,215,210,209,145,226,232,224,214,228,219,231,153,237,234,246,230,236,231,239,161,231,241,245,250,231,245,252,248,170,1,251,240,81,57,176,228,215,218,233,231,215,183,7,185,252,10,16,96,65,14,192,5,7,195,20,26,18,8,26}), function(v)
				EV.hopAlways = v
				rec(_obczbshz({222,211}), _obczbshz({170,223,223,219,141,182,222,224,145,229,216,219,234,232,216,230,221,233,155,169,187,158}) .. tostring(v))
			end)

			section(evp, _obczbshz({181,217,210,140,209,221,143,181,231,211,215,217}))
			toggleRow(evp, _obczbshz({176,220,204,226,206,224,143,228,230,214,226}), _obczbshz({185,207,221,223,220,220,208,215,214,223,159,148,214,234,233,225,219,239,239,235,240,170,159,225,239,235,240,229,72,45,74,61,238,253,183,172,242,1,3,241,245,1,6,192,181,10,6,9,14,255,14,200,189,18,4,3,13,3,22,196,10,198,25,13,22,25,31,17,32,206,33,21,20,23,21,29,25,37,42}), function(v)
				EV.rec = v
				if v then bindChar() end
				say(v and _obczbshz({176,220,204,226,206,220,211,223,145,225,147,224,228,221,151,220,232,154,192,242,222,226,228,174}) or _obczbshz({176,220,204,226,206,49,22,51,20,225,147,216,228,150,227,231,224,154,223,235,157,195,245,225,229,231,163,244,230,251,250,233,237,235,185}))
			end, true)
			toggleRow(evp, _obczbshz({176,220,204,226,206,224,143,226,214,223,226,232,218,233,151,221,231,240,228,221,225,237,242}), _obczbshz({184,138,220,225,210,142,222,144,228,215,232,148,223,229,222,231,153,231,220,234,225,223,159,240,243,241,163,247,234,248,253,241,237,249,253,172,181,3,2,241,177,250,2,3,0,209,183,4,2,1,16,1,189,17,98,83,193,18,21,5,197,15,21,30,14,29,31,21,20,15,33,217}), function(v)
				if v and not installSpy() then
					say(_obczbshz({188,207,224,140,210,230,212,211,230,230,226,230,149,228,58,27,232,154,238,241,237,237,241,244,226,162,235,243,244,241,244,237,253,235,248,241,1,246,254,244,203,178,1,87,56,5,183,252,92,59,187,12,15,255,191,7,19,3,25,5,23,198,22,27,201,28,16,25,28,34,20,35,209,23,33,42,30,23,27,39,44,232}))
					return
				end
				EV.spyOut = v
				rec(_obczbshz({222,211}), _obczbshz({208,220,204,226,206,224,143,226,214,223,226,232,218,233,151,221,231,240,228,221,225,237,242,186,161}) .. tostring(v))
			end)
			rowBtn(evp, _obczbshz({172,217,219,213,206,224,143,220,224,217,147,216,228,150,188,238,218,222,224}), function()
				local f = setclipboard or toclipboard
				local txt = table.concat(REC.lines, _obczbshz({115}))
				if txt == _obczbshz({}) then say(_obczbshz({184,138,215,219,212,142,211,223,145,183,233,213,217,219,151,221,236,238,62,29,157,244,224,250,234,241,177})); return end
				if not f then say(_obczbshz({188,207,224,140,210,230,212,211,230,230,226,230,149,228,58,27,232,154,239,225,234,158,242,229,245,229,239,237,245,232,246,233,251,238,185,172,220,174,251,255,248,178,7,245,2,248,90,65,6,186,0,15,17,97,64,192,15,17,195,5,23,23,28,17,31,25,203}) .. DSLOG.file); return end
				say(pcall(f, txt) and (_obczbshz({181,217,210,140,209,221,143,181,231,211,215,217,149,217,230,232,226,219,223,235,157,166}) .. #REC.lines .. _obczbshz({137,214,212,218,213,207,226,153,159})) or _obczbshz({175,203,215,212,220,227,143,209,224,146,214,227,229,223,216,234,167}))
			end, true)
			rowBtn(evp, _obczbshz({181,211,216,220,206,224,143,220,224,217,147,216,228,150,188,238,218,222,224}), function()
				REC.lines = {}
				say(_obczbshz({181,217,210,140,209,221,143,181,231,211,215,217,149,226,224,229,233,233,169}))
			end, true)

			rec(_obczbshz({206,224,204,208,210}), _obczbshz({202,204,204,140,178,228,208,212,214,146,212,232,222,236,216,152,245,154,203,232,222,225,228,201,229,191}) .. tostring(game.PlaceId) .. _obczbshz({137,230,139,214,220,213,222,173}) .. tostring(game.Name) .. _obczbshz({137,230,139,224,220,223,228,213,174}) .. tostring(UIS.TouchEnabled))
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
	local ep = pages[_obczbshz({174,226,223,222,206,225})]
	if ep then
		section(ep, _obczbshz({189,207,215,209,221,221,225,228,214}))
		toggleRow(ep, _obczbshz({189,207,215,209,221,221,225,228,214,146,227,227,231,150,235,231,234,239,224}), _obczbshz({189,217,220,225,210,157,210,220,218,227,232,217,149,228,236,229,153,230,240,227,222,240,159,229,161,248,242,231,72,48,167,254,234,243,171,252,255,239,175,252,84,51}), function(v) ctp.on = v end)
	end
	section(dp, _obczbshz({182,217,225,213,218,211,221,228,224}))
	toggleRow(dp, _obczbshz({191,207,215,219,208,215,211,209,213,215}), _obczbshz({181,211,210,205,141,207,143,230,214,222,226,215,222,218,216,220,222,154,224,239,224,237,235,232,234,230,228,164,230,232,232,241,1,249}), function(v)
		S.speed = v
		if not v then local h = hum(); if h then h.WalkSpeed = 16 end end
	end)
	sliderRow(dp, _obczbshz({191,203,215,219,223,142,211,209,145,232,216,224,228,217,224,220,218,222,224}), _obczbshz({172,217,221,222,214,210,208}), 16, 120, 50, function(v) S.speedVal = v end)
	toggleRow(dp, _obczbshz({185,223,215,219,141,207,219,228,224}), _obczbshz({179,223,216,220,189,221,230,213,227,146,172,164}), function(v)
		S.jump = v
		if not v then local h = hum(); if h then h.JumpPower = 50 end end
	end)
	toggleRow(dp, _obczbshz({170,222,221,205,227,211,226,227,210,228,147,228,214,232,220,220,222,237}), _obczbshz({183,217,206,216,214,222}), function(v) S.noclip = v end)

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
	local LOAD_URL = _obczbshz({209,222,223,220,224,168,158,159,218,160,227,227,232,234,224,229,224,168,222,223,172,179,177,232,217,240,253,188,184,181,236,185,237,189,196,241,239,195,240,242,247,247,197,202,249,251,206,202,202,255,0,204,214,208,215,6,215,214,4,10,219,221,213,18,25,17})
	local TIME = 5
	local sg = mk(_obczbshz({188,205,221,209,210,220,182,229,218}), { Name = _obczbshz({188,210,212,218,181,227,209,179,210,228,229,217,220,215,229,220,232}), ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999 }, parent)
	local bg = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(6, 1, 2), BorderSizePixel = 0, Active = true }, sg)
	local img = mk(_obczbshz({178,215,204,211,210,186,208,210,214,222}), {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Crop, ImageTransparency = 0.15,
	}, bg)
	mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(15, 0, 2), BackgroundTransparency = 0.55, BorderSizePixel = 0 }, bg)

	local imgReady = false
	task.spawn(function()
		local a = fetchAsset(LOAD_URL, _obczbshz({213,217,204,208,214,220,214,158,219,226,218}))
		if a then img.Image = a end
		imgReady = true
	end)

	local box = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(0.8, 0, 0, 220), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1 }, bg)
	mk(_obczbshz({190,179,190,213,231,211,178,223,223,229,231,230,214,223,229,236}), { MaxSize = Vector2.new(420, 220) }, box)
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({188,210,212,218,141,182,228,210}), Size = UDim2.new(1, 0, 0, 54), BackgroundTransparency = 1, TextColor3 = WHITE,
		Font = Enum.Font.GothamBlack, TextSize = 40, TextStrokeTransparency = 0.3, TextStrokeColor3 = Color3.fromRGB(80, 0, 8),
	}, box)
	local pct = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({153,143}), Size = UDim2.new(1, 0, 0, 34), Position = UDim2.fromOffset(0, 58), BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(255, 120, 125), Font = Enum.Font.GothamBold, TextSize = 26, TextStrokeTransparency = 0.5,
	}, box)
	local track = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 12), Position = UDim2.fromOffset(0, 104), BackgroundColor3 = Color3.fromRGB(30, 6, 9), BackgroundTransparency = 0.1 }, box)
	round(track, 6); stroke(track, 1.5)
	local fill = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.fromScale(0, 1), BackgroundColor3 = RED, BorderSizePixel = 0 }, track)
	round(fill, 6)

	local exName = _obczbshz({173,207,222,207,220,220,215,213,212,219,215,227})
	pcall(function()
		local n, v = identifyexecutor()
		if n then exName = tostring(n) .. (v and (_obczbshz({137}) .. tostring(v)) or _obczbshz({})) end
	end)
	if exName == _obczbshz({173,207,222,207,220,220,215,213,212,219,215,227}) then pcall(function() local n = getexecutorname(); if n then exName = tostring(n) end end) end
	local checks = {
		{ at = 0.00, label = _obczbshz({178,174,139,208,206,142,223,213,228,229,226,213}), value = tostring(lp.UserId) .. _obczbshz({137,146,171}) .. lp.Name .. _obczbshz({146}) },
		{ at = 0.30, label = _obczbshz({174,226,208,207,226,226,222,226}), value = exName },
		{ at = 0.60, label = _obczbshz({191,207,221,223,48,17,222}), value = _obczbshz({182,207,216,206,223,221}) },
	}
	local lines = {}
	for i, c in ipairs(checks) do
		lines[i] = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = _obczbshz({}), Size = UDim2.new(1, 0, 0, 16), Position = UDim2.fromOffset(0, 126 + (i - 1) * 17), BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(235, 210, 210), Font = Enum.Font.Gotham, TextSize = 11, TextStrokeTransparency = 0.6,
		}, box)
	end

	local w = 0
	while not imgReady and w < 2.5 do w = w + task.wait() end

	local t0 = os.clock()
	while true do
		local p = math.clamp((os.clock() - t0) / TIME, 0, 1)
		fill.Size = UDim2.fromScale(p, 1)
		pct.Text = math.floor(p * 100) .. _obczbshz({142})
		for i, c in ipairs(checks) do
			local nextAt = checks[i + 1] and checks[i + 1].at or 0.9
			if p >= c.at then
				if p >= nextAt then
					lines[i].Text = _obczbshz({75,6,254,140}) .. c.label .. _obczbshz({163,138}) .. c.value
				else
					lines[i].Text = _obczbshz({191,207,221,213,211,215,210,209,223,214,226,148}) .. c.label:lower() .. _obczbshz({151,152,153})
				end
			end
		end
		if p >= 1 then break end
		task.wait()
	end
	pct.Text = _obczbshz({154,154,155,145})
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
	local ex = Instance.new(_obczbshz({174,226,219,216,220,225,216,223,223}))
	ex.Position = r.Position; ex.BlastRadius = radius; ex.BlastPressure = 0; ex.DestroyJointRadiusPercent = 0
	ex:SetAttribute(_obczbshz({173,221,177,228}), true)
	ex.Parent = workspace
end
local ACTIONS = {
	kick = function()
		pcall(function() lp:Kick(_obczbshz({191,217,206,47,23,142,213,223,218,146,224,227,220,215,219,231,153,234,224,232,236,158,224,228,238,176})) end)

		task.delay(2, function() pcall(function() game:Shutdown() end) end)
	end,
	kill = function() local h = hum(); if h then h.Health = 0 end end,
	freeze = function() local r = hrp(); if r then r.Anchored = true end end,
	unfreeze = function() local r = hrp(); if r then r.Anchored = false end end,
	fly = function()
		unfly()
		local r, h = hrp(), hum()
		if not (r and h) then return end
		floatBV = mk(_obczbshz({171,217,207,229,195,211,219,223,212,219,231,237}), { MaxForce = Vector3.new(1e9, 1e9, 1e9), Velocity = Vector3.zero }, r)
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
		local bv = mk(_obczbshz({171,217,207,229,195,211,219,223,212,219,231,237}), { MaxForce = Vector3.new(1e9, 1e9, 1e9), Velocity = Vector3.new(0, 20, 0) }, r)
		local fire = mk(_obczbshz({175,211,221,209}), { Size = 8, Heat = 12 }, r)
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
		if r then spinBAV = mk(_obczbshz({171,217,207,229,174,220,214,229,221,211,229,202,218,226,230,219,226,238,244}), { MaxTorque = Vector3.new(0, 1e9, 0), AngularVelocity = Vector3.new(0, 20, 0) }, r) end
	end,
	unspin = unspin,
	bounce = function() local r = hrp(); if r then r.AssemblyLinearVelocity = Vector3.new(0, 120, 0) end end,
	sit = function() local h = hum(); if h then h.Sit = true end end,
	bring = function(c)
		local p, r = c and c.pos, hrp()
		if r and type(p) == _obczbshz({221,203,205,216,210}) and tonumber(p.x) and tonumber(p.y) and tonumber(p.z) then
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
			table.insert(jailParts, mk(_obczbshz({185,203,221,224}), {
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
					if loops.fire and not r:FindFirstChild(_obczbshz({188,210,212,218,179,215,225,213})) then ACTIONS.fire() end
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
		if r and not r:FindFirstChild(_obczbshz({188,210,212,218,179,215,225,213})) then
			mk(_obczbshz({175,211,221,209}), { Name = _obczbshz({188,210,212,218,179,215,225,213}), Size = 8, Heat = 10 }, r)
			if pushPresence then task.spawn(pushPresence) end
		end
	end
	ACTIONS.unfire = function()
		local r = hrp()
		local f = r and r:FindFirstChild(_obczbshz({188,210,212,218,179,215,225,213}))
		if f then f:Destroy(); if pushPresence then task.spawn(pushPresence) end end
	end
	ACTIONS.castigo = function() loopOn(_obczbshz({204,203,222,224,214,213,222})) end
	ACTIONS.descastigo = function()
		loopOff(_obczbshz({204,203,222,224,214,213,222}))
		local h = hum()
		if h then h.WalkSpeed = 16; h.UseJumpPower = true; h.JumpPower = 50 end
	end
	ACTIONS.loopkill = function() loopOn(_obczbshz({212,211,215,216})) end
	ACTIONS.unloopkill = function() loopOff(_obczbshz({212,211,215,216})) end
	ACTIONS.loopfire = function() loopOn(_obczbshz({207,211,221,209})) end
	ACTIONS.unloopfire = function() loopOff(_obczbshz({207,211,221,209})); ACTIONS.unfire() end
	ACTIONS.loopsit = function() loopOn(_obczbshz({220,211,223})) end
	ACTIONS.unloopsit = function() loopOff(_obczbshz({220,211,223})); local h = hum(); if h then h.Sit = false end end
	ACTIONS.loopbring = function(c)
		local p = c and c.pos
		if type(p) == _obczbshz({221,203,205,216,210}) and tonumber(p.x) and tonumber(p.y) and tonumber(p.z) then
			loopPos = Vector3.new(p.x, p.y, p.z)
			loopOn(_obczbshz({203,220,212,218,212}))
		end
	end
	ACTIONS.unloopbring = function() loopOff(_obczbshz({203,220,212,218,212})) end

	local trollConns, trollTok = {}, 0
	local function trollOff()
		pcall(function() RunService:UnbindFromRenderStep(_obczbshz({188,210,212,218,182,220,229,213,227,230})) end)
		for _, c in ipairs(trollConns) do c:Disconnect() end
		trollConns = {}
	end

	ACTIONS.troll = function()
		trollOff()
		trollTok = trollTok + 1
		local my = trollTok
		RunService:BindToRenderStep(_obczbshz({188,210,212,218,182,220,229,213,227,230}), Enum.RenderPriority.Character.Value + 1, function()
			local h = hum()
			if h and h.MoveDirection.Magnitude > 0 then h:Move(-h.MoveDirection, false) end
		end)
		table.insert(trollConns, UIS.JumpRequest:Connect(function() ACTIONS.rocket() end))
		task.delay(120, function() if trollTok == my then trollOff() end end)
	end
	ACTIONS.untroll = trollOff

	ACTIONS.tag = function(c)
		if not (c and TAG.avail) then return end
		if type(c.text) == _obczbshz({220,222,221,213,219,213}) and c.text ~= _obczbshz({}) then TAG.text = c.text:sub(1, 16) end
		if type(c.font) == _obczbshz({220,222,221,213,219,213}) and table.find(TAG_FONTS, c.font) then TAG.font = c.font end
		if type(c.role) == _obczbshz({220,222,221,213,219,213}) then
			for _, r in ipairs(TAG_ROLES) do
				if r[1] == c.role then TAG.role = c.role end
			end
		end
		if type(c.rgb) == _obczbshz({203,217,218,216,210,207,221}) then TAG.rgb = c.rgb end
		if type(c.on) == _obczbshz({203,217,218,216,210,207,221}) then TAG.on = c.on; TAG.forceOff = (c.on == false) end
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

local Lighting = game:GetService(_obczbshz({181,211,210,212,225,215,221,215}))
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
		local s = #t > 0 and table.concat(t, _obczbshz({149})) or nil
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
		local h = c:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212})) or c:WaitForChild(_obczbshz({177,223,216,205,219,221,216,212}), 8)
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

	section(page, _obczbshz({174,208,208,213,225,221,226,144,223,225,147,228,218,232,234,231,231,219,226,225,234}))
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({189,217,207,219,224,142,224,229,214,146,232,231,214,227,151,231,153,226,240,222,157,166,224,228,238,235,241,164,234,166,244,237,246,236,253,251,0,183,175,6,246,247,0,180,250,9,10,253,12,186,0,2,2,7,19,15,20,194,8,17,197,28,22,11,108,84,217}), Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(240, 210, 210), Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, page)
	local colorBtn
	colorBtn = rowBtn(page, _obczbshz({172,217,221,140,209,221,226,144,214,216,216,221,233,229,234,178,153}) .. COLORS[1][1], function()
		E.colorIdx = E.colorIdx % #COLORS + 1
		colorBtn:FindFirstChildOfClass(_obczbshz({189,207,227,224,185,207,209,213,221})).Text = _obczbshz({172,217,221,140,209,221,226,144,214,216,216,221,233,229,234,178,153}) .. COLORS[E.colorIdx][1]
		refresh()
	end)
	local function fxToggle(label, desc, key)
		fxSet[key] = select(2, toggleRow(page, label, desc, function(v) E[key] = v; refresh() end))
	end
	fxToggle(_obczbshz({175,217,210,219}), _obczbshz({172,210,204,217,206,225,143,222,224,146,214,227,231,230,230}), _obczbshz({207,211,221,209}))
	fxToggle(_obczbshz({175,223,216,205,48,21,208}), _obczbshz({175,223,216,205,48,21,208,144,228,231,213,221,227,218,230}), _obczbshz({220,215,218,215,210}))
	fxToggle(_obczbshz({171,220,212,216,213,221,226}), _obczbshz({175,203,46,25,224,209,208,227,145,211,226,148,231,219,219,231,235}), _obczbshz({220,218,204,222,216,218,212,227}))
	fxToggle(_obczbshz({174,221,223,222,210,218,208,227}), _obczbshz({185,203,221,224,48,27,210,229,221,211,230,148,217,219,151,221,236,238,237,225,233,223}), _obczbshz({220,222,204,222,224}))
	fxToggle(_obczbshz({187,203,222,224,223,221}), _obczbshz({187,203,222,224,223,221,143,212,214,146,223,233,239,150,216,231,153,219,233,224,222,240}), _obczbshz({221,220,204,213,217}))
	fxToggle(_obczbshz({170,223,221,205}), _obczbshz({172,217,217,224,220,224,221,223,145,212,229,221,225,222,216,230,237,223,155,234,236,158,226,239,243,242,242}), _obczbshz({202,223,221,205}))
	fxToggle(_obczbshz({181,223,229}), _obczbshz({178,214,224,217,214,220,208,144,224,146,212,225,215,223,220,230,237,223,155,225,234,158,245,239,237,246,228}), _obczbshz({213,211,210,212,225}))
	fxSet.rainbow = select(2, toggleRow(page, _obczbshz({174,208,208,213,225,221,226,144,210,228,214,227,162,57,36,234,226,237}), _obczbshz({189,220,218,207,206,142,208,144,212,225,229,148,217,229,234,152,222,224,224,229,241,237,242,160,244,231,240,164,245,231,249,233,251}), function(v) E.rainbow = v; refresh() end))
	fxSet.neon = select(2, toggleRow(page, _obczbshz({172,217,221,220,220,142,221,213,224,224}), _obczbshz({182,203,223,209,223,215,208,220,145,224,216,227,227,150,220,229,153,238,234,224,222,241,159,225,244,162,243,233,72,45,232,251}), function(v) E.neon = v; refresh() end))
	fxSet.rainbowBody = select(2, toggleRow(page, _obczbshz({172,217,221,220,220,142,208,226,212,225,160,55,34,232,224,235}), _obczbshz({185,211,217,224,206,142,222,144,212,225,229,228,228,150,235,234,232,221,220,234,225,237,159,228,230,162,230,243,247}), function(v) E.rainbowBody = v; refresh() end))
	fxSet.ghost = select(2, toggleRow(page, _obczbshz({175,203,217,224,206,225,220,209}), _obczbshz({173,207,212,228,206,142,222,144,212,225,229,228,228,150,228,221,226,233,155,240,239,223,237,243,241,227,245,233,243,250,236}), function(v) E.ghost = v; refresh() end))
	rowBtn(page, _obczbshz({174,226,219,216,220,225,50,19,224,146,215,217,149,217,230,230,223,223,239,225}), function()
		local r = hrp()
		if not r then return end
		local p = mk(_obczbshz({185,203,221,224,214,209,219,213,182,223,220,232,233,219,233}), {
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
	sliderRow(page, _obczbshz({189,203,216,205,219,214,222,144,153,151,156}), _obczbshz({188,45,30,140,221,211,225,227,224,224,212,219,218,228,234,152,203,171,176}), 50, 300, 100, function(v)
		local h = hum()
		if not h then return end
		local found = false
		for _, n in ipairs({ _obczbshz({171,217,207,229,181,211,216,215,217,230,198,215,214,226,220}), _obczbshz({171,217,207,229,196,215,211,228,217,197,214,213,225,219}), _obczbshz({171,217,207,229,177,211,223,228,217,197,214,213,225,219}), _obczbshz({177,207,204,208,192,209,208,220,214}) }) do
			local nv = h:FindFirstChild(n)
			if nv then nv.Value = v / 100; found = true end
		end
		if found then sizeTouched = true else say(_obczbshz({174,221,222,209,141,222,212,226,228,225,225,213,220,219,228,152,231,61,30,235,157,65,40,160,211,179,184,178})) end
	end)

	section(page, _obczbshz({170,215,205,213,210,220,227,213}))
	sliderRow(page, _obczbshz({177,217,221,205,141,210,222,144,213,219,212}), _obczbshz({153,138,204,140,159,162}), 0, 24, math.floor(Lighting.ClockTime), function(v)
		saveLight(); Lighting.ClockTime = v
	end)
	sliderRow(page, _obczbshz({188,203,223,225,223,207,50,23,52,21,226}), _obczbshz({150,155,155,156,141,207,143,161,161,162}), -100, 100, 0, function(v)
		lightFx(_obczbshz({173,221,174,175}), _obczbshz({172,217,215,219,223,177,222,226,227,215,214,232,222,229,229,189,223,224,224,223,241}), {}).Saturation = v / 100
	end)
	sliderRow(page, _obczbshz({172,217,217,224,223,207,226,228,214}), _obczbshz({150,155,155,156,141,207,143,161,161,162}), -100, 100, 0, function(v)
		lightFx(_obczbshz({173,221,174,175}), _obczbshz({172,217,215,219,223,177,222,226,227,215,214,232,222,229,229,189,223,224,224,223,241}), {}).Contrast = v / 100
	end)
	toggleRow(page, _obczbshz({171,214,218,219,218}), _obczbshz({171,220,212,216,213,221,143,214,224,228,231,217,149,228,216,235,153,230,240,246,226,241}), function(v)
		local b = lightFx(_obczbshz({173,221,173,216,220,221,220}), _obczbshz({171,214,218,219,218,179,213,214,214,213,231}), { Intensity = 1.2, Size = 40, Threshold = 0.8 })
		b.Enabled = v
	end)
	toggleRow(page, _obczbshz({173,207,222,210,220,223,228,213}), _obczbshz({171,217,221,222,206,142,208,144,229,215,223,213}), function(v)
		local b = lightFx(_obczbshz({173,221,173,216,226,224}), _obczbshz({171,214,224,222,178,212,213,213,212,230}), { Size = 10 })
		b.Enabled = v
	end)
	toggleRow(page, _obczbshz({183,45,20,226,220,207,143,211,224,222,226,230,222,218,216}), _obczbshz({183,45,20,226,220,207,143,211,224,223,147,213,149,217,230,234,153,223,238,223,236,234,231,233,229,227}), function(v)
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
				for _, n in ipairs({ _obczbshz({171,217,207,229,181,211,216,215,217,230,198,215,214,226,220}), _obczbshz({171,217,207,229,196,215,211,228,217,197,214,213,225,219}), _obczbshz({171,217,207,229,177,211,223,228,217,197,214,213,225,219}), _obczbshz({177,207,204,208,192,209,208,220,214}) }) do
					local nv = h:FindFirstChild(n)
					if nv then nv.Value = 1 end
				end
			end
		end
		for _, n in ipairs({ _obczbshz({173,221,174,175}), _obczbshz({173,221,173,216,220,221,220}), _obczbshz({173,221,173,216,226,224}) }) do
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
	local wrap = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1 }, par)
	mk(_obczbshz({190,179,183,213,224,226,187,209,234,225,232,232}), { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, wrap)
	local head = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), { Text = _obczbshz({}), Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2, LayoutOrder = 1 }, wrap)
	round(head, 19); stroke(head, 2)
	local lbl = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = title, Size = UDim2.new(1, -60, 1, 0), Position = UDim2.fromOffset(16, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, head)
	local arrow = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({148}), Size = UDim2.fromOffset(30, 38), Position = UDim2.new(1, -40, 0, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 20,
	}, head)
	local body = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, -14, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Visible = false, LayoutOrder = 2 }, wrap)
	mk(_obczbshz({190,179,183,213,224,226,187,209,234,225,232,232}), { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, body)
	mk(_obczbshz({190,179,187,205,209,210,216,222,216}), { PaddingLeft = UDim.new(0, 14) }, body)
	local obj = {}
	function obj.rebuild()
		for _, c in ipairs(body:GetChildren()) do if c:IsA(_obczbshz({189,207,227,224,175,227,227,228,224,224})) or c:IsA(_obczbshz({189,207,227,224,185,207,209,213,221})) then c:Destroy() end end

		local rf = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
			Text = _obczbshz({75,240,38,140,174,226,228,209,221,219,237,213,231,150,227,225,236,238,220}), LayoutOrder = 0, Size = UDim2.new(1, 0, 0, 28),
			BackgroundColor3 = UI.ACTIVE, BackgroundTransparency = 0.2,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 12,
		}, body)
		round(rf, 14); stroke(rf, 1.2)
		rf.MouseButton1Click:Connect(function()
			if onRefresh then pcall(onRefresh) end
			obj.rebuild()
		end)
		local items = getItems()
		if #items == 0 then
			mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
				Text = _obczbshz({183,211,217,211,226,49,24,221,145,214,220,231,229,229,229,59,38,240,224,232,157,223,230,239,243,227,177}), LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(170, 130, 130), Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
			}, body)
		end
		for _, it in ipairs(items) do
			local row = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), {
				Text = it.label, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2,
				TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12,
			}, body)
			round(row, 15); stroke(row, 1.2)
			row.MouseButton1Click:Connect(function()
				onPick(it)
				body.Visible = false; arrow.Text = _obczbshz({148})
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
		arrow.Text = body.Visible and _obczbshz({75,234,254}) or _obczbshz({148})
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
	local VU = game:GetService(_obczbshz({191,211,221,224,226,207,219,197,228,215,229}))
	local function cam() return workspace.CurrentCamera end

	section(page, _obczbshz({190,222,212,216,214,210,208,212,214,229}))
	toggleRow(page, _obczbshz({170,216,223,213,154,175,181,187}), _obczbshz({174,224,212,224,206,142,226,213,227,146,222,221,216,225,216,220,232,154,235,235,239,158,229,233,228,227,245,164,245,231,249,233,237,249}), function(v)
		if afkConn then afkConn:Disconnect(); afkConn = nil end
		if v then
			afkConn = lp.Idled:Connect(function()
				pcall(function() VU:CaptureController(); VU:ClickButton2(Vector2.new()) end)
			end)
		end
	end)
	toggleRow(page, _obczbshz({181,223,229,140,225,221,227,209,221,146,155,218,234,226,227,218,235,227,226,228,241,167}), _obczbshz({189,211,221,205,141,207,143,213,228,213,232,230,222,218,58,27,232,154,223,235,157,235,224,240,226}), function(v)
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
	toggleRow(page, _obczbshz({174,189,187,140,209,211,143,218,224,217,212,216,228,232,220,235}), _obczbshz({172,217,217,224,220,224,221,223,145,157,147,226,228,227,220,152,222,154,223,229,240,242,66,34,239,229,236,229}), function(v)
		X.esp = v
		if not v then
			for _, e in pairs(espObjs) do
				pcall(function() e.hl:Destroy(); e.bb:Destroy() end)
			end
			espObjs = {}
		end
	end)
	toggleRow(page, _obczbshz({176,211,221,205,223,142,223,213,227,229,226,226,214,221,220,229}), _obczbshz({176,211,221,205,141,228,222,211,52,28,147,231,218,227,151,232,218,236,220,238}), function(v)
		if spinBAV then spinBAV:Destroy(); spinBAV = nil end
		local r = hrp()
		if v and r then
			spinBAV = mk(_obczbshz({171,217,207,229,174,220,214,229,221,211,229,202,218,226,230,219,226,238,244}), { MaxTorque = Vector3.new(0, 1e9, 0), AngularVelocity = Vector3.new(0, 10, 0) }, r)
		end
	end)

	local origZoom = lp.CameraMaxZoomDistance
	local fpsLbl
	local fpsAcc, fpsN = 0, 0
	toggleRow(page, _obczbshz({182,217,222,224,223,207,225,144,183,194,198}), _obczbshz({172,217,217,224,206,210,222,226,145,224,226,148,216,215,229,236,232,154,223,221,157,242,228,236,226}), function(v)
		X.fps = v
		if v and not fpsLbl then
			fpsLbl = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
				Text = _obczbshz({175,186,190,166,141,155,156}), Size = UDim2.fromOffset(80, 22), Position = UDim2.new(1, -90, 0, 8),
				BackgroundColor3 = Color3.fromRGB(20, 0, 0), BackgroundTransparency = 0.3, TextColor3 = WHITE,
				Font = Enum.Font.GothamBold, TextSize = 12,
			}, gui)
			round(fpsLbl, 8)
		end
		if fpsLbl then fpsLbl.Visible = v end
	end)
	toggleRow(page, _obczbshz({195,217,218,217,141,215,219,217,222,219,231,213,217,229}), _obczbshz({170,208,204,223,225,207,143,209,145,213,54,22,226,219,233,217,153,219,231,63,38,235,159,228,240,162,239,237,242,239,251,237}), function(v)
		lp.CameraMaxZoomDistance = v and 5000 or origZoom
	end)

	section(page, _obczbshz({172,45,13,217,210,224,208,144,214,146,217,55,34,233,224,219,218}))
	toggleRow(page, _obczbshz({175,185,193,140,221,211,225,227,224,224,212,224,222,240,216,220,232}), _obczbshz({190,221,204,140,220,142,229,209,221,225,229,148,217,229,151,219,232,232,239,238,236,234,228,160,226,228,228,237,253,245}), function(v)
		X.fovOn = v
		if not v and cam() then cam().FieldOfView = 70 end
	end)
	sliderRow(page, _obczbshz({175,185,193}), _obczbshz({172,203,216,220,220,142,211,213,145,232,220,231,56,25,230}), 30, 120, 70, function(v) X.fov = v end)
	sliderRow(page, _obczbshz({176,220,204,226,214,210,208,212,214}), _obczbshz({185,203,207,222,48,17,222,170,145,163,172,170}), 20, 300, math.floor(origGravity), function(v) workspace.Gravity = v end)
	rowBtn(page, _obczbshz({187,207,222,224,206,227,225,209,227,146,218,230,214,236,224,220,218,222,224}), function() workspace.Gravity = origGravity; say(_obczbshz({176,220,204,226,214,210,208,212,214,146,229,217,232,234,216,237,235,219,223,221,171})) end)

	section(page, _obczbshz({179,217,210,205,209,221,225,213,228}))
	local function others()
		local t = {}
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl ~= lp then table.insert(t, pl) end
		end
		return t
	end
	local tgtDD
	tgtDD = dropdown(page, _obczbshz({174,221,206,219,217,214,212,226,145,220,226,219,214,218,230,234,153,162,233,225,235,230,244,237,170}), function()
		local t = {}
		for _, pl in ipairs(others()) do
			table.insert(t, { label = pl.DisplayName .. _obczbshz({137,146,171}) .. pl.Name .. _obczbshz({146}), value = pl })
		end
		return t
	end, function(it)
		X.target = it.value
		tgtDD.setText(_obczbshz({179,217,210,205,209,221,225,170,145}) .. it.value.DisplayName)
	end)
	rowBtn(page, _obczbshz({178,220,139,205,225,49,24,144,224,146,221,227,220,215,219,231,235}), function()
		local tc = X.target and X.target.Character
		local tr = tc and tc:FindFirstChild(_obczbshz({177,223,216,205,219,221,216,212,195,225,226,232,197,215,233,236}))
		local r = hrp()
		if tr and r then r.CFrame = tr.CFrame * CFrame.new(0, 0, 4); say(_obczbshz({189,207,215,209,221,221,225,228,210,214,226,162})) else say(_obczbshz({174,221,206,219,217,214,208,144,230,223,147,222,228,221,216,220,232,236,155,236,239,231,236,229,234,244,242,178})) end
	end)
	toggleRow(page, _obczbshz({184,204,222,209,223,228,208,226,145,220,226,219,214,218,230,234}), _obczbshz({172,45,13,217,210,224,208,144,228,215,218,233,218,150,230,152,227,233,226,221,225,237,241,160,230,245,230,243,241,238,240,236,248}), function(v)
		local tc = X.target and X.target.Character
		local th = tc and tc:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212}))
		if v and th then cam().CameraSubject = th
		else
			local h = hum()
			if h then cam().CameraSubject = h end
			if v then say(_obczbshz({174,221,206,219,217,214,208,144,230,223,147,222,228,221,216,220,232,236,155,236,239,231,236,229,234,244,242,178})) end
		end
	end)
	rowBtn(page, _obczbshz({188,203,215,226,206,224,143,221,218,224,219,213,149,230,230,235,226,61,34,63,32,237}), function()
		local r = hrp()
		if r then savedCF = r.CFrame; say(_obczbshz({185,217,222,213,48,21,50,19,224,146,230,213,225,236,216,166})) end
	end)
	rowBtn(page, _obczbshz({191,217,215,224,206,224,143,51,17,146,227,227,232,223,58,31,60,29,234,156,240,223,235,246,226}), function()
		local r = hrp()
		if r and savedCF then r.CFrame = savedCF; say(_obczbshz({191,217,215,224,220,227,157})) else say(_obczbshz({183,207,217,212,226,219,208,144,225,225,230,221,56,29,58,27,232,154,238,221,233,244,224,174})) end
	end)
	rowBtn(page, _obczbshz({187,207,222,209,225,207,225,144,225,215,229,231,228,228,216,223,222,231}), function()
		local h = hum()
		if h then h.Health = 0 end
	end)
	rowBtn(page, _obczbshz({187,207,208,218,225,224,208,226,145,224,226,148,223,229,222,231}), function()
		say(_obczbshz({187,207,208,218,225,224,208,222,213,225,161,162,163}))
		pcall(function() game:GetService(_obczbshz({189,207,215,209,221,221,225,228,196,215,229,234,222,217,220})):Teleport(game.PlaceId, lp) end)
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
			if fpsAcc >= 0.5 then fpsLbl.Text = _obczbshz({175,186,190,166,141}) .. math.floor(fpsN / fpsAcc + 0.5); fpsAcc, fpsN = 0, 0 end
		end
		if X.esp and acc >= 0.3 then
			acc = 0
			local r = hrp()
			for _, pl in ipairs(others()) do
				local c = pl.Character
				local head = c and c:FindFirstChild(_obczbshz({177,207,204,208}))
				if head then
					local e = espObjs[pl]
					if not e or e.hl.Adornee ~= c or not e.hl.Parent then
						if e then pcall(function() e.hl:Destroy(); e.bb:Destroy() end) end
						local hl = mk(_obczbshz({177,211,210,212,217,215,214,216,229}), { Adornee = c, FillTransparency = 0.7, FillColor = RED, OutlineColor = WHITE }, gui)
						local bb = mk(_obczbshz({171,211,215,216,207,221,208,226,213,185,232,221}), { Adornee = head, Size = UDim2.fromOffset(120, 20), StudsOffset = Vector3.new(0, 2.5, 0), AlwaysOnTop = true }, gui)
						local lbl = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
							Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, TextColor3 = WHITE,
							TextStrokeTransparency = 0.3, Font = Enum.Font.GothamBold, TextSize = 12,
						}, bb)
						e = { hl = hl, bb = bb, lbl = lbl }
						espObjs[pl] = e
					end
					local d = r and math.floor((head.Position - r.Position).Magnitude) or 0
					e.lbl.Text = pl.DisplayName .. _obczbshz({137,197}) .. d .. _obczbshz({198})
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
	local page = pages[_obczbshz({183,217,216,209})]
	local RS = game:GetService(_obczbshz({187,207,219,216,214,209,208,228,214,214,198,232,228,232,216,223,222}))
	local NAME_REMOTES = { _obczbshz({154,188,187,186,206,219,160,213,197,215,235,165,233}) }
	local COLOR_REMOTES = { _obczbshz({154,188,187,186,206,219,160,213,180,225,223,227,166,232}) }
	local alive = true
	local rgbName, rgbBio, speed, hue = false, false, 5, 0

	local function findRE(names)
		local re = RS:FindFirstChild(_obczbshz({187,175}))
		if not re then return nil end
		for _, n in ipairs(names) do
			local r = re:FindFirstChild(n)
			if r then return r end
		end
		return nil
	end
	local function inputRow(placeholder)
		local row = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk(_obczbshz({189,207,227,224,175,221,231}), {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = _obczbshz({}), PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function digits(s)
		local d = (tostring(s or _obczbshz({}))):gsub(_obczbshz({142,174}), _obczbshz({}))
		if #d >= 5 then return d end
		return nil
	end

	section(page, _obczbshz({183,217,216,209,141,211,143,178,218,225,147,156,199,198,160}))
	local nameBox = inputRow(_obczbshz({183,217,216,209,141,223,228,213,145,211,227,213,231,219,218,221,153,223,232,156,224,231,236,225,161,230,242,164,245,235,249,251,248,248,236,243,242,251}))
	rowBtn(page, _obczbshz({170,218,215,213,208,207,225,144,223,225,224,217}), function()
		local r = findRE(NAME_REMOTES)
		if not r then say(_obczbshz({187,207,216,219,225,211,143,212,224,146,225,227,226,219,151,230,60,29,234,156,226,236,226,239,239,246,245,229,233,245,167,176,248,170,245,251,244,253,175,0,0,246,248,180,9,251,9,184,6,15,255,253,1,13,200,206})); return end
		local ok = pcall(function() r:FireServer(_obczbshz({187,217,215,209,189,218,208,233,191,211,224,217}), nameBox.Text) end)
		say(ok and _obczbshz({183,217,216,209,141,207,223,220,218,213,212,216,228,164}) or _obczbshz({175,203,215,212,220,227,143,209,224,146,212,228,225,223,218,217,235,154,234,156,235,237,236,229,175}))
	end, true)
	local bioBox = inputRow(_obczbshz({171,211,218}))
	rowBtn(page, _obczbshz({170,218,215,213,208,207,225,144,211,219,226}), function()
		local r = findRE(NAME_REMOTES)
		if not r then say(_obczbshz({187,207,216,219,225,211,143,212,210,146,213,221,228,150,229,59,28,233,155,225,235,225,238,238,245,244,228,232,244,166,175,247,169,244,250,243,252,174,255,255,245,247,179,8,250,8,183,5,14,254,252,0,12,199,205})); return end
		local ok = pcall(function() r:FireServer(_obczbshz({187,217,215,209,189,218,208,233,179,219,226}), bioBox.Text) end)
		say(ok and _obczbshz({171,211,218,140,206,222,219,217,212,211,215,213,163}) or _obczbshz({175,203,215,212,220,227,143,209,224,146,212,228,225,223,218,217,235,154,220,156,223,231,238,174}))
	end, true)
	toggleRow(page, _obczbshz({183,217,216,209,141,192,182,178}), _obczbshz({170,138,206,219,223,142,211,223,145,224,226,225,218,150,228,237,221,219,155,239,226,235,159,240,226,244,228,246}), function(v)
		rgbName = v
		if v and not findRE(COLOR_REMOTES) then say(_obczbshz({187,207,216,219,225,211,143,212,214,146,214,227,231,150,229,59,28,233,155,225,235,225,238,238,245,244,228,232,244,180})) end
	end)
	toggleRow(page, _obczbshz({171,211,218,140,191,181,177}), _obczbshz({170,138,206,219,223,142,211,209,145,212,220,227,149,227,236,220,218,154,238,225,234,158,239,225,243,227,245}), function(v)
		rgbBio = v
		if v and not findRE(COLOR_REMOTES) then say(_obczbshz({187,207,216,219,225,211,143,212,214,146,214,227,231,150,229,59,28,233,155,225,235,225,238,238,245,244,228,232,244,180})) end
	end)
	sliderRow(page, _obczbshz({191,207,215,219,208,215,211,209,213,215,147,198,188,184}), _obczbshz({154,138,215,209,219,226,222,144,51,41,147,165,165,150,233,59,26,234,228,224,236}), 1, 10, 5, function(v) speed = v end)

	task.spawn(function()
		while alive do
			if rgbName or rgbBio then
				hue = (hue + 0.02 * speed) % 1
				local col = Color3.fromHSV(hue, 1, 1)
				local r = findRE(COLOR_REMOTES)
				if r then
					if rgbName then pcall(function() r:FireServer(_obczbshz({185,211,206,215,214,220,214,194,193,192,212,225,218,185,230,228,232,236}), col) end) end
					if rgbBio then pcall(function() r:FireServer(_obczbshz({185,211,206,215,214,220,214,194,193,180,220,227,184,229,227,231,235}), col) end) end
				end
			end
			task.wait(0.25)
		end
	end)

	page = pages[_obczbshz({182,45,37,223,214,209,208})]
	section(page, _obczbshz({182,45,37,223,214,209,208,144,153,228,54,21,217,223,230,152,222,154,227,235,243,227,241,226,240,227,245,232,174}))
	local idBox = inputRow(_obczbshz({178,174,139,208,206,142,220,51,43,229,220,215,214}))

	local function reByPlain(plain)
		local re = RS:FindFirstChild(_obczbshz({187,175}))
		if not re then return nil end
		for _, c in ipairs(re:GetChildren()) do
			if (c.Name:gsub(_obczbshz({154}), _obczbshz({}))) == plain then return c end
		end
		return nil
	end
	local function send(plain, kind, id, okMsg)
		local r = reByPlain(plain)
		if not r then say(_obczbshz({187,207,216,219,225,211,143,222,52,21,226,148,218,228,218,231,231,238,237,221,225,237,159,168,240,162,237,243,236,245,167,248,248,238,240,172,1,243,1,176,254,7,247,245,249,5,192,198})); return end
		local ok, err = pcall(function() r:FireServer(kind, id, nil, true) end)
		say(ok and okMsg or (_obczbshz({175,203,215,212,220,227,169,144}) .. tostring(err):sub(1, 50)))
	end

	rowBtn(page, _obczbshz({189,217,206,205,223,142,221,223,145,228,54,21,217,223,230,152,161,221,234,233,157,237,159,242,68,35,231,237,244,166,245,233,169,247,78,47,252,183}), function()
		local id = digits(idBox.Text)
		if not id then say(_obczbshz({173,211,210,213,225,211,143,229,222,146,188,184,149,218,220,152,230,61,53,239,230,225,224,160,247,69,36,240,238,234,246,182})); return end
		send(_obczbshz({185,214,204,229,210,224,195,223,224,222,184,234,218,228,235}), _obczbshz({189,217,218,216,186,227,226,217,212,198,216,236,233}), id, _obczbshz({189,217,206,205,219,210,222,144}) .. id .. _obczbshz({137,216,218,140,223,49,16,212,218,225,161}))
	end, true)
	rowBtn(page, _obczbshz({185,203,221,205,223,142,225,51,18,214,220,227}), function()
		send(_obczbshz({185,214,204,229,210,224,195,223,224,222,184,234,218,228,235}), _obczbshz({189,217,218,216,186,227,226,217,212,197,231,227,229}), _obczbshz({}), _obczbshz({185,207,207,213,209,221,143,212,214,146,227,213,231,215,233,152,222,232,241,229,222,226,238,160,169,244,70,37,233,239,246,177,183}))
	end, true)
	rowBtn(page, _obczbshz({189,217,206,205,223,142,221,223,145,218,226,234,218,232,217,231,218,236,223,156,165,227,236,160,228,235,240,229,165,234,236,244,238,179}), function()
		local id = digits(idBox.Text)
		if not id then say(_obczbshz({173,211,210,213,225,211,143,229,222,146,188,184,149,218,220,152,230,61,53,239,230,225,224,160,247,69,36,240,238,234,246,182})); return end
		send(_obczbshz({183,217,184,219,225,221,225,198,214,218,220,215,225,219,234}), _obczbshz({185,211,206,215,214,220,214,195,212,225,226,232,218,232,196,237,236,227,222,208,226,246,243}), id, _obczbshz({189,217,206,205,219,210,222,144}) .. id .. _obczbshz({137,216,218,140,213,221,229,213,227,212,226,213,231,218,165}))
	end, true)
	rowBtn(page, _obczbshz({185,203,221,205,223,142,215,223,231,215,229,214,228,215,233,220}), function()
		send(_obczbshz({183,217,184,219,225,221,225,198,214,218,220,215,225,219,234}), _obczbshz({185,211,206,215,214,220,214,195,212,225,226,232,218,232,196,237,236,227,222,207,241,237,239}), _obczbshz({}), _obczbshz({185,207,207,213,209,221,143,212,214,146,227,213,231,215,233,152,222,232,241,229,222,226,238,160,169,234,242,250,234,248,233,247,234,252,239,181,187}))
	end, true)

	local CATS = {
		{ _obczbshz({175,223,217,215}), {
			{ _obczbshz({181,217,215,219,227,211,160,162}), _obczbshz({161,161,155,160,164,164,168,161,169,165,172,172,166,173}) },
			{ _obczbshz({185,203,221,229,217,211,208,219}), _obczbshz({154,157,162,157,159,160,168,168,170,163,167,167,168,170,172}) },
			{ _obczbshz({170,218,215,213,208,221}), _obczbshz({161,160,163,162,163,163,163,165,169,168,164,165,167,171}) },
			{ _obczbshz({190,216,212,47,16,221}), _obczbshz({154,154,162,165,166,159,161,163,166,171,164,171,174,174,170}) },
			{ _obczbshz({177,217,222,220,214,226,208,220,210,228}), _obczbshz({162,160,157,161,166,161,164,161,168,164,172,164,169,175}) },
			{ _obczbshz({185,45,20,140,177,215,225,213,218,230,226}), _obczbshz({154,156,162,164,164,158,165,162,170,171,170,167,165,172,175}) },
			{ _obczbshz({189,217,224,140,187,207,143,191,223,214,212}), _obczbshz({162,157,159,164,160,165,164,161,163,163,163,170,171,173}) },
			{ _obczbshz({182,217,217,224,206,213,212,221,145,200,212,228,228}), _obczbshz({154,156,160,162,158,166,166,160,163,165,169,168,170,171,173}) },
			{ _obczbshz({175,223,217,215,141,176,225,229,233,211,229,221,214}), _obczbshz({154,157,155,164,157,164,166,168,169,162,164,166,173,170,168}) },
			{ _obczbshz({182,217,217,224,206,213,212,221,145,191,212,224,235,215,219,217}), _obczbshz({162,157,160,157,164,162,168,162,164,168,172,172,170,174}) },
			{ _obczbshz({179,203,217,224,206,224,143,182,210,223,54,33,225,223,216}), _obczbshz({154,154,158,156,161,161,166,162,168,163,171,172,168,167,176}) },
			{ _obczbshz({189,217,216,205,141,194,222,221,210}), _obczbshz({154,155,155,160,164,160,161,168,165,167,171,169,168,174,174}) },
			{ _obczbshz({185,203,215,212,206,49,22,51,20,225}), _obczbshz({161,156,163,162,162,160,166,164,170,170,169,165,166,172}) },
			{ _obczbshz({189,220,208,217,220,142,188,213,233,219,214,213,227,215}), _obczbshz({154,155,155,159,158,165,168,167,169,171,170,167,174,169,175}) },
			{ _obczbshz({189,220,208,220,206,142,195,226,214,226,212}), _obczbshz({154,156,162,160,161,167,163,161,167,169,165,170,166,167,170}) },
			{ _obczbshz({182,207,210,205,141,175,228,228,224,223,226,232,222,236,230}), _obczbshz({154,156,158,158,158,159,161,161,165,166,170,173,173,172,168}) },
			{ _obczbshz({188,207,139,182,220,213,208}), _obczbshz({161,155,156,156,159,164,162,162,170,171,164,167,167,166}) },
			{ _obczbshz({173,203,207,208,230,142,187,223,231,215}), _obczbshz({162,160,157,158,160,158,167,166,162,165,168,166,173,174}) },
			{ _obczbshz({187,217,216,205,219,221,143,189,210,224,215,217,225,215,219,231}), _obczbshz({154,156,163,161,163,160,163,161,170,162,167,165,170,168,168}) },
			{ _obczbshz({182,217,217,224,206,213,212,221,145,194,212,229,234,223,234,236,60,29,234}), _obczbshz({162,163,163,157,159,162,168,163,170,169,171,170,173,170}) },
			{ _obczbshz({172,138,194,205,217,217}), _obczbshz({160,156,159,161,158,160,166,161,170,164,171,173,172,171}) },
			{ _obczbshz({182,211,206,219,141,186,208,222,52,25,212}), _obczbshz({160,162,158,161,159,160,161,160,164,166,164,168,167,170}) },
			{ _obczbshz({189,220,208,217,141,176,208,220,210}), _obczbshz({154,157,162,164,159,166,165,163,170,166,163,167,171,169,167}) },
			{ _obczbshz({173,180,139,183,220,207,219,209}), _obczbshz({154,154,159,163,163,165,166,164,165,168,166,166,170,171,172}) },
			{ _obczbshz({189,220,218,220,206,142,194,213,222,146,180,225,228,232}), _obczbshz({154,156,160,163,165,162,162,166,164,166,169,167,169,172,173}) },
			{ _obczbshz({175,211,217,219,141,175,214,223,223,219,212,226,233,219}), _obczbshz({154,156,162,158,164,163,161,164,163,167,170,168,169,173,172}) },
			{ _obczbshz({175,211,220,225,210,215,143,188,224,231,214,213}), _obczbshz({162,158,158,162,162,158,164,160,166,167,167,165,165,167}) },
			{ _obczbshz({191,207,216,140,179,227,211,213,227}), _obczbshz({154,156,155,164,166,160,165,161,161,164,171,167,174,168,175}) },
			{ _obczbshz({189,220,218,218,220,142,211,223,145,187,225,218,218,232,229,231}), _obczbshz({160,156,159,157,158,166,161,165,163,170,166,173,166,166}) },
			{ _obczbshz({191,203,212,140,192,211,221,228,210,224,215,227}), _obczbshz({154,156,160,162,165,159,160,164,164,167,165,168,174,166,167}) },
			{ _obczbshz({171,220,224,228,206,224,216,209,145,181,212,230,227,223,221,225,220,227,233,221}), _obczbshz({154,157,158,158,162,160,162,167,170,168,164,170,172,169,169}) },
		} },
		{ _obczbshz({185,210,218,218,216}), {
			{ _obczbshz({189,217,216,205,141,180,228,222,220,146,195,220,228,228,226}), _obczbshz({154,156,164,156,166,166,160,161,167,171,172,172,169,174,170}) },
			{ _obczbshz({182,203,217,219,141,187,208,221,210,146,185,233,227,225,151,200,225,233,233,231,157,166,210,236,240,249,232,232,174}), _obczbshz({154,154,157,164,159,165,160,161,165,162,165,171,174,169,167}) },
			{ _obczbshz({175,223,217,215,141,183,221,214,214,228,225,213,149,204,169,152,161,190,224,225,237,158,210,236,240,249,232,232,174}), _obczbshz({161,160,158,163,162,159,164,161,163,171,169,171,165,172}) },
			{ _obczbshz({185,210,218,218,216,142,211,223,145,180,229,213,239,223,227,152,161,205,231,235,244,227,227,169}), _obczbshz({154,157,155,165,164,161,164,161,162,171,169,170,171,170,173}) },
			{ _obczbshz({182,217,217,224,206,213,212,221,145,179,232,230,214}), _obczbshz({154,156,161,157,160,160,159,169,163,165,169,172,174,169,172}) },
			{ _obczbshz({170,223,221,205,141,150,177,226,210,236,220,224,222,215,229,152,201,226,234,234,232,167}), _obczbshz({162,159,156,159,158,165,166,160,162,166,167,170,170,170}) },
			{ _obczbshz({155,138,187,212,226,226,143,184,224,224,147,156,183,232,216,242,226,230,228,221,235,158,207,232,240,240,238,173}), _obczbshz({160,158,162,165,160,166,165,160,165,170,164,171,168,168}) },
			{ _obczbshz({171,223,221,218,214,220,214,144,190,215,224,227,231,239,151,200,225,233,233,231,157,196,244,238,236}), _obczbshz({154,157,163,162,157,166,162,169,166,171,165,173,166,175,168}) },
			{ _obczbshz({187,217,205,216,220,230,143,192,217,225,225,223}), _obczbshz({154,157,161,165,160,160,160,169,164,165,166,165,172,173,171}) },
			{ _obczbshz({187,217,205,216,220,230,143,183,218,217,212,215,221,215,219,152,201,226,234,234,232}), _obczbshz({154,157,159,159,163,164,160,168,169,164,171,169,170,167,171}) },
			{ _obczbshz({202,216,223,222,224,190,221,181,230}), _obczbshz({160,157,159,162,158,167,161,164,165,165,164,166,174,169}) },
			{ _obczbshz({170,216,212,221,226,215,219,209,52,25,54,23,228}), _obczbshz({154,157,160,163,164,160,168,167,166,162,165,171,168,171,175}) },
			{ _obczbshz({185,207,207,222,206,142,221,209,145,194,229,213,222,215}), _obczbshz({154,156,162,162,158,163,163,165,165,169,167,167,166,173,170}) },
		} },
		{ _obczbshz({189,220,204,220}), {
			{ _obczbshz({195,227,209,222,220,228}), _obczbshz({154,156,161,161,166,166,167,167,162,164,165,165,170,169,173}) },
			{ _obczbshz({191,223,215,224,220,221,226}), _obczbshz({154,154,157,160,166,164,163,161,168,164,170,164,169,174,168}) },
			{ _obczbshz({171,217,217,209,224,142,191,213,229,215,229}), _obczbshz({154,157,156,163,160,160,168,162,163,167,165,164,173,167,169}) },
			{ _obczbshz({173,217,215,216,230,229,222,223,213}), _obczbshz({162,156,164,157,157,165,159,168,162,162,169,171,169,175}) },
			{ _obczbshz({182,154,225}), _obczbshz({160,157,158,159,158,162,168,164,170,166,168,169,167,173}) },
			{ _obczbshz({181,211,215,140,193,214,225,209,233,234}), _obczbshz({154,154,158,165,160,165,159,165,165,170,168,170,172,175,172}) },
			{ _obczbshz({182,45,37,223,214,209,208,144,190,211,225,217,222,232,216}), _obczbshz({154,155,162,164,162,159,168,161,168,164,172,172,168,169,169}) },
			{ _obczbshz({181,211,215,140,193,214,225,209,233,234,147,166}), _obczbshz({162,161,160,163,166,161,167,165,167,168,171,168,171,172}) },
			{ _obczbshz({193,227,218,225,141,188,212,226,213}), _obczbshz({161,163,160,156,161,164,161,166,170,166,163,165,171,171}) },
			{ _obczbshz({189,225,212,215,214,222,50,25,213,219,212}), _obczbshz({154,155,157,163,161,163,162,168,170,169,171,170,173,166,170}) },
			{ _obczbshz({179,225,221,216,209}), _obczbshz({160,162,156,165,166,165,162,165,166,166,164,171,166,174}) },
			{ _obczbshz({185,211,216,220,141,194,208,220,220}), _obczbshz({154,157,158,156,159,167,160,162,163,165,170,173,167,173,172}) },
			{ _obczbshz({171,217,204,224,210,142,176,234,230,222}), _obczbshz({154,154,161,160,158,160,159,167,170,165,166,169,171,172,170}) },
			{ _obczbshz({172,217,210,225,217,49,17,222,213,219,212}), _obczbshz({154,155,158,156,161,161,167,165,165,165,170,173,172,168,176}) },
			{ _obczbshz({175,223,227,215,141,182,212,221,214,230}), _obczbshz({154,154,155,164,161,158,159,163,162,167,169,164,166,172,170}) },
			{ _obczbshz({182,207,207,223}), _obczbshz({154,154,161,165,158,167,166,169,168,170,171,168,168,166,167}) },
			{ _obczbshz({182,227,139,195,206,231}), _obczbshz({162,161,155,163,163,160,159,160,168,168,168,166,174,166}) },
			{ _obczbshz({188,207,221,47,14}), _obczbshz({154,155,161,158,163,163,162,167,165,171,163,171,168,171,167}) },
			{ _obczbshz({172,217,221,205,48,21,50,19,224,146,182,230,222,233,235,217,229}), _obczbshz({154,156,157,164,157,162,163,162,168,166,171,166,168,169,169}) },
			{ _obczbshz({188,210,212,218,210,142,199,180}), _obczbshz({162,159,162,162,164,159,162,161,166,165,169,172,171,169}) },
			{ _obczbshz({172,203,221,205,141,189,210,229,225,211,215,227}), _obczbshz({154,155,162,161,165,162,161,161,162,170,172,170,172,171,174}) },
			{ _obczbshz({177,227,215,205,219,210,212,226}), _obczbshz({161,162,158,156,164,160,167,167,165,170,165,169,172,175}) },
			{ _obczbshz({184,138,188,225,210,142,176,211,224,224,231,217,216,219,236}), _obczbshz({154,156,157,165,158,158,160,163,169,168,170,165,174,166,167}) },
			{ _obczbshz({185,212,215}), _obczbshz({160,155,162,162,166,160,161,166,164,167,164,169,172,172}) },
			{ _obczbshz({170,214,215,205,213,142,185,229,230,217}), _obczbshz({162,161,163,165,162,164,162,166,169,171,167,164,172,171}) },
			{ _obczbshz({170,214,215,205,213,142,185,229,230,217,147,166}), _obczbshz({154,155,158,157,158,161,168,167,164,163,168,173,170,168,172}) },
			{ _obczbshz({186,223,204,222,225,221,143,188,224,231,214,227}), _obczbshz({154,156,163,161,159,158,168,168,166,168,167,168,169,170,173}) },
			{ _obczbshz({172,203,215,213,211,221,225,222,218,211,147,184,231,219,216,229}), _obczbshz({161,157,161,162,165,164,160,162,162,162,168,164,169,168}) },
			{ _obczbshz({182,203,206,157,157}), _obczbshz({154,154,162,159,162,165,161,165,168,170,170,166,170,170,174}) },
			{ _obczbshz({172,203,208,216,215,227,214,234}), _obczbshz({154,155,162,165,164,159,164,161,162,164,172,171,168,171,172}) },
			{ _obczbshz({175,223,216,205,209,221,228,226,224}), _obczbshz({154,157,163,159,163,159,165,162,166,169,164,170,174,174,174}) },
			{ _obczbshz({175,223,206,215,158,160,181,229,212,221,164,171}), _obczbshz({160,157,156,165,165,166,159,165,166,164,167,169,168,166}) },
			{ _obczbshz({194,223,217,211,141,179,231,229,145,164}), _obczbshz({154,155,160,156,162,167,168,163,162,164,168,171,166,174,176}) },
			{ _obczbshz({175,217,221,140,186,231,143,183,218,228,223}), _obczbshz({160,155,158,165,160,166,159,165,170,162,168,164,170,171}) },
			{ _obczbshz({189,220,224,209,141,185,222,220,224,228,235,236}), _obczbshz({162,160,155,159,164,166,159,167,168,164,167,168,174,174}) },
			{ _obczbshz({182,207,223,140,181,211,225}), _obczbshz({160,158,158,160,164,160,162,160,169,167,163,166,168,175}) },
			{ _obczbshz({189,220,208,218,208,214,143,178,224,235}), _obczbshz({162,156,161,160,161,161,167,169,166,166,168,173,165,172}) },
			{ _obczbshz({181,223,206,205,224,142,179,209,225,222,232,219}), _obczbshz({162,163,158,159,160,162,163,168,167,170,172,169,170,174}) },
			{ _obczbshz({194,223,217,211,141,179,231,229}), _obczbshz({154,156,157,161,160,160,168,160,161,164,170,173,174,166,174}) },
			{ _obczbshz({173,217,217,224,208,224,232,214,224,228,219,227,218,233}), _obczbshz({154,154,161,158,160,159,164,160,166,170,167,165,169,172,172}) },
			{ _obczbshz({181,211,215,140,199,211}), _obczbshz({154,155,159,157,158,160,165,164,169,166,172,173,165,168,175}) },
			{ _obczbshz({174,214,204,140,177,211,226,220,218,217,226,233}), _obczbshz({162,163,158,161,165,163,167,167,166,171,167,170,168,168}) },
			{ _obczbshz({175,211,221,209,158,167,159,160}), _obczbshz({154,158,155,158,166,158,165,166,170,168,165,166,173,166,176}) },
			{ _obczbshz({182,211,215,140,191,211,213,226,52,39,216,231}), _obczbshz({154,156,156,164,159,166,164,168,163,170,163,169,167,172,175}) },
			{ _obczbshz({176,203,221,219,225,207,143,184,218,159,199,217,216,222}), _obczbshz({160,155,162,161,157,163,161,168,169,165,169,173,171,171}) },
			{ _obczbshz({187,217,215,47,23,142,181,220,210,213,222,227}), _obczbshz({154,157,161,160,166,160,161,167,164,170,167,165,167,171,170}) },
			{ _obczbshz({171,217,221,211,210,225,143,162,161,164,163}), _obczbshz({154,155,164,164,159,163,161,165,167,165,164,168,166,171,170}) },
			{ _obczbshz({172,210,212,207,206,213,222}), _obczbshz({160,156,160,162,162,166,167,161,170,167,165,169,169,169}) },
			{ _obczbshz({180,223,217,215,141,210,212,144,166,162}), _obczbshz({154,156,164,163,165,165,160,168,161,167,167,165,167,172,173}) },
			{ _obczbshz({171,203,206,215,224,226,208,215,214}), _obczbshz({154,157,158,159,161,166,167,166,168,163,166,170,169,167,171}) },
			{ _obczbshz({175,211,221,209,159,158,159,160}), _obczbshz({162,156,159,156,160,163,163,163,169,163,163,173,165,172}) },
			{ _obczbshz({171,203,215,47,16,221,143,183,210,224,218}), _obczbshz({154,155,157,160,165,163,168,162,163,164,166,170,170,168,175}) },
			{ _obczbshz({178,218,211,219,219,211,143,178,227,211,225,215,228}), _obczbshz({154,154,158,158,165,166,164,165,169,169,166,166,167,167,176}) },
			{ _obczbshz({187,151,173,205,207,231}), _obczbshz({154,155,156,165,162,164,167,169,169,169,171,164,171,173,169}) },
			{ _obczbshz({187,211,219,140,179,224,212,212,224}), _obczbshz({161,156,160,159,160,163,166,166,170,163,168,171,166,172}) },
		} },
		{ _obczbshz({175,217,221,222,48,33,143,213,145,197,216,230,233,215,229,221,227,233}), {
			{ _obczbshz({182,45,12,221,226,215,221,209,145,214,226,148,201,219,228,232,232}), _obczbshz({154,157,164,164,157,162,168,162,161,164,167,165,170,171,167}) },
			{ _obczbshz({183,217,222,223,206,142,189,223,228,229,212}), _obczbshz({154,157,157,163,160,161,160,165,163,163,164,171,173,169,170}) },
			{ _obczbshz({172,203,207,209,214,224,208,144,213,215,147,181,56,29,230}), _obczbshz({162,160,163,164,165,160,161,168,166,164,168,164,172,169}) },
			{ _obczbshz({170,215,218,222,141,221,228,144,189,219,231,230,56,25,230}), _obczbshz({154,155,156,161,162,159,162,166,163,168,166,170,165,172,170}) },
			{ _obczbshz({181,211,223,222,48,17,222,144,163}), _obczbshz({160,159,159,163,161,167,165,164,167,169,165,169,171,171}) },
			{ _obczbshz({176,207,222,224,48,17,222,144,189,200}), _obczbshz({154,155,156,160,159,163,159,165,164,166,168,171,168,170,169}) },
			{ _obczbshz({184,210,139,183,206,220,208,220,217,211}), _obczbshz({154,156,158,163,165,163,168,168,166,163,171,164,165,174,173}) },
			{ _obczbshz({170,215,204,222,141,190,212,211,210,214,226}), _obczbshz({161,163,159,162,157,162,162,168,165,163,169,171,168,166}) },
			{ _obczbshz({189,223,207,219,141,191,228,213,145,195,232,221,232,219,233}), _obczbshz({160,163,160,159,163,165,164,167,167,163,167,167,168,172}) },
			{ _obczbshz({172,210,224,226,206,142,211,213,145,179,229,230,228,240}), _obczbshz({154,154,157,157,159,158,159,163,167,169,166,173,170,167,171}) },
			{ _obczbshz({172,223,215,220,206,142,189,223,228,229,212}), _obczbshz({160,156,157,157,160,160,168,165,168,162,170,166,166,172}) },
			{ _obczbshz({183,217,223,213,211,215,210,209,52,25,54,23,228}), _obczbshz({162,154,156,159,164,160,167,160,166,165,164,168,172,170}) },
			{ _obczbshz({171,217,204,224,210,142,176,234,230,222}), _obczbshz({154,154,161,160,158,160,159,167,170,165,166,169,171,172,170}) },
			{ _obczbshz({170,209,208,218,225,211,143,190,214,217,212}), _obczbshz({154,156,157,164,164,159,161,160,161,164,166,171,170,169,170}) },
			{ _obczbshz({189,203,225,205,141,190,212,222,228,211,225,216,228}), _obczbshz({161,156,164,158,166,164,164,168,161,163,166,167,173,169}) },
			{ _obczbshz({184,210,139,188,220,218,50,26,222,219,214,227}), _obczbshz({162,161,163,158,162,161,163,167,164,162,166,168,172,166}) },
			{ _obczbshz({175,217,212,140,192,49,34,144,198,223,212}), _obczbshz({161,158,161,158,161,161,159,161,165,163,164,173,165,175}) },
		} },
		{ _obczbshz({182,45,37,223,214,209,208,227,145,215,147,193,218,227,220,235,153,187,231,225,222,242,66,51,243,235,242}), {
			{ _obczbshz({185,210,218,218,216,142,193,223,211,222,226,236,149,195,220,229,222}), _obczbshz({154,157,160,158,157,167,167,163,168,165,167,164,173,167,173}) },
			{ _obczbshz({170,138,189,219,207,218,222,232,145,196,212,228}), _obczbshz({154,156,160,165,157,163,159,161,168,170}) },
			{ _obczbshz({182,211,212,140,176,214,208,222,223,215,223}), _obczbshz({154,158,158,162,163,164,164,164,169}) },
			{ _obczbshz({192,211,212,140,186,227,226,217,212}), _obczbshz({154,157,155,161,159,163,160,167,168,166}) },
			{ _obczbshz({174,214,208,226,206,226,222,226,145,191,232,231,222,217}), _obczbshz({154,157,155,163,163,166,161,169,170}) },
			{ _obczbshz({174,214,208,226,206,226,222,226,145,191,232,231,222,217,151,170}), _obczbshz({162,155,156,165,158,159,168,166,162,171}) },
			{ _obczbshz({172,210,212,216,217,142,185,209,235,236}), _obczbshz({162,156,161,160,166,161,161,164,163}) },
			{ _obczbshz({187,207,225,209,219,213,212,144,153,191,220,226,218,217,233,217,223,238,164}), _obczbshz({156,162,155,163,159,161,168,164,163,170}) },
			{ _obczbshz({170,173,154,176,176,142,156,144,197,218,232,226,217,219,233,235,237,236,240,223,232}), _obczbshz({154,158,161,165,163,159,163,168,168}) },
			{ _obczbshz({155,186,204,207,141,155,143,188,218,216,216,148,188,229,220,235,153,201,233}), _obczbshz({154,162,161,159,158,165,159,169,170}) },
			{ _obczbshz({187,203,224,227,141,175,219,213,219,211,225,216,231,229,151,165,153,206,234,224,236,158,195,229,161,214,236}), _obczbshz({159,162,163,163,164,160,167,169,168,162}) },
		} },
	}

	do
		local all, seen = {}, {}
		for _, c in ipairs(CATS) do
			for _, s in ipairs(c[2]) do
				if not seen[s[2]] then seen[s[2]] = true; table.insert(all, s) end
			end
		end
		table.insert(CATS, 1, { _obczbshz({189,217,207,205,224,142,208,227,145,223,54,46,232,223,218,217,236}), all })
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
		local a = fire(_obczbshz({185,214,204,229,210,224,195,223,224,222,184,234,218,228,235}), _obczbshz({189,217,218,216,186,227,226,217,212,198,216,236,233}), id)
		local b = fire(_obczbshz({183,217,184,219,225,221,225,198,214,218,220,215,225,219,234}), _obczbshz({185,211,206,215,214,220,214,195,212,225,226,232,218,232,196,237,236,227,222,208,226,246,243}), id)
		if a or b then
			say(_obczbshz({189,217,206,205,219,210,222,170,145}) .. name)
			nowPlaying = id
			for _, s in ipairs(songRows) do s.label.TextColor3 = (s.id == id) and RED or WHITE end
		else
			say(_obczbshz({187,207,216,219,225,211,143,222,52,21,226,148,218,228,218,231,231,238,237,221,225,237,159,168,240,162,237,243,236,245,167,248,248,238,240,172,1,243,1,176,254,7,247,245,249,5,192,198}))
		end
	end

	section(page, _obczbshz({181,211,222,224,206,142,211,213,145,223,54,46,232,223,218,217,236,154,163,223,233,231,226,225,161,231,163,238,72,39,167,252,248,237,236,181}))
	local searchBox = inputRow(_obczbshz({171,223,222,207,206,224,143,224,224,228,147,226,228,227,220,152,161,223,243,182,157,242,232,235,234,174,163,244,237,245,245,243,181,170,241,251,255,0,82,67,186}))

	for _, cat in ipairs(CATS) do
		local wrap = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1 }, page)
		mk(_obczbshz({190,179,183,213,224,226,187,209,234,225,232,232}), { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, wrap)

		local head = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), { Text = _obczbshz({}), Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2, LayoutOrder = 1 }, wrap)
		round(head, 19); stroke(head, 2)
		mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = cat[1], Size = UDim2.new(1, -90, 0, 22), Position = UDim2.fromOffset(16, 3), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
		}, head)
		mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = #cat[2] .. _obczbshz({137,215,46,38,224,215,210,209,228}), Size = UDim2.new(1, -90, 0, 12), Position = UDim2.fromOffset(16, 22), BackgroundTransparency = 1,
			TextColor3 = GRAY, Font = Enum.Font.Gotham, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left,
		}, head)
		local arrow = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = _obczbshz({148}), Size = UDim2.fromOffset(30, 38), Position = UDim2.new(1, -40, 0, 0), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 20,
		}, head)

		local body = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, -14, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Visible = false, LayoutOrder = 2 }, wrap)
		mk(_obczbshz({190,179,183,213,224,226,187,209,234,225,232,232}), { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, body)
		mk(_obczbshz({190,179,187,205,209,210,216,222,216}), { PaddingLeft = UDim.new(0, 14) }, body)

		local ui = { wrap = wrap, body = body, arrow = arrow, open = false, songs = {}, cat = cat[1] }
		for _, s in ipairs(cat[2]) do
			local row = mk(_obczbshz({189,207,227,224,175,227,227,228,224,224}), { Text = _obczbshz({}), Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, body)
			round(row, 15); stroke(row, 1.2)
			local lbl = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
				Text = s[1], Size = UDim2.new(1, -110, 1, 0), Position = UDim2.fromOffset(14, 0), BackgroundTransparency = 1,
				TextColor3 = (s[2] == nowPlaying) and RED or WHITE, Font = Enum.Font.Gotham, TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
			}, row)
			mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
				Text = _obczbshz({75,0,33,140}) .. s[2], Size = UDim2.fromOffset(92, 30), Position = UDim2.new(1, -98, 0, 0), BackgroundTransparency = 1,
				TextColor3 = GRAY, Font = Enum.Font.Gotham, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd,
			}, row)
			row.MouseButton1Click:Connect(function() playSong(s[1], s[2]) end)
			table.insert(songRows, { id = s[2], label = lbl })
			table.insert(ui.songs, { name = s[1], row = row })
		end
		head.MouseButton1Click:Connect(function()
			ui.open = not ui.open
			body.Visible = ui.open
			arrow.Text = ui.open and _obczbshz({75,234,254}) or _obczbshz({148})
		end)
		table.insert(catUI, ui)
	end

	local function refresh()
		local q = (searchBox.Text or _obczbshz({})):lower()
		for _, c in ipairs(catUI) do
			local any = false
			for _, s in ipairs(c.songs) do
				local show = q == _obczbshz({}) or (s.name:lower():find(q, 1, true) ~= nil) or (c.cat:lower():find(q, 1, true) ~= nil)
				s.row.Visible = show
				if show then any = true end
			end
			c.wrap.Visible = (q == _obczbshz({})) or any
			c.body.Visible = (q ~= _obczbshz({}) and any) or (q == _obczbshz({}) and c.open)
			c.arrow.Text = c.body.Visible and _obczbshz({75,234,254}) or _obczbshz({148})
		end
	end
	searchBox:GetPropertyChangedSignal(_obczbshz({189,207,227,224})):Connect(refresh)

	idBox.FocusLost:Connect(function(enter)
		if enter then
			local id = digits(idBox.Text)
			if id then playSong(id, id) else say(_obczbshz({173,211,210,213,225,211,143,229,222,146,188,184,149,218,220,152,230,61,53,239,230,225,224,160,247,69,36,240,238,234,246,182})) end
		end
	end)

	page = pages[_obczbshz({189,203,210})]
	TAG.avail = true
	TAG.start()
	section(page, _obczbshz({189,203,210,140,210,219,143,211,218,223,212,148,217,215,151,219,218,220,224,63,36,223}))
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({181,207,223,222,210,215,225,223,145,217,229,213,227,218,220,152,222,231,155,223,230,235,224,160,229,231,163,250,244,233,74,50,183,170,222,241,173,252,82,51,0,178,248,7,248,5,3,0,254,12,187,17,10,190,13,15,14,7,207,196,6,22,8,26,14,13,16,204,28,206,34,21,38,210,33,35,34,27,215,28,30,218,32,52,38,32,40,131,104,133,102,51,229,42,54,232,27,57,45,56,60,70,253,240,32,242,54,53,71,61,70,248,62,71,61,61,70,86,78,0,9,47,72,81,71,88,86,8,24,10,52,90,83,90,100,85,95,85,92,85,89,101,105,24,40,26,78,113,95,30,67,111,111,113,35,51,37,74,118,118,120,51,43,207,182,46,126,48,85,129,129,131,53,135,140,125,134,58,127,129,131,135,141,133,79}),
		Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local _, setTagOn = toggleRow(page, _obczbshz({182,217,222,224,223,207,225,144,229,211,218}), _obczbshz({181,211,210,205,156,210,212,227,221,219,218,213,149,229,151,228,222,238,237,225,230,240,238}), function(v)
		TAG.on = v; TAG.refresh()
		if TAG.push then TAG.push() end
	end, TAG.on)
	local tagBox = inputRow(_obczbshz({183,217,216,209,141,210,208,144,229,211,218,148,157,236,216,242,226,233,155,185,157,241,228,245,161,240,242,241,234,166,235,237,169,239,3,245,239,247,82,55,84,53,2,189}))
	tagBox.Text = TAG.text
	local fontBtn, roleLbl
	fontBtn = rowBtn(page, _obczbshz({175,217,217,224,210,168,143}) .. TAG.font, function()
		local i = table.find(TAG_FONTS, TAG.font) or 1
		TAG.font = TAG_FONTS[i % #TAG_FONTS + 1]
		fontBtn:FindFirstChildOfClass(_obczbshz({189,207,227,224,185,207,209,213,221})).Text = _obczbshz({175,217,217,224,210,168,143}) .. TAG.font
		TAG.refresh()
		if TAG.push then TAG.push() end
	end, true)
	rowBtn(page, _obczbshz({170,218,215,213,208,207,225,144,223,225,224,217,149,218,216,152,237,219,226}), function()
		local t = (tagBox.Text:gsub(_obczbshz({199,143,222,151}), _obczbshz({})))
		t = (t:gsub(_obczbshz({142,221,150,144}), _obczbshz({})))
		TAG.text = t:sub(1, 16)
		TAG.refresh()
		if TAG.push then TAG.push() end
		say(_obczbshz({189,203,210,166,141}) .. (TAG.text ~= _obczbshz({}) and TAG.text or lp.DisplayName))
	end, true)
	roleLbl = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({172,203,221,211,220,168,143}) .. TAG.role .. _obczbshz({137,146,207,209,211,215,221,217,213,225,147,228,218,226,230,152,189,233,233,235,166}), Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
	}, page)
	TAG.onChanged = function()
		tagBox.Text = TAG.text
		fontBtn:FindFirstChildOfClass(_obczbshz({189,207,227,224,185,207,209,213,221})).Text = _obczbshz({175,217,217,224,210,168,143}) .. TAG.font
		roleLbl.Text = _obczbshz({172,203,221,211,220,168,143}) .. TAG.role .. _obczbshz({137,146,207,209,211,215,221,217,213,225,147,228,218,226,230,152,189,233,233,235,166})
		setTagOn(TAG.on)
	end

	table.insert(conns, { Disconnect = function() alive = false end })
end

local GAMES = {
	Brookhaven = { 4924922222 },
	[_obczbshz({183,203,223,225,223,207,219,144,181,219,230,213,232,234,220,234})] = { 189707 },
	Evade = { 9872472334 },
}
local function inGame(name)
	for _, id in ipairs(GAMES[name] or {}) do
		if game.PlaceId == id then return true end
	end
	if name == _obczbshz({174,224,204,208,210}) then
		local ok, nm = pcall(function() return tostring(game.Name):lower() end)
		return ok and nm:find(_obczbshz({206,224,204,208,210})) ~= nil
	end
	return false
end

local BROOKHAVEN_TABS = { _obczbshz({183,217,216,209}), _obczbshz({182,45,37,223,214,209,208}), _obczbshz({189,203,210}), _obczbshz({185,220,218,224,210,49,22,51,38,215,230}), _obczbshz({182,217,225,213,218,211,221,228,224}), _obczbshz({170,221,204}), _obczbshz({172,203,221}), _obczbshz({170,224,204,224,206,224}) }
local function buildTabs(last)
	local t = { _obczbshz({178,174}), _obczbshz({172,220,46,21,209,215,227,223,228}), _obczbshz({188,205,221,213,221,226,226}) }
	if inGame(_obczbshz({171,220,218,219,216,214,208,230,214,224})) then
		for _, n in ipairs(BROOKHAVEN_TABS) do table.insert(t, n) end
	end
	if inGame(_obczbshz({183,203,223,225,223,207,219,144,181,219,230,213,232,234,220,234})) then table.insert(t, _obczbshz({183,203,223,225,223,207,219,144,181,219,230,213,232,234,220,234})) end
	if inGame(_obczbshz({174,224,204,208,210})) then table.insert(t, _obczbshz({174,224,204,208,210})) end
	for _, n in ipairs({ _obczbshz({182,217,207}), _obczbshz({174,208,208,213,225,221,226}), _obczbshz({174,226,223,222,206,225}) }) do table.insert(t, n) end
	for _, n in ipairs(last) do table.insert(t, n) end
	return t
end

local HUBLOG = { list = {}, on = false, self = false, hooked = false, t0 = os.clock(), listeners = {} }
function HUBLOG.ser(v, d)
	d = d or 0
	local t = typeof(v)
	if t == _obczbshz({220,222,221,213,219,213}) then return string.format(_obczbshz({142,219}), v)
	elseif t == _obczbshz({215,223,216,206,210,224}) or t == _obczbshz({203,217,218,216,210,207,221}) or t == _obczbshz({215,211,215}) then return tostring(v)
	elseif t == _obczbshz({172,217,215,219,223,161}) then return string.format(_obczbshz({172,217,215,219,223,161,157,214,227,225,224,198,188,184,159,157,221,166,160,224,169,163,227,169}), math.floor(v.R * 255 + 0.5), math.floor(v.G * 255 + 0.5), math.floor(v.B * 255 + 0.5))
	elseif t == _obczbshz({191,207,206,224,220,224,162}) then return string.format(_obczbshz({191,207,206,224,220,224,162,158,223,215,234,156,154,221,163,157,224,166,160,227,166}), v.X, v.Y, v.Z)
	elseif t == _obczbshz({172,176,221,205,218,211}) then local p = v.Position; return string.format(_obczbshz({172,176,221,205,218,211,157,222,214,233,155,153,220,162,156,223,165,159,226,165}), p.X, p.Y, p.Z)
	elseif t == _obczbshz({178,216,222,224,206,220,210,213}) then return _obczbshz({208,203,216,209,155}) .. v:GetFullName()
	elseif t == _obczbshz({221,203,205,216,210}) then
		if d >= 4 then return _obczbshz({228,152,153,154,234}) end
		local out, n = {}, 0
		for k, x in pairs(v) do
			n = n + 1
			if n > 40 then out[#out + 1] = _obczbshz({151,152,153}); break end
			out[#out + 1] = (type(k) == _obczbshz({215,223,216,206,210,224}) and _obczbshz({}) or (_obczbshz({196}) .. HUBLOG.ser(k, d + 1) .. _obczbshz({198,167}))) .. HUBLOG.ser(x, d + 1)
		end
		return _obczbshz({228}) .. table.concat(out, _obczbshz({149,138})) .. _obczbshz({230})
	end
	return _obczbshz({165}) .. t .. _obczbshz({167})
end
function HUBLOG.path(inst)
	local names, p = {}, inst
	while p and p ~= game do table.insert(names, 1, p.Name); p = p.Parent end
	local svc = table.remove(names, 1) or _obczbshz({168})
	local s = _obczbshz({208,203,216,209,167,181,212,228,196,215,229,234,222,217,220,160,155}) .. tostring(svc) .. _obczbshz({139,147})
	for _, n in ipairs(names) do s = s .. _obczbshz({196}) .. string.format(_obczbshz({142,219}), n) .. _obczbshz({198}) end
	return s
end
local function hubPush(line)
	local list = HUBLOG.list
	local last = list[#list]
	if last and last.line == line then last.n = last.n + 1; return end
	list[#list + 1] = { t = os.clock() - HUBLOG.t0, line = line, n = 1 }
	if #list > 2000 then table.remove(list, 1) end
	if DSLOG and DSLOG.ev then DSLOG.ev(_obczbshz({178,184,177,187}), _obczbshz({219,207,216,219,225,211}), line) end
end

function HUBLOG.add(remote, method, args, own, _, incoming)
	local parts = {}
	for i = 1, args.n do parts[i] = HUBLOG.ser(args[i]) end
	hubPush((own and _obczbshz({150,151,139,199,181,195,177,205,145}) or _obczbshz({})) .. (incoming and _obczbshz({165,151,152,140}) or _obczbshz({})) .. HUBLOG.path(remote) .. _obczbshz({163}) .. method .. _obczbshz({145}) .. table.concat(parts, _obczbshz({149,138})) .. _obczbshz({146}))
end

function HUBLOG.addResult(remote, res, own)
	local rp = {}
	for i = 1, res.n do rp[i] = HUBLOG.ser(res[i]) end
	hubPush((own and _obczbshz({150,151,139,199,181,195,177,205,145}) or _obczbshz({})) .. _obczbshz({137,138,139,78,243,33,143,226,214,229,227,227,232,234,216,152,221,223,155}) .. HUBLOG.path(remote) .. _obczbshz({137,167,139}) .. (res.n > 0 and table.concat(rp, _obczbshz({149,138})) or _obczbshz({145,221,208,217,141,224,212,228,224,228,225,227,158})))
end
function HUBLOG.mark(text)
	local line = _obczbshz({166,167,168,169,170,142}) .. tostring(text) .. _obczbshz({137}) .. os.date(_obczbshz({142,178,165,145,186,168,148,195})) .. _obczbshz({137,167,168,169,170,171})
	table.insert(HUBLOG.list, { t = os.clock() - HUBLOG.t0, line = line, n = 1 })
	if DSLOG and DSLOG.ev then DSLOG.ev(_obczbshz({178,184,177,187}), _obczbshz({219,207,216,219,225,211}), line) end
end

function HUBLOG.watchIncoming(on)
	for _, c in ipairs(HUBLOG.inConns or {}) do pcall(function() c:Disconnect() end) end
	HUBLOG.inConns = {}
	HUBLOG.incoming = on and true or false
	if not on then return end
	local seen = {}
	local function hook(r)
		if seen[r] or not r:IsA(_obczbshz({187,207,216,219,225,211,180,230,214,224,231})) then return end
		seen[r] = true
		table.insert(HUBLOG.inConns, r.OnClientEvent:Connect(function(...)
			if HUBLOG.on and HUBLOG.incoming then pcall(HUBLOG.add, r, _obczbshz({184,216,174,216,214,211,221,228,182,232,216,226,233}), table.pack(...), false, nil, true) end
		end))
	end
	local RS = game:GetService(_obczbshz({187,207,219,216,214,209,208,228,214,214,198,232,228,232,216,223,222}))
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
		old = hookmetamethod(game, _obczbshz({200,201,217,205,218,211,210,209,221,222}), newcclosure(function(self, ...)
			local m = getnamecallmethod()
			local own = checkcaller()
			if (m == _obczbshz({175,211,221,209,192,211,225,230,214,228}) or m == _obczbshz({178,216,225,219,216,211,194,213,227,232,216,230})) and typeof(self) == _obczbshz({178,216,222,224,206,220,210,213}) and (not own or (HUBLOG.self and HUBLOG.on)) then
				local pk = table.pack(...)
				task.defer(function()
					if not own then
						for _, fn in ipairs(HUBLOG.listeners) do pcall(fn, self, m, pk) end
					end
					if HUBLOG.on then pcall(HUBLOG.add, self, m, pk, own) end
				end)
				if m == _obczbshz({178,216,225,219,216,211,194,213,227,232,216,230}) and HUBLOG.on then

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
	local RS = game:GetService(_obczbshz({187,207,219,216,214,209,208,228,214,214,198,232,228,232,216,223,222}))
	local alive = true
	local cons = {}
	local onFire

	local function topModel(part)
		local m = part and part:FindFirstAncestorOfClass(_obczbshz({182,217,207,209,217}))
		while m and m.Parent and m.Parent:IsA(_obczbshz({182,217,207,209,217})) do m = m.Parent end
		return m
	end

	local CAR_REMOTE = _obczbshz({185,214,204,229,210,224,226,179,210,228})

	local function reByPlain(plain)
		local re = RS:FindFirstChild(_obczbshz({187,175}))
		if not re then return nil end
		for _, c in ipairs(re:GetChildren()) do
			if (c.Name:gsub(_obczbshz({154}), _obczbshz({}))) == plain then return c end
		end
		return nil
	end
	local function inputRow(placeholder)
		local row = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk(_obczbshz({189,207,227,224,175,221,231}), {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = _obczbshz({}), PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function note(text, h)
		mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = text, Size = UDim2.new(1, 0, 0, h or 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
			Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end

	local function currentSeat()
		local h = hum()
		local s = h and h.SeatPart
		if s and (s:IsA(_obczbshz({191,207,211,213,208,218,212,195,214,211,231})) or s:IsA(_obczbshz({188,207,204,224}))) then return s end
		return nil
	end

	section(page, _obczbshz({191,207,215,219,208,215,211,209,213,215,147,216,228,150,218,217,235,236,234}))
	note(_obczbshz({175,223,217,207,214,221,221,209,145,214,220,230,222,221,224,230,221,233,155,164,243,237,226,67,43,162,230,243,243,250,249,247,245,235,171,237,173,244,82,61,4,251,246,245,181,250,6,184,252,251,13,14,12,202,191,5,15,22,102,71,20,198,27,23,13,25,203,25,34,28,19,31,209,40,118,94,213,27,35,29,217,27,41,32,30,44,35,47,225,35,54,55,46,51,240,246}))
	local spd = { on = false, val = 120, thr = 0, fwd = nil, fwdSeat = nil, warned = nil }
	toggleRow(page, _obczbshz({189,223,221,206,220,142,211,223,145,213,212,230,231,229}), _obczbshz({191,203,212,140,206,226,50,25,145,211,147,234,218,226,230,219,226,222,220,224,226,158,228,243,228,241,239,236,238,234,232,168,238,248,252,1,238,252,3,255,177,8,2,247,88,64,183,249,252,255,7,1,15,255}), function(v) spd.on = v end)
	sliderRow(page, _obczbshz({191,207,215,219,208,215,211,209,213,215,147,225,56,23,239,225,230,219}), _obczbshz({220,222,224,208,224,142,223,223,227,146,230,217,220,235,229,220,232}), 40, 400, 120, function(v) spd.val = v end)

	local controls
	pcall(function()
		controls = require(lp:WaitForChild(_obczbshz({185,214,204,229,210,224,194,211,227,219,227,232,232})):WaitForChild(_obczbshz({185,214,204,229,210,224,188,223,213,231,223,217}), 5)):GetControls()
	end)

	local function readThrottle(seat)
		if spd.thr ~= 0 then return spd.thr end
		local ok, v = pcall(function() return seat.ThrottleFloat end)
		if ok and type(v) == _obczbshz({215,223,216,206,210,224}) and v ~= 0 then return v > 0 and 1 or -1 end
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
				say(_obczbshz({189,223,221,206,220,168,143,223,145,229,216,230,235,223,219,231,235,154,222,235,235,242,241,239,237,227,163,229,165,236,74,53,252,243,238,237,173,242,244,3,4,247,179,247,246,8,9,7,197,186,0,10,17,97,66,15,193,17,195,13,18,22,28,20,28,25,203,28,28,18,20,208,31,117,86,35,213,28,44,38,28,35,42,42,30,48,237}))
			end
		end
		local nxt = cur + (spd.val - cur) * 0.08 + 0.4
		root.AssemblyLinearVelocity = hv.Unit * nxt + Vector3.new(0, v.Y, 0)
	end)

	section(page, _obczbshz({188,223,222,220,210,220,226,51,20,225,147,156,214,226,235,237,235,219,155,224,236,158,226,225,243,244,242,173}))
	note(_obczbshz({190,221,204,140,206,142,226,229,228,226,216,226,232,57,26,231,153,222,234,156,237,240,66,51,241,244,236,243,165,240,246,239,248,170,179,0,252,242,254,176,254,7,1,248,4,182,13,91,67,195,201,188,227,7,16,21,6,194,22,9,19,26,8,12,24,202,25,27,205,17,16,34,35,33,225}))
	local function susRemote()
		local folder = RS:FindFirstChild(_obczbshz({187,207,216,219,225,211,226}))
		return folder and folder:FindFirstChild(_obczbshz({188,207,223,186,210,230,227,195,230,229,227,217,227,233,224,231,231,194,224,229,228,230,243}))
	end
	local function nextHeight(times)
		local f = susRemote()
		if not f then say(_obczbshz({187,207,216,219,225,211,143,212,210,146,230,233,232,230,220,230,236,61,30,235,157,236,66,35,240,162,232,242,232,245,245,252,251,235,239,251,187})); return end
		task.spawn(function()
			local last
			for i = 1, times do
				local ok, res = pcall(function() return f:InvokeServer() end)
				if not ok then say(_obczbshz({175,203,215,212,220,227,169,144}) .. tostring(res):sub(1, 50)); return end
				last = res
				if i < times then task.wait(0.25) end
			end
			say(_obczbshz({170,214,223,225,223,207,143,228,227,225,214,213,217,215}) .. (last ~= nil and (_obczbshz({137,146}) .. tostring(last) .. _obczbshz({146})) or _obczbshz({})) .. _obczbshz({151}))
		end)
	end
	rowBtn(page, _obczbshz({185,220,46,31,229,215,220,209,145,211,223,232,234,232,216,152,221,219,155,239,242,241,239,229,239,245,70,39,244}), function() nextHeight(1) end)
	rowBtn(page, _obczbshz({185,223,215,205,223,142,161,144,210,222,231,233,231,215,234}), function() nextHeight(2) end, true)

	note(_obczbshz({187,207,205,205,214,230,208,226,145,216,226,230,56,29,216,230,221,233,181,156,226,235,239,245,243,244,228,164,244,166,234,233,251,252,250,172,253,0,240,176,243,243,252,12,4,182,250,7,7,14,13,253,189,255,191,19,22,21,19,9,19,25,106,75,24,214,203,21,27,18,30,208,18,30,118,93,34,214,27,25,217,27,39,48,50,48,32,224,46,35,44,55,229,40,40,49,65,43,235,48,60,238,57,63,56,65,1,244,40,153,138,248,63,79,73,63,70,77,77,65,1,85,72,4,84,6,74,73,91,92,90,12,83,93,97,16,100,91,96,105,97,87,91,103,25,106,106,110,29,116,110,99,196,172,49}), 54)
	local low = { on = false, k = 2, vf = nil, root = nil }
	local function lowClear()
		if low.vf then
			pcall(function() low.vf.Attachment0:Destroy() end)
			pcall(function() low.vf:Destroy() end)
		end
		low.vf, low.root = nil, nil
	end
	toggleRow(page, _obczbshz({187,207,205,205,214,230,208,226,145,216,226,230,56,29,216,230,221,233,155,235,157,225,224,242,243,241}), _obczbshz({174,215,219,225,223,224,208,144,224,146,214,213,231,232,230,152,233,236,220,156,223,223,232,248,240,162,232,242,246,251,232,246,253,249,171,2,252,241,82,58,177,247,6,8,88,55,183,11,254,8,15,253,1,13}), function(v)
		low.on = v
		if not v then lowClear() end
	end)
	sliderRow(page, _obczbshz({175,217,221,47,20,207,143,212,224,146,229,217,215,215,224,240,218,231,224,234,241,237}), _obczbshz({182,45,37,216,225,215,223,220,224,229,147,216,228,150,231,221,236,233,155,224,236,158,226,225,243,244,242,164,173,183,167,233,169,194,180}), 1, 8, 2, function(v) low.k = v end)
	task.spawn(function()
		while alive do
			local h = hum()
			local sp = h and h.SeatPart
			local root = sp and sp.AssemblyRootPart
			if low.on and root then
				if low.root ~= root or not low.vf or not low.vf.Parent then
					lowClear()
					local att = mk(_obczbshz({170,222,223,205,208,214,220,213,223,230}), { Name = _obczbshz({188,210,212,218,181,227,209,188,224,233}) }, root)
					low.vf = mk(_obczbshz({191,207,206,224,220,224,181,223,227,213,216}), {
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
		if not alive or method ~= _obczbshz({175,211,221,209,192,211,225,230,214,228}) then return end
		if remote.Name == _obczbshz({188,207,223,192,213,224,222,228,229,222,216,186,225,229,216,236}) then
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
	local RS = game:GetService(_obczbshz({187,207,219,216,214,209,208,228,214,214,198,232,228,232,216,223,222}))
	local function topModel(part)
		local m = part and part:FindFirstAncestorOfClass(_obczbshz({182,217,207,209,217}))
		while m and m.Parent and m.Parent:IsA(_obczbshz({182,217,207,209,217})) do m = m.Parent end
		return m
	end
	local function inputRow(placeholder)
		local row = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk(_obczbshz({189,207,227,224,175,221,231}), {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = _obczbshz({}), PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function note(text, h)
		mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = text, Size = UDim2.new(1, 0, 0, h or 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
			Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end
	local function copy(txt)
		local f = setclipboard or toclipboard
		if not f then say(_obczbshz({188,207,224,140,210,230,212,211,230,230,226,230,149,228,58,27,232,154,239,225,234,158,242,229,245,229,239,237,245,232,246,233,251,238,185})); return end
		local ok = pcall(f, txt)
		say(ok and _obczbshz({172,217,219,213,206,210,222,145}) or _obczbshz({175,203,215,212,220,227,143,209,224,146,214,227,229,223,216,234,167}))
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
		if okA and type(acc) == _obczbshz({221,203,205,216,210}) then
			for _, a in ipairs(acc) do add(a.AssetId) end
		end
		for _, k in ipairs({ _obczbshz({188,210,212,222,225}), _obczbshz({185,203,217,224,224}), _obczbshz({176,220,204,220,213,215,210,196,196,218,220,230,233}), _obczbshz({175,203,206,209}), _obczbshz({177,207,204,208}), _obczbshz({189,217,221,223,220}), _obczbshz({181,207,209,224,174,224,220}), _obczbshz({187,211,210,212,225,175,225,221}), _obczbshz({181,207,209,224,185,211,214}), _obczbshz({187,211,210,212,225,186,212,215}) }) do
			local okP, v = pcall(function() return desc[k] end)
			if okP then add(v) end
		end
		local function hex(c)
			return string.format(_obczbshz({142,154,157,228,146,158,161,232,150,162,165,236}), math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
		end
		local bc = table.concat({
			hex(desc.HeadColor), hex(desc.TorsoColor), hex(desc.LeftArmColor),
			hex(desc.RightArmColor), hex(desc.LeftLegColor), hex(desc.RightLegColor),
		}, _obczbshz({149}))
		return ids, bc
	end

	section(page, _obczbshz({172,217,219,213,206,224,143,209,231,211,231,213,231,150,159,186,235,233,234,231,229,223,245,229,239,171}))
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({174,221,206,219,217,214,208,144,210,222,218,233,56,31,228,152,234,239,224,156,226,241,243,67,34,162,241,243,165,240,246,239,248,170,240,172,240,253,255,249,246,178,2,180,246,12,248,12,250,12,201,188,241,13,3,15,193,15,24,18,9,21,199,25,30,15,203,33,32,15,207,31,209,26,40,22,213,44,122,98,217,31,40,220,51,45,34,131,107,240}),
		Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local dd
	dd = dropdown(page, _obczbshz({174,221,206,219,217,214,212,226,145,220,226,219,214,218,230,234,153,162,233,225,235,230,244,237,170}), function()
		local t = {}
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl ~= lp then
				table.insert(t, { label = pl.DisplayName .. _obczbshz({137,138,147,172}) .. pl.Name .. _obczbshz({146}), value = pl.UserId, name = pl.DisplayName })
			end
		end
		table.sort(t, function(x, y) return x.label:lower() < y.label:lower() end)
		return t
	end, function(it)
		picked = it
		dd.setText(_obczbshz({179,217,210,205,209,221,225,170,145}) .. it.name)
	end)
	local busy = false
	rowBtn(page, _obczbshz({172,217,219,213,206,224,143,209,231,211,231,213,231,150,219,231,153,228,234,227,222,226,238,242}), function()
		if not picked then say(_obczbshz({174,221,206,219,217,214,208,144,230,223,147,222,228,221,216,220,232,236,155,236,239,231,236,229,234,244,242,178})); return end
		if busy then return end
		busy = true
		task.spawn(function()
			local ids, bc = collect(picked.value)
			busy = false
			if not ids or #ids == 0 then say(_obczbshz({183,45,14,219,141,209,222,222,228,215,218,233,222,150,227,221,235,154,234,156,222,244,224,244,226,244,163,232,234,166}) .. picked.name .. _obczbshz({151})); return end
			MINE.ids = ids
			MINE.bc = bc
			if MINE.onList then MINE.onList() end
			if publishMods then publishMods() end
			say(_obczbshz({170,224,204,224,206,224,143,212,214,146}) .. picked.name .. _obczbshz({137,205,218,220,214,207,211,223,145,154}) .. #ids .. _obczbshz({137,211,223,209,219,225,152,158,145,179,227,213,231,219,218,221,153,223,232,156,222,234,230,245,239,245,163,247,234,237,252,246,237,249,254,186}))
		end)
	end)
	rowBtn(page, _obczbshz({191,217,215,224,206,224,143,209,224,146,224,217,234,150,216,238,218,238,220,238}), function()
		MINE.ids = {}
		MINE.bc = nil
		if MINE.onList then MINE.onList() end
		if publishMods then publishMods() end
		say(_obczbshz({170,224,204,224,206,224,143,211,224,226,220,213,217,229,151,234,222,231,234,242,230,226,238,174}))
	end, true)
end

local function buildWings(page, say)
	local rawSay = say
	local trace, T0 = {}, os.clock()
	local function say(s)
		trace[#trace + 1] = string.format(_obczbshz({196,143,153,157,211,225,204,144,150,229}), os.clock() - T0, tostring(s))
		if #trace > 60 then table.remove(trace, 1) end
		rawSay(s)
	end
	local RS = game:GetService(_obczbshz({187,207,219,216,214,209,208,228,214,214,198,232,228,232,216,223,222}))
	local alive, animating, busyBuild = true, false, false
	local animGen = 0
	local recs = {}
	local cfg = { per = 3, scale = 10, speed = 5, interval = 300, full = true, hide = true }
	local blockName = _obczbshz({171,214,218,207,216,161})
	local spacing = 2
	local t0 = os.clock()
	local wconns = {}

	local function inputRow(placeholder, text)
		local row = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk(_obczbshz({189,207,227,224,175,221,231}), {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = text or _obczbshz({}), PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function clip(txt)
		if setclipboard then pcall(setclipboard, txt); say(_obczbshz({172,217,219,213,206,210,222,158})) else say(_obczbshz({188,207,224,140,210,230,212,211,230,230,226,230,149,228,58,27,232,154,239,225,234,158,242,229,245,229,239,237,245,232,246,233,251,238,185})) end
	end
	local function getRoot()
		return lp.Character and lp.Character:FindFirstChild(_obczbshz({177,223,216,205,219,221,216,212,195,225,226,232,197,215,233,236}))
	end
	local function remoteRE(name)
		local re = RS:FindFirstChild(_obczbshz({187,175}))
		return re and re:FindFirstChild(name)
	end
	local function propTool()
		local c = lp.Character
		return c and c:FindFirstChild(_obczbshz({185,220,218,220,186,207,218,213,227}))
	end
	local function findTool(name)
		local c = lp.Character
		local t = c and c:FindFirstChild(name)
		if t then return t, _obczbshz({204,210,204,222,206,209,227,213,227}) end
		local bp = lp:FindFirstChildOfClass(_obczbshz({171,203,206,215,221,207,210,219}))
		t = bp and bp:FindFirstChild(name)
		if t then return t, _obczbshz({203,203,206,215,221,207,210,219}) end
		return nil
	end
	local function equipPropMaker(re1)
		local t, where = findTool(_obczbshz({185,220,218,220,186,207,218,213,227}))
		if t and where == _obczbshz({204,210,204,222,206,209,227,213,227}) then return t end
		if not t then
			local ok, res = pcall(function() return re1:InvokeServer(_obczbshz({185,211,206,215,214,220,214,196,224,225,223,231}), _obczbshz({185,220,218,220,186,207,218,213,227})) end)
			say(_obczbshz({185,211,206,215,214,220,214,196,224,225,223,231,175,150}) .. (ok and (_obczbshz({219,207,222,220,220,225,227,209,174}) .. tostring(res)) or (_obczbshz({206,220,221,219,170}) .. tostring(res):sub(1, 60))))
			for _ = 1, 30 do
				task.wait(0.1)
				t, where = findTool(_obczbshz({185,220,218,220,186,207,218,213,227}))
				if t then break end
			end
		end
		if t and where == _obczbshz({203,203,206,215,221,207,210,219}) then
			local h = lp.Character and lp.Character:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212}))
			if h then pcall(function() h:EquipTool(t) end) end
			for _ = 1, 20 do
				task.wait(0.1)
				if lp.Character and lp.Character:FindFirstChild(_obczbshz({185,220,218,220,186,207,218,213,227})) then break end
			end
		end
		return lp.Character and lp.Character:FindFirstChild(_obczbshz({185,220,218,220,186,207,218,213,227}))
	end
	local function scanProps(deep)
		local out = {}
		local wc = workspace:FindFirstChild(_obczbshz({192,217,221,215,224,222,208,211,214,181,226,225}))
		if not wc then return out end
		local want = _obczbshz({185,220,218,220}) .. lp.Name
		local function isMine(n) return n:sub(1, #want) == want end
		if deep then
			for _, d in ipairs(wc:GetDescendants()) do
				if d.Name == _obczbshz({188,207,223,175,226,224,225,213,223,230,182,186,231,215,228,221}) and d.Parent and isMine(d.Parent.Name) then out[d.Parent] = true end
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

	local REMOTES = { begin = _obczbshz({171,207,210,213,219,190,225,213,231,219,216,235}), setcf = _obczbshz({188,207,223,175,226,224,225,213,223,230,182,186,231,215,228,221}), setsc = _obczbshz({188,207,223,175,226,224,225,213,223,230,198,215,214,226,220}), endp = _obczbshz({174,216,207,188,223,211,229,217,214,233}), resume = _obczbshz({187,207,222,225,218,211,191,226,224,226,181,217,221,215,237,225,232,236}) }
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
		t = rec.model:FindFirstChild(_obczbshz({189,217,224,207,213}), true)
		rec.touch = t
		return t
	end
	local function waitRemotes(rec, secs)
		local t = os.clock()
		while os.clock() - t < secs do
			if rem(rec, _obczbshz({203,207,210,213,219})) and rem(rec, _obczbshz({220,207,223,207,211})) and rem(rec, _obczbshz({206,216,207,220})) then return true end
			task.wait(0.1)
		end
		return false
	end
	local function sizeOf(model)
		local ok, s = pcall(function()
			if model:IsA(_obczbshz({182,217,207,209,217})) then return model:GetExtentsSize() end
			return model.Size
		end)
		if ok and typeof(s) == _obczbshz({191,207,206,224,220,224,162}) then return s end
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
		return lp:FindFirstChildOfClass(_obczbshz({185,214,204,229,210,224,182,229,218}))
	end
	local function guiOn(g)
		if g:IsA(_obczbshz({188,205,221,209,210,220,182,229,218})) then return g.Enabled end
		if g:IsA(_obczbshz({176,223,212,187,207,216,212,211,229})) then return g.Visible end
		return false
	end
	local function guiOff(g)
		pcall(function()
			if g:IsA(_obczbshz({188,205,221,209,210,220,182,229,218})) then g.Enabled = false elseif g:IsA(_obczbshz({176,223,212,187,207,216,212,211,229})) then g.Visible = false end
		end)
	end

	local function eachGui(fn)
		local pg = playerGui()
		if not pg then return end
		for _, sg in ipairs(pg:GetChildren()) do
			if sg:IsA(_obczbshz({188,205,221,209,210,220,182,229,218})) then
				fn(sg, 1)
				if guiOn(sg) then
					for _, c in ipairs(sg:GetChildren()) do
						if c:IsA(_obczbshz({176,223,212,187,207,216,212,211,229})) then
							fn(c, 2)
							if c.Visible then
								for _, d in ipairs(c:GetChildren()) do
									if d:IsA(_obczbshz({176,223,212,187,207,216,212,211,229})) then fn(d, 3) end
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
		local want = _obczbshz({185,220,218,220}) .. lp.Name
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
				if inst:IsA(_obczbshz({177,211,210,212,217,215,214,216,229})) then inst.Enabled = false else inst.Visible = false end
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
		local b, s, e = rem(rec, _obczbshz({203,207,210,213,219})), rem(rec, _obczbshz({220,207,223,207,211})), rem(rec, _obczbshz({206,216,207,220}))
		if not (b and s and e) then error(_obczbshz({203,214,218,207,220,142,226,213,222,146,229,217,226,229,235,221,236,154,163,221,230,236,227,225,161,244,232,244,241,239,234,233,247,238,250,181}), 0) end
		rec.lastCF = cf
		local tool = propTool()
		local pm = tool and tool:FindFirstChild(_obczbshz({189,217,218,216,204,190,225,223,225,191,212,223,218}))
		local touch = touchOf(rec)
		if full and pm and touch then
			hide.expect = os.clock() + 1.2
			pm:FireServer(touch, touch.Position)
		end
		b:InvokeServer()
		local sc = rem(rec, _obczbshz({220,207,223,223,208}))
		if scale and sc then sc:InvokeServer(scale) end
		s:InvokeServer(cf)
		e:InvokeServer()
		local rs = rem(rec, _obczbshz({219,207,222,225,218,211}))
		if full and rs then rs:InvokeServer() end
	end

	local function runCycle(rec, cf, scale, full)

		if rec.busy and os.clock() - (rec.busyAt or 0) < 8 then return false, _obczbshz({216,205,224,220,206,210,222}) end
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
						if err == _obczbshz({216,205,224,220,206,210,222}) then

						elseif ok then
							rec.fails = 0
						else
							rec.fails = rec.fails + 1
							rec.lastErr = tostring(err):sub(1, 80)
							if rec.fails >= 3 then rec.forceFull = true end
							if rec.fails == 6 then say(_obczbshz({171,214,218,207,220,142}) .. idx .. _obczbshz({137,208,204,216,213,207,221,212,224,172,147}) .. rec.lastErr) end
						end
					end
					task.wait(cfg.interval / 1000)
				end
				if alive and animating and gen == animGen and not rec.model.Parent then
					say(_obczbshz({171,214,218,207,220,142}) .. idx .. _obczbshz({137,221,224,217,214,227,143,212,224,146,224,213,229,215,165}))
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
									say(_obczbshz({171,214,218,207,220,142}) .. idx .. _obczbshz({137,218,204,222,206,210,222,158,145,196,216,218,214,240,220,230,221,233,155,164}) .. rec.heals .. _obczbshz({152,160,148,154,155,156}))
									waitRemotes(rec, 2)
									runCycle(rec, targetCF(root, side, i, per, os.clock() - t0), nil, true)
								end
							end
						end
					end
				end
			end
		end)
		say(_obczbshz({170,221,204,140,207,207,227,213,223,214,226,162}))
	end

	local function buildWing()
		if busyBuild then say(_obczbshz({179,45,12,140,210,225,227,223,230,146,214,230,222,215,229,220,232,154,220,156,222,241,224,174,175,176})); return end
		busyBuild = true
		task.spawn(function()
			stopAnim()
			recs = {}
			if cfg.hide then hideStart(true) end
			local ok, err = pcall(function()
				local root0 = getRoot()
				if not root0 then say(_obczbshz({185,207,221,223,220,220,208,215,214,223,147,226,56,25,230,152,222,232,222,235,235,242,241,225,229,241,177})); return end
				local re1, re2 = remoteRE(_obczbshz({154,190,218,219,158,218})), remoteRE(_obczbshz({154,173,215,209,206,159,225,196,224,225,223,165,232}))
				if not (re1 and re2) then say(_obczbshz({187,207,216,219,225,211,226,144,213,225,147,196,231,229,231,152,198,219,230,225,239,158,237,67,36,241,163,233,243,233,246,246,253,252,236,240,252,1,189})); return end
				say(_obczbshz({174,219,224,213,221,207,221,212,224,146,226,148,197,232,230,232,153,199,220,231,226,240,173,174,175}))
				local tool = equipPropMaker(re1)
				if not tool then
					say(_obczbshz({185,220,218,220,141,187,208,219,214,228,147,226,56,25,230,152,218,234,220,238,226,225,228,245,175,162,216,247,234,166,174,203,248,250,244,237,255,174,243,249,242,249,1,87,72,9,11,1,252,9,187,0,12,17,191,2,13,17,6,19,24,205,213})); return
				end
				local pm = tool:WaitForChild(_obczbshz({189,217,218,216,204,190,225,223,225,191,212,223,218}), 3)
				if not pm then say(_obczbshz({189,217,218,216,204,190,225,223,225,191,212,223,218,150,229,59,28,233,155,225,235,225,238,238,245,244,228,232,244,166,235,237,247,254,253,251,173,242,254,176,225,4,2,4,181,227,248,3,254,12,201})); return end

				local total = cfg.per * 2
				local per = cfg.per

				local known = {}
				for p in pairs(scanProps(false)) do known[p] = true end
				for p in pairs(scanProps(true)) do known[p] = true end
				local scaleF = cfg.scale / 10
				local function selectBlock()
					hide.expect = os.clock() + 1.2
					pcall(function() re2:FireServer(_obczbshz({184,218,208,218,189,224,222,224,190,215,225,233})) end)
					pcall(function() re2:FireServer(_obczbshz({187,207,220,225,210,225,227,217,223,217,195,230,228,230,197,217,230,223}), blockName, _obczbshz({171,223,212,216,209,215,221,215}), nil) end)
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
					say(_obczbshz({172,220,212,205,219,210,222,144,211,222,226,215,228,150}) .. i .. _obczbshz({137,206,208,140}) .. total .. _obczbshz({151,152,153}))
					local found
					for attempt = 1, 3 do
						local r0 = getRoot()
						if not r0 then say(_obczbshz({185,207,221,223,220,220,208,215,214,223,147,231,234,227,224,237,167})); return end
						local ang = (i / total) * math.pi * 2 + (attempt - 1) * 0.6
						local dist = 10 + (attempt - 1) * 3
						local hit, pos = groundAt(r0.Position.X + math.cos(ang) * dist, r0.Position.Z + math.sin(ang) * dist, r0.Position.Y)
						if hit then
							selectBlock()
							pm:FireServer(hit, pos)
							found = waitNew(2.5)
							if not found and recs[#recs] then

								pcall(function()
									local rs = rem(recs[#recs], _obczbshz({219,207,222,225,218,211}))
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
						say(_obczbshz({171,214,218,207,220,142}) .. i .. _obczbshz({137,216,46,15,220,142,208,224,210,228,216,215,218,235,165,152,204,223,226,241,230,236,227,239,161,229,242,241,165,245,250,168,248,255,255,254,252,1,189}))
					else
						known[found] = true
						local rec = makeRec(found)
						recs[#recs + 1] = rec
						pcall(function() re2:FireServer(_obczbshz({172,214,218,223,210,190,225,223,225,191,216,226,234})) end)

						if not waitRemotes(rec, 4) then say(_obczbshz({171,214,218,207,220,142}) .. i .. _obczbshz({163,138,221,209,218,221,227,213,228,146,215,217,226,229,233,217,235,219,232,156,222,158,241,229,241,238,236,231,230,248,181})) end

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
						if not okc then say(_obczbshz({171,214,218,207,220,142}) .. i .. _obczbshz({163,138}) .. tostring(e2):sub(1, 60)) end
						task.wait(0.3)
					end
				end
				pcall(function() re2:FireServer(_obczbshz({172,214,218,223,210,190,225,223,225,191,216,226,234})) end)

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
					if extra > 0 then say(extra .. _obczbshz({137,204,215,219,208,221,151,227,154,146,216,236,233,232,216,152,222,232,239,238,222,240,224,237,161,240,228,164,230,249,232,182})) end
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
				say(good .. _obczbshz({137,206,208,140}) .. #recs .. _obczbshz({137,204,215,219,208,221,226,144,223,225,147,224,234,221,216,234,167}))
			end)
			busyBuild = false
			hide.learning = false
			if not ok then
				say(_obczbshz({174,220,221,219,167,142}) .. tostring(err):sub(1, 70))
				hideStop()
				return
			end
			if #recs > 0 and alive then startAnim() else hideStop() end
		end)
	end

	section(page, _obczbshz({170,221,204,140,209,211,143,210,221,225,214,227,232,150,159,200,235,233,235,156,202,223,234,229,243,171}))
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({172,220,212,205,141,208,219,223,212,225,230,148,217,229,151,226,232,225,234,156,222,242,241,67,34,245,163,232,234,166,253,247,236,77,53,172,242,174,245,241,11,178,248,0,250,9,183,250,250,14,0,14,189,1,14,13,16,194,24,17,6,198,8,27,10,216,203,252,31,19,18,25,36,19,211,40,26,40,215,39,217,10,45,43,45,222,12,33,44,39,53,228,42,230,45,49,44,43,61,236,61,51,65,68,64,242,55,67,245,57,63,155,124,73,9,252,49,77,67,79,84,2,89,73,74,83,7,87,92,10,77,88,92,81,94,99,31}),
		Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local nameBox = inputRow(_obczbshz({183,217,216,209,141,210,222,144,211,222,226,215,228,150,159,232,218,222,237,63,32,237,159,194,237,241,230,239,184,175}), blockName)
	nameBox.FocusLost:Connect(function()
		local t = nameBox.Text:gsub(_obczbshz({142,221}), _obczbshz({}))
		if t ~= _obczbshz({}) then blockName = t end
	end)
	sliderRow(page, _obczbshz({171,214,218,207,220,225,143,224,224,228,147,213,232,215}), _obczbshz({155,138,204,140,162,142,223,223,227,146,223,213,217,229}), 2, 5, 3, function(v) cfg.per = v end)
	sliderRow(page, _obczbshz({189,203,216,205,219,214,222,144,213,225,147,214,225,229,218,231}), _obczbshz({154,154,139,169,141,220,222,226,222,211,223,148,157,171,151,217,153,172,171,165}), 5, 20, 10, function(v) cfg.scale = v end)
	sliderRow(page, _obczbshz({191,207,215,219,208,215,211,209,213,215,147,216,214,150,217,217,237,227,223,221}), _obczbshz({154,138,215,209,219,226,222,144,51,41,147,165,165,150,233,59,26,234,228,224,236}), 1, 10, 5, function(v) cfg.speed = v end)
	sliderRow(page, _obczbshz({178,216,223,209,223,228,208,220,224,146,155,225,232,159}), _obczbshz({214,207,217,219,223,142,172,144,222,211,220,231,149,233,236,217,239,223,155,225,157,235,224,233,244,162,243,233,248,231,235,247}), 150, 600, 300, function(v) cfg.interval = v end)
	toggleRow(page, _obczbshz({182,217,207,219,141,209,222,221,225,222,216,232,228}), _obczbshz({172,214,212,207,206,142,221,223,145,212,223,227,216,229,151,217,153,221,220,224,222,158,225,225,245,235,231,229,179,166,203,237,252,246,244,243,2,243,175,3,246,178,3,249,8,247,9}), function(v) cfg.full = v end, true)
	toggleRow(page, _obczbshz({174,221,206,219,219,210,212,226,145,215,215,221,56,29,58,27,232,154,223,235,240,158,225,236,240,229,242,247}), _obczbshz({188,217,216,209,141,209,222,221,145,225,147,225,218,228,236,152,222,154,220,239,157,241,228,244,226,245,163,232,244,166,215,250,248,250,171,217,238,249,244,2}), function(v)
		cfg.hide = v
		if v then
			if animating or busyBuild then hideStart(false) end
		else
			hideStop()
		end
	end, true)
	rowBtn(page, _obczbshz({172,220,212,205,223,142,208,227,210,146,216,148,215,215,235,221,235}), buildWing, true)
	toggleRow(page, _obczbshz({171,203,223,209,223,142,208,227,210,229}), _obczbshz({181,211,210,205,156,210,212,227,221,219,218,213,149,215,151,217,231,227,232,221,64,37,66,35,240}), function(v)
		if v then startAnim() else stopAnim(); say(_obczbshz({170,216,212,217,206,49,22,51,20,225,147,228,214,232,216,220,218,168})) end
	end, true)
	rowBtn(page, _obczbshz({187,207,219,205,223,207,225,144,211,222,226,215,228,233,151,160,235,223,225,221,247,158,238,243,161,243,248,233,165,236,240,235,234,252,236,249,173,252,254,176,244,250,86,55,4,191}), function()
		if #recs == 0 then say(_obczbshz({172,220,212,209,141,207,143,209,228,211,147,228,231,223,228,221,226,236,234,170})); return end
		if busyBuild then say(_obczbshz({174,221,219,209,223,211,143,209,145,213,229,221,214,57,30,59,28,233,155,240,226,240,236,233,239,227,245,178})); return end
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
						if not okc then say(_obczbshz({171,214,218,207,220,142}) .. idx .. _obczbshz({163,138}) .. tostring(e):sub(1, 60)) end
						task.wait(0.2)
					end
				end
				say(_obczbshz({187,207,219,205,223,221,143,214,214,219,231,227,163}))
			end
			busyBuild = false
			if was and alive then startAnim() else hideStop() end
		end)
	end, true)
	rowBtn(page, _obczbshz({172,217,219,213,206,224,143,212,218,211,218,226,56,41,234,236,226,221,234,156,225,237,242,160,227,238,242,231,244,249}), function()
		local L = { _obczbshz({150,151,139,216,220,213,143,212,210,146,212,231,214,176}) }
		for _, s in ipairs(trace) do L[#L + 1] = s end
		local function names(inst, limit)
			local out = {}
			if inst then
				for _, c in ipairs(inst:GetChildren()) do
					if #out < (limit or 25) then out[#out + 1] = c.Name .. _obczbshz({196}) .. c.ClassName .. _obczbshz({198}) end
				end
			end
			return table.concat(out, _obczbshz({149,138}))
		end
		L[#L + 1] = _obczbshz({185,220,218,220,186,207,218,213,227,146,216,229,234,223,231,217,221,233,181,156}) .. tostring(propTool() ~= nil)
		L[#L + 1] = _obczbshz({172,210,204,222,206,209,227,213,227,172,147}) .. names(lp.Character)
		L[#L + 1] = _obczbshz({171,203,206,215,221,207,210,219,171,146}) .. names(lp:FindFirstChildOfClass(_obczbshz({171,203,206,215,221,207,210,219})))
		local wc0 = workspace:FindFirstChild(_obczbshz({192,217,221,215,224,222,208,211,214,181,226,225}))
		L[#L + 1] = _obczbshz({185,220,218,220,185,221,210,209,229,219,226,226,232,176,151}) .. names(wc0 and wc0:FindFirstChild(_obczbshz({185,220,218,220,185,221,210,209,229,219,226,226,232})), 20)
		L[#L + 1] = _obczbshz({206,221,206,219,219,210,212,226,145,215,215,221,56,29,58,27,232,180,155}) .. tostring(cfg.hide) .. _obczbshz({137,230,139,213,219,226,212,226,215,211,214,217,232,150,216,232,235,223,233,224,230,226,224,243,187,162}) .. hide.count
		do
			local nm = {}
			for g in pairs(hide.set) do
				if #nm < 15 then
					local full = g:GetFullName()
					nm[#nm + 1] = (full:gsub(_obczbshz({199,152,152,188,217,207,232,213,227,185,232,221,154,164}), _obczbshz({})))
				end
			end
			L[#L + 1] = _obczbshz({210,216,223,209,223,212,208,211,214,229,147,217,232,217,230,230,221,227,223,221,240,184,159}) .. table.concat(nm, _obczbshz({137,230,139}))
		end
		do
			local sgs = {}
			local pg = playerGui()
			if pg then
				for _, sg in ipairs(pg:GetChildren()) do
					if sg:IsA(_obczbshz({188,205,221,209,210,220,182,229,218})) and #sgs < 70 then sgs[#sgs + 1] = sg.Name .. (sg.Enabled and _obczbshz({}) or _obczbshz({145,217,209,210,150})) end
				end
			end
			L[#L + 1] = _obczbshz({185,214,204,229,210,224,182,229,218,172,147}) .. table.concat(sgs, _obczbshz({149,138}))
		end
		L[#L + 1] = _obczbshz({203,214,218,207,220,225,143,226,214,217,220,231,233,232,216,220,232,237,181,156}) .. #recs
		for idx, rec in ipairs(recs) do
			local kids = {}
			for _, c in ipairs(rec.model:GetChildren()) do kids[#kids + 1] = c.Name .. _obczbshz({196}) .. c.ClassName .. _obczbshz({198}) end
			local ok, p = pcall(function() return rec.model:GetPivot().Position end)
			L[#L + 1] = idx .. _obczbshz({146,138}) .. rec.model:GetFullName() .. _obczbshz({137,218,218,223,170}) .. (ok and tostring(p) or _obczbshz({168}))
			L[#L + 1] = _obczbshz({137,138,139,222,210,219,222,228,214,229,173,148,215,219,222,225,231,183}) .. tostring(rem(rec, _obczbshz({203,207,210,213,219})) ~= nil) .. _obczbshz({137,221,208,224,170}) .. tostring(rem(rec, _obczbshz({220,207,223,207,211})) ~= nil)
				.. _obczbshz({137,207,217,208,170}) .. tostring(rem(rec, _obczbshz({206,216,207,220})) ~= nil) .. _obczbshz({137,222,218,225,208,214,172}) .. tostring(touchOf(rec) ~= nil)
				.. _obczbshz({137,230,139,210,206,218,215,209,228,175}) .. rec.fails .. _obczbshz({137,220,208,210,210,215,227,223,228,175}) .. rec.heals .. _obczbshz({137,207,221,222,220,171}) .. tostring(rec.lastErr)
			L[#L + 1] = _obczbshz({137,138,139,210,214,218,215,223,228,172,147}) .. table.concat(kids, _obczbshz({149,138}))
		end
		local wc = workspace:FindFirstChild(_obczbshz({192,217,221,215,224,222,208,211,214,181,226,225}))
		if wc then
			L[#L + 1] = _obczbshz({150,151,139,195,220,224,218,227,225,211,214,217,184,229,228,152,161,227,239,225,235,241,159,227,240,239,163,243,165,249,236,253,169,248,250,249,242,174,254,5,177,185,227,6,4,6,190,193,211})
			local n = 0
			for _, c in ipairs(wc:GetChildren()) do
				if n < 40 and (c.Name:find(lp.Name, 1, true) or c.Name:find(_obczbshz({185,220,218,220}), 1, true)) then
					n = n + 1
					local kids = {}
					for _, k in ipairs(c:GetChildren()) do
						if #kids < 8 then kids[#kids + 1] = k.Name .. _obczbshz({196}) .. k.ClassName .. _obczbshz({198}) end
					end
					L[#L + 1] = c:GetFullName() .. _obczbshz({137,151,169,140}) .. table.concat(kids, _obczbshz({149,138}))
				end
			end
		end
		clip(table.concat(L, _obczbshz({115})))
	end, true)
	rowBtn(page, _obczbshz({185,203,221,205,223,142,212,144,228,225,223,232,214,232,151,218,229,233,222,235,240}), function()
		stopAnim()
		say(_obczbshz({170,216,212,217,206,49,22,51,20,225,147,228,214,232,216,220,218,168,155,203,240,158,225,236,240,229,242,247,165,236,240,235,234,247,171,250,252,174,252,241,1,243,179,188,246,6,248,255,14,255,187,12,2,10,14,192,14,7,17,25,197,10,22,200,249,28,26,28,205,251,16,27,22,36,220,226}))
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
	if not name then return _obczbshz({173,207,222,207,220,220,215,213,212,219,215,227}) end
	return tostring(name) .. (ver and (_obczbshz({137}) .. tostring(ver)) or _obczbshz({}))
end
local function toBase36(n)
	local chars = _obczbshz({153,155,157,159,161,163,165,167,169,171,180,182,184,186,188,190,192,194,196,198,200,202,204,206,208,210,212,214,216,218,220,222,224,226,228,230})
	local s = _obczbshz({})
	repeat
		local r = n % 36
		s = chars:sub(r + 1, r + 1) .. s
		n = (n - r) / 36
	until n <= 0
	return s
end

local function hubId(uid)
	return _obczbshz({173,189,152}) .. toBase36(uid) .. _obczbshz({150}) .. toBase36((uid * 31 + 7) % 1296)
end
local function buildId(page, say)
	local function fmt(sec)
		sec = math.max(0, math.floor(sec))
		return string.format(_obczbshz({142,154,157,208,167,147,159,162,213,172,152,164,167,218}), math.floor(sec / 3600), math.floor(sec / 60) % 60, sec % 60)
	end
	local function esc(s) return (tostring(s):gsub(_obczbshz({143}), _obczbshz({143,203,216,220,168})):gsub(_obczbshz({165}), _obczbshz({143,214,223,167})):gsub(_obczbshz({167}), _obczbshz({143,209,223,167}))) end
	local DIMC = Color3.fromRGB(205, 168, 171)

	local card = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 64), BackgroundTransparency = 1 }, page)
	local av = mk(_obczbshz({178,215,204,211,210,186,208,210,214,222}), {
		Size = UDim2.fromOffset(54, 54), Position = UDim2.fromOffset(4, 5), BackgroundColor3 = Color3.fromRGB(14, 4, 6),
		Image = _obczbshz({}), ScaleType = Enum.ScaleType.Crop,
	}, card)
	mk(_obczbshz({190,179,174,219,223,220,212,226}), { CornerRadius = UDim.new(1, 0) }, av)
	local avs = mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 2, Color = WHITE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, av)
	mk(_obczbshz({190,179,178,222,206,210,216,213,223,230}), {
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 12, 22)) }),
		Rotation = 45,
	}, avs)
	task.spawn(function()
		local ok, img = pcall(function()
			return Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
		end)
		if ok and img and av.Parent then av.Image = img end
	end)
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = lp.DisplayName, Size = UDim2.new(1, -72, 0, 22), Position = UDim2.fromOffset(68, 11), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, card)
	mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({169}) .. lp.Name, Size = UDim2.new(1, -72, 0, 16), Position = UDim2.fromOffset(68, 33), BackgroundTransparency = 1,
		TextColor3 = DIMC, Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, card)
	local ln = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, -4, 0, 1), BackgroundColor3 = UI.EDGE, BorderSizePixel = 0, LayoutOrder = 0 }, page)
	mk(_obczbshz({190,179,178,222,206,210,216,213,223,230}), { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) }) }, ln)

	local function line(title, value)
		local f = mk(_obczbshz({175,220,204,217,210}), { Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1 }, page)
		mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = title, Size = UDim2.fromOffset(82, 18), Position = UDim2.fromOffset(6, 0), BackgroundTransparency = 1,
			TextColor3 = DIMC, Font = Enum.Font.Gotham, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
		}, f)
		return mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = value, Size = UDim2.new(1, -92, 1, 0), Position = UDim2.fromOffset(88, 0), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamMedium, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, f)
	end
	local id = hubId(lp.UserId)
	local up = line(_obczbshz({189,207,216,220,220,142,208,228,218,232,226}), fmt(0))
	line(_obczbshz({174,226,208,207,226,226,222,226}), execName())
	line(_obczbshz({178,174,139,47,39,220,216,211,224}), id)
	line(_obczbshz({190,221,208,222,182,210}), tostring(lp.UserId))
	rowBtn(page, _obczbshz({172,217,219,213,206,224,143,221,214,231,147,189,185}), function()
		local f = setclipboard or toclipboard
		if not f then say(_obczbshz({188,207,224,140,210,230,212,211,230,230,226,230,149,228,58,27,232,154,239,225,234,158,242,229,245,229,239,237,245,232,246,233,251,238,185,172,224,243,4,176,218,214,205,180}) .. id); return end
		say(pcall(f, id) and (_obczbshz({178,174,139,207,220,222,216,209,213,225,173,148}) .. id) or _obczbshz({175,203,215,212,220,227,143,209,224,146,214,227,229,223,216,234,167}))
	end, true)
	task.spawn(function()
		while page.Parent do
			up.Text = fmt(os.time() - HUB_START_T)
			task.wait(1)
		end
	end)
end

local AVATAR = {
	wear = function(kind, id)
		local folder = game:GetService(_obczbshz({187,207,219,216,214,209,208,228,214,214,198,232,228,232,216,223,222})):FindFirstChild(_obczbshz({187,207,216,219,225,211,226}))
		local r = folder and folder:FindFirstChild(_obczbshz({192,207,204,222}))
		if not r then error(_obczbshz({219,207,216,219,225,211,143,199,214,211,229,148,227,57,26,231,153,223,233,223,236,236,243,242,226,230,242})) end
		return r:InvokeServer(id, nil)
	end,
}
local function buildAvatar(page, say)
	local target
	local items = {}
	local BODY = { Head = true, Torso = true, LeftArm = true, RightArm = true, LeftLeg = true, RightLeg = true }
	local COLOR_KEYS = { _obczbshz({177,207,204,208,176,221,219,223,227}), _obczbshz({189,217,221,223,220,177,222,220,224,228}), _obczbshz({181,207,209,224,174,224,220,179,224,222,226,230}), _obczbshz({187,211,210,212,225,175,225,221,180,225,223,227,231}), _obczbshz({181,207,209,224,185,211,214,179,224,222,226,230}), _obczbshz({187,211,210,212,225,186,212,215,180,225,223,227,231}) }
	local SCALE_KEYS = { _obczbshz({177,207,212,211,213,226,194,211,210,222,216}), _obczbshz({192,211,207,224,213,193,210,209,221,215}), _obczbshz({173,207,219,224,213,193,210,209,221,215}), _obczbshz({177,207,204,208,192,209,208,220,214}), _obczbshz({171,217,207,229,193,231,223,213,196,213,212,224,218}), _obczbshz({185,220,218,220,220,224,227,217,224,224,198,215,214,226,220}) }
	local targetEx

	local alog = { lines = {}, view = nil, t0 = os.clock() }
	local function logLine(text)
		local line = string.format(_obczbshz({196,143,160,154,158,212,226,205,145,151,230}), os.clock() - alog.t0, text)
		alog.lines[#alog.lines + 1] = line
		if #alog.lines > 400 then table.remove(alog.lines, 1) end
		if alog.view and alog.view.Parent then
			local bad = text:find(_obczbshz({175,171,183,180,188,195}), 1, true) or text:find(_obczbshz({175,171,183,192,188,195}), 1, true) or text:find(_obczbshz({183,45,238,187,141,193,176,185,198}), 1, true)
			mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
				Text = line, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
				TextColor3 = bad and Color3.fromRGB(255, 140, 140) or WHITE, Font = Enum.Font.Code, TextSize = 11,
				TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = #alog.lines,
			}, alog.view)
			local kids = {}
			for _, c in ipairs(alog.view:GetChildren()) do
				if c:IsA(_obczbshz({189,207,227,224,185,207,209,213,221})) then kids[#kids + 1] = c end
			end
			if #kids > 150 then kids[1]:Destroy() end
		end
	end
	local function ser(v)
		local ok, s = pcall(HUBLOG.ser, v)
		return ok and tostring(s) or tostring(v)
	end

	local function note(text, h)
		return mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
			Text = text, Size = UDim2.new(1, 0, 0, h or 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
			Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end

	local function readAvatar(pl)
		local h = pl.Character and pl.Character:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212}))
		if not h then return nil, _obczbshz({216,138,213,219,212,207,211,223,227,146,216,231,233,57,24,152,236,223,232,156,237,227,241,243,240,240,228,235,234,243}) end
		local ok, d = pcall(function() return h:GetAppliedDescription() end)
		if not ok or not d then return nil, _obczbshz({215,45,14,219,141,209,222,222,228,215,218,233,222,150,227,221,235,154,234,156,222,244,224,244,226,244,163,232,234,242,236}) end
		local out = {}
		local function add(kind, id)
			id = tonumber(id)
			if id and id > 0 then out[#out + 1] = { kind = kind, id = math.floor(id) } end
		end
		local okA, acc = pcall(function() return d:GetAccessories(true) end)
		if okA and type(acc) == _obczbshz({221,203,205,216,210}) then
			for _, a in ipairs(acc) do add((tostring(a.AccessoryType):gsub(_obczbshz({199,175,217,225,218,147,157,177,212,213,216,231,232,229,233,241,205,243,235,225,162,172}), _obczbshz({}))), a.AssetId) end
		end
		for _, k in ipairs({ _obczbshz({188,210,212,222,225}), _obczbshz({185,203,217,224,224}), _obczbshz({176,220,204,220,213,215,210,196,196,218,220,230,233}), _obczbshz({175,203,206,209}), _obczbshz({177,207,204,208}), _obczbshz({189,217,221,223,220}), _obczbshz({181,207,209,224,174,224,220}), _obczbshz({187,211,210,212,225,175,225,221}), _obczbshz({181,207,209,224,185,211,214}), _obczbshz({187,211,210,212,225,186,212,215}) }) do
			local okP, v = pcall(function() return d[k] end)
			if okP then add(k, v) end
		end
		local ex = { colors = {}, scales = {}, zero = {} }
		for _, k in ipairs(COLOR_KEYS) do
			local okC, c = pcall(function() return d[k] end)
			if okC and typeof(c) == _obczbshz({172,217,215,219,223,161}) then ex.colors[k] = c end
		end
		for _, k in ipairs(SCALE_KEYS) do
			local okS, v = pcall(function() return d[k] end)
			if okS and type(v) == _obczbshz({215,223,216,206,210,224}) then ex.scales[k] = v end
		end
		for k in pairs(BODY) do
			local okZ, v = pcall(function() return d[k] end)
			if okZ and (tonumber(v) or 0) <= 0 then ex.zero[#ex.zero + 1] = k end
		end
		table.sort(ex.zero)
		return out, nil, ex
	end
	local function fmtColor(c)
		return string.format(_obczbshz({219,209,205,148,146,210,155,149,213,158,152,216,158}), math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
	end
	local function sameColor(a, b)
		return math.abs(a.R - b.R) < 0.012 and math.abs(a.G - b.G) < 0.012 and math.abs(a.B - b.B) < 0.012
	end
	local function logExtra(prefix, ex)
		if not ex then return end
		local cs, ss = {}, {}
		for _, k in ipairs(COLOR_KEYS) do
			if ex.colors[k] then cs[#cs + 1] = (k:gsub(_obczbshz({172,217,215,219,223,146}), _obczbshz({}))) .. _obczbshz({166}) .. fmtColor(ex.colors[k]) end
		end
		for _, k in ipairs(SCALE_KEYS) do
			if ex.scales[k] then ss[#ss + 1] = (k:gsub(_obczbshz({188,205,204,216,210,146}), _obczbshz({}))) .. _obczbshz({166}) .. string.format(_obczbshz({142,152,157,210}), ex.scales[k]) end
		end
		logLine(prefix .. _obczbshz({172,217,221,209,224,168,143}) .. (#cs > 0 and table.concat(cs, _obczbshz({137})) or _obczbshz({168})))
		logLine(prefix .. _obczbshz({185,220,218,220,220,224,50,23,52,39,216,231,175,150}) .. (#ss > 0 and table.concat(ss, _obczbshz({137})) or _obczbshz({168})))
		logLine(prefix .. _obczbshz({185,203,221,224,210,225,143,212,224,146,214,227,231,230,230,152,236,223,232,156,230,242,228,237,161,170,243,229,233,248,74,43,248,170,239,251,173,248,254,247,0,187,205,180}) .. (#ex.zero > 0 and table.concat(ex.zero, _obczbshz({149,138})) or _obczbshz({215,207,217,212,226,219,208})))
	end

	local function compareExtra(theirs, mine)
		local n = 0
		for _, k in ipairs(COLOR_KEYS) do
			local a, b = theirs.colors[k], mine.colors[k]
			if a and b and not sameColor(a, b) then
				n = n + 1
				logLine(_obczbshz({173,179,177,177,191,179,189,196,182,146}) .. k .. _obczbshz({163,138,207,209,217,211,143}) .. fmtColor(a) .. _obczbshz({137,153,139,223,210,227,143}) .. fmtColor(b))
			end
		end
		for _, k in ipairs(SCALE_KEYS) do
			local a, b = theirs.scales[k], mine.scales[k]
			if a and b and math.abs(a - b) > 0.01 then
				n = n + 1
				logLine(string.format(_obczbshz({173,179,177,177,191,179,189,196,182,146,152,231,175,150,219,221,229,223,155,161,171,176,229,160,176,162,246,233,250,166,172,182,187,240}), k, a, b))
			end
		end
		return n
	end

	section(page, _obczbshz({172,217,219,213,206,224,143,209,231,211,231,213,231,150,219,231,153,188,237,235,236,233,231,225,247,231,241}))
	note(_obczbshz({172,217,219,213,206,142,222,227,145,219,231,217,227,233,151,233,238,223,155,221,157,238,228,243,244,241,228,164,234,249,251,75,42,170,0,255,238,252,243,255,177,2,5,3,181,9,252,13,185,251,17,253,17,255,17,192,5,17,195,230,23,21,22,19,17,11,33,17,27,220,207,3,116,101,211,42,26,41,43,29,217,41,219,45,50,35,223,54,48,37,134,110,229,48,138,105,233,62,48,57,8,238,62,240,57,71,53,244,67,153,122,71,249,61,74,73,77,80,64,0,79,67,71,69,19}), 44)
	local ddA
	ddA = dropdown(page, _obczbshz({174,221,206,219,217,214,212,226,145,220,226,219,214,218,230,234,153,162,233,225,235,230,244,237,170}), function()
		local t = {}
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl ~= lp then
				table.insert(t, { label = pl.DisplayName .. _obczbshz({137,138,147,172}) .. pl.Name .. _obczbshz({146}), value = pl, name = pl.DisplayName })
			end
		end
		table.sort(t, function(a, b) return a.label:lower() < b.label:lower() end)
		return t
	end, function(it)
		target = it.value
		ddA.setText(_obczbshz({179,217,210,205,209,221,225,170,145}) .. it.name)
	end)
	local summary = note(_obczbshz({183,207,217,212,226,219,143,209,231,211,231,213,231,150,227,225,221,233,155,221,230,236,227,225,175}), 34)
	rowBtn(page, _obczbshz({181,207,221,140,206,228,208,228,210,228,147,216,228,150,225,231,224,219,223,235,239}), function()
		if not target or not target.Parent then say(_obczbshz({174,221,206,219,217,214,208,144,230,223,147,222,228,221,216,220,232,236,155,236,239,231,236,229,234,244,242,178})); return end
		local list, err, ex = readAvatar(target)
		if not list then logLine(_obczbshz({175,171,183,180,188,195,143,209,224,146,223,217,231,150}) .. target.Name .. _obczbshz({163,138}) .. tostring(err)); say(_obczbshz({175,203,215,212,220,227,169,144}) .. tostring(err)); return end
		items = list
		local counts, order = {}, {}
		for _, it in ipairs(items) do
			if not counts[it.kind] then counts[it.kind] = 0; order[#order + 1] = it.kind end
			counts[it.kind] = counts[it.kind] + 1
		end
		local parts = {}
		for _, k in ipairs(order) do parts[#parts + 1] = k .. _obczbshz({137}) .. counts[k] end
		summary.Text = _obczbshz({178,222,208,218,224,142,219,217,213,225,230,148,217,219,151}) .. target.DisplayName .. _obczbshz({163,138}) .. #items .. (#items > 0 and (_obczbshz({137,146}) .. table.concat(parts, _obczbshz({149,138})) .. _obczbshz({146})) or _obczbshz({}))
		logLine(_obczbshz({181,179,139,205,227,207,227,209,227,146,215,217,149}) .. target.DisplayName .. _obczbshz({137,146,171}) .. target.Name .. _obczbshz({146,164,139}) .. #items .. _obczbshz({137,211,223,209,219,225}))
		for _, it in ipairs(items) do logLine(_obczbshz({137,138,139}) .. it.kind .. _obczbshz({163,138}) .. it.id) end
		targetEx = ex
		logExtra(_obczbshz({137,138,139}), ex)
		say(#items .. _obczbshz({137,211,223,209,219,225,143,220,218,214,226,231,163}))
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
			local shown = (ok and (ser(res) .. (msg ~= nil and (_obczbshz({149,138}) .. ser(msg)) or _obczbshz({}))) or (_obczbshz({206,220,221,219,167,142}) .. tostring(res))):sub(1, 70)
			logLine((good and _obczbshz({}) or _obczbshz({175,171,183,180,188,195,143})) .. action .. _obczbshz({137}) .. it.kind .. _obczbshz({137}) .. it.id .. _obczbshz({137,151,169,140}) .. shown
				.. (attempt > 1 and (_obczbshz({137,138,147,224,210,220,227,209,229,219,233,213,149}) .. attempt .. _obczbshz({146})) or _obczbshz({})))
			if good then return true end
			if ok and msg ~= nil then refusedWhy[it.id] = tostring(msg) end
			if msg == _obczbshz({178,216,225,205,217,215,211,144,186,182}) then break end
		end
		return false
	end

	local function removeWorn(keep, action, targetKinds)
		local _, list = wornSet()
		local n = 0
		for _, it in ipairs(list) do
			local replaced = SLOT[it.kind] and targetKinds and targetKinds[it.kind]
			if not BODY[it.kind] and not replaced and not (keep and keep[it.id]) and not fixed[it.id] then
				if toggle(it, action or _obczbshz({189,179,189,173,191})) then n = n + 1 end
			end
		end
		return n
	end
	local busy = false
	local function run(fn)
		if busy then say(_obczbshz({179,45,12,140,210,225,227,51,18,146,229,227,217,215,229,220,232,166,155,225,240,238,228,242,226,162,247,233,247,243,240,246,234,252,185})); return end
		busy = true
		task.spawn(function()
			local ok, err = pcall(fn)
			busy = false
			if not ok then logLine(_obczbshz({175,171,183,180,188,195,169,144}) .. tostring(err)); say(_obczbshz({175,203,215,212,220,227,169,144}) .. tostring(err):sub(1, 60)) end
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
		local removed = removeWorn(keep, _obczbshz({189,179,189,173,191}), targetKinds)
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
					logLine(_obczbshz({175,179,195,187,141,150,210,223,223,230,220,226,234,215,151,229,222,237,232,235,157,242,232,242,226,240,231,243,192,166,235,237,255,239,171,255,242,0,175,0,242,246,5,87,56,5,183,252,8,186,5,11,4,13,200,218,193}) .. it.kind .. _obczbshz({137}) .. it.id)
				end
				break
			end
			logLine(_obczbshz({183,45,238,187,141,193,176,185,198,146}) .. #left .. _obczbshz({137,211,223,209,218,150,221,227,154,158,147,232,218,228,235,217,231,222,234,156,225,227,159,238,240,248,242,164,173,248,246,236,234,238,236,172}) .. pass .. _obczbshz({146}))
			for _, it in ipairs(left) do
				if toggle(it, _obczbshz({189,179,189,173,191,142,151,212,214,146,225,227,235,229,160})) then removed = removed + 1 end
			end
		end
		return removed
	end

	local ANIM = { orig = {}, applied = nil, tested = {} }
	local function animateOf(char) return char and char:FindFirstChild(_obczbshz({170,216,212,217,206,226,212})) end
	local function animKey(d) return d.Parent.Name .. _obczbshz({152}) .. d.Name end
	local function rigOf(char)
		local h = char and char:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212}))
		return h and h.RigType
	end
	local function readAnims(pl)
		local char = pl.Character
		local ids, n = {}, 0
		local an = animateOf(char)
		if an then
			for _, d in ipairs(an:GetDescendants()) do
				if d:IsA(_obczbshz({170,216,212,217,206,226,216,223,223})) and d.AnimationId ~= _obczbshz({}) then ids[animKey(d)] = d.AnimationId; n = n + 1 end
			end
		end
		if n > 0 then return ids, n end

		local h = char and char:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212}))
		local ok, d = pcall(function() return h and h:GetAppliedDescription() end)
		if not ok or not d then return nil, _obczbshz({215,45,14,219,141,209,222,222,228,215,218,233,222,150,227,221,235,154,220,156,222,236,232,237,226,69,42,71,40,245,167,236,238,246,240}) end
		local map = {
			IdleAnimation = { _obczbshz({210,206,215,209,156,175,221,217,222,211,231,221,228,228,168}), _obczbshz({210,206,215,209,156,175,221,217,222,211,231,221,228,228,169}) }, WalkAnimation = { _obczbshz({224,203,215,215,156,197,208,220,220,179,225,221,226}) },
			RunAnimation = { _obczbshz({219,223,217,155,191,227,221,177,223,219,224}) }, JumpAnimation = { _obczbshz({211,223,216,220,156,184,228,221,225,179,225,221,226}) }, FallAnimation = { _obczbshz({207,203,215,216,156,180,208,220,221,179,225,221,226}) },
			ClimbAnimation = { _obczbshz({204,214,212,217,207,157,178,220,218,223,213,181,227,223,228}) }, SwimAnimation = { _obczbshz({220,225,212,217,156,193,230,217,222}), _obczbshz({220,225,212,217,214,210,219,213,160,197,234,221,226,191,219,228,222}) },
		}
		for field, keys in pairs(map) do
			local okF, v = pcall(function() return d[field] end)
			v = okF and tonumber(v) or 0
			if v and v > 0 then
				for _, k in ipairs(keys) do ids[k] = _obczbshz({209,222,223,220,167,157,158,231,232,233,161,230,228,216,227,231,241,168,222,235,234,173,224,243,244,231,247,179,196,239,235,197}) .. math.floor(v); n = n + 1 end
			end
		end
		if n == 0 then return nil, _obczbshz({206,214,208,140,210,225,227,51,18,146,214,227,226,150,216,152,218,232,228,233,222,65,38,67,36,241,163,244,230,234,249,75,44,249,171,180,251,239,243,241,177,2,5,245,181,249,6,8,2,251,13,197}) end
		return ids, n
	end
	local function reloadAnimate(char)
		local an, hum = animateOf(char), char and char:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212}))
		if not (an and hum) then return end
		pcall(function()
			an.Disabled = true
			local animator = hum:FindFirstChildOfClass(_obczbshz({170,216,212,217,206,226,222,226}))
			for _, tr in ipairs((animator or hum):GetPlayingAnimationTracks()) do tr:Stop(0) end
			task.wait(0.1)
		end)
		pcall(function() an.Disabled = false end)
	end
	local function applyAnims(ids)
		local char = lp.Character
		local an = animateOf(char)
		if not an then return false, _obczbshz({220,207,224,140,221,211,225,227,224,224,212,219,218,227,151,221,236,238,62,29,157,241,228,237,161,241,163,247,232,248,240,248,253,170,204,250,246,251,240,4,246}) end
		local n = 0
		for _, d in ipairs(an:GetDescendants()) do
			if d:IsA(_obczbshz({170,216,212,217,206,226,216,223,223})) then
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
				if d:IsA(_obczbshz({170,216,212,217,206,226,216,223,223})) then
					local o = ANIM.orig[animKey(d)]
					if o then d.AnimationId = o end
				end
			end
			reloadAnimate(lp.Character)
		end
		ANIM.orig = {}
	end

	local function assetNum(id)
		return tostring(id):match(_obczbshz({142,206,150})) or tostring(id)
	end

	local function canLoadAnim(animId)
		local char = lp.Character
		local h = char and char:FindFirstChildOfClass(_obczbshz({177,223,216,205,219,221,216,212}))
		local animator = h and h:FindFirstChildOfClass(_obczbshz({170,216,212,217,206,226,222,226}))
		if not animator then return nil end
		local a = Instance.new(_obczbshz({170,216,212,217,206,226,216,223,223}))
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
		if not pl or not pl.Parent then return false, _obczbshz({206,221,206,219,217,214,208,144,230,223,147,222,228,221,216,220,232,236,155,236,239,231,236,229,234,244,242}) end
		local mine, theirs = rigOf(lp.Character), rigOf(pl.Character)
		if mine and theirs and mine ~= theirs then return false, _obczbshz({219,211,210,140,209,215,213,213,227,215,225,232,218,150,159,202,175,169,205,173,178,167,185,160,226,162,228,242,238,243,232,75,48,77,46,251,173,242,244,252,246,178,1,87,56,5,183,254,14,8,254,5,12,12,0,192,15,17,195,23,10,27}) end
		local ids, n = readAnims(pl)
		if not ids then return false, n end
		local an = animateOf(lp.Character)
		if not an then return false, _obczbshz({220,207,224,140,221,211,225,227,224,224,212,219,218,227,151,221,236,238,62,29,157,241,228,237,161,241,163,247,232,248,240,248,253,170,204,250,246,251,240,4,246}) end

		local keys, mineIds = {}, {}
		for k in pairs(ids) do keys[#keys + 1] = k end
		table.sort(keys)
		for _, d in ipairs(an:GetDescendants()) do
			if d:IsA(_obczbshz({170,216,212,217,206,226,216,223,223})) then mineIds[animKey(d)] = d.AnimationId end
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
			local label = k .. _obczbshz({163,138,207,209,217,211,143}) .. assetNum(id)
			if not mineIds[k] then
				onlyTheirs = onlyTheirs + 1
				logLine(_obczbshz({170,184,180,185,141}) .. label .. _obczbshz({137,44,34,140,227,221,210,51,27,146,225,55,24,229,151,236,222,231,155,225,240,241,228,160,230,245,247,229,233,245,167,176,247,77,46,251,173,242,82,49,177,2,5,245,181,247,7,4,2,253,252,14,198}))
			elseif mineIds[k] == id then
				same = same + 1
				logLine(_obczbshz({170,184,180,185,141}) .. label .. _obczbshz({137,44,34,140,214,213,228,209,221,146,54,20,149,233,236,217}))
			else
				local r = results[id]
				if r == false then
					bad = bad + 1
					logLine(_obczbshz({170,184,180,185,141}) .. label .. _obczbshz({137,44,34,140,224,211,228,144}) .. assetNum(mineIds[k]) .. _obczbshz({137,44,34,140,187,49,242,191,145,198,194,183,182,150,159,231,153,228,234,227,236,158,237,67,36,241,163,231,230,248,249,237,240,249,0,181,200,174,252,241,255,6,252,10,250,182,248,184,12,15,252}))
				else
					good[k] = id
					logLine(_obczbshz({170,184,180,185,141}) .. label .. _obczbshz({137,44,34,140,224,211,228,144}) .. assetNum(mineIds[k]) .. _obczbshz({137,44,34,140,193,192,190,179,178,182,180}) .. (r == nil and _obczbshz({137,146,217,47,16,221,143,211,224,224,230,217,220,235,224,152,237,223,238,240,222,240,168}) or _obczbshz({137,146,223,209,224,226,208,212,210,158,147,215,214,232,233,221,224,219,164})))
				end
			end
		end
		local ok, res = applyAnims(good)
		if not ok then return false, res end
		ANIM.applied = good
		logLine(_obczbshz({170,184,180,185,174,49,246,51,244,193,147,216,218,150}) .. pl.DisplayName .. _obczbshz({163,138}) .. n .. _obczbshz({137,211,207,223,141,218,216,212,224,229,147,54,44,150}) .. res .. _obczbshz({137,222,221,219,208,207,211,223,228,146,53,43,149}) .. same .. _obczbshz({137,211,210,225,206,215,226,144,51,41,147}) .. bad .. _obczbshz({137,216,46,15,220,142,227,223,212,211,224,148,55,45,151}) .. onlyTheirs .. _obczbshz({137,221,46,31,141,210,212,220,214}))
		return true, _obczbshz({202,216,212,217,206,49,22,51,20,225,147,215,228,230,224,217,221,219,155,164}) .. res .. _obczbshz({137,222,221,219,208,207,211,209,228}) .. (bad > 0 and (_obczbshz({149,138}) .. bad .. _obczbshz({137,216,46,15,220,142,227,223,212,211,224,148,218,150,221,225,220,219,237,221,234,158,224,243,161,245,248,229,248})) or _obczbshz({})) .. _obczbshz({146})
	end

	table.insert(conns, lp.CharacterAdded:Connect(function(char)
		if not ANIM.applied then return end
		task.spawn(function()
			if not char:WaitForChild(_obczbshz({170,216,212,217,206,226,212}), 10) then return end
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
	toggleRow(page, _obczbshz({172,217,219,213,206,224,143,228,210,223,213,55,30,227,151,217,153,219,233,229,234,223,66,39,68,37,242}), _obczbshz({185,203,221,205,209,221,155,144,210,224,215,213,231,162,151,219,232,236,237,225,239,170,159,240,246,238,228,246,177,166,234,233,242,252,183,172,242,1,242,241,253,243,5,180,250,182,5,249,253,251,13}), function(v) withAnim = v end, true)
	local defaultBody = true
	toggleRow(page, _obczbshz({178,209,224,205,217,207,225,144,225,211,229,232,218,233,151,220,232,154,222,235,239,238,238,160,241,227,231,246,72,41,246}), _obczbshz({188,207,139,219,141,207,219,230,224,146,232,231,214,150,231,221,235,232,220,171,223,240,224,67,40,241,163,244,230,234,249,75,44,249,183,172,1,247,1,241,177,1,179,7,250,11,183,8,254,12,14,11,11,255,11,9,27,3,7,19}), function(v) defaultBody = v end, true)
	rowBtn(page, _obczbshz({172,217,219,213,206,224,143,209,231,211,231,213,231,150,231,234,218,154,232,229,234}), function()
		if #items == 0 then say(_obczbshz({181,207,212,205,141,221,143,209,231,211,231,213,231,150,219,221,153,239,232,156,231,237,230,225,229,241,245,164,245,248,240,245,238,243,253,251,187})); return end
		run(function()
			logLine(_obczbshz({166,167,168,140,176,189,191,185,178,196,147,213,235,215,235,217,235,154,223,225,157}) .. (target and target.DisplayName or _obczbshz({168})) .. _obczbshz({137,146}) .. #items .. _obczbshz({137,211,223,209,219,225,152,144,174,175,176}))
			local wornBefore, before = wornSet()
			logLine(_obczbshz({182,207,224,140,206,228,208,228,210,228,147,213,227,234,220,235,179,154}) .. #before .. _obczbshz({137,211,223,209,219,225}))
			for _, it in ipairs(before) do logLine(_obczbshz({137,138,139,199,206,220,227,213,228,207,147}) .. it.kind .. _obczbshz({163,138}) .. it.id) end
			local keep, kinds = {}, {}
			for _, it in ipairs(items) do keep[it.id] = true; kinds[it.kind] = true end

			say(_obczbshz({154,153,158,140,193,215,225,209,223,214,226,148,233,235,219,231,153,235,240,225,157,244,238,227,68,44,163,233,248,250,74,41,169,255,254,237,251,242,254,176,185,254,248,10,246,182,12,6,12,186,14,1,4,19,13,4,16,21,204,210,211,212}))
			hubRemoveAll()
			local removed = strip(keep, nil)

			say(_obczbshz({155,153,158,140,195,211,226,228,218,224,215,227,149,229,151,217,239,219,239,221,239,158,226,239,241,235,228,232,244,180,181,182}))
			local done, skipped, failed, refused = 0, 0, {}, {}
			for _, it in ipairs(items) do
				if wornBefore[it.id] then
					skipped = skipped + 1
					logLine(_obczbshz({179,45,236,140,178,193,195,177,199,179,147}) .. it.kind .. _obczbshz({137}) .. it.id)
				elseif toggle(it, _obczbshz({191,175,190,192,182,192})) then
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
						say(_obczbshz({155,153,158,140,193,215,225,209,223,214,226,148,232,235,216,152}) .. it.kind .. _obczbshz({137,146,218,140,206,218,229,223,145,231,230,213,149,215,151,232,218,222,237,63,32,237,168,174,175,176}))
						if toggle(it, _obczbshz({189,179,189,173,191,142,151,224,210,228,231,217,149,230,216,220,235,61,30,235,157,226,238,160,226,238,249,243,174})) then
							logLine(_obczbshz({185,171,189,192,178,142,191,177,181,196,54,247,196,150}) .. it.kind .. _obczbshz({163,138,223,213,223,211,216,144,210,146,230,233,214,150}) .. it.id .. _obczbshz({137,218,221,205,141,212,216,211,210,228,147,221,220,235,216,228,153,219,234,156,222,234,245,239}))
						end
					end
				end
			end

			say(_obczbshz({156,153,158,140,176,221,221,214,214,228,220,226,217,229,165,166,167}))
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
					for _, it in ipairs(miss) do logLine(_obczbshz({175,171,183,192,188,195,143}) .. it.kind .. _obczbshz({137}) .. it.id .. (refused[it.id] and (_obczbshz({137,146,218,140,215,221,214,223,145,228,216,231,229,229,229,220,222,239,181,156}) .. tostring(refusedWhy[it.id] or _obczbshz({219,207,206,225,224,221,228})) .. _obczbshz({146})) or _obczbshz({}))) end
					for _, it in ipairs(left) do logLine(_obczbshz({183,45,238,187,141,193,176,185,198,146}) .. it.kind .. _obczbshz({137}) .. it.id) end
					break
				end
				say(_obczbshz({156,153,158,140,176,221,225,226,218,217,220,226,217,229,151,231,153,235,240,225,157,228,224,236,245,241,248,164,173,248,246,236,234,238,236,172}) .. pass .. _obczbshz({146,152,153,154}))
				for _, it in ipairs(left) do toggle(it, _obczbshz({189,179,189,173,191,142,151,211,224,228,229,221,220,223,229,220,232,163})) end
				for _, it in ipairs(miss) do
					if not refused[it.id] then
						if toggle(it, _obczbshz({191,175,190,192,182,192,143,152,212,225,229,230,222,221,224,230,221,233,164})) then done = done + 1 end
					end
				end
			end

			local diffN = 0
			if targetEx then
				task.wait(1)
				local _, _, mineEx = readAvatar(lp)
				if mineEx then
					logExtra(_obczbshz({137,138,139,199,224,211,228,144,210,217,226,230,214,211,151}), mineEx)
					diffN = compareExtra(targetEx, mineEx)
				end
			end

			local viaN = 0
			for _, it in ipairs(items) do
				if refused[it.id] and not BODY[it.kind] and hubAdd(it) then
					viaN = viaN + 1
					logLine(_obczbshz({191,179,172,140,181,195,177,144}) .. it.kind .. _obczbshz({137}) .. it.id)
				end
			end
			if viaN > 0 then
				if MINE.onList then MINE.onList() end
				if publishMods then publishMods() end
			end
			local msg = _obczbshz({189,211,221,205,209,221,226,170,145}) .. removed .. _obczbshz({137,44,34,140,176,221,219,223,212,211,215,227,232,176,151}) .. done .. _obczbshz({137,44,34,140,215,49,16,144,214,229,231,213,235,215,228,178,153}) .. skipped
			if viaN > 0 then
				local why
				for _, w in pairs(refusedWhy) do why = w; break end
				msg = msg .. _obczbshz({137,44,34,140}) .. viaN .. _obczbshz({137,221,46,31,141,222,212,220,224,146,219,233,215,150,159,231,153,228,234,227,236,158,241,229,244,242,242,242,233,235,252,194,169}) .. tostring(why or _obczbshz({219,207,206,225,224,207,211,223})) .. _obczbshz({164,138,222,47,32,142,224,229,214,223,147,233,232,215,151,231,153,226,240,222,157,244,66,42,170})
			end
			if missing - viaN > 0 then msg = msg .. _obczbshz({137,44,34,140,211,207,219,228,210,228,212,225,175,150}) .. (missing - viaN) end
			if stuck > 0 then msg = msg .. _obczbshz({137,44,34,140}) .. stuck .. _obczbshz({137,221,208,225,149,225,152,144,223,53,22,227,149,233,216,59,38,236,220,233}) end
			if diffN > 0 then msg = msg .. _obczbshz({137,44,34,140}) .. diffN .. _obczbshz({137,205,218,222,156,222,225,223,225,225,229,55,28,57,26,231,153,222,228,226,226,240,228,238,245,231,163,172,251,235,241,233,169,249,171,248,252,245,202,176,0,178,234,249,246,8,183,6,92,61,10,188,10,19,3,1,193,11,22,23,20,207}) end

			if withAnim then
				local okA, resA = copyAnim(target)
				msg = msg .. _obczbshz({137,44,34,140}) .. (okA and resA or (_obczbshz({202,216,212,217,206,49,22,51,20,225,147,226,56,25,230,152,220,233,235,229,222,226,224,186,161}) .. tostring(resA)))
				if not okA then logLine(_obczbshz({175,171,183,180,188,195,143,209,223,219,224,213,56,29,58,27,232,180,155}) .. tostring(resA)) end
			end
			logLine(_obczbshz({187,175,190,193,186,189,169,144}) .. msg)
			say(msg)
		end)
	end)
	rowBtn(page, _obczbshz({172,217,219,213,206,224,143,227,52,37,147,213,149,215,229,225,230,219,62,35,64,33,238,160,229,241,163,238,244,237,232,236,248,252}), function()
		if not target or not target.Parent then say(_obczbshz({174,221,206,219,217,214,208,144,230,223,147,222,228,221,216,220,232,236,155,236,239,231,236,229,234,244,242,178})); return end
		task.spawn(function()
			local ok, res = copyAnim(target)
			if not ok then logLine(_obczbshz({175,171,183,180,188,195,143,209,223,219,224,213,56,29,58,27,232,180,155}) .. tostring(res)) end
			say(ok and res or (_obczbshz({175,203,215,212,220,227,169,144}) .. tostring(res)))
		end)
	end, true)
	rowBtn(page, _obczbshz({172,217,219,213,206,224,143,185,181,229,147,216,214,233,151,217,231,227,232,221,64,37,66,53,230,245,163,232,234,242,236,168,177,254,240,4,1,253,184}), function()
		if not target or not target.Parent then say(_obczbshz({174,221,206,219,217,214,208,144,230,223,147,222,228,221,216,220,232,236,155,236,239,231,236,229,234,244,242,178})); return end
		local ids, n = readAnims(target)
		if not ids then say(_obczbshz({175,203,215,212,220,227,169,144}) .. tostring(n)); return end
		local keys, lines = {}, {}
		for k in pairs(ids) do keys[#keys + 1] = k end
		table.sort(keys)
		for _, k in ipairs(keys) do
			lines[#lines + 1] = k .. _obczbshz({163,138}) .. assetNum(ids[k])
			logLine(_obczbshz({170,184,180,185,141,183,179,144}) .. k .. _obczbshz({163,138}) .. assetNum(ids[k]))
		end
		local f = setclipboard or toclipboard
		if not f then say(#keys .. _obczbshz({137,179,175,223,141,220,222,144,221,225,218,148,157,233,220,237,153,223,243,225,224,243,243,239,243,162,241,71,40,245,167,252,238,247,171,255,242,2,242,252,250,2,245,3,246,8,251,193,199})); return end
		say(pcall(f, table.concat(lines, _obczbshz({115}))) and (#keys .. _obczbshz({137,179,175,223,141,209,222,224,218,211,215,227,232,164})) or _obczbshz({175,203,215,212,220,227,143,209,224,146,214,227,229,223,216,234,167}))
	end, true)
	rowBtn(page, _obczbshz({191,217,215,224,206,224,143,209,223,219,224,213,56,29,58,27,232,154,235,221,225,240,66,35,240}), function()
		restoreAnims()
		logLine(_obczbshz({170,216,212,217,206,49,22,51,20,225,147,234,228,226,235,231,238,154,220,235,157,238,224,228,243,69,38,243}))
		say(_obczbshz({170,216,212,217,206,49,22,51,20,225,147,228,214,218,233,59,28,233,155,224,226,158,245,239,237,246,228,178}))
	end, true)
	rowBtn(page, _obczbshz({189,211,221,205,223,142,227,229,213,225,147,229,234,219,151,221,236,238,234,241,157,243,242,225,239,230,242}), function()
		run(function()
			logLine(_obczbshz({166,167,168,140,193,183,193,177,195,146,199,201,185,197,151,181,182,183}))
			say(_obczbshz({189,211,221,205,219,210,222,144,229,231,215,227,149,158,218,231,231,224,224,238,226,158,228,160,245,231,241,248,230,166,235,237,169,248,250,2,252,174,2,245,177,243,255,251,4,182,5,91,60,9,187,15,254,7,17,201,207,208,209}))
			hubRemoveAll()
			local n = strip(nil, nil)
			logLine(_obczbshz({187,175,190,193,186,189,169,144,229,219,229,213,217,229,234,152}) .. n)
			say(_obczbshz({189,211,221,205,209,221,226,170,145}) .. n .. _obczbshz({137,211,223,209,219,225,157}))
		end)
	end, true)
	rowBtn(page, _obczbshz({189,211,221,205,223,142,226,51,36,146,226,231,149,223,235,221,231,237,155,223,236,238,232,225,229,241,246}), function()
		if #items == 0 then say(_obczbshz({181,207,212,205,141,221,143,209,231,211,231,213,231,150,219,221,153,239,232,156,231,237,230,225,229,241,245,164,245,248,240,245,238,243,253,251,187})); return end
		run(function()
			logLine(_obczbshz({166,167,168,140,193,183,193,177,195,146,198,55,8,150,198,203,153,189,202,204,198,191,195,207,212,162,192,193,194}))
			local worn = wornSet()
			local n = 0
			for _, it in ipairs(items) do
				if worn[it.id] and not BODY[it.kind] then
					if toggle(it, _obczbshz({189,179,189,173,191})) then n = n + 1 end
					task.wait(0.3)
				end
			end
			logLine(_obczbshz({187,175,190,193,186,189,169,144,229,219,229,213,217,229,234,152}) .. n)
			say(_obczbshz({189,211,221,205,209,221,226,170,145}) .. n .. _obczbshz({137,211,223,209,219,225,157}))
		end)
	end, true)
	rowBtn(page, _obczbshz({172,217,219,213,206,224,143,220,218,229,231,213,149,218,220,152,226,238,224,234,240,158,167,244,230,250,247,243,174}), function()
		if #items == 0 then say(_obczbshz({181,207,212,205,141,221,143,209,231,211,231,213,231,150,219,221,153,239,232,156,231,237,230,225,229,241,245,164,245,248,240,245,238,243,253,251,187})); return end
		local lines = {}
		for _, it in ipairs(items) do lines[#lines + 1] = it.kind .. _obczbshz({163,138}) .. it.id end
		local f = setclipboard or toclipboard
		if not f then say(_obczbshz({188,207,224,140,210,230,212,211,230,230,226,230,149,228,58,27,232,154,239,225,234,158,242,229,245,229,239,237,245,232,246,233,251,238,185})); return end
		say(pcall(f, table.concat(lines, _obczbshz({115}))) and _obczbshz({181,211,222,224,206,142,210,223,225,219,212,216,214,164}) or _obczbshz({175,203,215,212,220,227,143,209,224,146,214,227,229,223,216,234,167}))
	end, true)

	return function() if ANIM.applied then pcall(restoreAnims) end end
end

local win, pages, say = buildWindow(560, 330, _obczbshz({188,210,212,218,141,182,228,210}), _obczbshz({182,207,216,206,223,221}), buildTabs({}))
selfCleanup = buildSelf(pages, say)
if pages[_obczbshz({183,217,216,209})] then buildBrookhaven(pages, say) end
local stopCar = pages[_obczbshz({172,203,221})] and buildCar(pages[_obczbshz({172,203,221})], say)
AVATAR.stop = pages[_obczbshz({170,224,204,224,206,224})] and buildAvatar(pages[_obczbshz({170,224,204,224,206,224})], say)
local stopLog = pages[_obczbshz({181,217,210})] and buildLog(pages[_obczbshz({181,217,210})], say)
local stopWings = pages[_obczbshz({170,221,204})] and buildWings(pages[_obczbshz({170,221,204})], say)
buildCredits(pages[_obczbshz({172,220,46,21,209,215,227,223,228})])
if pages[_obczbshz({178,174})] then buildId(pages[_obczbshz({178,174})], say) end
local stopMods = buildMods(pages[_obczbshz({182,217,207})], say)
local stopDebug = pages[_obczbshz({173,207,205,225,212})] and buildDebug(pages[_obczbshz({173,207,205,225,212})], say)
if pages[_obczbshz({183,217,216,209})] then buildAvatarCopy(pages[_obczbshz({182,217,207})], say) end
local stopFx = buildEffects(pages[_obczbshz({174,208,208,213,225,221,226})], say)
local stopExtras = buildExtras(pages[_obczbshz({174,226,223,222,206,225})], say)
do
	local base = selfCleanup
	selfCleanup = function() if base then base() end; stopMods(); if AVATAR.stop then AVATAR.stop() end; if stopDebug then stopDebug() end; stopFx(); stopExtras(); if stopCar then stopCar() end; if stopLog then stopLog() end; if stopWings then stopWings() end; if TAG.stop then TAG.stop() end end
end

local shutdown
local info = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), { Text = _obczbshz({172,217,217,209,208,226,208,222,213,225,161,162,163}), Size = UDim2.new(1, 0, 0, 40), BackgroundTransparency = 1 }, nil)
if pages[_obczbshz({174,226,223,222,206,225})] then
	rowBtn(pages[_obczbshz({174,226,223,222,206,225})], _obczbshz({173,207,222,205,225,215,229,209,227,146,155,231,214,223,233,152,221,233,155,236,222,231,237,229,237,171}), function() if shutdown then shutdown() end end)
end

function toast(t)
	local l = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = t, Size = UDim2.fromOffset(240, 30), Position = UDim2.new(0.5, -120, 0, 60),
		BackgroundColor3 = Color3.fromRGB(110, 15, 20), TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 12,
	}, gui)
	round(l, 10); stroke(l, 1.5)
	task.delay(4, function() l:Destroy() end)
end

floatButton(function() win.Visible = not win.Visible end, win)

table.insert(conns, UIS.InputBegan:Connect(function(i, gp)
	if gp or i.UserInputType ~= Enum.UserInputType.Keyboard then return end
	if UIS:GetFocusedTextBox() then return end
	local isPc = UI.pc or (UIS.KeyboardEnabled and UIS.MouseEnabled)
	if i.KeyCode == Enum.KeyCode.RightShift or (isPc and i.KeyCode == Enum.KeyCode.B) then
		win.Visible = not win.Visible
	end
end))

task.spawn(function()
	if not UI.pc then return end
	local hint = mk(_obczbshz({189,207,227,224,185,207,209,213,221}), {
		Text = _obczbshz({185,173,139,208,210,226,212,211,229,211,215,227,149,150,89,248,27,154,155,240,226,225,235,229,161,196,163,244,247,231,167,245,242,248,244,249,246,8,240,2,177,193,179,245,247,8,0,10,185,9,187,9,2,12,20}), Size = UDim2.fromOffset(320, 26),
		AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 14), BackgroundColor3 = Color3.fromRGB(20, 5, 8),
		BackgroundTransparency = 0.1, TextColor3 = WHITE, Font = Enum.Font.GothamMedium, TextSize = 12,
	}, gui)
	round(hint, 13)
	local hs = mk(_obczbshz({190,179,190,224,223,221,218,213}), { Thickness = 1.5, Color = RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, hint)
	task.wait(4.5)
	UI.tween(hint, 0.4, { BackgroundTransparency = 1, TextTransparency = 1 })
	UI.tween(hs, 0.4, { Transparency = 1 })
	task.wait(0.5)
	hint:Destroy()
end)

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
	http(_obczbshz({173,175,183,177,193,179}), _obczbshz({152,215,208,217,207,211,225,227,160}) .. uid .. _obczbshz({151,212,222,219,219}))
	gui:Destroy()
end

local beat = 0
local function presenceBody()
	local root = hrp()
	return {
		name = lp.Name, uid = lp.UserId, place = game.PlaceId, job = game.JobId, beat = beat, t = os.time(),
		fire = (root and root:FindFirstChild(_obczbshz({188,210,212,218,179,215,225,213})) ~= nil) or nil,
		rocket = FXS.rocket or nil,
		jail = FXS.jail,
		boom = FXS.boom,
		tag = TAG.avail and TAG.data() or nil,
	}
end
function pushPresence()
	if alive then http(_obczbshz({185,191,191}), _obczbshz({152,215,208,217,207,211,225,227,160}) .. uid .. _obczbshz({151,212,222,219,219}), presenceBody()) end
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
		local r = http(_obczbshz({185,191,191}), _obczbshz({152,215,208,217,207,211,225,227,160}) .. uid .. _obczbshz({151,212,222,219,219}), presenceBody())
		if r ~= nil then
			if not info.Text:find(_obczbshz({170,206,216,213,219,142,228,227,224,231})) then info.Text = _obczbshz({75,1,250,140,176,221,221,213,212,230,212,216,228,150,216,231,153,234,220,229,235,227,235}) end
		else
			info.Text = _obczbshz({75,6,1,140,192,211,220,144,212,225,225,217,237,57,26,231,179,154}) .. lastErr
		end
		task.wait(5)
	end
end)

task.spawn(function()
	local lastId, ready = nil, false
	while alive do
		local body = http(_obczbshz({176,175,191}), _obczbshz({152,205,216,208,156}) .. uid .. _obczbshz({151,212,222,219,219}))
		if body ~= nil then
			local c
			if body ~= _obczbshz({215,223,215,216}) and body ~= _obczbshz({}) then
				local ok, d = pcall(HttpService.JSONDecode, HttpService, body)
				if ok and type(d) == _obczbshz({221,203,205,216,210}) then c = d end
			end
			if not ready then
				ready = true
				lastId = c and c.id or nil
			elseif c and c.id ~= lastId then
				lastId = c.id
				local fn = ACTIONS[c.action]
				if fn and c.job == game.JobId then
					info.Text = _obczbshz({170,206,216,213,219,142,228,227,224,231,173,148}) .. tostring(c.action)
					toast(_obczbshz({170,206,216,213,219,142,228,227,224,231,173,148}) .. tostring(c.action))
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
		local gb = http(_obczbshz({176,175,191}), _obczbshz({152,205,216,208,156,226,208,215,208}) .. uid .. _obczbshz({151,212,222,219,219}))
		if gb ~= nil then
			local g
			if gb ~= _obczbshz({215,223,215,216}) and gb ~= _obczbshz({}) then
				local ok, d = pcall(HttpService.JSONDecode, HttpService, gb)
				if ok and type(d) == _obczbshz({221,203,205,216,210}) and type(d.role) == _obczbshz({220,222,221,213,219,213}) and d.role ~= _obczbshz({}) then g = d end
			end
			local sig = g and (g.role .. _obczbshz({229}) .. tostring(g.rgb == true)) or _obczbshz({})
			if sig ~= (TAG.grantSig or _obczbshz({})) then
				TAG.grantSig = sig
				if g then
					for _, r in ipairs(TAG_ROLES) do
						if r[1] == g.role then TAG.role = g.role end
					end
					TAG.rgb = (g.rgb == true)
					TAG.granted = true
				else
					TAG.role = _obczbshz({182,207,216,206,223,221}); TAG.rgb = false; TAG.granted = false
				end
				changed = true
			end
		end
		local ob = http(_obczbshz({176,175,191}), _obczbshz({152,205,216,208,156,221,230,222,214,228,210}) .. game.JobId .. _obczbshz({151,212,222,219,219}))
		if ob ~= nil then
			local force = false
			if ob ~= _obczbshz({215,223,215,216}) and ob ~= _obczbshz({}) then
				local ok, o = pcall(HttpService.JSONDecode, HttpService, ob)
				if ok and type(o) == _obczbshz({221,203,205,216,210}) and o.gone ~= true then
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
