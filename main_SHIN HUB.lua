-- Shin Hub | MEMBRO v2
-- Só funciona se a pessoa aceitar o aviso. Os comandos do admin são FIXOS (lista ACTIONS).
local DB = "https://site-0ds-default-rtdb.firebaseio.com"
local BG_URL = "https://i.postimg.cc/50Wf56pX/e288c5a05c52f160f09a367703e89231.jpg"
local ICON_URL = "https://i.postimg.cc/R0HMnc77/85b8ac8bcf9f322d967a6ed4b5e8bf6b.jpg" -- foto do botão flutuante
local FOLDER = "MeuHub"

-- Scripts que aparecem no menu: { "Nome", "link do script", "Grupo (opcional)" }
local SCRIPTS = {
	{ "Emotes", "https://api.rubis.app/v2/scrap/qehrlb7Oh8oLOgu3/raw", "Emotes Scripts" },
	{ "VR", "https://rawscripts.net/raw/Natural-Disaster-Survival-FE-Fake-VR-Natural-Disaster-Keyless-241098", "Random Scripts" },
	{ "Brookhaven", "https://rawscripts.net/raw/Brookhaven-RP-Slayer-Hub-246319", "Scripts" },
}

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local req = request or http_request or (syn and syn.request)

-- ===== HTTP (mostra o erro real) =====
local lastErr = ""
local function http(method, path, body)
	if not req then lastErr = "executor sem request()"; return nil end
	local ok, res = pcall(req, {
		Url = DB .. path, Method = method,
		Headers = { ["Content-Type"] = "application/json" },
		Body = body and HttpService:JSONEncode(body) or nil,
	})
	if not ok then lastErr = tostring(res):sub(1, 60); return nil end
	local code = res.StatusCode or 0
	if res.Success or code == 200 then lastErr = ""; return res.Body or "" end
	lastErr = "HTTP " .. tostring(code) .. " " .. tostring(res.Body or ""):sub(1, 50)
	return nil
end

-- ===== UI helpers =====
local RED = Color3.fromRGB(220, 30, 40)
local PANEL = Color3.fromRGB(22, 5, 7)
local WHITE = Color3.new(1, 1, 1)
local function mk(class, props, par)
	local o = Instance.new(class)
	for k, v in pairs(props) do o[k] = v end
	o.Parent = par
	return o
end
local function round(o, r) mk("UICorner", { CornerRadius = UDim.new(0, r or 8) }, o) end
local function stroke(o, th, col)
	mk("UIStroke", { Thickness = th or 1.5, Color = col or RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, o)
end
local function fetchAsset(url, name)
	local ok, res = pcall(function()
		if not isfolder(FOLDER) then makefolder(FOLDER) end
		local path = FOLDER .. "/" .. name
		if not isfile(path) then writefile(path, game:HttpGet(url)) end
		return getcustomasset(path)
	end)
	return ok and res or nil
end

local parent = (gethui and gethui()) or game:GetService("CoreGui")
local old = parent:FindFirstChild("MeuHubMembro")
if old then old:Destroy() end
local gui = mk("ScreenGui", { Name = "MeuHubMembro", ResetOnSpawn = false }, parent)

local function isPress(i)
	return i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch
end
local function isMove(i)
	return i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch
end

-- arrasta "target" segurando "handle"; se só tocar (sem arrastar) chama onTap
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
	local f = mk("Frame", {
		Size = UDim2.fromOffset(w, h), Position = pos,
		BackgroundColor3 = Color3.fromRGB(6, 1, 2), ClipsDescendants = true,
	}, gui)
	round(f, 22); stroke(f, 2.5)
	local img = mk("ImageLabel", {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		ScaleType = Enum.ScaleType.Crop, ImageTransparency = 0.45,
	}, f)
	round(img, 22)
	local shade = mk("Frame", {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(25, 0, 3),
		BackgroundTransparency = 0.7, BorderSizePixel = 0,
	}, f)
	round(shade, 22)
	task.spawn(function() local a = fetchAsset(BG_URL, "bg.jpg"); if a then img.Image = a end end)
	return f
end
local function bigBtn(par, text, pos, size, filled)
	local b = mk("TextButton", {
		Text = text, Position = pos, Size = size,
		BackgroundColor3 = filled and RED or PANEL, BackgroundTransparency = filled and 0 or 0.1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 14,
	}, par)
	round(b, 20); stroke(b, 2)
	return b
end

-- janela com menu lateral (estilo hub): abas à esquerda, conteúdo à direita
local ICONS = {
	["Scripts"] = "◆", ["Brookhaven"] = "◇", ["Natural Disaster"] = "▲", ["Mod"] = "★", ["Efeitos"] = "●",
	["Extras"] = "■", ["Conexão"] = "▼", ["Créditos"] = "☆", ["Admin"] = "◀", ["Proteções"] = "◈", ["Movimento"] = "▶",
	["Nome"] = "▣", ["Música"] = "♪", ["Tag"] = "✦",
}
local function buildWindow(w, h, title, sub, tabNames, onClose)
	local win = panel(w, h, UDim2.new(0.5, -w / 2, 0.5, -h / 2))
	local top = mk("Frame", { Size = UDim2.new(1, 0, 0, 42), BackgroundTransparency = 1 }, win)
	mk("TextLabel", {
		Text = title .. '  <font size="11" color="rgb(230,120,120)">' .. sub .. '</font>', RichText = true,
		Size = UDim2.new(1, -140, 1, 0), Position = UDim2.fromOffset(22, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left,
	}, top)
	makeDraggable(top, win)

	local statusLbl = mk("TextLabel", {
		Position = UDim2.new(0, 170, 1, -26), Size = UDim2.new(1, -184, 0, 20), BackgroundTransparency = 1,
		Text = "", TextColor3 = Color3.fromRGB(240, 210, 210), Font = Enum.Font.Gotham,
		TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
	}, win)

	local side = mk("ScrollingFrame", {
		Position = UDim2.fromOffset(10, 46), Size = UDim2.new(0, 150, 1, -56), BackgroundTransparency = 1,
		BorderSizePixel = 0, ScrollBarThickness = 2, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(),
	}, win)
	mk("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, side)
	mk("UIPadding", { PaddingTop = UDim.new(0, 2), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4) }, side)

	local pages, tabBtns, bars = {}, {}, {}
	local function selectTab(name)
		for n, p in pairs(pages) do p.Visible = (n == name) end
		for n, b in pairs(tabBtns) do
			b.BackgroundColor3 = (n == name) and Color3.fromRGB(70, 10, 14) or PANEL
			bars[n].Visible = (n == name)
		end
	end
	for _, name in ipairs(tabNames) do
		local b = mk("TextButton", {
			Text = "", Size = UDim2.new(1, 0, 0, 28),
			BackgroundColor3 = PANEL, BackgroundTransparency = 0.1,
		}, side)
		round(b, 14); stroke(b, 1.5)
		mk("TextLabel", {
			Text = ICONS[name] or "◆", Size = UDim2.fromOffset(22, 28), Position = UDim2.fromOffset(12, 0),
			BackgroundTransparency = 1, TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 14,
		}, b)
		mk("TextLabel", {
			Text = name, Size = UDim2.new(1, -46, 1, 0), Position = UDim2.fromOffset(38, 0),
			BackgroundTransparency = 1, TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		}, b)
		local bar = mk("Frame", { Size = UDim2.fromOffset(3, 14), Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = RED, Visible = false }, b)
		round(bar, 2)
		local p = mk("ScrollingFrame", {
			Position = UDim2.fromOffset(170, 46), Size = UDim2.new(1, -182, 1, -76), BackgroundTransparency = 1,
			BorderSizePixel = 0, ScrollBarThickness = 3, AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(), Visible = false,
		}, win)
		mk("UIListLayout", { Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, p)
		mk("UIPadding", { PaddingTop = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8) }, p)
		pages[name], tabBtns[name], bars[name] = p, b, bar
		b.MouseButton1Click:Connect(function() selectTab(name) end)
	end
	selectTab(tabNames[1])

	-- botões do topo: engrenagem (abre "Extras"), minimizar e fechar
	local function topBtn(txt, x, size, cb)
		local t = mk("TextButton", {
			Text = txt, Size = UDim2.fromOffset(30, 30), Position = UDim2.new(1, x, 0, 6), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = size,
		}, top)
		t.MouseButton1Click:Connect(cb)
		return t
	end
	topBtn("⚙", -108, 20, function() if pages["Extras"] then selectTab("Extras") end end)
	topBtn("—", -74, 16, function() win.Visible = false end)
	topBtn("X", -40, 15, function() if onClose then onClose() else win.Visible = false end end)

	return win, pages, function(t) statusLbl.Text = t end
end

-- botão flutuante pequeno (clica = abre/minimiza o menu)
local function floatButton(onTap)
	local b = mk("ImageButton", {
		Size = UDim2.fromOffset(36, 36), Position = UDim2.fromOffset(10, 8),
		BackgroundColor3 = PANEL, AutoButtonColor = false, ScaleType = Enum.ScaleType.Crop, Image = "",
	}, gui)
	mk("UICorner", { CornerRadius = UDim.new(1, 0) }, b) -- redondo
	stroke(b, 2, RED)
	local fallback = mk("TextLabel", {
		Text = "M", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 17,
	}, b)
	if ICON_URL:find("^http") then
		task.spawn(function()
			local a = fetchAsset(ICON_URL, "icon.png")
			if a then b.Image = a; fallback.Visible = false end
		end)
	end
	makeDraggable(b, b, onTap)
	return b
end

-- linhas / seções das páginas
local function section(par, text)
	mk("TextLabel", {
		Text = text, Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, TextColor3 = WHITE,
		Font = Enum.Font.Gotham, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left,
	}, par)
end
local function rowBtn(par, text, cb, compact)
	local hgt = compact and 34 or 42
	local b = mk("TextButton", { Text = "", Size = UDim2.new(1, 0, 0, hgt), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, par)
	round(b, math.floor(hgt / 2)); stroke(b, compact and 1.5 or 2)
	mk("TextLabel", {
		Text = text, Size = UDim2.new(1, -48, 1, 0), Position = UDim2.fromOffset(compact and 14 or 16, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = compact and 12 or 13, TextXAlignment = Enum.TextXAlignment.Left,
	}, b)
	mk("TextLabel", {
		Text = "›", Size = UDim2.fromOffset(30, hgt), Position = UDim2.new(1, compact and -36 or -40, 0, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = compact and 22 or 26,
	}, b)
	b.MouseButton1Click:Connect(cb)
	return b
end
local DARK = Color3.fromRGB(40, 8, 10)
local function toggleRow(par, text, desc, onChange, initial)
	if type(desc) == "function" then initial = onChange; onChange, desc = desc, nil end
	local state = initial and true or false
	local b = mk("TextButton", { Text = "", Size = UDim2.new(1, 0, 0, desc and 50 or 42), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, par)
	round(b, 21); stroke(b, 2)
	mk("TextLabel", {
		Text = text, Size = UDim2.new(1, -84, 0, desc and 26 or 42), Position = UDim2.fromOffset(16, desc and 3 or 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
	}, b)
	if desc then
		mk("TextLabel", {
			Text = desc, Size = UDim2.new(1, -84, 0, 16), Position = UDim2.fromOffset(16, 29), BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(220, 140, 140), Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left,
		}, b)
	end
	local sw = mk("Frame", { Size = UDim2.fromOffset(48, 26), Position = UDim2.new(1, -62, 0.5, -13), BackgroundColor3 = DARK }, b)
	round(sw, 13); stroke(sw, 2)
	local knob = mk("Frame", { Size = UDim2.fromOffset(20, 20), Position = UDim2.fromOffset(3, 3), BackgroundColor3 = WHITE, BackgroundTransparency = 1 }, sw)
	round(knob, 10)
	local ks = mk("UIStroke", { Thickness = 2, Color = RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, knob)
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
	local b = mk("Frame", { Size = UDim2.new(1, 0, 0, 50), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, par)
	round(b, 21); stroke(b, 2)
	mk("TextLabel", {
		Text = text, Size = UDim2.new(0.5, -16, 0, 26), Position = UDim2.fromOffset(16, 3), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
	}, b)
	mk("TextLabel", {
		Text = desc, Size = UDim2.new(0.5, -16, 0, 16), Position = UDim2.fromOffset(16, 29), BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(220, 140, 140), Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left,
	}, b)
	local val = mk("TextLabel", {
		Text = tostring(defV), Size = UDim2.fromOffset(30, 50), Position = UDim2.new(0.5, 0, 0, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 13,
	}, b)
	local hit = mk("Frame", { Size = UDim2.new(0.5, -52, 0, 28), Position = UDim2.new(0.5, 34, 0.5, -14), BackgroundTransparency = 1 }, b)
	local bar = mk("Frame", { Size = UDim2.new(1, 0, 0, 8), Position = UDim2.new(0, 0, 0.5, -4), BackgroundColor3 = DARK }, hit)
	round(bar, 4); stroke(bar, 1.5)
	local fill = mk("Frame", { Size = UDim2.new((defV - minV) / (maxV - minV), 0, 1, 0), BackgroundColor3 = RED }, bar)
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
		mk("TextLabel", {
			Text = text, Size = UDim2.new(1, 0, 0, h or 24), BackgroundTransparency = 1,
			TextColor3 = col or WHITE, Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham, TextSize = size,
			TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end
	section(page, "Créditos")
	lbl("Feito por 0Ds", 15, true)
	lbl("Nick: elitefroster", 13, false)
	lbl("", 8, false, WHITE, 10)
	lbl("⚠ Aviso: o hub não está 100% pronto e o andar sobre a água não funciona.", 12, true, Color3.fromRGB(255, 190, 120), 44)
end

-- ===== Efeitos compartilhados (todos que usam o hub veem, admin e membro) =====
local COLORS = {
	{ "Vermelho", Color3.fromRGB(255, 40, 50) }, { "Azul", Color3.fromRGB(60, 140, 255) },
	{ "Verde", Color3.fromRGB(60, 255, 120) }, { "Roxo", Color3.fromRGB(170, 70, 255) },
	{ "Rosa", Color3.fromRGB(255, 90, 200) }, { "Amarelo", Color3.fromRGB(255, 220, 60) },
	{ "Branco", Color3.fromRGB(255, 255, 255) },
}
local STAR_TEX = "rbxasset://textures/particles/sparkles_main.dds"
local FX_KEYS = { "fire", "smoke", "sparkles", "stars", "trail", "aura", "light", "rainbow", "neon", "rainbowBody", "ghost" }
local FX_REG = setmetatable({}, { __mode = "k" }) -- personagem -> { list, body, set }
local MINE = { ids = {}, headless = false, fx = nil, fc = 1 }
local publishMods

-- (re)aplica no personagem só os efeitos da lista "set" (tabela chave -> true). Lista vazia = limpa tudo.
local function fxApply(char, set, ci)
	if not (char and char.Parent) then return end
	local rec = FX_REG[char]
	if not rec then rec = { list = {}, body = {} }; FX_REG[char] = rec end
	for _, o in ipairs(rec.list) do pcall(function() o:Destroy() end) end
	rec.list, rec.body = {}, {}
	rec.set = set
	local k = (COLORS[ci] or COLORS[1])[2]
	local r = char:FindFirstChild("HumanoidRootPart")
	local function add(inst, par)
		inst:SetAttribute("DsFx", true)
		inst.Parent = par
		table.insert(rec.list, inst)
		return inst
	end
	if r then
		if set.fire then add(mk("Fire", { Color = k, SecondaryColor = k, Size = 7, Heat = 9 }), r) end
		if set.smoke then add(mk("Smoke", { Color = k, Size = 4, Opacity = 0.4, RiseVelocity = 3 }), r) end
		if set.sparkles then add(mk("Sparkles", { SparkleColor = k }), r) end
		if set.stars then
			add(mk("ParticleEmitter", {
				Texture = STAR_TEX, Rate = 30, Lifetime = NumberRange.new(1, 2), Speed = NumberRange.new(2, 5),
				SpreadAngle = Vector2.new(180, 180), Color = ColorSequence.new(k), LightEmission = 1,
				Size = NumberSequence.new(0.5, 0),
			}), r)
		end
		if set.trail then
			local a0 = add(mk("Attachment", { Position = Vector3.new(0, 1.2, 0) }), r)
			local a1 = add(mk("Attachment", { Position = Vector3.new(0, -1.2, 0) }), r)
			add(mk("Trail", {
				Attachment0 = a0, Attachment1 = a1, Lifetime = 0.8, LightEmission = 1, Color = ColorSequence.new(k),
				Transparency = NumberSequence.new(0.1, 1),
			}), r)
		end
		if set.light then add(mk("PointLight", { Color = k, Range = 18, Brightness = 3 }), r) end
	end
	if set.aura then
		add(mk("Highlight", { Adornee = char, FillColor = k, OutlineColor = k, FillTransparency = 0.65, OutlineTransparency = 0 }), char)
	end
	-- corpo: neon / fantasma / arco-íris (guarda o original e restaura ao desligar)
	for _, p in ipairs(char:GetDescendants()) do
		if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" and not p:GetAttribute("DsFx") then
			if set.neon then
				if p:GetAttribute("DsOM") == nil then p:SetAttribute("DsOM", p.Material.Name) end
				p.Material = Enum.Material.Neon
			elseif p:GetAttribute("DsOM") then
				p.Material = Enum.Material[p:GetAttribute("DsOM")]; p:SetAttribute("DsOM", nil)
			end
			if set.ghost then
				if p:GetAttribute("DsOT") == nil then p:SetAttribute("DsOT", p.Transparency) end
				p.Transparency = math.max(p:GetAttribute("DsOT"), 0.65)
			elseif p:GetAttribute("DsOT") then
				p.Transparency = p:GetAttribute("DsOT"); p:SetAttribute("DsOT", nil)
			end
			if set.rainbowBody then
				if p:GetAttribute("DsOC") == nil then p:SetAttribute("DsOC", p.Color) end
				table.insert(rec.body, p)
			elseif p:GetAttribute("DsOC") then
				p.Color = p:GetAttribute("DsOC"); p:SetAttribute("DsOC", nil)
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
						if o:IsA("Highlight") then o.FillColor = c; o.OutlineColor = c
						elseif o:IsA("Fire") then o.Color = c; o.SecondaryColor = c
						elseif o:IsA("Smoke") then o.Color = c
						elseif o:IsA("Sparkles") then o.SparkleColor = c
						elseif o:IsA("PointLight") then o.Color = c
						elseif o:IsA("Trail") or o:IsA("ParticleEmitter") then o.Color = ColorSequence.new(c) end
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
		if #mine.ids == 0 and not mine.headless and not mine.fx and not mine.tag then
			http("DELETE", "/mods/" .. uid .. ".json")
		else
			http("PUT", "/mods/" .. uid .. ".json", {
				name = lp.Name, ids = table.concat(mine.ids, ","), headless = mine.headless,
				fx = mine.fx or "", fc = mine.fc or 1, tag = mine.tag,
			})
		end
	end
	publishMods = publish

	-- carrega o item pelo ID e remove qualquer script de dentro (só visual)
	local function loadAsset(id)
		if cache[id] ~= nil then return cache[id] or nil end
		local objs
		local ok, res = pcall(function() return game:GetObjects("rbxassetid://" .. id) end)
		if ok and type(res) == "table" then
			objs = res
		else
			local ok2, m = pcall(function() return game:GetService("InsertService"):LoadAsset(id) end)
			if ok2 and m then objs = m:GetChildren() end
		end
		if objs then
			for _, o in ipairs(objs) do
				for _, d in ipairs(o:GetDescendants()) do
					if d:IsA("LuaSourceContainer") or d:IsA("Sound") then d:Destroy() end
				end
			end
		end
		cache[id] = objs or false
		return objs
	end

	local function limb(char, mp)
		if mp:FindFirstAncestorOfClass("Accessory") then return end
		local t = char:FindFirstChild(mp.Name)
		if not (t and t:IsA("BasePart")) or t:GetAttribute("DsMod") then return end
		local c = mp:Clone()
		c:ClearAllChildren()
		c.Anchored = false; c.CanCollide = false; c.Massless = true
		c.CFrame = t.CFrame
		c:SetAttribute("DsMod", true)
		c.Parent = char
		local w = Instance.new("WeldConstraint")
		w.Part0 = c; w.Part1 = t; w.Parent = c
		t.Transparency = 1
		t:SetAttribute("DsHidLimb", true)
	end

	local EFX = { ParticleEmitter = true, Fire = true, Smoke = true, Sparkles = true, PointLight = true, SpotLight = true, SurfaceLight = true }

	-- guarda (em vez de apagar) as roupas originais; clearMods devolve tudo
	local function stash(char, class)
		local st = char:FindFirstChild("DsStash")
		if not st then
			st = Instance.new("Folder"); st.Name = "DsStash"; st.Parent = char
		end
		for _, o in ipairs(char:GetChildren()) do
			if o:IsA(class) and not o:GetAttribute("DsMod") then o.Parent = st end
		end
	end

	-- item solto (modelo/peça): gruda no seu personagem sem colisão
	local function attachProp(char, src)
		local r = char:FindFirstChild("HumanoidRootPart")
		if not r then return end
		local c = src:Clone()
		for _, d in ipairs(c:GetDescendants()) do
			if d:IsA("Humanoid") or d:IsA("Animator") then d:Destroy() end
		end
		local parts = {}
		if c:IsA("BasePart") then table.insert(parts, c) end
		for _, d in ipairs(c:GetDescendants()) do
			if d:IsA("BasePart") then table.insert(parts, d) end
		end
		if #parts == 0 or #parts > 200 then c:Destroy(); return end
		for _, p in ipairs(parts) do
			p.Anchored = false; p.CanCollide = false; p.Massless = true
		end
		c:SetAttribute("DsMod", true)
		c.Parent = char
		if c:IsA("Model") then c:PivotTo(r.CFrame) else c.CFrame = r.CFrame end
		for _, p in ipairs(parts) do
			local w = Instance.new("WeldConstraint")
			w.Part0 = p; w.Part1 = r; w.Parent = p
		end
	end

	-- aplica qualquer item visual: acessórios, roupas, cores, rosto, partes do corpo,
	-- props soltos e efeitos (partículas, fogo, fumaça, brilho, luzes, rastro, feixes)
	local function handle(char, hm, r, o)
		if o:IsA("Accessory") then
			if hm then
				local c = o:Clone(); c:SetAttribute("DsMod", true); hm:AddAccessory(c)
			end
			return true
		elseif o:IsA("Shirt") or o:IsA("Pants") or o:IsA("ShirtGraphic") or o:IsA("BodyColors") then
			stash(char, o.ClassName)
			local c = o:Clone(); c:SetAttribute("DsMod", true); c.Parent = char
			return true
		elseif o:IsA("CharacterMesh") then
			local c = o:Clone(); c:SetAttribute("DsMod", true); c.Parent = char
			return true
		elseif o:IsA("Decal") then
			local head = char:FindFirstChild("Head")
			if head then
				for _, d in ipairs(head:GetChildren()) do
					if d:IsA("Decal") and not d:GetAttribute("DsMod") and not d:GetAttribute("DsHidDecal") then
						d.Transparency = 1; d:SetAttribute("DsHidDecal", true)
					end
				end
				local c = o:Clone(); c.Face = Enum.NormalId.Front; c:SetAttribute("DsMod", true); c.Parent = head
			end
			return true
		elseif EFX[o.ClassName] then
			if r then
				local c = o:Clone(); c:SetAttribute("DsMod", true); c.Parent = r
			end
			return true
		elseif o:IsA("MeshPart") and char:FindFirstChild(o.Name) and char[o.Name]:IsA("BasePart") then
			limb(char, o)
			return true
		elseif o:IsA("Model") or o:IsA("Folder") then
			local any = false
			for _, ch in ipairs(o:GetChildren()) do
				if handle(char, hm, r, ch) then any = true end
			end
			if not any and o:IsA("Model") then
				attachProp(char, o)
				any = true
			end
			return any
		elseif o:IsA("BasePart") then
			if char:FindFirstChild(o.Name) then return false end
			attachProp(char, o)
			return true
		end
		return false
	end

	local function applyOne(char, id)
		local objs = loadAsset(id)
		if not objs then return end
		local hm = char:FindFirstChildOfClass("Humanoid")
		local r = char:FindFirstChild("HumanoidRootPart")
		for _, o in ipairs(objs) do
			pcall(handle, char, hm, r, o)
		end
	end

	local function clearMods(char)
		local st = char:FindFirstChild("DsStash")
		if st then
			for _, o in ipairs(st:GetChildren()) do o.Parent = char end
			st:Destroy()
		end
		for _, o in ipairs(char:GetDescendants()) do
			if o:GetAttribute("DsMod") then
				o:Destroy()
			elseif o:GetAttribute("DsHidLimb") then
				o.Transparency = 0; o:SetAttribute("DsHidLimb", nil)
			elseif o:GetAttribute("DsHidDecal") then
				o.Transparency = 0; o:SetAttribute("DsHidDecal", nil)
			end
		end
	end

	local function headless(char)
		local head = char:FindFirstChild("Head")
		if not head then return end
		head.Transparency = 1; head:SetAttribute("DsHidLimb", true)
		for _, d in ipairs(head:GetChildren()) do
			if d:IsA("Decal") then d.Transparency = 1; d:SetAttribute("DsHidDecal", true) end
		end
	end

	-- aplica (só visualmente, no seu aparelho) os mods de todo mundo que está com o hub ativo
	local function sync()
		local body = http("GET", "/mods.json")
		if body == nil then return end
		local data = {}
		if body ~= "null" and body ~= "" then
			local ok, d = pcall(HttpService.JSONDecode, HttpService, body)
			if ok and type(d) == "table" then data = d end
		end
		for _, pl in ipairs(Players:GetPlayers()) do
			local char = pl.Character
			if char and char:FindFirstChildOfClass("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
				local d = data[tostring(pl.UserId)]
				local want = d and (tostring(d.ids or "") .. "|" .. tostring(d.headless == true) .. "|" .. tostring(d.fx or "") .. "|" .. tostring(d.fc or 1)) or nil
				if char:GetAttribute("DsSig") ~= want then
					clearMods(char)
					if pl ~= lp then
						local set = {}
						if d then
							for k in tostring(d.fx or ""):gmatch("%a+") do set[k] = true end
						end
						pcall(fxApply, char, set, tonumber(d and d.fc) or 1)
					end
					if d then
						if d.headless == true then headless(char) end
						local n = 0
						for id in tostring(d.ids or ""):gmatch("%d+") do
							n = n + 1
							if n > 8 then break end
							pcall(applyOne, char, tonumber(id))
						end
					end
					char:SetAttribute("DsSig", want)
				end
				if pl ~= lp then pcall(tagDraw, char, d and type(d.tag) == "table" and d.tag or nil, "DsTagB") end
			end
		end
	end
	task.spawn(function()
		while alive do pcall(sync); task.wait(3) end
	end)

	-- UI da aba Mod
	section(page, "Mod personalizado")
	mk("TextLabel", {
		Text = "Cole o ID de qualquer item visual do catálogo (acessório, roupa, pacote, partes do corpo, rosto ou efeito). Scripts e sons são removidos. Todos que usam o hub veem.",
		Size = UDim2.new(1, 0, 0, 58), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	toggleRow(page, "Sem cabeça (headless)", "Esconde a sua cabeça", function(v)
		mine.headless = v
		publish()
		say(v and "Headless ligado." or "Headless desligado.")
	end)
	local idRow = mk("Frame", { Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = PANEL, BackgroundTransparency = 0.15 }, page)
	round(idRow, 10); stroke(idRow, 1.5)
	local idBox = mk("TextBox", {
		Size = UDim2.new(1, -20, 1, -8), Position = UDim2.fromOffset(10, 4), BackgroundTransparency = 1,
		Text = "", PlaceholderText = "ID do item (só números)", PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
		TextColor3 = WHITE, Font = Enum.Font.Code, TextSize = 12, ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
	}, idRow)
	local listLbl = mk("TextLabel", {
		Text = "IDs ativos: nenhum", Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local function refreshList()
		listLbl.Text = "IDs ativos: " .. (#mine.ids > 0 and table.concat(mine.ids, ", ") or "nenhum")
	end
	rowBtn(page, "Adicionar ID", function()
		local n = idBox.Text:match("%d+")
		if not n then say("Digite o ID (só números)."); return end
		if #mine.ids >= 8 then say("Máximo de 8 IDs."); return end
		table.insert(mine.ids, n)
		idBox.Text = ""
		refreshList()
		publish()
		say("ID " .. n .. " adicionado.")
	end)
	rowBtn(page, "Limpar IDs", function()
		mine.ids = {}
		refreshList()
		publish()
		say("IDs removidos.")
	end)

	return function()
		alive = false
		fxConn:Disconnect()
		fxClearAll()
		for _, pl in ipairs(Players:GetPlayers()) do
			local hd = pl.Character and pl.Character:FindFirstChild("Head")
			local o = hd and hd:FindFirstChild("DsTagB")
			if o then o:Destroy() end
		end
		http("DELETE", "/mods/" .. uid .. ".json")
	end
end

-- ===== recursos locais (só afetam VOCÊ) =====
local function hrp() return lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") end
local function hum() return lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") end

local selfCleanup
-- ===== Tag grande em cima da cabeça (quem usa o hub vê a própria; o ADM vê a de todos os membros) =====
local TAG_FONTS = { "GothamBlack", "FredokaOne", "Bangers", "Creepster", "Arcade", "Fantasy", "SciFi", "LuckiestGuy", "PermanentMarker", "Cartoon", "Code" }
local TAG_ROLES = {
	{ "Membro", Color3.fromRGB(235, 235, 235) },
	{ "ADM", Color3.fromRGB(255, 70, 80) },
	{ "Dono", Color3.fromRGB(255, 205, 60) },
}
local TAG = { avail = false, on = true, text = "0DS", font = "GothamBlack", role = "Membro" }
local function tagRoleColor(name)
	for _, r in ipairs(TAG_ROLES) do
		if r[1] == name then return r[2] end
	end
	return TAG_ROLES[1][2]
end
-- desenha (ou atualiza / remove) o letreiro na cabeça de "char". d = { on, text, font, role }
local function tagDraw(char, d, nm)
	nm = nm or "DsTag"
	local head = char and char:FindFirstChild("Head")
	if not head then return end
	local old = head:FindFirstChild(nm)
	if not (type(d) == "table" and d.on) then
		if old then old:Destroy() end
		return
	end
	local text = tostring(d.text or "0DS"):sub(1, 16)
	local role = tostring(d.role or "Membro"):sub(1, 10)
	local fontName = table.find(TAG_FONTS, d.font) and d.font or "GothamBlack"
	local g = old
	if not g then
		g = mk("BillboardGui", {
			Name = nm, Size = UDim2.fromOffset(320, 110), StudsOffset = Vector3.new(0, 3.8, 0),
			AlwaysOnTop = true, LightInfluence = 0, MaxDistance = 1500,
		}, nil)
		g:SetAttribute("DsFx", true)
		mk("TextLabel", {
			Name = "N", Size = UDim2.new(1, 0, 0.62, 0), BackgroundTransparency = 1, TextScaled = true,
			TextColor3 = WHITE, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		}, g)
		mk("TextLabel", {
			Name = "R", Size = UDim2.new(1, 0, 0.3, 0), Position = UDim2.new(0, 0, 0.66, 0), BackgroundTransparency = 1,
			TextScaled = true, Font = Enum.Font.GothamBold, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
		}, g)
		g.Parent = head
	end
	local n, r = g:FindFirstChild("N"), g:FindFirstChild("R")
	if n then n.Text = text; n.Font = Enum.Font[fontName] end
	if r then r.Text = role; r.TextColor3 = tagRoleColor(role) end
end
function TAG.refresh()
	if TAG.avail then pcall(tagDraw, lp.Character, TAG) end
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
			local hd = lp.Character and lp.Character:FindFirstChild("Head")
			local o = hd and hd:FindFirstChild("DsTag")
			if o then o:Destroy() end
		end)
	end)
end
function TAG.stop() TAG.running = false end

local function buildSelf(pages, say)
	-- aba Scripts
	local sp = pages["Scripts"]
	local function runUrl(name, url)
		say("Executando " .. name .. "...")
		local ok, err = pcall(function() loadstring(game:HttpGet(url))() end)
		say(ok and (name .. " executado.") or ("Erro: " .. tostring(err):sub(1, 60)))
	end
	if #SCRIPTS == 0 then
		section(sp, "Scripts")
		mk("TextLabel", {
			Text = "Nenhum script na lista. Edite a tabela SCRIPTS no topo do arquivo ou cole um link abaixo.",
			Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
			Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, sp)
	end
	local lastGroup
	for _, s in ipairs(SCRIPTS) do
		local g = s[3] or "Scripts"
		if g ~= lastGroup then section(sp, g); lastGroup = g end
		rowBtn(sp, s[1], function() runUrl(s[1], s[2]) end, true)
	end
	section(sp, "Executar por link")
	local boxRow = mk("Frame", { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, sp)
	round(boxRow, 17); stroke(boxRow, 1.5)
	local urlBox = mk("TextBox", {
		Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
		Text = "", PlaceholderText = "Cole o link do script aqui", PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
		TextColor3 = WHITE, Font = Enum.Font.Code, TextSize = 11, ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
	}, boxRow)
	rowBtn(sp, "Executar link", function()
		local u = urlBox.Text
		if not u:find("^http") then say("Cole um link que comece com http."); return end
		runUrl("link", u)
	end, true)

	-- aba Natural Disaster
	local dp = pages["Natural Disaster"] or mk("Frame", {}) -- fora do Natural Disaster fica solto (invisível)
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
				local w = sp and sp:FindFirstChild("SeatWeld")
				if w then w:Destroy() end
				h.Sit = false
			end
		end
		if S.noclip then
			for _, p in ipairs(c:GetDescendants()) do
				if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
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
						if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
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
				local waterish = res.Material == Enum.Material.Water or nm:find("water") or nm:find("flood") or nm:find("tsunami")
					or (not ins.CanCollide and ins.Transparency >= 0.2 and ins.Color.B > ins.Color.R + 0.1)
				if waterish then surfaceY = res.Position.Y end
			end
			if not surfaceY and h:GetState() == Enum.HumanoidStateType.Swimming then
				surfaceY = r.Position.Y - (h.HipHeight + r.Size.Y / 2)
			end
			if surfaceY then
				if not wwPart then
					wwPart = mk("Part", {
						Name = "MeuHubWater", Size = Vector3.new(14, 1, 14), Anchored = true, CanCollide = true,
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
				selfBV = mk("BodyVelocity", { MaxForce = Vector3.new(1e9, 1e9, 1e9), Velocity = Vector3.zero }, r)
			end
			local mv = h.MoveDirection
			local look = workspace.CurrentCamera.CFrame.LookVector
			local flat = Vector3.new(look.X, 0, look.Z)
			local up = 0
			if mv.Magnitude > 0 and flat.Magnitude > 0 then
				up = look.Y * math.clamp(mv:Dot(flat.Unit), -1, 1)
			end
			if S.flyBtns then
				up = ((S.flyUp and 1 or 0) - (S.flyDown and 1 or 0)) -- botões: sobe/desce, solto = parado
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

	-- ===== Anti-lag: segura flood de partículas, sons e explosões feitos por scripts de lag =====
	-- (só protege o SEU aparelho; lag causado no servidor não dá pra bloquear daqui)
	local LAG_LIMITS = { ParticleEmitter = 40, Sound = 25, Explosion = 15, Fire = 25, Smoke = 25, Sparkles = 25, Beam = 50, Trail = 50 }
	local lag = { on = false, cnt = {}, t0 = 0, bad = 0, lastClean = 0, started = 0 }
	local function lagOwn(o)
		return o:GetAttribute("DsFx") or o.Name == "ShinFire" or o.Name == "AdmFxFire"
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
		elseif o:IsA("ParticleEmitter") and o.Rate > 50 then
			o.Rate = 50
		end
	end
	local function lagEmergency()
		for _, o in ipairs(workspace:GetDescendants()) do
			if LAG_LIMITS[o.ClassName] and not lagOwn(o) then
				if o:IsA("Sound") then pcall(function() o:Stop() end)
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
			-- travou feio (menos de ~3 fps por 3 frames seguidos): limpa o que costuma causar lag
			if os.clock() - lag.started < 15 then return end
			if dt > 0.35 then lag.bad = lag.bad + 1 else lag.bad = 0 end
			if lag.bad >= 3 and os.clock() - lag.lastClean > 4 then
				lag.bad, lag.lastClean = 0, os.clock()
				task.spawn(lagEmergency)
			end
		end)
	end

	-- ===== Fling nos outros: gira rápido; quem encostar em você sai voando e VOCÊ fica no lugar =====
	local tfTok, tfBAV, tfOld = 0, nil, {}
	local startTFling
	local function stopTFling()
		tfTok = tfTok + 1
		if tfBAV then tfBAV:Destroy(); tfBAV = nil end
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
			if p:IsA("BasePart") then
				tfOld[p] = p.CustomPhysicalProperties or false
				p.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5, 1, 1)
			end
		end
		tfBAV = mk("BodyAngularVelocity", { MaxTorque = Vector3.new(0, 1e9, 0), AngularVelocity = Vector3.new(0, S.flingVal * 2, 0), P = 1e5 }, r)
		task.spawn(function()
			while tfTok == my do
				RunService.Heartbeat:Wait()
				local root = hrp()
				if not root then
					task.wait(0.5)
				elseif not tfBAV or tfBAV.Parent ~= root then
					startTFling() -- renasceu: refaz tudo
					return
				else
					local v = root.AssemblyLinearVelocity
					if v.Magnitude > 50 then v = v.Unit * 50 end
					root.AssemblyLinearVelocity = v * 10000 + Vector3.new(0, 10000, 0)
					RunService.RenderStepped:Wait()
					if root.Parent then root.AssemblyLinearVelocity = v end
					RunService.Stepped:Wait()
					if root.Parent then root.AssemblyLinearVelocity = v + Vector3.new(0, 0.1, 0) end
				end
			end
		end)
	end

	-- ===== Blocos soltos (desancorados): telecinese e fling parts =====
	local function claimSim()
		pcall(function() sethiddenproperty(lp, "SimulationRadius", 1e9) end)
		pcall(function() lp.MaximumSimulationRadius = 1e9 end)
	end
	local function isLoose(p)
		if not (p and p:IsA("BasePart")) or p.Anchored then return false end
		if p.Name == "HumanoidRootPart" or p.Name == "MeuHubWater" or p:GetAttribute("DsFx") then return false end
		if p:FindFirstAncestorOfClass("Accessory") or p:FindFirstAncestorOfClass("Tool") then return false end
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
		tk.bp = mk("BodyPosition", { MaxForce = Vector3.new(1e9, 1e9, 1e9), P = 1e5, D = 2e3, Position = part.Position }, part)
		tk.bg = mk("BodyGyro", { MaxTorque = Vector3.new(1e9, 1e9, 1e9), P = 1e4, D = 500, CFrame = CFrame.new() }, part)
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
		-- olhando pra cima/baixo e andando = o bloco sobe/desce (voo em cima do bloco)
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
			say("Bloco pego! Ande em cima dele. Olhe pra cima/baixo e ande pra voar.")
		else
			say("Isso não é um bloco solto (desancorado).")
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
			if d:IsA("BasePart") and not d.Anchored and d.Size.Magnitude < 60 and d ~= tk.part and isLoose(d) then
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

	section(dp, "Sobreviver")
	toggleRow(dp, "Voar", "Olhe pra cima + joystick = sobe", function(v) S.fly = v end)
	toggleRow(dp, "Anti-queda", "Limita a velocidade da queda", function(v) S.nofall = v end)
	rowBtn(dp, "Subir 100 studs (fugir da água)", function()
		local r = hrp()
		if r then r.CFrame = r.CFrame + Vector3.new(0, 100, 0); say("Subiu 100 studs.") end
	end)
	toggleRow(dp, "Fling (girar e lançar os outros)", "Você gira; quem encostar sai voando. Você não é lançado", function(v)
		S.tfling = v
		if v then startTFling() else stopTFling() end
	end)
	sliderRow(dp, "Giro do fling", "Velocidade do giro", 50, 300, 150, function(v)
		S.flingVal = v
		if tfBAV then tfBAV.AngularVelocity = Vector3.new(0, v * 2, 0) end
	end)
	toggleRow(dp, "Anti-void", "Volta pro último lugar seguro se cair no vazio", function(v) S.antivoid = v end)
	toggleRow(dp, "Pulo infinito", "Pula no ar quantas vezes quiser", function(v) S.infjump = v end)
	toggleRow(dp, "Andar sobre a água", "Plataforma invisível na superfície", function(v)
		S.waterwalk = v
		if not v and wwPart then wwPart:Destroy(); wwPart = nil end
	end)
	local island, islandBack
	rowBtn(dp, "Ilha segura (plataforma no céu)", function()
		local r = hrp()
		if not r then return end
		if not island or not island.Parent then
			island = mk("Part", {
				Name = "MeuHubIlha", Size = Vector3.new(40, 2, 40), Anchored = true, CanCollide = true,
				Material = Enum.Material.SmoothPlastic, Color = Color3.fromRGB(60, 8, 12),
				Position = Vector3.new(r.Position.X, 3500, r.Position.Z),
			}, workspace)
		end
		islandBack = r.CFrame
		r.AssemblyLinearVelocity = Vector3.zero
		r.CFrame = CFrame.new(island.Position + Vector3.new(0, 4, 0))
		say("Na ilha segura. Use \"Voltar da ilha\" quando passar.")
	end)
	rowBtn(dp, "Voltar da ilha", function()
		local r = hrp()
		if r and islandBack then
			r.AssemblyLinearVelocity = Vector3.zero
			r.CFrame = islandBack
			say("De volta.")
		else
			say("Você ainda não foi pra ilha.")
		end
	end, true)
	section(dp, "Blocos soltos")
	rowBtn(dp, "Telecinese: escolher bloco", function()
		tk.armed = true
		say("Toque num bloco solto (desancorado) do mapa, fora do menu.")
	end)
	rowBtn(dp, "Telecinese: soltar bloco", function() tkRelease(); say("Bloco solto.") end, true)
	rowBtn(dp, "Bloco: subir 10", function() tk.y = tk.y + 10 end, true)
	rowBtn(dp, "Bloco: descer 10", function() tk.y = tk.y - 10 end, true)
	toggleRow(dp, "Fling Parts", "Peças soltas giram em volta de você", function(v)
		fpSet(v)
		say(v and "Procurando peças soltas..." or "Fling Parts desligado.")
	end)
	sliderRow(dp, "Raio das peças", "Distância do círculo", 8, 40, 14, function(v) fp.radius = v end)
	section(dp, "Proteção")
	toggleRow(dp, "Anti-fling", "Ignora colisão de outros jogadores e zera giro/arremesso", function(v) S.antifling = v end)
	-- aba Proteções (Brookhaven)
	local pp = pages["Proteções"]
	if pp then
		section(pp, "Proteções")
		toggleRow(pp, "Anti-fling", "Ignora colisão de outros jogadores e zera giro/arremesso", function(v) S.antifling = v end)
		toggleRow(pp, "Anti-void", "Volta pro último lugar seguro se cair do mapa", function(v) S.antivoid = v end)
		toggleRow(pp, "Sem dano de queda", "Reduz a velocidade da queda", function(v) S.nofall = v end)
		toggleRow(pp, "Anti-sentar", "Não deixa sentar em carro, cadeira nem banco", function(v)
			S.antisit = v
			if not v then
				local h = hum()
				if h then h:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
			end
		end)
		toggleRow(pp, "Anti-lag", "Segura flood de partículas, sons e explosões de scripts de lag", function(v)
			if v then lagStart() else lagStop() end
			say(v and "Anti-lag ligado." or "Anti-lag desligado.")
		end)
	end
	-- aba Movimento (Brookhaven): mesmos controles do Natural Disaster
	local mp = pages["Movimento"]
	if mp then
		section(mp, "Movimento")
		toggleRow(mp, "Voar", "Olhe pra cima + joystick = sobe", function(v) S.fly = v end)
		toggleRow(mp, "Velocidade", "Liga a velocidade escolhida abaixo", function(v)
			S.speed = v
			if not v then local h = hum(); if h then h.WalkSpeed = 16 end end
		end)
		sliderRow(mp, "Valor da velocidade", "Corrida", 16, 120, 50, function(v) S.speedVal = v end)
		sliderRow(mp, "Velocidade do voo", "Voar", 20, 150, 50, function(v) S.flyVal = v end)
		-- botões ▲ ▼ na tela (segurar): aparecem só com "Voar" + "Botões de voo" ligados
		flyGui = mk("Frame", { Size = UDim2.fromOffset(60, 124), Position = UDim2.new(0, 24, 0.55, -62), BackgroundTransparency = 1, Visible = false, ZIndex = 20 }, gui)
		local function holdBtn(txt, y, key)
			local b = mk("TextButton", {
				Text = txt, Size = UDim2.fromOffset(60, 56), Position = UDim2.fromOffset(0, y),
				BackgroundColor3 = PANEL, BackgroundTransparency = 0.15, TextColor3 = WHITE,
				Font = Enum.Font.GothamBold, TextSize = 24, ZIndex = 21,
			}, flyGui)
			round(b, 28); stroke(b, 2)
			local function isHold(i) return i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 end
			b.InputBegan:Connect(function(i) if isHold(i) then S[key] = true end end)
			b.InputEnded:Connect(function(i) if isHold(i) then S[key] = false end end)
		end
		holdBtn("▲", 0, "flyUp")
		holdBtn("▼", 68, "flyDown")
		toggleRow(mp, "Botões de voo (subir/descer)", "Com o Voar ligado, mostra ▲ ▼ na tela: segure pra subir ou descer; solto = fica parado no ar", function(v)
			S.flyBtns = v
			if not v then S.flyUp = false; S.flyDown = false end
		end)
		toggleRow(mp, "Pulo alto", "JumpPower 90", function(v)
			S.jump = v
			if not v then local h = hum(); if h then h.JumpPower = 50 end end
		end)
		toggleRow(mp, "Pulo infinito", "Pula no ar quantas vezes quiser", function(v) S.infjump = v end)
		toggleRow(mp, "Atravessar paredes", "Noclip", function(v) S.noclip = v end)
	end
	-- teleporte por toque/clique (aba Extras)
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
	local ep = pages["Extras"]
	if ep then
		section(ep, "Teleporte")
		toggleRow(ep, "Teleporte por toque", "Toque/clique num lugar e você vai pra lá", function(v) ctp.on = v end)
	end
	section(dp, "Movimento")
	toggleRow(dp, "Velocidade", "Liga a velocidade escolhida abaixo", function(v)
		S.speed = v
		if not v then local h = hum(); if h then h.WalkSpeed = 16 end end
	end)
	sliderRow(dp, "Valor da velocidade", "Corrida", 16, 120, 50, function(v) S.speedVal = v end)
	sliderRow(dp, "Velocidade do voo", "Voar", 20, 150, 50, function(v) S.flyVal = v end)
	toggleRow(dp, "Pulo alto", "JumpPower 90", function(v)
		S.jump = v
		if not v then local h = hum(); if h then h.JumpPower = 50 end end
	end)
	toggleRow(dp, "Atravessar paredes", "Noclip", function(v) S.noclip = v end)

	return function()
		loopConn:Disconnect(); jumpConn:Disconnect()
		tkConn:Disconnect(); tkInput:Disconnect(); fpConn:Disconnect(); ctpInput:Disconnect()
		if island then island:Destroy(); island = nil end
		fpSet(false); tkRelease(); stopTFling(); lagStop()
		local hh = hum(); if hh then hh:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
		if wwPart then wwPart:Destroy(); wwPart = nil end
		stopSelfFly()
		local h = hum()
		if h then h.WalkSpeed = 16; h.JumpPower = 50 end
	end
end

-- ===== AVISO (obrigatório) =====
local accepted
local box = panel(430, 380, UDim2.new(0.5, -215, 0.5, -190))
mk("TextLabel", {
	Text = "Aviso antes de continuar", Size = UDim2.new(1, -24, 0, 36), Position = UDim2.fromOffset(14, 4),
	BackgroundTransparency = 1, TextColor3 = WHITE, Font = Enum.Font.GothamBold,
	TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left,
}, box)
local textBg = mk("Frame", {
	Position = UDim2.fromOffset(12, 44), Size = UDim2.new(1, -24, 1, -112),
	BackgroundColor3 = PANEL, BackgroundTransparency = 0.25,
}, box)
round(textBg, 10); stroke(textBg, 1.5)
mk("TextLabel", {
	Text = "script em desenvolvimento:\n\n"
		.. "• SHIN HUB \n"
		.. "• korblox,headless visual através de ID  \n• poucas opções, mais em breve terá mais coisas \n"
		.. "• contem Efeitos  visuais obs: eles só ficam visível pra vc e pra outras pessoas q usan o script \n\n"
		.. "•ids funcionado por enquanto só no brook\n\n"
		.. "mais atualização em breve",
	Position = UDim2.fromOffset(10, 6), Size = UDim2.new(1, -20, 1, -12), BackgroundTransparency = 1,
	TextColor3 = Color3.fromRGB(240, 225, 225), Font = Enum.Font.Gotham, TextSize = 11,
	TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
}, textBg)
local yes = bigBtn(box, "Aceitar", UDim2.new(0, 12, 1, -56), UDim2.new(0.5, -18, 0, 44), true)
local no = bigBtn(box, "Não aceito", UDim2.new(0.5, 6, 1, -56), UDim2.new(0.5, -18, 0, 44), false)
yes.MouseButton1Click:Connect(function() accepted = true end)
no.MouseButton1Click:Connect(function() accepted = false end)
repeat task.wait() until accepted ~= nil
box:Destroy()
if not accepted then gui:Destroy(); return end

-- ===== AÇÕES FIXAS (única coisa que o admin consegue disparar) =====
local floatConn, floatBV
local function unfly()
	if floatConn then floatConn:Disconnect(); floatConn = nil end
	if floatBV then floatBV:Destroy(); floatBV = nil end
end
local toast
local spinBAV
local function unspin() if spinBAV then spinBAV:Destroy(); spinBAV = nil end end
local rocketing = false
-- estado visual dos comandos do admin (fogo, foguete, caixa, explosão): vai junto com a presença
-- pro Firebase, e o painel ADM desenha igual no aparelho dele
local FXS = { rocket = false, jail = nil, boom = nil }
local pushPresence -- definida lá embaixo (precisa do uid/beat)
local function boom(r, radius)
	FXS.boom = { id = HttpService:GenerateGUID(false), x = r.Position.X, y = r.Position.Y, z = r.Position.Z, r = radius }
	if pushPresence then task.spawn(pushPresence) end
	local ex = Instance.new("Explosion")
	ex.Position = r.Position; ex.BlastRadius = radius; ex.BlastPressure = 0; ex.DestroyJointRadiusPercent = 0
	ex:SetAttribute("DsFx", true)
	ex.Parent = workspace
end
local ACTIONS = {
	kick = function()
		pcall(function() lp:Kick("Você foi mogado pelo adm.") end)
		-- plano B: se o jogo bloquear o Kick, fecha o jogo depois de 2s
		task.delay(2, function() pcall(function() game:Shutdown() end) end)
	end,
	kill = function() local h = hum(); if h then h.Health = 0 end end,
	freeze = function() local r = hrp(); if r then r.Anchored = true end end,
	unfreeze = function() local r = hrp(); if r then r.Anchored = false end end,
	fly = function()
		unfly()
		local r, h = hrp(), hum()
		if not (r and h) then return end
		floatBV = mk("BodyVelocity", { MaxForce = Vector3.new(1e9, 1e9, 1e9), Velocity = Vector3.zero }, r)
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
		local bv = mk("BodyVelocity", { MaxForce = Vector3.new(1e9, 1e9, 1e9), Velocity = Vector3.new(0, 20, 0) }, r)
		local fire = mk("Fire", { Size = 8, Heat = 12 }, r)
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
		if r then spinBAV = mk("BodyAngularVelocity", { MaxTorque = Vector3.new(0, 1e9, 0), AngularVelocity = Vector3.new(0, 20, 0) }, r) end
	end,
	unspin = unspin,
	bounce = function() local r = hrp(); if r then r.AssemblyLinearVelocity = Vector3.new(0, 120, 0) end end,
	sit = function() local h = hum(); if h then h.Sit = true end end,
	bring = function(c)
		local p, r = c and c.pos, hrp()
		if r and type(p) == "table" and tonumber(p.x) and tonumber(p.y) and tonumber(p.z) then
			r.CFrame = CFrame.new(p.x, p.y + 3, p.z)
		end
	end,
	message = function(c)
		if c and c.text and toast then toast(tostring(c.text):sub(1, 80)) end
	end,
}

-- ===== Ações extras do admin (só mexem no SEU personagem; loops expiram sozinhos em 2 min) =====
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
			table.insert(jailParts, mk("Part", {
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
					if loops.fire and not r:FindFirstChild("ShinFire") then ACTIONS.fire() end
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
		if r and not r:FindFirstChild("ShinFire") then
			mk("Fire", { Name = "ShinFire", Size = 8, Heat = 10 }, r)
			if pushPresence then task.spawn(pushPresence) end
		end
	end
	ACTIONS.unfire = function()
		local r = hrp()
		local f = r and r:FindFirstChild("ShinFire")
		if f then f:Destroy(); if pushPresence then task.spawn(pushPresence) end end
	end
	ACTIONS.castigo = function() loopOn("castigo") end
	ACTIONS.descastigo = function()
		loopOff("castigo")
		local h = hum()
		if h then h.WalkSpeed = 16; h.UseJumpPower = true; h.JumpPower = 50 end
	end
	ACTIONS.loopkill = function() loopOn("kill") end
	ACTIONS.unloopkill = function() loopOff("kill") end
	ACTIONS.loopfire = function() loopOn("fire") end
	ACTIONS.unloopfire = function() loopOff("fire"); ACTIONS.unfire() end
	ACTIONS.loopsit = function() loopOn("sit") end
	ACTIONS.unloopsit = function() loopOff("sit"); local h = hum(); if h then h.Sit = false end end
	ACTIONS.loopbring = function(c)
		local p = c and c.pos
		if type(p) == "table" and tonumber(p.x) and tonumber(p.y) and tonumber(p.z) then
			loopPos = Vector3.new(p.x, p.y, p.z)
			loopOn("bring")
		end
	end
	ACTIONS.unloopbring = function() loopOff("bring") end

	local trollConns, trollTok = {}, 0
	local function trollOff()
		pcall(function() RunService:UnbindFromRenderStep("ShinInvert") end)
		for _, c in ipairs(trollConns) do c:Disconnect() end
		trollConns = {}
	end
	-- troll: andar invertido; se pular vira foguete (expira em 2 min)
	ACTIONS.troll = function()
		trollOff()
		trollTok = trollTok + 1
		local my = trollTok
		RunService:BindToRenderStep("ShinInvert", Enum.RenderPriority.Character.Value + 1, function()
			local h = hum()
			if h and h.MoveDirection.Magnitude > 0 then h:Move(-h.MoveDirection, false) end
		end)
		table.insert(trollConns, UIS.JumpRequest:Connect(function() ACTIONS.rocket() end))
		task.delay(120, function() if trollTok == my then trollOff() end end)
	end
	ACTIONS.untroll = trollOff
	-- tag: o ADM muda nome / fonte / cargo / mostrar-esconder (só vale no Brookhaven)
	ACTIONS.tag = function(c)
		if not (c and TAG.avail) then return end
		if type(c.text) == "string" and c.text ~= "" then TAG.text = c.text:sub(1, 16) end
		if type(c.font) == "string" and table.find(TAG_FONTS, c.font) then TAG.font = c.font end
		if type(c.role) == "string" then
			for _, r in ipairs(TAG_ROLES) do
				if r[1] == c.role then TAG.role = c.role end
			end
		end
		if type(c.on) == "boolean" then TAG.on = c.on end
		TAG.refresh()
		if TAG.onChanged then pcall(TAG.onChanged) end
		if pushPresence then task.spawn(pushPresence) end
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

-- ===== Menu (abas) + botão flutuante =====
-- ===== Aba Efeitos (só no SEU aparelho) =====
local Lighting = game:GetService("Lighting")
local function buildEffects(page, say)
	local E = { colorIdx = 1 }
	local lightOrig
	local sizeTouched = false
	local function col() return COLORS[E.colorIdx][2] end

	-- publica o seu conjunto de efeitos (todos que usam o hub passam a ver em você)
	local function share()
		local t = {}
		for _, k in ipairs(FX_KEYS) do
			if E[k] then table.insert(t, k) end
		end
		local s = #t > 0 and table.concat(t, ",") or nil
		if MINE.fx == s and MINE.fc == E.colorIdx then return end
		MINE.fx, MINE.fc = s, E.colorIdx
		if publishMods then publishMods() end
	end
	local function refresh()
		local c = lp.Character
		if c then fxApply(c, E, E.colorIdx) end
		share()
	end

	local charConn = lp.CharacterAdded:Connect(function()
		task.wait(1.2)
		refresh()
	end)

	-- ambiente (guarda o original uma vez)
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

	section(page, "Efeitos no personagem")
	mk("TextLabel", {
		Text = "Todos que usam o hub (admin e membros) veem esses efeitos em você.", Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(240, 210, 210), Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, page)
	local colorBtn
	colorBtn = rowBtn(page, "Cor dos efeitos: " .. COLORS[1][1], function()
		E.colorIdx = E.colorIdx % #COLORS + 1
		colorBtn:FindFirstChildOfClass("TextLabel").Text = "Cor dos efeitos: " .. COLORS[E.colorIdx][1]
		refresh()
	end)
	local function fxToggle(label, desc, key)
		toggleRow(page, label, desc, function(v) E[key] = v; refresh() end)
	end
	fxToggle("Fogo", "Chamas no corpo", "fire")
	fxToggle("Fumaça", "Fumaça subindo", "smoke")
	fxToggle("Brilhos", "Faíscas ao redor", "sparkles")
	fxToggle("Estrelas", "Partículas de estrela", "stars")
	fxToggle("Rastro", "Rastro de luz ao andar", "trail")
	fxToggle("Aura", "Contorno brilhante no corpo", "aura")
	fxToggle("Luz", "Ilumina o ambiente em volta", "light")
	toggleRow(page, "Efeitos arco-íris", "Troca a cor dos efeitos sem parar", function(v) E.rainbow = v; refresh() end)
	toggleRow(page, "Corpo neon", "Material neon em todas as peças", function(v) E.neon = v; refresh() end)
	toggleRow(page, "Corpo arco-íris", "Pinta o corpo trocando de cor", function(v) E.rainbowBody = v; refresh() end)
	toggleRow(page, "Fantasma", "Deixa o corpo meio transparente", function(v) E.ghost = v; refresh() end)
	rowBtn(page, "Explosão de confete", function()
		local r = hrp()
		if not r then return end
		local p = mk("ParticleEmitter", {
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
	sliderRow(page, "Tamanho (%)", "Só personagens R15", 50, 300, 100, function(v)
		local h = hum()
		if not h then return end
		local found = false
		for _, n in ipairs({ "BodyHeightScale", "BodyWidthScale", "BodyDepthScale", "HeadScale" }) do
			local nv = h:FindFirstChild(n)
			if nv then nv.Value = v / 100; found = true end
		end
		if found then sizeTouched = true else say("Esse personagem não é R15.") end
	end)

	section(page, "Ambiente")
	sliderRow(page, "Hora do dia", "0 a 24", 0, 24, math.floor(Lighting.ClockTime), function(v)
		saveLight(); Lighting.ClockTime = v
	end)
	sliderRow(page, "Saturação", "-100 a 100", -100, 100, 0, function(v)
		lightFx("DsCC", "ColorCorrectionEffect", {}).Saturation = v / 100
	end)
	sliderRow(page, "Contraste", "-100 a 100", -100, 100, 0, function(v)
		lightFx("DsCC", "ColorCorrectionEffect", {}).Contrast = v / 100
	end)
	toggleRow(page, "Bloom", "Brilho forte nas luzes", function(v)
		local b = lightFx("DsBloom", "BloomEffect", { Intensity = 1.2, Size = 40, Threshold = 0.8 })
		b.Enabled = v
	end)
	toggleRow(page, "Desfoque", "Borra a tela", function(v)
		local b = lightFx("DsBlur", "BlurEffect", { Size = 10 })
		b.Enabled = v
	end)
	toggleRow(page, "Névoa colorida", "Névoa com a cor escolhida", function(v)
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
				for _, n in ipairs({ "BodyHeightScale", "BodyWidthScale", "BodyDepthScale", "HeadScale" }) do
					local nv = h:FindFirstChild(n)
					if nv then nv.Value = 1 end
				end
			end
		end
		for _, n in ipairs({ "DsCC", "DsBloom", "DsBlur" }) do
			local o = Lighting:FindFirstChild(n)
			if o then o:Destroy() end
		end
		if lightOrig then
			Lighting.ClockTime = lightOrig.ClockTime
			Lighting.FogEnd = lightOrig.FogEnd; Lighting.FogColor = lightOrig.FogColor
		end
	end
end

-- ===== Seletor em aba (abre/fecha, igual às categorias de música) =====
local function dropdown(par, title, getItems, onPick, onRefresh)
	local wrap = mk("Frame", { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1 }, par)
	mk("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, wrap)
	local head = mk("TextButton", { Text = "", Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2, LayoutOrder = 1 }, wrap)
	round(head, 19); stroke(head, 2)
	local lbl = mk("TextLabel", {
		Text = title, Size = UDim2.new(1, -60, 1, 0), Position = UDim2.fromOffset(16, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, head)
	local arrow = mk("TextLabel", {
		Text = "+", Size = UDim2.fromOffset(30, 38), Position = UDim2.new(1, -40, 0, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 20,
	}, head)
	local body = mk("Frame", { Size = UDim2.new(1, -14, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Visible = false, LayoutOrder = 2 }, wrap)
	mk("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, body)
	mk("UIPadding", { PaddingLeft = UDim.new(0, 14) }, body)
	local obj = {}
	function obj.rebuild()
		for _, c in ipairs(body:GetChildren()) do if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end end
		-- botão de atualizar a lista (sempre no topo)
		local rf = mk("TextButton", {
			Text = "↻ Atualizar lista", LayoutOrder = 0, Size = UDim2.new(1, 0, 0, 28),
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
			mk("TextLabel", {
				Text = "Ninguém disponível agora.", LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(170, 130, 130), Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
			}, body)
		end
		for _, it in ipairs(items) do
			local row = mk("TextButton", {
				Text = it.label, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2,
				TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12,
			}, body)
			round(row, 15); stroke(row, 1.2)
			row.MouseButton1Click:Connect(function()
				onPick(it)
				body.Visible = false; arrow.Text = "+"
			end)
		end
	end
	function obj.setText(t) lbl.Text = t end
	-- se a lista estiver aberta e alguém entrar/sair, atualiza sozinha
	local function auto() if body.Parent and body.Visible then task.defer(obj.rebuild) end end
	Players.PlayerAdded:Connect(auto)
	Players.PlayerRemoving:Connect(auto)
	head.MouseButton1Click:Connect(function()
		if not body.Visible then obj.rebuild() end
		body.Visible = not body.Visible
		arrow.Text = body.Visible and "–" or "+"
	end)
	return obj
end

-- ===== Aba Extras (só afetam VOCÊ) =====
local function buildExtras(page, say)
	local cs = {}
	local X = { fov = 70, fovOn = false, fb = false, esp = false, target = nil }
	local origGravity = workspace.Gravity
	local fbOrig
	local espObjs = {}
	local savedCF
	local spinBAV
	local afkConn
	local VU = game:GetService("VirtualUser")
	local function cam() return workspace.CurrentCamera end

	section(page, "Utilidades")
	toggleRow(page, "Anti-AFK", "Evita ser kickado por ficar parado", function(v)
		if afkConn then afkConn:Disconnect(); afkConn = nil end
		if v then
			afkConn = lp.Idled:Connect(function()
				pcall(function() VU:CaptureController(); VU:ClickButton2(Vector2.new()) end)
			end)
		end
	end)
	toggleRow(page, "Luz total (fullbright)", "Tira a escuridão do mapa", function(v)
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
	toggleRow(page, "ESP de jogadores", "Contorno + nome e distância", function(v)
		X.esp = v
		if not v then
			for _, e in pairs(espObjs) do
				pcall(function() e.hl:Destroy(); e.bb:Destroy() end)
			end
			espObjs = {}
		end
	end)
	toggleRow(page, "Girar personagem", "Gira você sem parar", function(v)
		if spinBAV then spinBAV:Destroy(); spinBAV = nil end
		local r = hrp()
		if v and r then
			spinBAV = mk("BodyAngularVelocity", { MaxTorque = Vector3.new(0, 1e9, 0), AngularVelocity = Vector3.new(0, 10, 0) }, r)
		end
	end)

	local origZoom = lp.CameraMaxZoomDistance
	local fpsLbl
	local fpsAcc, fpsN = 0, 0
	toggleRow(page, "Mostrar FPS", "Contador no canto da tela", function(v)
		X.fps = v
		if v and not fpsLbl then
			fpsLbl = mk("TextLabel", {
				Text = "FPS: --", Size = UDim2.fromOffset(80, 22), Position = UDim2.new(1, -90, 0, 8),
				BackgroundColor3 = Color3.fromRGB(20, 0, 0), BackgroundTransparency = 0.3, TextColor3 = WHITE,
				Font = Enum.Font.GothamBold, TextSize = 12,
			}, gui)
			round(fpsLbl, 8)
		end
		if fpsLbl then fpsLbl.Visible = v end
	end)
	toggleRow(page, "Zoom ilimitado", "Afasta a câmera além do limite", function(v)
		lp.CameraMaxZoomDistance = v and 5000 or origZoom
	end)

	section(page, "Câmera e física")
	toggleRow(page, "FOV personalizado", "Usa o valor do controle abaixo", function(v)
		X.fovOn = v
		if not v and cam() then cam().FieldOfView = 70 end
	end)
	sliderRow(page, "FOV", "Campo de visão", 30, 120, 70, function(v) X.fov = v end)
	sliderRow(page, "Gravidade", "Padrão: 196", 20, 300, math.floor(origGravity), function(v) workspace.Gravity = v end)
	rowBtn(page, "Restaurar gravidade", function() workspace.Gravity = origGravity; say("Gravidade restaurada.") end)

	section(page, "Jogadores")
	local function others()
		local t = {}
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl ~= lp then table.insert(t, pl) end
		end
		return t
	end
	local tgtDD
	tgtDD = dropdown(page, "Escolher jogador (nenhum)", function()
		local t = {}
		for _, pl in ipairs(others()) do
			table.insert(t, { label = pl.DisplayName .. " (@" .. pl.Name .. ")", value = pl })
		end
		return t
	end, function(it)
		X.target = it.value
		tgtDD.setText("Jogador: " .. it.value.DisplayName)
	end)
	rowBtn(page, "Ir até o jogador", function()
		local tc = X.target and X.target.Character
		local tr = tc and tc:FindFirstChild("HumanoidRootPart")
		local r = hrp()
		if tr and r then r.CFrame = tr.CFrame * CFrame.new(0, 0, 4); say("Teleportado.") else say("Escolha um jogador primeiro.") end
	end)
	toggleRow(page, "Observar jogador", "Câmera segue o jogador escolhido", function(v)
		local tc = X.target and X.target.Character
		local th = tc and tc:FindFirstChildOfClass("Humanoid")
		if v and th then cam().CameraSubject = th
		else
			local h = hum()
			if h then cam().CameraSubject = h end
			if v then say("Escolha um jogador primeiro.") end
		end
	end)
	rowBtn(page, "Salvar minha posição", function()
		local r = hrp()
		if r then savedCF = r.CFrame; say("Posição salva.") end
	end)
	rowBtn(page, "Voltar à posição salva", function()
		local r = hrp()
		if r and savedCF then r.CFrame = savedCF; say("Voltou.") else say("Nenhuma posição salva.") end
	end)
	rowBtn(page, "Resetar personagem", function()
		local h = hum()
		if h then h.Health = 0 end
	end)
	rowBtn(page, "Reentrar no jogo", function()
		say("Reentrando...")
		pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, lp) end)
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
			if fpsAcc >= 0.5 then fpsLbl.Text = "FPS: " .. math.floor(fpsN / fpsAcc + 0.5); fpsAcc, fpsN = 0, 0 end
		end
		if X.esp and acc >= 0.3 then
			acc = 0
			local r = hrp()
			for _, pl in ipairs(others()) do
				local c = pl.Character
				local head = c and c:FindFirstChild("Head")
				if head then
					local e = espObjs[pl]
					if not e or e.hl.Adornee ~= c or not e.hl.Parent then
						if e then pcall(function() e.hl:Destroy(); e.bb:Destroy() end) end
						local hl = mk("Highlight", { Adornee = c, FillTransparency = 0.7, FillColor = RED, OutlineColor = WHITE }, gui)
						local bb = mk("BillboardGui", { Adornee = head, Size = UDim2.fromOffset(120, 20), StudsOffset = Vector3.new(0, 2.5, 0), AlwaysOnTop = true }, gui)
						local lbl = mk("TextLabel", {
							Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, TextColor3 = WHITE,
							TextStrokeTransparency = 0.3, Font = Enum.Font.GothamBold, TextSize = 12,
						}, bb)
						e = { hl = hl, bb = bb, lbl = lbl }
						espObjs[pl] = e
					end
					local d = r and math.floor((head.Position - r.Position).Magnitude) or 0
					e.lbl.Text = pl.DisplayName .. " [" .. d .. "]"
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


-- ===== aba Brookhaven: nome/bio RP (com RGB) + rádio por ID =====
-- Os remotes ficam dentro da função (nomes podem mudar se o jogo atualizar).
local function buildBrookhaven(pages, say)
	local page = pages["Nome"]
	local RS = game:GetService("ReplicatedStorage")
	local NAME_REMOTES = { "1RPNam1eTex1t" }   -- RolePlayName / RolePlayBio
	local COLOR_REMOTES = { "1RPNam1eColo1r" } -- PickingRPNameColor / PickingRPBioColor
	local alive = true
	local rgbName, rgbBio, speed, hue = false, false, 5, 0

	local function findRE(names)
		local re = RS:FindFirstChild("RE")
		if not re then return nil end
		for _, n in ipairs(names) do
			local r = re:FindFirstChild(n)
			if r then return r end
		end
		return nil
	end
	local function inputRow(placeholder)
		local row = mk("Frame", { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk("TextBox", {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = "", PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(170, 130, 130),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function digits(s)
		local d = (tostring(s or "")):gsub("%D", "")
		if #d >= 5 then return d end
		return nil
	end

	-- ===== Nome e Bio =====
	section(page, "Nome e Bio (RP)")
	local nameBox = inputRow("Nome que aparece em cima do personagem")
	rowBtn(page, "Aplicar nome", function()
		local r = findRE(NAME_REMOTES)
		if not r then say("Remote do nome não encontrado (o jogo pode ter mudado)."); return end
		local ok = pcall(function() r:FireServer("RolePlayName", nameBox.Text) end)
		say(ok and "Nome aplicado." or "Falhou ao aplicar o nome.")
	end, true)
	local bioBox = inputRow("Bio")
	rowBtn(page, "Aplicar bio", function()
		local r = findRE(NAME_REMOTES)
		if not r then say("Remote da bio não encontrado (o jogo pode ter mudado)."); return end
		local ok = pcall(function() r:FireServer("RolePlayBio", bioBox.Text) end)
		say(ok and "Bio aplicada." or "Falhou ao aplicar a bio.")
	end, true)
	toggleRow(page, "Nome RGB", "A cor do nome muda sem parar", function(v)
		rgbName = v
		if v and not findRE(COLOR_REMOTES) then say("Remote de cor não encontrado.") end
	end)
	toggleRow(page, "Bio RGB", "A cor da bio muda sem parar", function(v)
		rgbBio = v
		if v and not findRE(COLOR_REMOTES) then say("Remote de cor não encontrado.") end
	end)
	sliderRow(page, "Velocidade RGB", "1 lento · 10 rápido", 1, 10, 5, function(v) speed = v end)

	task.spawn(function()
		while alive do
			if rgbName or rgbBio then
				hue = (hue + 0.02 * speed) % 1
				local col = Color3.fromHSV(hue, 1, 1)
				local r = findRE(COLOR_REMOTES)
				if r then
					if rgbName then pcall(function() r:FireServer("PickingRPNameColor", col) end) end
					if rgbBio then pcall(function() r:FireServer("PickingRPBioColor", col) end) end
				end
			end
			task.wait(0.25)
		end
	end)

	-- ===== Música: rádio e hoverboard (precisa ter o item/gamepass) =====
	page = pages["Música"]
	section(page, "Música (rádio e hoverboard)")
	local idBox = inputRow("ID da música")

	-- os nomes dos remotes têm "1" no meio (ex.: 1NoMoto1rVehicle1s); acha pelo nome sem os "1"
	local function reByPlain(plain)
		local re = RS:FindFirstChild("RE")
		if not re then return nil end
		for _, c in ipairs(re:GetChildren()) do
			if (c.Name:gsub("1", "")) == plain then return c end
		end
		return nil
	end
	local function send(plain, kind, id, okMsg)
		local r = reByPlain(plain)
		if not r then say("Remote não encontrado (o jogo pode ter mudado)."); return end
		local ok, err = pcall(function() r:FireServer(kind, id, nil, true) end)
		say(ok and okMsg or ("Falhou: " .. tostring(err):sub(1, 50)))
	end

	rowBtn(page, "Tocar no rádio (com o rádio na mão)", function()
		local id = digits(idBox.Text)
		if not id then say("Digite um ID de música válido."); return end
		send("PlayerToolEvent", "ToolMusicText", id, "Tocando " .. id .. " no rádio.")
	end, true)
	rowBtn(page, "Parar rádio", function()
		send("PlayerToolEvent", "ToolMusicStop", "", "Pedido de parar enviado (rádio).")
	end, true)
	rowBtn(page, "Tocar no hoverboard (em cima dele)", function()
		local id = digits(idBox.Text)
		if not id then say("Digite um ID de música válido."); return end
		send("NoMotorVehicles", "PickingScooterMusicText", id, "Tocando " .. id .. " no hoverboard.")
	end, true)
	rowBtn(page, "Parar hoverboard", function()
		send("NoMotorVehicles", "PickingScooterMusicStop", "", "Pedido de parar enviado (hoverboard).")
	end, true)

	-- ===== Lista de músicas por categoria: clica na música e já toca (rádio + hoverboard), sem botão de iniciar =====
	-- Para adicionar mais: { "Nome", "ID" } dentro da categoria. IDs do Roblox podem ser removidos por copyright com o tempo.
	local CATS = {
		{ "Funk", {
			{ "Lolove12", "87047691839817" },
			{ "Paryleak", "137122989143345" },
			{ "Aplico", "86866545861125" },
			{ "União", "107991235917983" },
			{ "Hospitalar", "96259351729049" },
			{ "Pé Direito", "127870629973068" },
			{ "Tou Na Onda", "93483751210667" },
			{ "Montagem Vapo", "125618702364556" },
			{ "Funk Bruxaria", "130806788012841" },
			{ "Montagem Malvada", "93517492369858" },
			{ "Jantar Família", "103043727188319" },
			{ "Toma Toma", "110472284585387" },
			{ "Palhação", "82865274986116" },
			{ "Tremo Mexicana", "110317978973938" },
			{ "Trepa Trepa", "127449416726113" },
			{ "Mega Automotivo", "123211214479861" },
			{ "Se Joga", "81102632991320" },
			{ "Daddy Love", "96223086135288" },
			{ "Romano Mandelado", "128562419041521" },
			{ "Montagem Paquistão", "99812493978684" },
			{ "C Walk", "72451271928975" },
			{ "Mico Lança", "78352220341424" },
			{ "Trem Bala", "137828639403630" },
			{ "DJ Koala", "104767744632555" },
			{ "Tropa Sem Amor", "125784363463466" },
			{ "Fino Agoniante", "127275242574475" },
			{ "Fiquei Louca", "94365050554101" },
			{ "Vem Fuder", "120892610283928" },
			{ "Trono do Inferno", "72411825283910" },
			{ "Vai Sentando", "125681143524900" },
			{ "Bruxaria Carnificina", "133252379616732" },
		} },
		{ "Phonk", {
			{ "Toma Funk Phonk", "129098116998483" },
			{ "Mano Mama Funk Phonk (Slowed)", "102827114027930" },
			{ "Funk Inferna V2 (Deep Slowed)", "86375151296706" },
			{ "Phonk do Brazil (Slowed)", "130973511966646" },
			{ "Montagem Aura", "126132092368935" },
			{ "Aura (Brazilian Phonk)", "95131770144654" },
			{ "2 Phut Hon (Brazilian Phonk)", "74793860481732" },
			{ "Burning Memory Phonk Funk", "138608395929191" },
			{ "Roblox Phonk", "136932193331774" },
			{ "Roblox Gigachad Phonk", "134366188285514" },
		} },
		{ "Trap", {
			{ "Zyfrov", "126598871221536" },
			{ "Vultoos", "102496417270481" },
			{ "Bones Peter", "131732922520812" },
			{ "Dollywood", "92910708106749" },
			{ "M0v", "73331494945527" },
			{ "Lil Thraxx", "103937054856795" },
			{ "Música Maneira", "117851917298332" },
			{ "Lil Thraxx 2", "97579385668466" },
			{ "Xyou Nerd", "89504626940165" },
			{ "Twikipédia", "112745389786803" },
			{ "Jwrld", "78199735541718" },
			{ "Pimp Talk", "133029122379275" },
			{ "Boate Azul", "106412079335663" },
			{ "Cogulândia", "113043854379729" },
			{ "Fuxk Hemet", "100840031560163" },
			{ "Meds", "106919797884300" },
			{ "My Way", "97076200765290" },
			{ "Será", "116265374907350" },
			{ "Coração Cristal", "122804427482332" },
			{ "Shine XD", "95767131536863" },
			{ "Cara Ocupado", "117584211896757" },
			{ "Hylander", "88307287482579" },
			{ "O Que Aconteceu", "122910138671900" },
			{ "Pjl", "71769226351576" },
			{ "Allah Juug", "97895636894075" },
			{ "Allah Juug 2", "113113973159525" },
			{ "Quarto Louco", "128520985644446" },
			{ "California Dream", "83668612105042" },
			{ "Mac10", "107357257872547" },
			{ "Caeljugz", "117971511297355" },
			{ "Fumadouro", "138361625716987" },
			{ "Fuck12Fuck17", "73198805524530" },
			{ "Yung Exu 2", "115059931257189" },
			{ "For My Girl", "71393805905055" },
			{ "True Kolorxx", "96037807724498" },
			{ "Met Her", "74347230850239" },
			{ "Trench Boy", "92644389545906" },
			{ "Lucas Daplug", "99333448689558" },
			{ "Yung Exu", "122532900279907" },
			{ "Dontcryforhoes", "106231505841465" },
			{ "Lil Ze", "114112648499028" },
			{ "Ela Desligou", "99358587594632" },
			{ "Fire1900", "140290669622809" },
			{ "Mil Refrões", "121828582805268" },
			{ "Garota Hi-Tech", "71750528836965" },
			{ "Rolê Flacko", "136492273841253" },
			{ "Borges 2020", "119825256314153" },
			{ "Chicago", "72565881952543" },
			{ "Kunk de 50", "129787180541266" },
			{ "Backstage", "133348867136414" },
			{ "Fire2000", "92403543810906" },
			{ "Balão Gang", "112485922236528" },
			{ "Iphone Branco", "103288558732219" },
			{ "R-Baby", "111956898780672" },
			{ "Rip Fredo", "82533576915716" },
		} },
		{ "Forró e Sertanejo", {
			{ "Máquina do Tempo", "139804920241550" },
			{ "Nossa Nossa", "132733152117833" },
			{ "Cadeira de Aço", "96888228525073" },
			{ "Amor ou Litrão", "111551362636063" },
			{ "Litrão 2", "75474964672565" },
			{ "Gestão LV", "111425053457342" },
			{ "Oh Kanalha", "123785985180086" },
			{ "Amar Pecado", "89460438416730" },
			{ "Tudo Que Quiser", "79536757614336" },
			{ "Chuva de Arroz", "102120036739514" },
			{ "Culpa Nossa", "72213295707216" },
			{ "Notificação", "90137280531474" },
			{ "Boate Azul", "106412079335663" },
			{ "Agente Nega", "122871200237533" },
			{ "Tava Pensando", "82929658013383" },
			{ "Oh Polêmico", "97825347303470" },
			{ "Foi Só Uma", "84624301411909" },
		} },
		{ "Músicas e Memes Aleatório", {
			{ "Phonk Roblox Meme", "135209837340816" },
			{ "A Roblox Rap", "1259050178" },
			{ "Mii Channel", "143666548" },
			{ "Wii Music", "1305251774" },
			{ "Elevator Music", "130768299" },
			{ "Elevator Music 2", "9119119619" },
			{ "Chill Jazz", "926493242" },
			{ "Revenge (Minecraft)", "3807239428" },
			{ "AC/DC - Thunderstruck", "146961487" },
			{ "2Pac - Life Goes On", "186317099" },
			{ "Rauw Alejandro - Todo De Ti", "6887728970" },
		} },
	}
	-- "Todas as músicas" = tudo junto, sem repetir ID
	do
		local all, seen = {}, {}
		for _, c in ipairs(CATS) do
			for _, s in ipairs(c[2]) do
				if not seen[s[2]] then seen[s[2]] = true; table.insert(all, s) end
			end
		end
		table.insert(CATS, 1, { "Todas as músicas", all })
	end

	local GRAY = Color3.fromRGB(170, 130, 130)
	local songRows, catUI, nowPlaying = {}, {}, nil

	local function fire(plain, kind, id)
		local r = reByPlain(plain)
		if not r then return false end
		return (pcall(function() r:FireServer(kind, id, nil, true) end))
	end
	-- toca no rádio (caixa) e no hoverboard ao mesmo tempo
	local function playSong(name, id)
		idBox.Text = id
		local a = fire("PlayerToolEvent", "ToolMusicText", id)
		local b = fire("NoMotorVehicles", "PickingScooterMusicText", id)
		if a or b then
			say("Tocando: " .. name)
			nowPlaying = id
			for _, s in ipairs(songRows) do s.label.TextColor3 = (s.id == id) and RED or WHITE end
		else
			say("Remote não encontrado (o jogo pode ter mudado).")
		end
	end

	section(page, "Lista de músicas (clica e já toca)")
	local searchBox = inputRow("Buscar por nome (ex: tiki, phonk, forró)")

	for _, cat in ipairs(CATS) do
		local wrap = mk("Frame", { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1 }, page)
		mk("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, wrap)

		local head = mk("TextButton", { Text = "", Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2, LayoutOrder = 1 }, wrap)
		round(head, 19); stroke(head, 2)
		mk("TextLabel", {
			Text = cat[1], Size = UDim2.new(1, -90, 0, 22), Position = UDim2.fromOffset(16, 3), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
		}, head)
		mk("TextLabel", {
			Text = #cat[2] .. " músicas", Size = UDim2.new(1, -90, 0, 12), Position = UDim2.fromOffset(16, 22), BackgroundTransparency = 1,
			TextColor3 = GRAY, Font = Enum.Font.Gotham, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left,
		}, head)
		local arrow = mk("TextLabel", {
			Text = "+", Size = UDim2.fromOffset(30, 38), Position = UDim2.new(1, -40, 0, 0), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 20,
		}, head)

		local body = mk("Frame", { Size = UDim2.new(1, -14, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Visible = false, LayoutOrder = 2 }, wrap)
		mk("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, body)
		mk("UIPadding", { PaddingLeft = UDim.new(0, 14) }, body)

		local ui = { wrap = wrap, body = body, arrow = arrow, open = false, songs = {}, cat = cat[1] }
		for _, s in ipairs(cat[2]) do
			local row = mk("TextButton", { Text = "", Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, body)
			round(row, 15); stroke(row, 1.2)
			local lbl = mk("TextLabel", {
				Text = s[1], Size = UDim2.new(1, -110, 1, 0), Position = UDim2.fromOffset(14, 0), BackgroundTransparency = 1,
				TextColor3 = (s[2] == nowPlaying) and RED or WHITE, Font = Enum.Font.Gotham, TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
			}, row)
			mk("TextLabel", {
				Text = "▶ " .. s[2], Size = UDim2.fromOffset(92, 30), Position = UDim2.new(1, -98, 0, 0), BackgroundTransparency = 1,
				TextColor3 = GRAY, Font = Enum.Font.Gotham, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd,
			}, row)
			row.MouseButton1Click:Connect(function() playSong(s[1], s[2]) end)
			table.insert(songRows, { id = s[2], label = lbl })
			table.insert(ui.songs, { name = s[1], row = row })
		end
		head.MouseButton1Click:Connect(function()
			ui.open = not ui.open
			body.Visible = ui.open
			arrow.Text = ui.open and "–" or "+"
		end)
		table.insert(catUI, ui)
	end

	-- busca por nome: filtra as músicas de todas as categorias e abre as que tiverem resultado
	local function refresh()
		local q = (searchBox.Text or ""):lower()
		for _, c in ipairs(catUI) do
			local any = false
			for _, s in ipairs(c.songs) do
				local show = q == "" or (s.name:lower():find(q, 1, true) ~= nil) or (c.cat:lower():find(q, 1, true) ~= nil)
				s.row.Visible = show
				if show then any = true end
			end
			c.wrap.Visible = (q == "") or any
			c.body.Visible = (q ~= "" and any) or (q == "" and c.open)
			c.arrow.Text = c.body.Visible and "–" or "+"
		end
	end
	searchBox:GetPropertyChangedSignal("Text"):Connect(refresh)

	-- digitar um ID na caixa de cima e apertar Enter também já toca
	idBox.FocusLost:Connect(function(enter)
		if enter then
			local id = digits(idBox.Text)
			if id then playSong(id, id) else say("Digite um ID de música válido.") end
		end
	end)

	-- ===== Tag em cima da cabeça (só você e o ADM veem) =====
	page = pages["Tag"]
	TAG.avail = true
	TAG.start()
	section(page, "Tag em cima da cabeça")
	mk("TextLabel", {
		Text = "Letreiro grande em cima de você, visível pra você e pro ADM. O cargo embaixo (Membro / ADM / Dono) é o ADM quem define.",
		Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(240, 210, 210),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local _, setTagOn = toggleRow(page, "Mostrar tag", "Liga/desliga o letreiro", function(v)
		TAG.on = v; TAG.refresh()
		if TAG.push then TAG.push() end
	end, TAG.on)
	local tagBox = inputRow("Nome da tag (máx. 16 letras)")
	tagBox.Text = TAG.text
	local fontBtn, roleLbl
	fontBtn = rowBtn(page, "Fonte: " .. TAG.font, function()
		local i = table.find(TAG_FONTS, TAG.font) or 1
		TAG.font = TAG_FONTS[i % #TAG_FONTS + 1]
		fontBtn:FindFirstChildOfClass("TextLabel").Text = "Fonte: " .. TAG.font
		TAG.refresh()
		if TAG.push then TAG.push() end
	end, true)
	rowBtn(page, "Aplicar nome da tag", function()
		local t = (tagBox.Text:gsub("^%s+", ""))
		t = (t:gsub("%s+$", ""))
		if t == "" then say("Digite o nome da tag."); return end
		TAG.text = t:sub(1, 16)
		TAG.refresh()
		if TAG.push then TAG.push() end
		say("Tag: " .. TAG.text)
	end, true)
	roleLbl = mk("TextLabel", {
		Text = "Cargo: " .. TAG.role .. " (definido pelo ADM)", Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
	}, page)
	TAG.onChanged = function()
		tagBox.Text = TAG.text
		fontBtn:FindFirstChildOfClass("TextLabel").Text = "Fonte: " .. TAG.font
		roleLbl.Text = "Cargo: " .. TAG.role .. " (definido pelo ADM)"
		setTagOn(TAG.on)
	end

	table.insert(conns, { Disconnect = function() alive = false end })
end

-- ===== Detecta o jogo: cada jogo só mostra as abas dele =====
local GAMES = {
	Brookhaven = { 4924922222 },
	["Natural Disaster"] = { 189707 },
}
local function inGame(name)
	for _, id in ipairs(GAMES[name] or {}) do
		if game.PlaceId == id then return true end
	end
	return false
end
local function buildTabs(last)
	local t = { "Scripts" }
	if inGame("Brookhaven") then table.insert(t, "Brookhaven") end
	if inGame("Natural Disaster") then table.insert(t, "Natural Disaster") end
	for _, n in ipairs({ "Mod", "Efeitos", "Extras" }) do table.insert(t, n) end -- comuns aos dois jogos
	for _, n in ipairs(last) do table.insert(t, n) end
	return t
end

-- ===== Menu Brookhaven: UMA aba só, com sub-abas (Nome, Música, Tag, Avatar, Proteções, Movimento) =====
local function addSubTabs(host, names)
	local bar = mk("Frame", { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 1 }, host)
	mk("UIGridLayout", { CellSize = UDim2.new(0.333, -5, 0, 26), CellPadding = UDim2.fromOffset(5, 5), SortOrder = Enum.SortOrder.LayoutOrder }, bar)
	local subs, chips = {}, {}
	local function pick(n)
		for k, f in pairs(subs) do f.Visible = (k == n) end
		for k, c in pairs(chips) do c.BackgroundColor3 = (k == n) and Color3.fromRGB(70, 10, 14) or PANEL end
	end
	for i, n in ipairs(names) do
		local c = mk("TextButton", {
			Text = n, LayoutOrder = i, BackgroundColor3 = PANEL, BackgroundTransparency = 0.1,
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 11,
		}, bar)
		round(c, 13); stroke(c, 1.5)
		local f = mk("Frame", { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Visible = false, LayoutOrder = 2 }, host)
		mk("UIListLayout", { Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, f)
		subs[n], chips[n] = f, c
		c.MouseButton1Click:Connect(function() pick(n) end)
	end
	pick(names[1])
	return subs
end

local win, pages, say = buildWindow(560, 330, "Shin Hub", "Membro", buildTabs({ "Conexão", "Créditos" }))
-- sub-abas do Brookhaven (as funções do Brookhaven ficam todas dentro do menu Brookhaven)
do
	local real = pages
	pages = {}
	for k, v in pairs(real) do pages[k] = v end
	if real["Brookhaven"] then
		local subs = addSubTabs(real["Brookhaven"], { "Nome", "Música", "Tag", "Proteções", "Movimento" })
		for n, f in pairs(subs) do pages[n] = f end
	end
end
selfCleanup = buildSelf(pages, say)
if pages["Nome"] then buildBrookhaven(pages, say) end
buildCredits(pages["Créditos"])
local stopMods = buildMods(pages["Mod"], say)
local stopFx = buildEffects(pages["Efeitos"], say)
local stopExtras = buildExtras(pages["Extras"], say)
do
	local base = selfCleanup
	selfCleanup = function() if base then base() end; stopMods(); stopFx(); stopExtras(); if TAG.stop then TAG.stop() end end
end

-- ===== Aba Conexão (status + Desativar ficam dentro do menu) =====
local shutdown
local cp = pages["Conexão"]
section(cp, "Conexão com o painel")
local info = mk("TextLabel", {
	Text = "Conectando...", Size = UDim2.new(1, 0, 0, 40), BackgroundTransparency = 1, TextColor3 = WHITE,
	Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
}, cp)
rowBtn(cp, "Desativar (sair do painel)", function() if shutdown then shutdown() end end)

-- aviso rápido na tela quando o admin usa um comando
function toast(t)
	local l = mk("TextLabel", {
		Text = t, Size = UDim2.fromOffset(240, 30), Position = UDim2.new(0.5, -120, 0, 60),
		BackgroundColor3 = Color3.fromRGB(110, 15, 20), TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 12,
	}, gui)
	round(l, 10); stroke(l, 1.5)
	task.delay(4, function() l:Destroy() end)
end

floatButton(function() win.Visible = not win.Visible end)
table.insert(conns, UIS.InputBegan:Connect(function(i, gp)
	-- atalho do teclado: RightShift abre/fecha o menu
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
	http("DELETE", "/members/" .. uid .. ".json")
	gui:Destroy()
end

-- presença (a cada 5s) + estado dos efeitos do admin (também enviado na hora que muda)
local beat = 0
local function presenceBody()
	local root = hrp()
	return {
		name = lp.Name, uid = lp.UserId, place = game.PlaceId, job = game.JobId, beat = beat,
		fire = (root and root:FindFirstChild("ShinFire") ~= nil) or nil,
		rocket = FXS.rocket or nil,
		jail = FXS.jail,
		boom = FXS.boom,
		tag = TAG.avail and { on = TAG.on, text = TAG.text, font = TAG.font, role = TAG.role } or nil,
	}
end
function pushPresence()
	if alive then http("PUT", "/members/" .. uid .. ".json", presenceBody()) end
end
TAG.push = function() task.spawn(pushPresence) end
table.insert(conns, lp.CharacterAdded:Connect(function() task.wait(1); pushPresence() end))
task.spawn(function()
	while alive do
		beat = beat + 1
		local r = http("PUT", "/members/" .. uid .. ".json", presenceBody())
		if r ~= nil then
			if not info.Text:find("Admin usou") then info.Text = "● Conectado ao painel" end
		else
			info.Text = "✖ Sem conexão: " .. lastErr
		end
		task.wait(5)
	end
end)

-- recebe comandos (a cada 2s). O primeiro comando lido só marca o ponto de partida.
task.spawn(function()
	local lastId, ready = nil, false
	while alive do
		local body = http("GET", "/cmd/" .. uid .. ".json")
		if body ~= nil then
			local c
			if body ~= "null" and body ~= "" then
				local ok, d = pcall(HttpService.JSONDecode, HttpService, body)
				if ok and type(d) == "table" then c = d end
			end
			if not ready then
				ready = true
				lastId = c and c.id or nil
			elseif c and c.id ~= lastId then
				lastId = c.id
				local fn = ACTIONS[c.action]
				if fn and c.job == game.JobId then
					info.Text = "Admin usou: " .. tostring(c.action)
					toast("Admin usou: " .. tostring(c.action))
					pcall(fn, c)
				end
			end
		end
		task.wait(2)
	end
end)
