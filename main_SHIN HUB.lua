-- Shin Hub | MEMBRO v3
-- Começa com uma tela de carregamento (5s). Os comandos do admin são FIXOS (lista ACTIONS).
local DB = "https://site-0ds-default-rtdb.firebaseio.com"
local API_KEY = "AIzaSyB_-Q7ZI2nxQhpd0z-kxHeg7v5bSL_MBj8" -- a mesma chave de API da Web do admin (não é segredo)
local ADMIN_EMAIL, ADMIN_PASSWORD = nil, nil -- só o script do admin usa
local BG_URL = "https://i.postimg.cc/50Wf56pX/e288c5a05c52f160f09a367703e89231.jpg"
local ICON_URL = "https://i.postimg.cc/R0HMnc77/85b8ac8bcf9f322d967a6ed4b5e8bf6b.jpg" -- foto do botão flutuante
local FOLDER = "SHIN HUB"

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

-- ===== LOG / DIAGNÓSTICO =====
-- Tudo que o hub faz (e todo erro) vai pra cá: aparece na aba "Debug" e é salvo em SHIN HUB/log.txt
-- (o log da execução anterior fica em SHIN HUB/log_anterior.txt). Na aba Debug use "Copiar log" pra mandar o erro.
local DSLOG = { lines = {}, pending = {}, max = 3000, t0 = os.clock(), file = FOLDER .. "/log.txt",
	n = { INFO = 0, WARN = 0, ERRO = 0 }, subs = {}, last = nil, rep = 0, alive = true }
pcall(function()
	if isfolder and not isfolder(FOLDER) then makefolder(FOLDER) end
	if isfile and readfile and writefile and isfile(DSLOG.file) then
		writefile(FOLDER .. "/log_anterior.txt", readfile(DSLOG.file))
	end
	if writefile then writefile(DSLOG.file, "") end
end)
local function dsEmit(level, tag, msg)
	local one = tostring(msg):gsub("[\r\n]+", " | ")
	local line = string.format("[%s +%6.1fs] %-4s %-10s %s", os.date("%H:%M:%S"), os.clock() - DSLOG.t0, level, tag, one)
	table.insert(DSLOG.lines, { level, line })
	if #DSLOG.lines > DSLOG.max then table.remove(DSLOG.lines, 1) end
	DSLOG.n[level] = (DSLOG.n[level] or 0) + 1
	table.insert(DSLOG.pending, line)
	for _, f in ipairs(DSLOG.subs) do pcall(f) end
end
function DSLOG.add(level, tag, msg)
	local key = level .. "|" .. tag .. "|" .. tostring(msg)
	if key == DSLOG.last then DSLOG.rep = DSLOG.rep + 1; return end -- mesma linha de novo: só conta
	if DSLOG.rep > 0 then dsEmit("INFO", "log", "(a linha acima se repetiu mais " .. DSLOG.rep .. "x)"); DSLOG.rep = 0 end
	DSLOG.last = key
	dsEmit(level, tag, msg)
end
function DSLOG.info(tag, msg) DSLOG.add("INFO", tag, msg) end
function DSLOG.warn(tag, msg) DSLOG.add("WARN", tag, msg) end
function DSLOG.err(tag, msg) DSLOG.add("ERRO", tag, msg) end
function DSLOG.ev(level, tag, msg) dsEmit(level, tag, msg) end -- sempre registra (sem juntar linhas repetidas)
-- roda protegido: se der erro, registra com o traceback e devolve false
function DSLOG.try(tag, fn, ...)
	local res = table.pack(xpcall(fn, function(e)
		local tb = ""
		pcall(function() tb = debug.traceback("", 2) end)
		return tostring(e) .. " @ " .. tb:gsub("%s*\n%s*", " > ")
	end, ...))
	if not res[1] then DSLOG.err(tag, res[2]); return false end
	return true, table.unpack(res, 2, res.n)
end
local function dsFlush()
	if #DSLOG.pending == 0 then return end
	local txt = table.concat(DSLOG.pending, "\n") .. "\n"
	DSLOG.pending = {}
	pcall(function()
		if appendfile then
			appendfile(DSLOG.file, txt)
		elseif writefile then
			local all = {}
			for _, l in ipairs(DSLOG.lines) do all[#all + 1] = l[2] end
			writefile(DSLOG.file, table.concat(all, "\n") .. "\n")
		end
	end)
end
DSLOG.flush = dsFlush
task.spawn(function()
	while DSLOG.alive do task.wait(2); dsFlush() end
end)
function DSLOG.header()
	local ex = "?"
	pcall(function() local n, v = identifyexecutor(); ex = tostring(n) .. " " .. tostring(v or "") end)
	local function has(f) return f and "sim" or "NÃO" end
	return table.concat({
		"Shin Hub log | " .. os.date("%Y-%m-%d %H:%M:%S"),
		"executor: " .. ex,
		"jogo: PlaceId " .. tostring(game.PlaceId) .. " | JobId " .. tostring(game.JobId),
		"jogador: " .. lp.Name .. " (" .. lp.UserId .. ")",
		"funções: request=" .. has(req) .. " getcustomasset=" .. has(getcustomasset) .. " appendfile=" .. has(appendfile)
			.. " setclipboard=" .. has(setclipboard) .. " gethui=" .. has(gethui),
		"contagem: " .. DSLOG.n.INFO .. " info, " .. DSLOG.n.WARN .. " avisos, " .. DSLOG.n.ERRO .. " erros",
	}, "\n")
end
function DSLOG.dump(onlyProblems)
	local out = { DSLOG.header(), "------" }
	for _, l in ipairs(DSLOG.lines) do
		if not onlyProblems or l[1] ~= "INFO" then out[#out + 1] = l[2] end
	end
	return table.concat(out, "\n")
end
-- foto do estado do personagem: acessórios no Humanoid, quais são do hub, quantos originais estão guardados
function DSLOG.charState(char, who)
	if not char then DSLOG.warn("avatar", tostring(who or "?") .. ": sem personagem agora"); return end
	local hm = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	local parts, nMod, st = {}, 0, char:FindFirstChild("DsStash")
	local function far(a)
		local h = a:FindFirstChild("Handle")
		if not h then return "(SEM Handle)" end
		if root and (h.Position - root.Position).Magnitude > 15 then return "(LONGE do corpo)" end
		return ""
	end
	if hm then
		for _, a in ipairs(hm:GetAccessories()) do
			parts[#parts + 1] = a.Name .. (a:GetAttribute("DsMod") and "[hub]" or "") .. far(a)
		end
	end
	local man = char:FindFirstChild("DsAcc")
	if man then
		for _, a in ipairs(man:GetChildren()) do parts[#parts + 1] = a.Name .. "[hub-manual]" .. far(a) end
	end
	for _, d in ipairs(char:GetDescendants()) do
		if d:GetAttribute("DsMod") then nMod = nMod + 1 end
	end
	DSLOG.info("avatar", string.format("%s | rig=%s | acessórios(%d): %s | itens do hub=%d | originais guardados=%d | sig=%s",
		tostring(who or char.Name), hm and hm.RigType.Name or "?", #parts,
		#parts > 0 and table.concat(parts, ", ") or "nenhum", nMod, st and #st:GetChildren() or 0, tostring(char:GetAttribute("DsSig") or "-")))
end
for l in DSLOG.header():gmatch("[^\n]+") do DSLOG.info("início", l) end

-- ===== LOGIN NO FIREBASE (o banco só responde pra quem estiver logado) =====
-- Membro: login anônimo automático (a sessão fica em SHIN HUB/auth.json, então o ID dele não muda).
-- Admin: e-mail e senha da conta criada no Firebase. A senha vai só pro Google (HTTPS), NUNCA pro banco.
local AUTH = { idToken = nil, refresh = nil, uid = nil, exp = 0, busy = false, err = nil, failAt = nil }
local AUTH_FILE = FOLDER .. "/auth.json"
local function scrub(s)
	return (tostring(s):gsub("auth=[%w%-%._~]+", "auth=***"):gsub("key=[%w%-%._]+", "key=***"))
end
local function authCall(url, body, form)
	if not req then return nil, "executor sem request()" end
	local ok, res = pcall(req, {
		Url = url, Method = "POST",
		Headers = { ["Content-Type"] = form and "application/x-www-form-urlencoded" or "application/json" },
		Body = form and body or HttpService:JSONEncode(body),
	})
	if not ok then return nil, scrub(res):sub(1, 80) end
	local okj, d = pcall(HttpService.JSONDecode, HttpService, res.Body or "")
	if not okj or type(d) ~= "table" then d = {} end
	if (res.Success or res.StatusCode == 200) and not d.error then return d end
	local why = type(d.error) == "table" and d.error.message or ("HTTP " .. tostring(res.StatusCode))
	return nil, tostring(why):sub(1, 80)
end
pcall(function()
	if not ADMIN_EMAIL and isfile and readfile and isfile(AUTH_FILE) then
		local d = HttpService:JSONDecode(readfile(AUTH_FILE))
		if type(d) == "table" and type(d.refresh) == "string" then AUTH.refresh = d.refresh end
	end
end)
local function authSave()
	if ADMIN_EMAIL then return end
	pcall(function()
		if writefile then
			if isfolder and not isfolder(FOLDER) and makefolder then makefolder(FOLDER) end
			writefile(AUTH_FILE, HttpService:JSONEncode({ refresh = AUTH.refresh }))
		end
	end)
end
local function authLogin()
	if API_KEY == "" or API_KEY:find("COLE_AQUI") then
		AUTH.err = "falta colocar a API_KEY no topo do script"
		return nil
	end
	local base = "https://identitytoolkit.googleapis.com/v1/accounts:"
	local d, e
	if AUTH.refresh then
		local r = authCall("https://securetoken.googleapis.com/v1/token?key=" .. API_KEY,
			"grant_type=refresh_token&refresh_token=" .. HttpService:UrlEncode(AUTH.refresh), true)
		if r and r.id_token then
			d = { idToken = r.id_token, refreshToken = r.refresh_token or AUTH.refresh, localId = r.user_id, expiresIn = r.expires_in }
		end
	end
	if not d then
		if ADMIN_EMAIL then
			d, e = authCall(base .. "signInWithPassword?key=" .. API_KEY,
				{ email = ADMIN_EMAIL, password = ADMIN_PASSWORD, returnSecureToken = true })
		else
			d, e = authCall(base .. "signUp?key=" .. API_KEY, { returnSecureToken = true })
		end
	end
	if not d or not d.idToken then AUTH.err = e or "login falhou"; return nil end
	AUTH.idToken, AUTH.refresh, AUTH.uid = d.idToken, d.refreshToken, d.localId
	AUTH.exp = os.clock() + math.max(60, (tonumber(d.expiresIn) or 3600) - 120)
	AUTH.err = nil
	authSave()
	return AUTH.idToken
end
-- devolve um token válido (renova sozinho). Várias tarefas pedindo ao mesmo tempo esperam o mesmo login.
function AUTH.token()
	if AUTH.idToken and os.clock() < AUTH.exp then return AUTH.idToken end
	if AUTH.busy then
		local t0 = os.clock()
		while AUTH.busy and os.clock() - t0 < 20 do task.wait(0.1) end
		if AUTH.idToken and os.clock() < AUTH.exp then return AUTH.idToken end
		return nil
	end
	if AUTH.failAt and os.clock() - AUTH.failAt < 10 then return nil end -- falhou há pouco: não fica martelando
	AUTH.busy = true
	local ok, tok = pcall(authLogin)
	AUTH.busy = false
	if ok and tok then AUTH.failAt = nil; return tok end
	AUTH.failAt = os.clock()
	if not ok then AUTH.err = scrub(tok):sub(1, 80) end
	DSLOG.err("auth", "login no Firebase falhou: " .. tostring(AUTH.err))
	return nil
end
function AUTH.id() AUTH.token(); return AUTH.uid end

-- ===== HTTP (mostra o erro real) =====
local lastErr = ""
local function http(method, path, body)
	if not req then lastErr = "executor sem request()"; DSLOG.err("http", lastErr); return nil end
	local tok = AUTH.token()
	if not tok then lastErr = "sem login: " .. tostring(AUTH.err or "?"); return nil end
	local ok, res = pcall(req, {
		Url = DB .. path .. "?auth=" .. tok, Method = method,
		Headers = { ["Content-Type"] = "application/json" },
		Body = body and HttpService:JSONEncode(body) or nil,
	})
	if not ok then
		lastErr = scrub(res):sub(1, 60)
		DSLOG.err("http", method .. " " .. path .. " falhou: " .. scrub(res):sub(1, 120))
		return nil
	end
	local code = res.StatusCode or 0
	if res.Success or code == 200 then lastErr = ""; return res.Body or "" end
	if code == 401 then AUTH.exp = 0 end -- token recusado: renova no próximo pedido
	lastErr = "HTTP " .. tostring(code) .. " " .. scrub(res.Body or ""):sub(1, 50)
	DSLOG.err("http", method .. " " .. path .. " -> " .. lastErr) -- (o corpo enviado nunca vai pro log)
	return nil
end

-- ===== UI helpers =====
local RED = Color3.fromRGB(222, 52, 68)
local PANEL = Color3.fromRGB(26, 27, 33)
local WHITE = Color3.new(1, 1, 1)
local function mk(class, props, par)
	local o = Instance.new(class)
	for k, v in pairs(props) do o[k] = v end
	o.Parent = par
	return o
end
local function round(o, r) mk("UICorner", { CornerRadius = UDim.new(0, r or 8) }, o) end
local function stroke(o, th, col)
	mk("UIStroke", { Thickness = th or 1.5, Color = col or Color3.fromRGB(70, 72, 86), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, o)
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
local old = parent:FindFirstChild("ShinHubMembro")
if old then old:Destroy() end
local gui = mk("ScreenGui", { Name = "ShinHubMembro", ResetOnSpawn = false, IgnoreGuiInset = true }, parent)
gui.Destroying:Connect(function()
	DSLOG.alive = false
	dsFlush()
	if DSLOG.lsConn then DSLOG.lsConn:Disconnect() end
end)
-- erros do próprio script que aparecem no console do executor também entram no log
pcall(function()
	DSLOG.lsConn = game:GetService("LogService").MessageOut:Connect(function(msg, mt)
		if mt == Enum.MessageType.MessageError and (msg:find("^%[string") or msg:find("Shin")) then
			DSLOG.err("console", msg:sub(1, 200))
		end
	end)
end)

local function isPress(i)
	return i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch
end
local function isMove(i)
	return i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch
end

-- arrasta "target" segurando "handle"; se só tocar (sem arrastar) chama onTap
-- onDrop(target) roda ao soltar depois de arrastar; clamp(target) segura o alvo dentro da tela enquanto arrasta
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
-- impede a janela de sumir da tela: a barra do topo sempre fica alcançável
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

-- ===== TEMA + DETECÇÃO DE DISPOSITIVO (PC / Mobile) =====
local UI = {
	ACTIVE = Color3.fromRGB(82, 26, 36), HOVER = Color3.fromRGB(36, 37, 45), EDGE = Color3.fromRGB(70, 72, 86),
	DIM = Color3.fromRGB(150, 155, 168), SOFT = Color3.fromRGB(128, 134, 148), GLOW = Color3.fromRGB(255, 80, 96),
	pc = false, listeners = {}, scaleFns = {}, bgFns = {}, keyFns = {},
	cfg = { scale = 1, accent = "Vermelho", bgOpacity = 100, bgImage = true, anim = true, key = "B", floatBtn = true, fps = false },
}
function UI.tween(o, t, props)
	pcall(function()
		game:GetService("TweenService"):Create(o, TweenInfo.new(UI.cfg.anim == false and 0 or (t or 0.15), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
	end)
end
-- PC = tem teclado e mouse; celular/tablet = toque. Se a pessoa trocar de entrada (tocar na tela / apertar tecla), atualiza sozinho.
UI.key = Enum.KeyCode.B
function UI.keyName() return UI.cfg.key or "B" end
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
	local f = mk("Frame", {
		Size = UDim2.fromOffset(w, h), Position = pos,
		BackgroundColor3 = Color3.fromRGB(15, 16, 20), ClipsDescendants = true,
	}, gui)
	round(f, 14)
	local es = mk("UIStroke", { Thickness = 1.5, Color = RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, f)
	mk("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(222, 52, 68)),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(72, 74, 88)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 46, 56)),
		}),
		Rotation = 90,
	}, es)
	local img = mk("ImageLabel", {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		ScaleType = Enum.ScaleType.Crop, ImageTransparency = 0.86,
	}, f)
	round(img, 14)
	local shade = mk("Frame", {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(15, 16, 20),
		BackgroundTransparency = 0, BorderSizePixel = 0,
	}, f)
	round(shade, 14)
	mk("UIGradient", {
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0.12) }),
		Rotation = 90,
	}, shade)
	-- escala: encaixa na tela do celular e dá uma animação suave ao abrir
	local function fitScale()
		local cam = workspace.CurrentCamera
		if not cam then return 1 end
		local vp = cam.ViewportSize
		local base = math.min((vp.X - 24) / w, (vp.Y - 24) / h)
		return math.min(math.clamp(base, 0.6, 1) * UI.cfg.scale, math.max(base, 0.6))
	end
	local sc = mk("UIScale", { Scale = fitScale() }, f)
	table.insert(UI.scaleFns, function() sc.Scale = fitScale() end)
	table.insert(UI.bgFns, function()
		img.Visible = UI.cfg.bgImage ~= false
		shade.BackgroundTransparency = math.clamp(1 - (UI.cfg.bgOpacity or 100) / 100, 0, 0.7)
	end)
	f:GetPropertyChangedSignal("Visible"):Connect(function()
		if f.Visible then
			local s = fitScale()
			sc.Scale = s * 0.94
			UI.tween(sc, 0.18, { Scale = s })
		end
	end)
	task.spawn(function() local a = fetchAsset(BG_URL, "bg.jpg"); if a then img.Image = a end end)
	return f
end
local function bigBtn(par, text, pos, size, filled)
	local b = mk("TextButton", {
		Text = text, Position = pos, Size = size, AutoButtonColor = false,
		BackgroundColor3 = filled and RED or PANEL, BackgroundTransparency = filled and 0 or 0.1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 14,
	}, par)
	round(b, 14); stroke(b, 1.5, UI.EDGE)
	return b
end

-- janela com menu lateral (estilo hub): abas à esquerda, conteúdo à direita
local ICONS = {
	["Scripts"] = "◆", ["Evade"] = "♦", ["Brookhaven"] = "◇", ["Natural Disaster"] = "▲", ["Mod"] = "★", ["Efeitos"] = "●",
	["Extras"] = "■", ["Conexão"] = "▼", ["Créditos"] = "☆", ["ID"] = "◉", ["Admin"] = "◀", ["Proteções"] = "◈", ["Movimento"] = "▶",
	["Debug"] = "◍", ["Nome"] = "▣", ["Música"] = "♪", ["Tag"] = "✦",
}
local function buildWindow(w, h, title, sub, tabNames, onClose)
	local win = panel(w, h, UDim2.new(0.5, 0, 0.5, 0))
	win.AnchorPoint = Vector2.new(0.5, 0.5)

	-- barra do topo (flutuante, com degradê)
	local top = mk("Frame", {
		Size = UDim2.new(1, -12, 0, 36), Position = UDim2.fromOffset(6, 6),
		BackgroundColor3 = Color3.fromRGB(20, 21, 26), BackgroundTransparency = 0.15, BorderSizePixel = 0,
	}, win)
	round(top, 12)
	mk("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(96, 28, 38)),
			ColorSequenceKeypoint.new(0.6, Color3.fromRGB(30, 31, 38)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 19, 24)),
		}),
	}, top)
	local left = mk("Frame", { Size = UDim2.new(1, -110, 1, 0), Position = UDim2.fromOffset(14, 0), BackgroundTransparency = 1 }, top)
	mk("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder,
	}, left)
	local brand = mk("Frame", { LayoutOrder = -1, Size = UDim2.fromOffset(8, 8), BackgroundColor3 = RED, BorderSizePixel = 0 }, left)
	round(brand, 4)
	mk("TextLabel", {
		Text = title, LayoutOrder = 0, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 36),
		BackgroundTransparency = 1, TextColor3 = WHITE, Font = Enum.Font.GothamBlack, TextSize = 16,
	}, left)
	local function pill(text, order, col)
		local pl = mk("TextLabel", {
			Text = text, LayoutOrder = order, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 18),
			BackgroundColor3 = col, BackgroundTransparency = 0.2, TextColor3 = WHITE,
			Font = Enum.Font.GothamBold, TextSize = 10,
		}, left)
		round(pl, 9)
		mk("UIPadding", { PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 9) }, pl)
		return pl
	end
	pill(sub, 1, Color3.fromRGB(150, 34, 48))
	local devPill = pill("", 2, Color3.fromRGB(44, 46, 54))
	local function devTxt() devPill.Text = UI.pc and ("PC  •  tecla " .. UI.keyName()) or "Mobile" end
	UI.onDevice(devTxt)
	table.insert(UI.keyFns, devTxt)
	makeDraggable(top, win, nil, nil, keepBarOnScreen(top))

	local statusLbl = mk("TextLabel", {
		Position = UDim2.new(0, 172, 1, -26), Size = UDim2.new(1, -186, 0, 20), BackgroundTransparency = 1,
		Text = "", TextColor3 = UI.SOFT, Font = Enum.Font.Gotham,
		TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, win)

	-- fundo da lateral e do conteúdo
	local sideBg = mk("Frame", {
		Position = UDim2.fromOffset(8, 48), Size = UDim2.new(0, 154, 1, -56),
		BackgroundColor3 = Color3.fromRGB(12, 13, 17), BackgroundTransparency = 0.35, BorderSizePixel = 0,
	}, win)
	round(sideBg, 12)
	mk("UIStroke", { Thickness = 1, Color = UI.EDGE, Transparency = 0.6, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, sideBg)
	local contentBg = mk("Frame", {
		Position = UDim2.fromOffset(168, 48), Size = UDim2.new(1, -176, 1, -78),
		BackgroundColor3 = Color3.fromRGB(12, 13, 17), BackgroundTransparency = 0.45, BorderSizePixel = 0,
	}, win)
	round(contentBg, 12)
	mk("UIStroke", { Thickness = 1, Color = UI.EDGE, Transparency = 0.6, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, contentBg)

	-- busca de abas
	local searchBox = mk("TextBox", {
		Position = UDim2.fromOffset(14, 54), Size = UDim2.fromOffset(142, 26), BackgroundColor3 = Color3.fromRGB(20, 21, 26),
		BackgroundTransparency = 0.25, Text = "", PlaceholderText = "🔍 Buscar aba...", PlaceholderColor3 = UI.DIM,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 11, ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left,
	}, win)
	round(searchBox, 9)
	local sbSt = mk("UIStroke", { Thickness = 1.2, Color = UI.EDGE, Transparency = 0.55, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, searchBox)
	mk("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 8) }, searchBox)
	searchBox.Focused:Connect(function() UI.tween(sbSt, 0.12, { Transparency = 0 }) end)
	searchBox.FocusLost:Connect(function() UI.tween(sbSt, 0.12, { Transparency = 0.55 }) end)

	local side = mk("ScrollingFrame", {
		Position = UDim2.fromOffset(10, 86), Size = UDim2.new(0, 150, 1, -96), BackgroundTransparency = 1,
		BorderSizePixel = 0, ScrollBarThickness = 2, ScrollBarImageColor3 = UI.EDGE,
		AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(),
	}, win)
	mk("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }, side)
	mk("UIPadding", { PaddingTop = UDim.new(0, 2), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4) }, side)

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
			tp.badge.BackgroundColor3 = on and RED or UI.HOVER
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
		local b = mk("TextButton", {
			Text = "", AutoButtonColor = false, Size = UDim2.new(1, 0, 0, 28),
			BackgroundColor3 = PANEL, BackgroundTransparency = 0.5,
		}, side)
		round(b, 10)
		UI.onDevice(function(pc) b.Size = UDim2.new(1, 0, 0, pc and 28 or 34) end)
		local bst = mk("UIStroke", { Thickness = 1.2, Color = UI.EDGE, Transparency = 0.65, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
		local badge = mk("Frame", { Size = UDim2.fromOffset(22, 22), Position = UDim2.new(0, 9, 0.5, -11), BackgroundColor3 = UI.HOVER, BorderSizePixel = 0 }, b)
			round(badge, 7)
			local ic = mk("TextLabel", {
				Text = ICONS[name] or "◆", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
				TextColor3 = UI.DIM, Font = Enum.Font.GothamBold, TextSize = 11,
			}, badge)
		local lb = mk("TextLabel", {
			Text = name, Size = UDim2.new(1, -46, 1, 0), Position = UDim2.fromOffset(38, 0),
			BackgroundTransparency = 1, TextColor3 = UI.DIM, Font = Enum.Font.GothamMedium, TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		}, b)
		local bar = mk("Frame", {
			Size = UDim2.fromOffset(3, 14), Position = UDim2.new(0, 3, 0.5, -7),
			BackgroundColor3 = UI.GLOW, BorderSizePixel = 0, Visible = false,
		}, b)
		round(bar, 2)
		local p = mk("ScrollingFrame", {
			Position = UDim2.fromOffset(176, 54), Size = UDim2.new(1, -192, 1, -88), BackgroundTransparency = 1,
			BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = UI.EDGE, AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(), Visible = false,
		}, win)
		mk("UIListLayout", { Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, p)
		mk("UIPadding", { PaddingTop = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8) }, p)
		pages[name], tabBtns[name], bars[name] = p, b, bar
		local tp = { hover = false, stroke = bst, ic = ic, lb = lb, badge = badge }
		parts[name] = tp
		b.MouseEnter:Connect(function() tp.hover = true; paintTab(name) end)
		b.MouseLeave:Connect(function() tp.hover = false; paintTab(name) end)
		b.MouseButton1Click:Connect(function() selectTab(name) end)
	end
	selectTab(tabNames[1])

	-- filtro da busca: esconde as abas que não combinam; Enter abre a primeira que sobrou
	local function applyFilter()
		local q = searchBox.Text:lower():gsub("^%s+", ""):gsub("%s+$", "")
		local first
		for _, name in ipairs(tabNames) do
			local show = (q == "") or (name:lower():find(q, 1, true) ~= nil)
			tabBtns[name].Visible = show
			if show and not first then first = name end
		end
		return first
	end
	searchBox:GetPropertyChangedSignal("Text"):Connect(applyFilter)
	searchBox.FocusLost:Connect(function(enter)
		if enter then
			local f = applyFilter()
			if f and searchBox.Text ~= "" then selectTab(f) end
		end
	end)

	-- botões do topo: engrenagem (abre "Extras"), minimizar e fechar
	local function topBtn(txt, x, size, cb, danger)
		local t = mk("TextButton", {
			Text = txt, Size = UDim2.fromOffset(26, 26), Position = UDim2.new(1, x, 0.5, -13), AutoButtonColor = false,
			BackgroundColor3 = Color3.fromRGB(18, 19, 24), BackgroundTransparency = 0.4,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = size,
		}, top)
		round(t, 13)
		t.MouseEnter:Connect(function()
			UI.tween(t, 0.12, { BackgroundColor3 = danger and Color3.fromRGB(205, 30, 46) or UI.ACTIVE, BackgroundTransparency = 0.05 })
		end)
		t.MouseLeave:Connect(function()
			UI.tween(t, 0.12, { BackgroundColor3 = Color3.fromRGB(18, 19, 24), BackgroundTransparency = 0.4 })
		end)
		t.MouseButton1Click:Connect(cb)
		return t
	end
	topBtn("⚙", -96, 15, function() if UI.toggleSettings then UI.toggleSettings(win) elseif pages["Extras"] then selectTab("Extras") end end)
	topBtn("—", -64, 13, function() win.Visible = false end)
	topBtn("X", -32, 13, function() if onClose then onClose() else win.Visible = false end end, true)

	return win, pages, function(t)
		statusLbl.Text = t
		local s = tostring(t)
		local low = s:lower()
		local bad = low:find("erro") or low:find("não consegui") or low:find("falhou")
		DSLOG.add(bad and "WARN" or "INFO", "ui", s)
	end
end

-- botão flutuante (clica = abre/minimiza o menu)
-- • arrasta livremente e "gruda" na borda mais próxima da tela ao soltar (lembra a posição da próxima vez)
-- • anel girando, pulso quando o menu está fechado, ponto verde quando está aberto
-- • efeito de aperto, balãozinho no PC e entrada animada. 2º parâmetro (win) sincroniza com o menu.
local function floatButton(onTap, winRef)
	local POS_FILE = FOLDER .. "/float_pos.json"
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
	-- posição salva (em fração da tela) ou canto superior esquerdo
	local sx, sy = MARGIN + 2, MARGIN + 64
	pcall(function()
		if isfile and readfile and isfile(POS_FILE) then
			local d = HttpService:JSONDecode(readfile(POS_FILE))
			local a = areaSize()
			if type(d.x) == "number" and type(d.y) == "number" then sx, sy = d.x * a.X, d.y * a.Y end
		end
	end)
	sx, sy = clampPos(sx, sy)

	local root = mk("Frame", { Size = UDim2.fromOffset(SIZE, SIZE), Position = UDim2.fromOffset(sx, sy), BackgroundTransparency = 1 }, gui)
	local rootScale = mk("UIScale", { Scale = 0.01 }, root)

	-- pulso (só com o menu fechado)
	local pulse = mk("Frame", {
		Size = UDim2.fromScale(1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		BackgroundTransparency = 1, ZIndex = 1,
	}, root)
	mk("UICorner", { CornerRadius = UDim.new(1, 0) }, pulse)
	local ps = mk("UIStroke", { Thickness = 2, Color = UI.GLOW, Transparency = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, pulse)
	local pulseScale = mk("UIScale", { Scale = 1 }, pulse)

	local b = mk("ImageButton", {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = PANEL, AutoButtonColor = false,
		ScaleType = Enum.ScaleType.Crop, Image = "", ZIndex = 2,
	}, root)
	mk("UICorner", { CornerRadius = UDim.new(1, 0) }, b)
	local press = mk("UIScale", { Scale = 1 }, b)
	local fs = mk("UIStroke", { Thickness = 2.5, Color = WHITE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
	local ring = mk("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 104)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(110, 10, 20)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 90, 104)),
		}),
	}, fs)
	-- anel girando sem parar
	pcall(function()
		game:GetService("TweenService"):Create(ring, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), { Rotation = 360 }):Play()
	end)
	-- escurece a foto um pouco pro anel e a letra aparecerem bem
	local tint = mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(14, 15, 19), BackgroundTransparency = 0.78, BorderSizePixel = 0, ZIndex = 2 }, b)
	mk("UICorner", { CornerRadius = UDim.new(1, 0) }, tint)
	local fallback = mk("TextLabel", {
		Text = "S", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 3,
		TextColor3 = WHITE, Font = Enum.Font.GothamBlack, TextSize = 20,
	}, b)
	if ICON_URL:find("^http") then
		task.spawn(function()
			local a = fetchAsset(ICON_URL, "icon.png")
			if a then b.Image = a; fallback.Visible = false; tint.BackgroundTransparency = 0.9 end
		end)
	end
	-- selinho "B" aparece só no PC (lembra o atalho)
	local badge = mk("TextLabel", {
		Text = UI.keyName(), Size = UDim2.fromOffset(17, 17), Position = UDim2.new(1, -14, 1, -14), ZIndex = 5,
		BackgroundColor3 = Color3.fromRGB(150, 34, 48), TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 10, Visible = false,
	}, root)
	round(badge, 9)
	mk("UIStroke", { Thickness = 1.5, Color = Color3.fromRGB(13, 14, 18), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, badge)
	UI.onDevice(function(pc) badge.Visible = pc end)
	table.insert(UI.keyFns, function() badge.Text = UI.keyName() end)
	-- ponto de status: verde = menu aberto
	local dot = mk("Frame", {
		Size = UDim2.fromOffset(11, 11), Position = UDim2.new(1, -11, 0, 0), ZIndex = 5,
		BackgroundColor3 = Color3.fromRGB(70, 220, 110), BorderSizePixel = 0, Visible = false,
	}, root)
	round(dot, 6)
	mk("UIStroke", { Thickness = 1.5, Color = Color3.fromRGB(13, 14, 18), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, dot)

	-- balãozinho (PC): aparece do lado de dentro da tela
	local tip = mk("TextLabel", {
		Text = "Shin Hub", Size = UDim2.fromOffset(0, 24), AutomaticSize = Enum.AutomaticSize.X, Visible = false, ZIndex = 6,
		BackgroundColor3 = Color3.fromRGB(20, 21, 26), BackgroundTransparency = 0.05, TextColor3 = WHITE,
		Font = Enum.Font.GothamMedium, TextSize = 11,
	}, root)
	round(tip, 12)
	mk("UIPadding", { PaddingLeft = UDim.new(0, 11), PaddingRight = UDim.new(0, 11) }, tip)
	mk("UIStroke", { Thickness = 1.2, Color = UI.EDGE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, tip)
	local function showTip(on)
		if not UI.pc then tip.Visible = false; return end
		local open = winRef and winRef.Visible
		tip.Text = (open and "Minimizar" or "Abrir menu") .. "  •  " .. UI.keyName()
		local a = areaSize()
		local leftSide = (root.Position.X.Offset + SIZE / 2) < a.X / 2
		tip.AnchorPoint = Vector2.new(leftSide and 0 or 1, 0.5)
		tip.Position = UDim2.new(leftSide and 1 or 0, leftSide and 8 or -8, 0.5, 0)
		tip.Visible = on
	end

	-- estado (aberto/fechado) + pulso
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
		winRef:GetPropertyChangedSignal("Visible"):Connect(syncState)
		syncState()
	end

	-- hover / aperto
	b.MouseEnter:Connect(function()
		UI.tween(press, 0.14, { Scale = 1.1 }); showTip(true)
	end)
	b.MouseLeave:Connect(function()
		UI.tween(press, 0.14, { Scale = 1 }); showTip(false)
	end)
	b.InputBegan:Connect(function(i) if isPress(i) then UI.tween(press, 0.08, { Scale = 0.88 }); tip.Visible = false end end)
	b.InputEnded:Connect(function(i) if isPress(i) then UI.tween(press, 0.14, { Scale = 1 }) end end)

	-- clamp dentro da tela (enquanto arrasta) e "ímã" na borda ao soltar
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

	-- tela mudou de tamanho (girou o celular, etc.): mantém o botão visível
	table.insert(conns, gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		pcall(function() clampBtn(root); snap(root) end)
	end))

	-- entrada animada
	pcall(function()
		game:GetService("TweenService"):Create(rootScale, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	end)
	return root
end

-- linhas / seções das páginas
local function section(par, text)
	local f = mk("Frame", { Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1 }, par)
	local acc = mk("Frame", { Size = UDim2.fromOffset(3, 15), Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = UI.GLOW, BorderSizePixel = 0 }, f)
	round(acc, 2)
	mk("TextLabel", {
		Text = text, Size = UDim2.new(1, -14, 1, 0), Position = UDim2.fromOffset(12, 0), BackgroundTransparency = 1, TextColor3 = WHITE,
		Font = Enum.Font.GothamBold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, f)
	local ln = mk("Frame", { Size = UDim2.new(1, -4, 0, 1), Position = UDim2.new(0, 2, 1, -2), BackgroundColor3 = UI.EDGE, BorderSizePixel = 0 }, f)
	mk("UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) }) }, ln)
end
-- (hover compartilhado pelas linhas)
local function rowHover(b, st)
	b.MouseEnter:Connect(function()
		UI.tween(b, 0.12, { BackgroundColor3 = UI.HOVER, BackgroundTransparency = 0.05 })
		UI.tween(st, 0.12, { Transparency = 0 })
	end)
	b.MouseLeave:Connect(function()
		UI.tween(b, 0.12, { BackgroundColor3 = PANEL, BackgroundTransparency = 0.25 })
		UI.tween(st, 0.12, { Transparency = 0.35 })
	end)
	-- efeito de aperto
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
	local b = mk("TextButton", {
		Text = "", AutoButtonColor = false, Size = UDim2.new(1, 0, 0, hgt), BackgroundColor3 = PANEL, BackgroundTransparency = 0.25,
	}, par)
	round(b, 10)
	local st = mk("UIStroke", { Thickness = 1.2, Color = UI.EDGE, Transparency = 0.35, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
	-- (o texto precisa ser o PRIMEIRO TextLabel: outras abas trocam esse texto)
	mk("TextLabel", {
		Text = text, Size = UDim2.new(1, -44, 1, 0), Position = UDim2.fromOffset(14, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = compact and 12 or 13, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, b)
	local arrow = mk("TextLabel", {
		Text = "›", Size = UDim2.fromOffset(28, hgt), Position = UDim2.new(1, -34, 0, 0), BackgroundTransparency = 1,
		TextColor3 = UI.GLOW, Font = Enum.Font.GothamBold, TextSize = compact and 20 or 24,
	}, b)
	b.MouseEnter:Connect(function() UI.tween(arrow, 0.14, { Position = UDim2.new(1, -28, 0, 0) }) end)
	b.MouseLeave:Connect(function() UI.tween(arrow, 0.14, { Position = UDim2.new(1, -34, 0, 0) }) end)
	rowHover(b, st)
	b.MouseButton1Click:Connect(cb)
	return b
end
local DARK = Color3.fromRGB(40, 41, 49)
local function toggleRow(par, text, desc, onChange, initial)
	if type(desc) == "function" then initial = onChange; onChange, desc = desc, nil end
	local state = initial and true or false
	local b = mk("TextButton", {
		Text = "", AutoButtonColor = false, Size = UDim2.new(1, 0, 0, desc and 48 or 38), BackgroundColor3 = PANEL, BackgroundTransparency = 0.25,
	}, par)
	round(b, 10)
	local st = mk("UIStroke", { Thickness = 1.2, Color = UI.EDGE, Transparency = 0.35, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
	mk("TextLabel", {
		Text = text, Size = UDim2.new(1, -78, 0, desc and 26 or 38), Position = UDim2.fromOffset(14, desc and 3 or 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, b)
	if desc then
		mk("TextLabel", {
			Text = desc, Size = UDim2.new(1, -78, 0, 16), Position = UDim2.fromOffset(14, 27), BackgroundTransparency = 1,
			TextColor3 = UI.SOFT, Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		}, b)
	end
	local sw = mk("Frame", { Size = UDim2.fromOffset(40, 22), Position = UDim2.new(1, -52, 0.5, -11), BackgroundColor3 = DARK, BorderSizePixel = 0 }, b)
	round(sw, 11)
	local sws = mk("UIStroke", { Thickness = 1.5, Color = UI.EDGE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, sw)
	local knob = mk("Frame", { Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(3, 3), BackgroundColor3 = WHITE, BorderSizePixel = 0 }, sw)
	round(knob, 8)
	local function paint(anim)
		local kp = state and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3)
		local sc = state and RED or DARK
		local kc = state and WHITE or Color3.fromRGB(150, 155, 168)
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
	local b = mk("Frame", { Size = UDim2.new(1, 0, 0, 48), BackgroundColor3 = PANEL, BackgroundTransparency = 0.25 }, par)
	round(b, 10)
	mk("UIStroke", { Thickness = 1.2, Color = UI.EDGE, Transparency = 0.35, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
	mk("TextLabel", {
		Text = text, Size = UDim2.new(0.5, -16, 0, 26), Position = UDim2.fromOffset(14, 3), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, b)
	mk("TextLabel", {
		Text = desc, Size = UDim2.new(0.5, -16, 0, 16), Position = UDim2.fromOffset(14, 27), BackgroundTransparency = 1,
		TextColor3 = UI.SOFT, Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	}, b)
	local val = mk("TextLabel", {
		Text = tostring(defV), Size = UDim2.fromOffset(34, 48), Position = UDim2.new(0.5, 0, 0, 0), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 13,
	}, b)
	local hit = mk("Frame", { Size = UDim2.new(0.5, -58, 0, 28), Position = UDim2.new(0.5, 38, 0.5, -14), BackgroundTransparency = 1 }, b)
	local bar = mk("Frame", { Size = UDim2.new(1, 0, 0, 6), Position = UDim2.new(0, 0, 0.5, -3), BackgroundColor3 = DARK, BorderSizePixel = 0 }, hit)
	round(bar, 3)
	local rel0 = (defV - minV) / (maxV - minV)
	local fill = mk("Frame", { Size = UDim2.new(rel0, 0, 1, 0), BackgroundColor3 = RED, BorderSizePixel = 0 }, bar)
	round(fill, 3)
	mk("UIGradient", { Color = ColorSequence.new(Color3.fromRGB(255, 90, 105), Color3.fromRGB(190, 25, 38)) }, fill)
	local knob = mk("Frame", {
		Size = UDim2.fromOffset(14, 14), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(rel0, 0, 0.5, 0),
		BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 2,
	}, bar)
	round(knob, 7)
	mk("UIStroke", { Thickness = 1.5, Color = RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, knob)
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

-- ===== CONFIGURAÇÕES (engrenagem ⚙): tamanho, cor, fundo, tecla, FPS... Salva em SHIN HUB/config.json =====
do
	local CFG_FILE = FOLDER .. "/config.json"
	local DEFAULT = { scale = 1, accent = "Vermelho", bgOpacity = 100, bgImage = true, anim = true, key = "B", floatBtn = true, fps = false }
	local ACCENTS = {
		{ "Vermelho", Color3.fromRGB(222, 52, 68) }, { "Laranja", Color3.fromRGB(240, 128, 48) },
		{ "Amarelo", Color3.fromRGB(235, 190, 50) }, { "Verde", Color3.fromRGB(46, 196, 120) },
		{ "Ciano", Color3.fromRGB(40, 190, 215) }, { "Azul", Color3.fromRGB(66, 130, 255) },
		{ "Roxo", Color3.fromRGB(150, 98, 255) }, { "Rosa", Color3.fromRGB(240, 82, 170) },
	}
	local KEYS = { "B", "M", "K", "V", "Z" }
	local BLACK = Color3.new(0, 0, 0)
	-- família do vermelho usada no tema: { cor original, como derivar da cor escolhida }
	local BASE = {
		{ Color3.fromRGB(222, 52, 68), function(c) return c end },
		{ Color3.fromRGB(255, 80, 96), function(c) return c:Lerp(WHITE, 0.22) end },
		{ Color3.fromRGB(255, 90, 104), function(c) return c:Lerp(WHITE, 0.26) end },
		{ Color3.fromRGB(255, 90, 105), function(c) return c:Lerp(WHITE, 0.27) end },
		{ Color3.fromRGB(255, 120, 125), function(c) return c:Lerp(WHITE, 0.4) end },
		{ Color3.fromRGB(82, 26, 36), function(c) return Color3.fromRGB(26, 27, 33):Lerp(c, 0.32) end },
		{ Color3.fromRGB(150, 34, 48), function(c) return c:Lerp(BLACK, 0.3) end },
		{ Color3.fromRGB(96, 28, 38), function(c) return c:Lerp(BLACK, 0.55) end },
		{ Color3.fromRGB(190, 25, 38), function(c) return c:Lerp(BLACK, 0.15) end },
		{ Color3.fromRGB(110, 10, 20), function(c) return c:Lerp(BLACK, 0.5) end },
	}
	local function ck(c) -- chave inteira da cor (evita erro de arredondamento ao comparar)
		return math.floor(c.R * 255 + 0.5) * 65536 + math.floor(c.G * 255 + 0.5) * 256 + math.floor(c.B * 255 + 0.5)
	end
	UI.accentName = "Vermelho"
	UI.curAccent = {}
	for i, b in ipairs(BASE) do UI.curAccent[i] = b[1] end

	-- carrega o que foi salvo
	pcall(function()
		if isfile and readfile and isfile(CFG_FILE) then
			UI.hadCfg = true
			local d = HttpService:JSONDecode(readfile(CFG_FILE))
			if type(d) == "table" then
				for k, v in pairs(DEFAULT) do
					if type(d[k]) == type(v) then UI.cfg[k] = d[k] end
				end
			end
		end
	end)
	if not UI.hadCfg and not UI.pc then UI.cfg.scale = 0.8 end -- celular: começa menor, sobra espaço pra mover
	UI.cfg.scale = math.clamp(UI.cfg.scale, 0.5, 1.3)
	UI.cfg.bgOpacity = math.clamp(UI.cfg.bgOpacity, 30, 100)
	pcall(function() UI.key = Enum.KeyCode[UI.cfg.key] end)

	local function save()
		pcall(function()
			if not writefile then return end
			if isfolder and not isfolder(FOLDER) and makefolder then makefolder(FOLDER) end
			writefile(CFG_FILE, HttpService:JSONEncode(UI.cfg))
		end)
	end
	local pending = false
	local function saveSoon()
		if pending then return end
		pending = true
		task.delay(0.6, function() pending = false; save() end)
	end

	-- troca a cor de destaque em tudo que já existe (e nas próximas coisas que forem criadas)
	function UI.setAccent(c)
		local new, map = {}, {}
		for i, b in ipairs(BASE) do new[i] = b[2](c) end
		for i = 1, #BASE do map[ck(UI.curAccent[i])] = new[i] end
		local function mc(col) return map[ck(col)] end
		for _, d in ipairs(gui:GetDescendants()) do
			if not d:GetAttribute("keep") then
				if d:IsA("GuiObject") then
					local n = mc(d.BackgroundColor3)
					if n then d.BackgroundColor3 = n end
					if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
						n = mc(d.TextColor3)
						if n then d.TextColor3 = n end
					elseif d:IsA("ImageLabel") or d:IsA("ImageButton") then
						n = mc(d.ImageColor3)
						if n then d.ImageColor3 = n end
					end
				elseif d:IsA("UIStroke") then
					local n = mc(d.Color)
					if n then d.Color = n end
				elseif d:IsA("UIGradient") then
					local out, changed = {}, false
					for _, k in ipairs(d.Color.Keypoints) do
						local n = mc(k.Value)
						if n then changed = true end
						out[#out + 1] = ColorSequenceKeypoint.new(k.Time, n or k.Value)
					end
					if changed then d.Color = ColorSequence.new(out) end
				end
			end
		end
		RED = new[1]
		UI.GLOW = new[2]
		UI.ACTIVE = new[6]
		UI.curAccent = new
	end

	-- contador de FPS / ping no canto
	local fpsLbl
	function UI.setFps(on)
		if on and not fpsLbl then
			fpsLbl = mk("TextLabel", {
				Size = UDim2.fromOffset(128, 20), Position = UDim2.new(1, -136, 0, 8), BackgroundColor3 = Color3.fromRGB(20, 21, 26),
				BackgroundTransparency = 0.2, TextColor3 = WHITE, Font = Enum.Font.GothamMedium, TextSize = 11, Text = "FPS", ZIndex = 5,
			}, gui)
			round(fpsLbl, 8)
			local lbl, acc, n = fpsLbl, 0, 0
			table.insert(conns, RunService.Heartbeat:Connect(function(dt)
				if not lbl.Parent then return end
				acc = acc + dt; n = n + 1
				if acc >= 0.5 then
					local ping = 0
					pcall(function() ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5) end)
					lbl.Text = string.format("FPS %d  •  %d ms", math.floor(n / acc + 0.5), ping)
					acc, n = 0, 0
				end
			end))
		elseif not on and fpsLbl then
			fpsLbl:Destroy(); fpsLbl = nil
		end
	end

	function UI.applyCfg()
		local c = UI.cfg
		pcall(function() UI.key = Enum.KeyCode[c.key] end)
		for _, f in ipairs(UI.scaleFns) do pcall(f) end
		for _, f in ipairs(UI.bgFns) do pcall(f) end
		for _, f in ipairs(UI.keyFns) do pcall(f) end
		if UI.float then UI.float.Visible = c.floatBtn ~= false end
		pcall(UI.setFps, c.fps == true)
		if c.accent ~= UI.accentName then
			for _, a in ipairs(ACCENTS) do
				if a[1] == c.accent then
					UI.accentName = a[1]
					pcall(UI.setAccent, a[2])
				end
			end
		end
	end

	-- janelinha de configurações
	local pop
	local function build(win)
		if pop then pop:Destroy() end
		pop = mk("Frame", {
			Name = "Config", Size = UDim2.fromOffset(300, 300), Position = UDim2.new(1, -312, 0, 46),
			BackgroundColor3 = Color3.fromRGB(17, 18, 23), ZIndex = 50, ClipsDescendants = true, Visible = false,
		}, win)
		round(pop, 12); stroke(pop, 1.2, UI.EDGE)
		mk("TextLabel", {
			Text = "Configurações", Size = UDim2.new(1, -50, 0, 34), Position = UDim2.fromOffset(14, 0), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left,
		}, pop)
		local x = mk("TextButton", {
			Text = "✕", Size = UDim2.fromOffset(26, 26), Position = UDim2.new(1, -32, 0, 4), BackgroundTransparency = 1,
			TextColor3 = UI.DIM, Font = Enum.Font.GothamBold, TextSize = 13, AutoButtonColor = false,
		}, pop)
		x.MouseButton1Click:Connect(function() pop.Visible = false end)
		local list = mk("ScrollingFrame", {
			Position = UDim2.fromOffset(8, 36), Size = UDim2.new(1, -16, 1, -44), BackgroundTransparency = 1, BorderSizePixel = 0,
			ScrollBarThickness = 3, ScrollBarImageColor3 = UI.EDGE, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(),
		}, pop)
		mk("UIListLayout", { Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, list)
		mk("UIPadding", { PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8) }, list)
		local c = UI.cfg

		section(list, "Aparência")
		sliderRow(list, "Tamanho", "Escala do menu", 50, 130, math.floor(c.scale * 100 + 0.5), function(v)
			c.scale = v / 100; UI.applyCfg(); saveSoon()
		end)
		sliderRow(list, "Fundo", "Opacidade do painel", 30, 100, math.floor(c.bgOpacity + 0.5), function(v)
			c.bgOpacity = v; UI.applyCfg(); saveSoon()
		end)
		-- cores de destaque
		local sw = mk("Frame", { Size = UDim2.new(1, 0, 0, 52), BackgroundColor3 = PANEL, BackgroundTransparency = 0.25 }, list)
		round(sw, 10); stroke(sw, 1.2, UI.EDGE)
		mk("TextLabel", {
			Text = "Cor de destaque", Size = UDim2.new(1, -16, 0, 20), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
		}, sw)
		local holder = mk("Frame", { Size = UDim2.new(1, -24, 0, 22), Position = UDim2.fromOffset(14, 26), BackgroundTransparency = 1 }, sw)
		mk("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, holder)
		local rings = {}
		for i, a in ipairs(ACCENTS) do
			local b = mk("TextButton", {
				Text = "", AutoButtonColor = false, Size = UDim2.fromOffset(22, 22), BackgroundColor3 = a[2], LayoutOrder = i,
			}, holder)
			b:SetAttribute("keep", true)
			round(b, 11)
			rings[a[1]] = mk("UIStroke", { Thickness = 2, Color = WHITE, Transparency = (c.accent == a[1]) and 0 or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
			b.MouseButton1Click:Connect(function()
				c.accent = a[1]
				for n, r in pairs(rings) do r.Transparency = (n == a[1]) and 0 or 1 end
				UI.applyCfg(); save()
			end)
		end
		toggleRow(list, "Foto de fundo", "Imagem atrás do menu", function(v) c.bgImage = v; UI.applyCfg(); saveSoon() end, c.bgImage)
		toggleRow(list, "Animações", "Efeitos suaves nos botões", function(v) c.anim = v; saveSoon() end, c.anim)

		section(list, "Controles")
		local keyRow
		keyRow = rowBtn(list, "Tecla do menu: " .. tostring(c.key), function()
			local idx = 1
			for i, k in ipairs(KEYS) do if k == c.key then idx = i end end
			c.key = KEYS[idx % #KEYS + 1]
			keyRow:FindFirstChildOfClass("TextLabel").Text = "Tecla do menu: " .. c.key
			UI.applyCfg(); save()
		end, true)
		local floatRow, setFloat
		floatRow, setFloat = toggleRow(list, "Botão flutuante", "No celular precisa ficar ligado", function(v)
			if not v and not UI.pc then setFloat(true); return end
			c.floatBtn = v; UI.applyCfg(); saveSoon()
		end, c.floatBtn)
		toggleRow(list, "Mostrar FPS", "FPS e ping no canto da tela", function(v) c.fps = v; UI.applyCfg(); saveSoon() end, c.fps)

		section(list, "Janela")
		rowBtn(list, "Centralizar menu", function() win.Position = UDim2.new(0.5, 0, 0.5, 0) end, true)
		rowBtn(list, "Restaurar padrão", function()
			for k, v in pairs(DEFAULT) do c[k] = v end
			UI.applyCfg(); save()
			build(win); pop.Visible = true
		end, true)
		-- tudo da janelinha fica acima do fundo dela (o ZIndex padrão ficaria escondido atrás)
		for _, d in ipairs(pop:GetDescendants()) do
			if d:IsA("GuiObject") then d.ZIndex = 51 end
		end
	end
	function UI.toggleSettings(win)
		if pop and pop.Parent == win then
			pop.Visible = not pop.Visible
		else
			build(win); pop.Visible = true
		end
	end
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
local tagDraw -- declarada aqui pra buildMods enxergar (antes era nil e a tag dos outros nunca aparecia)

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
		if #mine.ids == 0 and not mine.headless and not mine.fx and not mine.tag and not mine.bc then
			http("DELETE", "/mods/" .. uid .. ".json")
		else
			mine.beat = (mine.beat or 0) + 1
			http("PUT", "/mods/" .. uid .. ".json", {
				name = lp.Name, ids = table.concat(mine.ids, ","), headless = mine.headless,
				fx = mine.fx or "", fc = mine.fc or 1, tag = mine.tag, bc = mine.bc,
				beat = mine.beat, t = os.time(), o = AUTH.id(), ts = { [".sv"] = "timestamp" },
			})
		end
	end
	publishMods = publish

	-- carrega o item pelo ID e remove qualquer script de dentro (só visual)
	-- só guarda em cache quando CONSEGUE carregar; falha não fica presa pra sempre, tenta de novo depois
	-- cada passo vai pro log: GetObjects, InsertService, e quantos scripts/sons foram removidos
	local lastLoadErr = {}
	local function loadAsset(id)
		if cache[id] then return cache[id] end
		local objs
		local ok, res = pcall(function() return game:GetObjects("rbxassetid://" .. id) end)
		if ok and type(res) == "table" and #res > 0 then
			objs = res
			DSLOG.info("asset", "ID " .. id .. ": GetObjects ok (" .. #res .. " objeto(s))")
		else
			local why = ok and "voltou vazio" or tostring(res):sub(1, 90)
			DSLOG.warn("asset", "ID " .. id .. ": GetObjects falhou (" .. why .. "), tentando InsertService")
			local ok2, m = pcall(function() return game:GetService("InsertService"):LoadAsset(id) end)
			if ok2 and m then
				local kids = m:GetChildren()
				if #kids > 0 then
					objs = kids
					DSLOG.info("asset", "ID " .. id .. ": InsertService ok (" .. #kids .. " objeto(s))")
				else
					lastLoadErr[id] = "modelo vazio"
					DSLOG.err("asset", "ID " .. id .. ": InsertService voltou um modelo vazio")
				end
			else
				lastLoadErr[id] = ok2 and "voltou nada" or tostring(m):sub(1, 70)
				DSLOG.err("asset", "ID " .. id .. ": InsertService falhou: " .. lastLoadErr[id])
			end
		end
		if objs then
			local removed = 0
			for _, o in ipairs(objs) do
				for _, d in ipairs(o:GetDescendants()) do
					if d:IsA("LuaSourceContainer") or d:IsA("Sound") then d:Destroy(); removed = removed + 1 end
				end
			end
			if removed > 0 then DSLOG.info("asset", "ID " .. id .. ": " .. removed .. " script(s)/som(ns) removido(s)") end
			cache[id] = objs
		end
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

	-- qual "vaga" da cabeça o Accessory ocupa (Hat / Hair / Face / Eyebrow / Eyelash). nil = não é de cabeça (costas, ombro, cintura...)
	-- Cada vaga troca só ela mesma: um chapéu novo não derruba o cabelo nem o rosto (antes qualquer item de cabeça apagava todos)
	local clearGen = 0 -- sobe toda vez que o PRÓPRIO hub apaga itens (pra não confundir com o jogo removendo)
	local HEAD_SLOTS = { Hat = true, Hair = true, Face = true, Eyebrow = true, Eyelash = true }
	local function slotOf(o)
		if o:IsA("Hat") then return "Hat" end
		local ok, at = pcall(function() return o.AccessoryType end)
		if ok and at and at ~= Enum.AccessoryType.Unknown then
			return HEAD_SLOTS[at.Name] and at.Name or nil
		end
		local h = o:FindFirstChild("Handle")
		local att = h and h:FindFirstChildOfClass("Attachment")
		if att then
			local n = att.Name
			if n == "HatAttachment" then return "Hat" end
			if n == "HairAttachment" then return "Hair" end
			if n:match("^Face") then return "Face" end
		end
		return nil
	end
	local function isHeadAcc(o) return slotOf(o) ~= nil end

	-- item original guardado continua soldado na cabeça e VISÍVEL; por isso a gente deixa invisível enquanto está guardado
	-- (e devolve a transparência original quando o hub limpa)
	local function hideStashed(o)
		for _, p in ipairs(o:GetDescendants()) do
			if p:IsA("BasePart") and p:GetAttribute("DsHidAcc") == nil then
				p:SetAttribute("DsHidAcc", p.Transparency)
				p.Transparency = 1
			end
		end
	end
	local function showStashed(o)
		for _, p in ipairs(o:GetDescendants()) do
			if p:IsA("BasePart") and p:GetAttribute("DsHidAcc") ~= nil then
				p.Transparency = p:GetAttribute("DsHidAcc")
				p:SetAttribute("DsHidAcc", nil)
			end
		end
	end

	-- tira o item de cabeça que a pessoa já usa NA MESMA VAGA antes de colocar o novo (slot = nil: todas as vagas)
	-- se era de um mod anterior, apaga; se era original do avatar, guarda em DsStash (invisível) pra voltar depois
	local function clearHeadAccessories(char, slot)
		local st = char:FindFirstChild("DsStash")
		for _, o in ipairs(char:GetChildren()) do
			if o:IsA("Accessory") or o:IsA("Hat") then
				local s = slotOf(o)
				if s and (slot == nil or s == slot) then
					if o:GetAttribute("DsMod") then
						clearGen = clearGen + 1
						o:Destroy()
					else
						if not st then
							st = Instance.new("Folder"); st.Name = "DsStash"; st.Parent = char
						end
						o.Parent = st
						hideStashed(o)
						DSLOG.info("acessório", "original '" .. o.Name .. "' (" .. s .. ") guardado e escondido")
					end
				end
			end
		end
	end

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
	-- Modo manual: o acessório vai numa pasta (DsAcc) dentro do personagem e é soldado por nós no encaixe certo.
	-- Usado quando o jogo apaga os acessórios colocados do jeito normal (Humanoid:AddAccessory).
	local manualAcc = false
	local function placeManual(char, o)
		local c = o:Clone(); c:SetAttribute("DsMod", true)
		local h = c:FindFirstChild("Handle")
		local ha = h and h:FindFirstChildOfClass("Attachment")
		if not (h and ha) then
			DSLOG.err("acessório", o.Name .. ": sem Handle ou sem encaixe (Attachment), não dá pra soldar")
			c:Destroy(); return false
		end
		local target, tAtt
		for _, p in ipairs(char:GetChildren()) do
			if p:IsA("BasePart") then
				local a = p:FindFirstChild(ha.Name)
				if a and a:IsA("Attachment") then target, tAtt = p, a; break end
			end
		end
		if not target then
			DSLOG.err("acessório", o.Name .. ": o seu corpo não tem o encaixe '" .. ha.Name .. "' (R6/R15 diferente?)")
			c:Destroy(); return false
		end
		local folder = char:FindFirstChild("DsAcc")
		if not folder then
			folder = Instance.new("Folder"); folder.Name = "DsAcc"; folder:SetAttribute("DsMod", true); folder.Parent = char
		end
		h.Anchored = false; h.CanCollide = false; h.Massless = true
		c.Parent = folder
		local w = Instance.new("Weld")
		w.Name = "DsAccWeld"; w.Part0 = target; w.Part1 = h; w.C0 = tAtt.CFrame; w.C1 = ha.CFrame
		w.Parent = h
		DSLOG.info("acessório", "'" .. o.Name .. "' colocado em MODO MANUAL em " .. target.Name .. " (encaixe " .. ha.Name .. ")")
		return true
	end

	local function handle(char, hm, r, o)
		DSLOG.info("item", o.ClassName .. " '" .. o.Name .. "'")
		if o:IsA("Accessory") then
			if not hm then
				DSLOG.warn("acessório", o.Name .. ": seu personagem está sem Humanoid agora, pulei")
				return true
			end
			local slot = slotOf(o)
			if slot then clearHeadAccessories(char, slot) end
			if manualAcc then placeManual(char, o); return true end
			local c = o:Clone(); c:SetAttribute("DsMod", true)
			local h = c:FindFirstChild("Handle")
			local hAtt = h and h:FindFirstChildOfClass("Attachment")
			local okT, accType = pcall(function() return o.AccessoryType.Name end)
			local layered = h and (h:FindFirstChildOfClass("WrapLayer") ~= nil) or false
			local gone, newParent, myGen = false, nil, clearGen
			pcall(function() c.Destroying:Connect(function() gone = true end) end)
			pcall(function() c.AncestryChanged:Connect(function(_, p) newParent = p end) end)
			local okAdd, errAdd = pcall(function() hm:AddAccessory(c) end)
			if not okAdd then
				DSLOG.err("acessório", o.Name .. ": AddAccessory falhou: " .. tostring(errAdd):sub(1, 100))
				c:Destroy()
				return true
			end
			DSLOG.info("acessório", string.format("'%s' colocado | tipo=%s | encaixe=%s | vaga=%s%s", o.Name,
				okT and accType or "?", hAtt and hAtt.Name or "NENHUM", slot or "corpo",
				layered and " | roupa em camadas (WrapLayer, pode não deformar)" or ""))
			if not h then DSLOG.err("acessório", o.Name .. ": não tem Handle, não vai aparecer") end
			-- confere meio segundo depois: (1) o jogo apagou? -> troca pro modo manual; (2) soltou do corpo? -> solda na mão
			task.delay(0.6, function()
				if not c.Parent then
					if clearGen ~= myGen then return end -- foi o próprio hub que limpou, normal
					DSLOG.warn("acessório", "'" .. c.Name .. "' foi REMOVIDO do personagem em menos de 0.6s ("
						.. (gone and "Destroy()" or ("movido pra " .. tostring(newParent and newParent.Name or "nil")))
						.. "). Mudando pro modo manual")
					manualAcc = true
					if char.Parent and char:GetAttribute("DsSig") ~= nil then
						if placeManual(char, o) then char:SetAttribute("DsN", 1) end
					end
					return
				end
				local hh = c:FindFirstChild("Handle")
				local root2 = char:FindFirstChild("HumanoidRootPart")
				if not (hh and root2) then return end
				if (hh.Position - root2.Position).Magnitude < 15 then return end -- encaixou
				local ha = hh:FindFirstChildOfClass("Attachment")
				local target, tAtt
				if ha then
					for _, p in ipairs(char:GetChildren()) do
						if p:IsA("BasePart") then
							local a = p:FindFirstChild(ha.Name)
							if a and a:IsA("Attachment") then target, tAtt = p, a; break end
						end
					end
				end
				if target then
					hh.Anchored = false; hh.CanCollide = false; hh.Massless = true
					local w = Instance.new("Weld")
					w.Name = "DsAccWeld"; w.Part0 = target; w.Part1 = hh; w.C0 = tAtt.CFrame; w.C1 = ha.CFrame
					w.Parent = hh
					DSLOG.warn("acessório", "'" .. c.Name .. "' não encaixou sozinho; soldei na mão em " .. target.Name .. " (encaixe " .. ha.Name .. ")")
				else
					DSLOG.err("acessório", "'" .. c.Name .. "' longe do corpo e sem encaixe '" .. (ha and ha.Name or "?") .. "' no seu corpo (R6/R15 diferente?)")
				end
			end)
			return true
		elseif o:IsA("Hat") then
			DSLOG.info("chapéu", "chapéu antigo (classe Hat) '" .. o.Name .. "', soldando na cabeça")
			-- chapéu do sistema ANTIGO do Roblox (classe "Hat"): não entende Humanoid:AddAccessory,
			-- precisa ser soldado manualmente na cabeça usando o AttachmentPos do próprio item
			local head = char:FindFirstChild("Head")
			local srcHandle = o:FindFirstChild("Handle")
				if not (head and srcHandle) then DSLOG.warn("chapéu", o.Name .. ": sem Head ou sem Handle, ignorado") end
			if head and srcHandle then
				clearHeadAccessories(char, "Hat")
				local c = o:Clone(); c:SetAttribute("DsMod", true)
				local h = c:FindFirstChild("Handle")
				h.Anchored = false; h.CanCollide = false; h.Massless = true
				local okPos, pos = pcall(function() return c.AttachmentPos end)
				local offset = (okPos and typeof(pos) == "Vector3") and CFrame.new(pos) or CFrame.new(0, 0.6, 0)
				h.CFrame = head.CFrame * offset
				c.Parent = char
				local w = Instance.new("WeldConstraint")
				w.Part0 = head; w.Part1 = h; w.Parent = h
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
		if not objs then return false end
		local hm = char:FindFirstChildOfClass("Humanoid")
		local r = char:FindFirstChild("HumanoidRootPart")
		for _, o in ipairs(objs) do
			local ok, ret = pcall(handle, char, hm, r, o)
			if not ok then
				DSLOG.err("item", "ID " .. id .. " (" .. o.ClassName .. " '" .. o.Name .. "'): " .. tostring(ret):sub(1, 140))
			elseif ret == false then
				DSLOG.warn("item", "ID " .. id .. " (" .. o.ClassName .. " '" .. o.Name .. "'): não sei aplicar esse tipo de item")
			end
		end
		return true
	end

	-- aba Debug > "Inspecionar ID": carrega o item e mostra o que tem dentro, SEM aplicar (descobre por que um ID não aparece)
	DSLOG.inspect = function(idText)
		local n = tonumber(tostring(idText or ""):match("%d+"))
		if not n then DSLOG.warn("inspecionar", "digite um ID (só números)"); return end
		DSLOG.info("inspecionar", "ID " .. n .. ": carregando...")
		local objs = loadAsset(n)
		if not objs then
			DSLOG.err("inspecionar", "ID " .. n .. " NÃO carregou: " .. tostring(lastLoadErr[n] or "sem erro (voltou vazio)"))
			return
		end
		local shown = 0
		for _, o in ipairs(objs) do
			local extra = ""
			if o:IsA("Accessory") then
				local okT, at = pcall(function() return o.AccessoryType.Name end)
				extra = " tipo=" .. (okT and at or "?") .. " vaga=" .. tostring(slotOf(o) or "corpo")
			end
			DSLOG.info("inspecionar", "ID " .. n .. " raiz: " .. o.ClassName .. " '" .. o.Name .. "'" .. extra)
			for _, d in ipairs(o:GetDescendants()) do
				shown = shown + 1
				if shown > 40 then DSLOG.info("inspecionar", "... (mais itens não listados)"); return end
				DSLOG.info("inspecionar", "  - " .. d.ClassName .. " '" .. d.Name .. "' em " .. d.Parent.Name)
			end
		end
	end

	local function clearMods(char)
		clearGen = clearGen + 1
		local restored, removed = 0, 0
		local st = char:FindFirstChild("DsStash")
		if st then
			for _, o in ipairs(st:GetChildren()) do
				showStashed(o)
				o.Parent = char
				restored = restored + 1
			end
			st:Destroy()
		end
		for _, o in ipairs(char:GetDescendants()) do
			if o:GetAttribute("DsMod") then
				o:Destroy(); removed = removed + 1
			elseif o:GetAttribute("DsHidLimb") then
				o.Transparency = 0; o:SetAttribute("DsHidLimb", nil)
			elseif o:GetAttribute("DsHidDecal") then
				o.Transparency = 0; o:SetAttribute("DsHidDecal", nil)
			end
		end
		if removed > 0 or restored > 0 then
			DSLOG.info("limpar", removed .. " item(ns) do hub removido(s), " .. restored .. " original(is) devolvido(s)")
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

	-- cores do corpo (pele) copiadas de outro avatar: "hhhhhh,hhhhhh,..." (cabeça, tronco, braços, pernas)
	local function applyBC(char, bc)
		local cols = {}
		for h in tostring(bc):gmatch("%x%x%x%x%x%x") do
			cols[#cols + 1] = Color3.fromRGB(tonumber(h:sub(1, 2), 16), tonumber(h:sub(3, 4), 16), tonumber(h:sub(5, 6), 16))
		end
		if #cols < 6 then return end
		stash(char, "BodyColors")
		local b = Instance.new("BodyColors")
		b.HeadColor3, b.TorsoColor3 = cols[1], cols[2]
		b.LeftArmColor3, b.RightArmColor3 = cols[3], cols[4]
		b.LeftLegColor3, b.RightLegColor3 = cols[5], cols[6]
		b:SetAttribute("DsMod", true)
		b.Parent = char
	end

	-- registro "velho" (quem saiu do jogo, fechou o hub ou teleportou) para de mandar sinal e some pra todo mundo
	local seenB = {}
	local function isFresh(id, rec)
		local now = os.clock()
		local s = seenB[id]
		if not s or s.beat ~= rec.beat then
			seenB[id] = { beat = rec.beat, at = now, moved = s ~= nil }
			s = seenB[id]
		end
		if now - s.at > 25 then return false end -- sem sinal há mais de 25s
		local t = tonumber(rec.t)
		if t and math.abs(os.time() - t) <= 90 then return true end
		return s.moved -- relógio muito diferente: só confia depois de ver o sinal mudar
	end

	-- aplica (só visualmente, no seu aparelho) os mods de todo mundo que está com o hub ativo
	-- Os SEUS mods são aplicados direto da memória (não dependem do Firebase); os dos outros vêm do Firebase.
	-- Cada passo vai pro log (aba Debug / arquivo SHIN HUB/log.txt).
	local function localRecord()
		if #mine.ids == 0 and not mine.headless and not mine.bc then return nil end
		return { ids = table.concat(mine.ids, ","), headless = mine.headless, fx = mine.fx or "", fc = mine.fc or 1, bc = mine.bc }
	end
	-- o Roblox ainda pode estar colocando o avatar original quando o personagem nasce; se a gente aplica antes, o jogo atropela
	local function appearanceReady(pl)
		local ok, v = pcall(function() return pl:HasAppearanceLoaded() end)
		if ok and v == false then return false end
		return true
	end
	local function countMods(char)
		local n = 0
		for _, d in ipairs(char:GetDescendants()) do
			if d:GetAttribute("DsMod") then n = n + 1 end
		end
		return n
	end
	local reapplied = setmetatable({}, { __mode = "k" })
	local waitSince = setmetatable({}, { __mode = "k" })
	local netState = nil

	-- IDs que não carregaram: tenta de novo SÓ eles (sem apagar o resto, então não pisca), até 3 vezes
	local function retryFailed(pl, char, want, ids, attempt)
		if attempt > 3 then
			local t = {}
			for _, i in ipairs(ids) do t[#t + 1] = tostring(i) end
			DSLOG.err("sync", pl.Name .. ": desisti dos IDs " .. table.concat(t, ", ") .. " (inválidos, bloqueados ou o executor não consegue carregar)")
			return
		end
		task.delay(3 * attempt, function()
			if not (char and char.Parent) or char:GetAttribute("DsSig") ~= want then return end
			local still = {}
			for _, i in ipairs(ids) do
				local ok, applied = pcall(applyOne, char, i)
				if not (ok and applied) then still[#still + 1] = i end
			end
			char:SetAttribute("DsN", countMods(char))
			if #still > 0 then
				retryFailed(pl, char, want, still, attempt + 1)
			else
				DSLOG.info("sync", pl.Name .. ": os IDs que faltavam carregaram na tentativa " .. attempt)
			end
		end)
	end

	local function sync()
		local body = http("GET", "/mods.json")
		local netOk = body ~= nil
		if netOk ~= netState then
			netState = netOk
			if netOk then
				DSLOG.info("sync", "Firebase respondeu (rede OK)")
			else
				DSLOG.err("sync", "Firebase NÃO respondeu (" .. tostring(lastErr) .. "): aplico só os seus mods locais")
			end
		end
		local data = {}
		if netOk and body ~= "null" and body ~= "" then
			local ok, d = pcall(HttpService.JSONDecode, HttpService, body)
			if ok and type(d) == "table" then
				data = d
			else
				DSLOG.err("sync", "resposta do Firebase não é JSON: " .. tostring(body):sub(1, 60))
			end
		end
		for id, rec in pairs(data) do
			if type(rec) ~= "table" or not isFresh(id, rec) then data[id] = nil end
		end
		local mineRec = localRecord()
		if netOk and mineRec and not data[uid] then
			DSLOG.warn("sync", "seu registro não voltou do Firebase (o PUT falhou ou as regras bloquearam). Você se vê, mas os outros não te veem")
		end
		for _, pl in ipairs(Players:GetPlayers()) do
			local isMe = (pl == lp)
			local char = pl.Character
			if (isMe or netOk) and char and char:FindFirstChildOfClass("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
				local d
				if isMe then d = mineRec else d = data[tostring(pl.UserId)] end
				local want
				if d then
					if isMe then -- efeitos (fx) seus não passam por aqui, então não entram na assinatura (evita reaplicar acessório à toa)
						want = tostring(d.ids or "") .. "|" .. tostring(d.headless == true) .. "||1|" .. tostring(d.bc or "")
					else
						want = tostring(d.ids or "") .. "|" .. tostring(d.headless == true) .. "|" .. tostring(d.fx or "") .. "|" .. tostring(d.fc or 1) .. "|" .. tostring(d.bc or "")
					end
				end
				-- o jogo pode ter removido os itens (ex.: trocou de avatar): assinatura igual mas itens sumiram -> reaplica
				if want and char:GetAttribute("DsSig") == want and (char:GetAttribute("DsN") or 0) > 0 and countMods(char) == 0 then
					local n = (reapplied[char] or 0) + 1
					reapplied[char] = n
					if n <= 5 then
						DSLOG.warn("sync", pl.Name .. ": os itens do hub sumiram do personagem (o jogo removeu?), reaplicando (" .. n .. "/5)")
						char:SetAttribute("DsSig", nil)
					end
				end
				if char:GetAttribute("DsSig") ~= want then
					local ready = (want == nil) or appearanceReady(pl)
					if not ready then
						local t0 = waitSince[char]
						if not t0 then
							t0 = os.clock(); waitSince[char] = t0
							DSLOG.info("sync", pl.Name .. ": esperando o avatar terminar de carregar...")
						end
						if os.clock() - t0 >= 8 then
							ready = true
							DSLOG.warn("sync", pl.Name .. ": avatar demorou mais de 8s, aplicando mesmo assim")
						end
					end
					if ready then
						waitSince[char] = nil
						if d then
							DSLOG.info("sync", pl.Name .. ": aplicando mods | ids=" .. tostring(d.ids or "") .. (d.headless == true and " | headless" or "") .. (d.bc and " | cores" or ""))
						else
							DSLOG.info("sync", pl.Name .. ": sem mods, limpando")
						end
						clearMods(char)
						if not isMe then
							local set = {}
							if d then
								for k in tostring(d.fx or ""):gmatch("%a+") do set[k] = true end
							end
							local okF, eF = pcall(fxApply, char, set, tonumber(d and d.fc) or 1)
							if not okF then DSLOG.err("efeitos", pl.Name .. ": " .. tostring(eF):sub(1, 100)) end
						end
						local failed = {}
						if d then
							if d.headless == true then DSLOG.try("headless", headless, char) end
							if d.bc then DSLOG.try("cores", applyBC, char, d.bc) end
							local n = 0
							for idStr in tostring(d.ids or ""):gmatch("%d+") do
								n = n + 1
								if n > 24 then DSLOG.warn("sync", pl.Name .. ": mais de 24 IDs, ignorei o resto"); break end
								local idn = tonumber(idStr)
								local ok, applied = pcall(applyOne, char, idn)
								if not (ok and applied) then
									failed[#failed + 1] = idn
									DSLOG.err("sync", pl.Name .. ": falhou o ID " .. idStr .. (ok and " (não carregou)" or (": " .. tostring(applied):sub(1, 120))))
								end
							end
						end
						char:SetAttribute("DsSig", want)
						char:SetAttribute("DsN", countMods(char))
						if #failed > 0 then retryFailed(pl, char, want, failed, 1) end
						-- diagnóstico: só pra você mesmo, mostra se o acessório realmente entrou no Humanoid
						if isMe then
							DSLOG.try("avatar", DSLOG.charState, char, "você")
							local hm2 = char:FindFirstChildOfClass("Humanoid")
							local accN = hm2 and #hm2:GetAccessories() or -1
							local mf = char:FindFirstChild("DsAcc")
							if mf and #mf:GetChildren() > 0 then accN = tostring(accN) .. " + " .. #mf:GetChildren() .. " manual" end
							say((#failed == 0 and "Mods aplicados. " or "Alguns IDs falharam, tentando de novo. ") .. "Acessórios no seu Humanoid agora: " .. accN)
						end
					end
				end
				if not isMe then
					local okT, eT = pcall(tagDraw, char, d and type(d.tag) == "table" and d.tag or nil, "DsTagB")
					if not okT then DSLOG.err("tag", tostring(eT):sub(1, 100)) end
				end
			end
		end
	end
	-- nunca roda duas sincronizações ao mesmo tempo (duplicaria os acessórios)
	local syncing = false
	local function syncSafe()
		if syncing then return end
		syncing = true
		DSLOG.try("sync", sync)
		syncing = false
	end
	table.insert(conns, lp.CharacterAdded:Connect(function()
		DSLOG.info("avatar", "seu personagem renasceu, reaplicando os mods")
		task.wait(1)
		if alive then syncSafe() end
	end))
	task.spawn(function()
		while alive do syncSafe(); task.wait(3) end
	end)
	-- sinal de vida: reenvia o registro a cada 8s; ao sair/teleportar apaga na hora
	task.spawn(function()
		while alive do
			task.wait(8)
			if alive and (#mine.ids > 0 or mine.headless or mine.fx or mine.tag or mine.bc) then pcall(publish) end
		end
	end)
	local function goodbye() pcall(http, "DELETE", "/mods/" .. uid .. ".json") end
	table.insert(conns, Players.PlayerRemoving:Connect(function(p) if p == lp then goodbye() end end))
	pcall(function()
		table.insert(conns, lp.OnTeleport:Connect(function(st)
			if st == Enum.TeleportState.Started then goodbye() end
		end))
	end)

	-- UI da aba Mod
	section(page, "Mod personalizado")
	mk("TextLabel", {
		Text = "Cole o ID de qualquer item visual do catálogo (acessório, roupa, pacote, partes do corpo, rosto ou efeito). Scripts e sons são removidos. Chapéu/cabelo/rosto novo troca o que você já está usando automaticamente. Todos que usam o hub veem.",
		Size = UDim2.new(1, 0, 0, 58), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(232, 234, 240),
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
		Text = "", PlaceholderText = "ID do item (só números)", PlaceholderColor3 = Color3.fromRGB(125, 130, 142),
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
	mine.onList = refreshList
	rowBtn(page, "Adicionar ID", function()
		local n = idBox.Text:match("%d+")
		if not n then say("Digite o ID (só números)."); return end
		if #mine.ids >= 8 then say("Máximo de 8 IDs."); return end
		table.insert(mine.ids, n)
		idBox.Text = ""
		refreshList()
		publish()
		say("ID " .. n .. " adicionado, carregando...")
		task.spawn(function()
			local id = tonumber(n)
			local objs = loadAsset(id)
			if objs then
				local cls = {}
				for _, o in ipairs(objs) do cls[#cls + 1] = o.ClassName end
				say("ID " .. n .. " carregado: " .. table.concat(cls, ", ") .. ". Aplicando em até 3s.")
			else
				say("Não consegui carregar o ID " .. n .. (lastLoadErr[id] and (" (" .. lastLoadErr[id] .. ")") or "") .. ". Vou tentar de novo sozinho; confira se é um ID de item de avatar válido.")
			end
		end)
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
		-- ao fechar o hub, devolve o avatar de todo mundo ao normal (itens do hub saem, originais voltam)
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl.Character then
				pcall(clearMods, pl.Character)
				pl.Character:SetAttribute("DsSig", nil)
				pl.Character:SetAttribute("DsN", nil)
			end
		end
		fxClearAll()
		for _, pl in ipairs(Players:GetPlayers()) do
			local hd = pl.Character and pl.Character:FindFirstChild("Head")
			local o = hd and hd:FindFirstChild("DsTagB")
			if o then o:Destroy() end
		end
		http("DELETE", "/mods/" .. uid .. ".json")
	end
end

-- ===== Aba Debug: log na tela, copiar, salvar e inspecionar IDs =====
local function buildDebug(page, say)
	if not page then return nil end
	local onlyProblems, dirty, alive = false, true, true
	local function onNew() dirty = true end
	table.insert(DSLOG.subs, onNew)

	section(page, "Diagnóstico")
	local info = mk("TextLabel", {
		Text = "", Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(232, 234, 240),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	rowBtn(page, "Copiar log completo", function()
		local f = setclipboard or toclipboard
		DSLOG.flush()
		if not f then say("Seu executor não tem setclipboard. O log está no arquivo " .. DSLOG.file); return end
		pcall(f, DSLOG.dump(false))
		say("Log copiado (" .. #DSLOG.lines .. " linhas). Cole na conversa.")
	end, true)
	rowBtn(page, "Copiar só avisos e erros", function()
		local f = setclipboard or toclipboard
		DSLOG.flush()
		if not f then say("Seu executor não tem setclipboard. O log está no arquivo " .. DSLOG.file); return end
		pcall(f, DSLOG.dump(true))
		say("Avisos e erros copiados.")
	end, true)
	rowBtn(page, "Salvar agora no arquivo", function()
		DSLOG.flush()
		say("Salvo em " .. DSLOG.file .. " (pasta do executor)")
	end, true)
	rowBtn(page, "Ver estado do meu personagem", function()
		DSLOG.try("avatar", DSLOG.charState, lp.Character, "você")
		say("Estado do personagem registrado no log.")
	end, true)
	toggleRow(page, "Só avisos e erros", "Esconde as linhas de informação", function(v)
		onlyProblems = v; dirty = true
	end)
	local idRow = mk("Frame", { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
	round(idRow, 17); stroke(idRow, 1.5)
	local idBox = mk("TextBox", {
		Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
		Text = "", PlaceholderText = "ID pra inspecionar (só números)", PlaceholderColor3 = Color3.fromRGB(125, 130, 142),
		TextColor3 = WHITE, Font = Enum.Font.Code, TextSize = 11, ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
	}, idRow)
	rowBtn(page, "Inspecionar ID (não aplica)", function()
		if not DSLOG.inspect then say("A aba Mod ainda não carregou."); return end
		task.spawn(function() DSLOG.try("inspecionar", DSLOG.inspect, idBox.Text) end)
		say("Inspecionando, veja o log abaixo.")
	end, true)
	rowBtn(page, "Limpar tela", function()
		DSLOG.lines = {}
		dirty = true
	end, true)

	local box = mk("Frame", { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(16, 17, 21), BackgroundTransparency = 0.15 }, page)
	round(box, 10); stroke(box, 1.5)
	mk("UIPadding", { PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }, box)
	local txt = mk("TextLabel", {
		Text = "", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
		RichText = true, TextWrapped = true, Font = Enum.Font.Code, TextSize = 10, TextColor3 = Color3.fromRGB(232, 234, 240),
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, box)

	local COL = { INFO = "#e6d2d2", WARN = "#ffc864", ERRO = "#ff6464" }
	local function esc(s)
		return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
	end
	local function render()
		local out, total = {}, 0
		for i = #DSLOG.lines, 1, -1 do -- mais recente em cima
			local l = DSLOG.lines[i]
			if not onlyProblems or l[1] ~= "INFO" then
				local s = l[2]
				if #s > 220 then s = s:sub(1, 220) .. "..." end
				total = total + #s + 40
				if total > 14000 or #out >= 150 then break end
				out[#out + 1] = '<font color="' .. (COL[l[1]] or COL.INFO) .. '">' .. esc(s) .. "</font>"
			end
		end
		txt.Text = #out > 0 and table.concat(out, "\n") or "(log vazio)"
		info.Text = DSLOG.n.INFO .. " info · " .. DSLOG.n.WARN .. " avisos · " .. DSLOG.n.ERRO .. " erros · mais recente em cima\nArquivo: " .. DSLOG.file
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

-- ===== recursos locais (só afetam VOCÊ) =====
local function hrp() return lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") end
local function hum() return lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") end

local selfCleanup
-- ===== Tag grande em cima da cabeça (quem usa o hub vê a própria; o ADM vê a de todos os membros) =====
local TAG_FONTS = { "GothamBlack", "FredokaOne", "Bangers", "Creepster", "Arcade", "Fantasy", "SciFi", "LuckiestGuy", "PermanentMarker", "Cartoon", "Code" }
local TAG_ROLES = {
	{ "Membro", Color3.fromRGB(235, 235, 235) },
	{ "Influenciador", Color3.fromRGB(255, 105, 180) },
	{ "Sub Dono", Color3.fromRGB(255, 140, 40) },
	{ "Dono", Color3.fromRGB(255, 205, 60) },
}
local TAG = { avail = false, on = false, text = "", font = "GothamBlack", role = "Membro", rgb = false }
local function tagRoleColor(name)
	for _, r in ipairs(TAG_ROLES) do
		if r[1] == name then return r[2] end
	end
	return TAG_ROLES[1][2]
end
-- desenha (ou atualiza / remove) o letreiro na cabeça de "char". d = { on, text, font, role }
function tagDraw(char, d, nm)
	nm = nm or "DsTag"
	local head = char and char:FindFirstChild("Head")
	if not head then return end
	local old = head:FindFirstChild(nm)
	if not (type(d) == "table" and d.on) then
		if old then old:Destroy() end
		return
	end
	local text = tostring(d.text or ""):sub(1, 16)
	if text == "" then -- sem nome escolhido: usa o nome de exibição do Roblox da pessoa
		local pl = Players:GetPlayerFromCharacter(char)
		text = tostring(pl and pl.DisplayName or lp.DisplayName):sub(1, 16)
	end
	local role = tostring(d.role or "Membro"):sub(1, 14)
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
	if r then r.Text = role end
	if d.rgb == true then
		g:SetAttribute("Rgb", true)
		TAG.rgbStart()
	else
		g:SetAttribute("Rgb", nil)
		if n then n.TextColor3 = WHITE end
		if r then r.TextColor3 = tagRoleColor(role) end
	end
end
-- RGB: anima a cor de toda tag marcada com o atributo "Rgb" (a minha e as dos outros)
function TAG.rgbStart()
	if TAG.rgbRun then return end
	TAG.rgbRun = true
	task.spawn(function()
		while TAG.rgbRun and gui and gui.Parent do
			local h = (os.clock() * 0.35) % 1
			local c1, c2 = Color3.fromHSV(h, 1, 1), Color3.fromHSV((h + 0.5) % 1, 1, 1)
			local any = false
			for _, pl in ipairs(Players:GetPlayers()) do
				local hd = pl.Character and pl.Character:FindFirstChild("Head")
				if hd then
					for _, nm in ipairs({ "DsTag", "DsTagB" }) do
						local g = hd:FindFirstChild(nm)
						if g and g:GetAttribute("Rgb") then
							any = true
							local n, r = g:FindFirstChild("N"), g:FindFirstChild("R")
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
-- dados efetivos da tag: ligada pelo próprio, ou forçada quando o Dono está no servidor (só quem tem tag dada por ID)
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
			Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(232, 234, 240),
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
		Text = "", PlaceholderText = "Cole o link do script aqui", PlaceholderColor3 = Color3.fromRGB(125, 130, 142),
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
	-- ===== Voo: postura em pé + animação de andar no ar + painel flutuante (ON/OFF e velocidade 1, 2, 3...) =====
	local flyFx = { active = false, gyro = nil, face = nil, tracks = {}, cur = nil, char = nil, hum = nil, states = nil }
	local FLY_FALLBACK = {
		R15 = { walk = "rbxassetid://507777826", idle = "rbxassetid://507766388" },
		R6 = { walk = "rbxassetid://180426354", idle = "rbxassetid://180435571" },
	}
	local function flyAnimId(h, which)
		local id
		pcall(function()
			local a = lp.Character and lp.Character:FindFirstChild("Animate")
			if a then
				if which == "walk" then id = a.walk.WalkAnim.AnimationId else id = a.idle.Animation1.AnimationId end
			end
		end)
		if not id or id == "" then id = (FLY_FALLBACK[h.RigType.Name] or FLY_FALLBACK.R15)[which] end
		return id
	end
	-- toca a animação "walk" (andando) ou "idle" (parado) com prioridade alta: sobrepõe a de queda
	local function flyAnim(h, which, spd)
		local animator = h:FindFirstChildOfClass("Animator")
		if not animator then return end
		if flyFx.char ~= lp.Character then flyFx.char = lp.Character; flyFx.tracks = {}; flyFx.cur = nil end
		local tr = flyFx.tracks[which]
		if not tr then
			local a = Instance.new("Animation")
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

	-- painel flutuante do voo
	local FLY_MAX = 15
	local flyLevel = 4
	S.flyVal = 10 + flyLevel * 10
	local flyPanel, flyOnBtn, flyLvlLbl
	local flyToggles = {} -- setters visuais dos botões "Voar" das abas
	local function flyRefresh()
		if not flyPanel then return end
		flyLvlLbl.Text = "Velocidade " .. flyLevel
		flyOnBtn.Text = S.fly and "ON" or "OFF"
		UI.tween(flyOnBtn, 0.12, { BackgroundColor3 = S.fly and Color3.fromRGB(36, 160, 86) or Color3.fromRGB(46, 48, 58) })
	end
	local function setFlyLevel(n)
		flyLevel = math.clamp(n, 1, FLY_MAX)
		S.flyVal = 10 + flyLevel * 10
		flyRefresh()
	end
	local function setFly(v) S.fly = v and true or false; flyRefresh() end
	local function buildFlyPanel()
		flyPanel = mk("Frame", {
			Size = UDim2.fromOffset(176, 116), Position = UDim2.new(0, 24, 0.3, 0),
			BackgroundColor3 = Color3.fromRGB(13, 14, 18), BackgroundTransparency = 0.08, ZIndex = 20, Visible = false,
		}, gui)
		round(flyPanel, 14); stroke(flyPanel, 2)
		local title = mk("TextLabel", {
			Text = "✈  Voar", Size = UDim2.new(1, -34, 0, 28), Position = UDim2.fromOffset(12, 2), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21,
		}, flyPanel)
		local x = mk("TextButton", {
			Text = "✕", Size = UDim2.fromOffset(22, 22), Position = UDim2.new(1, -28, 0, 5), AutoButtonColor = false,
			BackgroundColor3 = Color3.fromRGB(40, 41, 49), TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 11, ZIndex = 21,
		}, flyPanel)
		round(x, 11)
		x.MouseButton1Click:Connect(function()
			setFly(false)
			flyPanel.Visible = false
			for _, set in ipairs(flyToggles) do pcall(set, false) end
		end)
		flyOnBtn = mk("TextButton", {
			Text = "OFF", Size = UDim2.new(1, -24, 0, 32), Position = UDim2.fromOffset(12, 34), AutoButtonColor = false,
			BackgroundColor3 = Color3.fromRGB(46, 48, 58), TextColor3 = WHITE, Font = Enum.Font.GothamBlack, TextSize = 16, ZIndex = 21,
		}, flyPanel)
		round(flyOnBtn, 10)
		flyOnBtn.MouseButton1Click:Connect(function() setFly(not S.fly) end)
		local function stepBtn(txt, xpos, delta)
			local b = mk("TextButton", {
				Text = txt, Size = UDim2.fromOffset(38, 32), Position = xpos, AutoButtonColor = false,
				BackgroundColor3 = PANEL, TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 20, ZIndex = 21,
			}, flyPanel)
			round(b, 10); stroke(b, 1.5, UI.EDGE)
			b.MouseButton1Click:Connect(function() setFlyLevel(flyLevel + delta) end)
		end
		stepBtn("−", UDim2.fromOffset(12, 74), -1)
		stepBtn("+", UDim2.new(1, -50, 0, 74), 1)
		flyLvlLbl = mk("TextLabel", {
			Text = "", Size = UDim2.new(1, -112, 0, 32), Position = UDim2.fromOffset(56, 74), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamMedium, TextSize = 11, ZIndex = 21,
		}, flyPanel)
		makeDraggable(title, flyPanel, nil, nil, keepBarOnScreen(title))
		flyRefresh()
	end
	-- liga/desliga o painel (o voo começa ligado; o ON/OFF do painel liga e desliga sem fechar)
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
						Name = "ShinHubWater", Size = Vector3.new(14, 1, 14), Anchored = true, CanCollide = true,
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
			local target = mv * S.flyVal + Vector3.new(0, up * S.flyVal, 0)
			selfBV.Velocity = selfBV.Velocity:Lerp(target, 0.35) -- arranca e para suave
			-- postura: em pé, sem girar, virado pra onde anda
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
				flyFx.gyro = mk("BodyGyro", { MaxTorque = Vector3.new(1e9, 1e9, 1e9), P = 30000, D = 800, CFrame = r.CFrame }, r)
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
			-- animação: andando no ar (parado = idle no ar)
			if target.Magnitude > 1 then
				flyAnim(h, "walk", math.clamp(S.flyVal / 14.5, 0.7, 2.2))
			else
				flyAnim(h, "idle", 1)
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
			if p:IsA("BasePart") then
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
					startTFling() -- renasceu: refaz tudo
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

	-- ===== Blocos soltos (desancorados): telecinese e fling parts =====
	local function claimSim()
		pcall(function() sethiddenproperty(lp, "SimulationRadius", 1e9) end)
		pcall(function() lp.MaximumSimulationRadius = 1e9 end)
	end
	local function isLoose(p)
		if not (p and p:IsA("BasePart")) or p.Anchored then return false end
		if p.Name == "HumanoidRootPart" or p.Name == "ShinHubWater" or p:GetAttribute("DsFx") then return false end
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
	do
		local _, st = toggleRow(dp, "Voar", "Abre o painel de voo (ON/OFF e velocidade) • olhe pra cima + joystick = sobe", function(v) setFlyPanel(v) end)
		table.insert(flyToggles, st)
	end
	toggleRow(dp, "Anti-queda", "Limita a velocidade da queda", function(v) S.nofall = v end)
	rowBtn(dp, "Subir 100 studs (fugir da água)", function()
		local r = hrp()
		if r then r.CFrame = r.CFrame + Vector3.new(0, 100, 0); say("Subiu 100 studs.") end
	end)
	toggleRow(dp, "Fling (lançar os outros)", "Quem encostar em você sai voando. Você não gira nem é lançado", function(v)
		S.tfling = v
		if v then startTFling() else stopTFling() end
	end)
	sliderRow(dp, "Força do fling", "Intensidade do lançamento", 50, 300, 150, function(v) S.flingVal = v end)
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
				Name = "ShinHubIlha", Size = Vector3.new(40, 2, 40), Anchored = true, CanCollide = true,
				Material = Enum.Material.SmoothPlastic, Color = Color3.fromRGB(44, 46, 54),
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
		do
			local _, st = toggleRow(mp, "Voar", "Abre o painel de voo (ON/OFF e velocidade) • olhe pra cima + joystick = sobe", function(v) setFlyPanel(v) end)
			table.insert(flyToggles, st)
		end
		toggleRow(mp, "Velocidade", "Liga a velocidade escolhida abaixo", function(v)
			S.speed = v
			if not v then local h = hum(); if h then h.WalkSpeed = 16 end end
		end)
		sliderRow(mp, "Valor da velocidade", "Corrida", 16, 120, 50, function(v) S.speedVal = v end)
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
	-- ===== aba Evade (só aparece no Evade): botões flutuantes de Infinite Slide / Auto Hop + gravador de log =====
	do
		local evp = pages["Evade"]
		if evp then
			local EV = {
				slide = false, hop = false, showSlide = false, showHop = false, locked = false,
				keyHeld = false, touchIn = nil, wasSliding = false, slideSpeed = 0, lastHop = 0, lastHook = 0,
				lastTick = 0, lastAnims = "", hn = 0, rec = true, spyOut = false, gState = "", gAt = 0, hopAlways = false,
			}
			local evConns, evButtons, recConns = {}, {}, {}
			local setSlideMenu, setHopMenu, paintSlide, paintHop

			-- ===== GRAVADOR: guarda tudo o que acontece (também vai pro log da aba Debug e pro arquivo) =====
			local REC = { lines = {}, rate = {}, t0 = os.clock() }
			local function ser(v, d)
				d = d or 0
				local t = typeof(v)
				if t == "string" then return string.format("%q", v:sub(1, 60))
				elseif t == "number" then return string.format("%.4g", v)
				elseif t == "boolean" or t == "nil" then return tostring(v)
				elseif t == "Vector3" then return string.format("V3(%.1f,%.1f,%.1f)", v.X, v.Y, v.Z)
				elseif t == "CFrame" then local p = v.Position; return string.format("CF(%.1f,%.1f,%.1f)", p.X, p.Y, p.Z)
				elseif t == "Instance" then return v:GetFullName()
				elseif t == "table" then
					if d >= 2 then return "{...}" end
					local out, n = {}, 0
					for k, x in pairs(v) do
						n = n + 1
						if n > 8 then out[#out + 1] = "..."; break end
						out[#out + 1] = tostring(k) .. "=" .. ser(x, d + 1)
					end
					return "{" .. table.concat(out, ", ") .. "}"
				end
				return "<" .. t .. ">"
			end
			local function push(cat, msg)
				local now = os.clock()
				local r = hrp()
				local sp = r and Vector3.new(r.AssemblyLinearVelocity.X, 0, r.AssemblyLinearVelocity.Z).Magnitude or 0
				local line = string.format("[%s +%6.1fs] %-8s %s | vel=%.0f", os.date("%H:%M:%S"), now - REC.t0, cat, msg, sp)
				REC.lines[#REC.lines + 1] = line
				if #REC.lines > 4000 then table.remove(REC.lines, 1) end
				DSLOG.ev("INFO", "evade", cat .. " " .. msg)
			end
			-- limite de linhas por segundo em cada categoria (o resto é contado e avisado)
			local function rec(cat, msg, limit)
				if not EV.rec then return end
				local now = os.clock()
				local r = REC.rate[cat]
				if not r or now - r.t >= 1 then
					if r and r.drop > 0 then push(cat, "(+" .. r.drop .. " linhas omitidas: muito rápido)") end
					r = { t = now, n = 0, drop = 0 }
					REC.rate[cat] = r
				end
				r.n = r.n + 1
				if r.n > (limit or 12) then r.drop = r.drop + 1; return end
				push(cat, msg)
			end

			-- liga o gravador no personagem atual (refaz quando o personagem muda, ex.: começo da rodada)
			local function unbindChar()
				for _, cn in ipairs(recConns) do pcall(function() cn:Disconnect() end) end
				recConns = {}
			end
			local function bindChar()
				unbindChar()
				local c, h = lp.Character, hum()
				if not (c and h) then rec("char", "ainda sem personagem/humanoid"); return end
				rec("char", "personagem " .. c:GetFullName() .. " rig=" .. tostring(h.RigType) .. " WalkSpeed=" .. tostring(h.WalkSpeed)
					.. " JumpPower=" .. tostring(h.JumpPower) .. " JumpHeight=" .. tostring(h.JumpHeight))
				local names = {}
				for n, x in pairs(c:GetAttributes()) do names[#names + 1] = "char." .. n .. "=" .. tostring(x) end
				for n, x in pairs(h:GetAttributes()) do names[#names + 1] = "hum." .. n .. "=" .. tostring(x) end
				for n, x in pairs(lp:GetAttributes()) do names[#names + 1] = "player." .. n .. "=" .. tostring(x) end
				rec("attr", "atributos agora: " .. (#names > 0 and table.concat(names, ", ") or "(nenhum)"))
				local kids = {}
				for _, k in ipairs(c:GetChildren()) do kids[#kids + 1] = k.Name .. ":" .. k.ClassName end
				rec("char", "filhos do personagem: " .. table.concat(kids, ", "))
				local function add(cn) recConns[#recConns + 1] = cn end
				local function watch(o, tag)
					add(o.AttributeChanged:Connect(function(n) rec("attr", tag .. "." .. n .. " = " .. ser(o:GetAttribute(n)), 20) end))
				end
				watch(c, "char"); watch(h, "hum"); watch(lp, "player")
				local root = hrp()
				if root then watch(root, "root") end
				add(c.ChildAdded:Connect(function(k) rec("char", "+filho " .. k.Name .. ":" .. k.ClassName, 10) end))
				add(c.ChildRemoved:Connect(function(k) rec("char", "-filho " .. k.Name, 10) end))
				for _, prop in ipairs({ "WalkSpeed", "JumpPower", "JumpHeight", "HipHeight", "Health", "PlatformStand", "Sit" }) do
					add(h:GetPropertyChangedSignal(prop):Connect(function() rec("hum", prop .. " = " .. ser(h[prop]), 6) end))
				end
				add(h.StateChanged:Connect(function(old, new) rec("estado", tostring(old) .. " -> " .. tostring(new), 20) end))
				local an = h:FindFirstChildOfClass("Animator")
				if an then
					add(an.AnimationPlayed:Connect(function(t)
						rec("anim", "tocou " .. tostring(t.Name) .. " id=" .. tostring(t.Animation and t.Animation.AnimationId)
							.. " dur=" .. string.format("%.2f", t.Length) .. " prio=" .. tostring(t.Priority), 20)
						t.Stopped:Connect(function() rec("anim", "parou " .. tostring(t.Name), 20) end)
					end))
				else
					rec("char", "sem Animator no humanoid")
				end
			end
			table.insert(evConns, lp.CharacterAdded:Connect(function()
				EV.gState = ""; EV.gSpeed = nil
				rec("char", "novo personagem (respawn/rodada)")
				task.wait(0.6)
				bindChar()
			end))

			-- remotes que o SERVIDOR manda pra você (só escuta, não altera nada)
			local watched = setmetatable({}, { __mode = "k" })
			local function watchRemote(r)
				if watched[r] or not r:IsA("RemoteEvent") then return end
				watched[r] = true
				table.insert(evConns, r.OnClientEvent:Connect(function(...)
					local a = table.pack(...)
					local p = {}
					for k = 1, math.min(a.n, 6) do p[k] = ser(a[k]) end
					rec("remote<-" .. r.Name, "(" .. table.concat(p, ", ") .. ")", 5)
				end))
			end
			pcall(function()
				local RS = game:GetService("ReplicatedStorage")
				for _, d in ipairs(RS:GetDescendants()) do watchRemote(d) end
				table.insert(evConns, RS.DescendantAdded:Connect(function(d) task.defer(watchRemote, d) end))
			end)

			-- remotes que VOCÊ manda pro servidor (usa hook; só liga se você ativar no menu)
			local spyHooked = false
			local function installSpy()
				if spyHooked then return true end
				if not (hookmetamethod and getnamecallmethod) then return false end
				local nc = newcclosure or function(f) return f end
				local ok = pcall(function()
					local old
					old = hookmetamethod(game, "__namecall", nc(function(self, ...)
						local m = getnamecallmethod()
						if EV.spyOut and (m == "FireServer" or m == "InvokeServer") then
							local a = table.pack(...)
							local okn, nm = pcall(function() return self.Name end)
							task.defer(function()
								local p = {}
								for k = 1, math.min(a.n, 6) do p[k] = ser(a[k]) end
								rec("remote->", (okn and nm or "?") .. ":" .. m .. "(" .. table.concat(p, ", ") .. ")", 15)
							end)
						end
						return old(self, ...)
					end))
				end)
				spyHooked = ok
				return ok
			end

			-- lê (só leitura) o estado de movimento que o PRÓPRIO jogo manda pro servidor: "Move", "Air", "Slide", "SlideAir"...
			-- o Evade não usa atributo nem animação pra isso, por isso o slide nunca era detectado
			local stateHooked = false
			local function installStateHook()
				if stateHooked or not (hookmetamethod and getnamecallmethod) then return stateHooked end
				local nc = newcclosure or function(f) return f end
				local ok = pcall(function()
					local old
					old = hookmetamethod(game, "__namecall", nc(function(self, ...)
						local a1, a2, a3 = ...
						if getnamecallmethod() == "FireServer" then
							local okn, nm = pcall(function() return self.Name end)
							if okn and nm == "UpdateCharacterDataRegistry" then
								pcall(function()
									-- o jogo manda 1 tabela: {1=buffer, 2="Slide", 3=V3, 4=velocidade} (a ordem varia)
									local list = (type(a1) == "table") and a1 or { a1, a2, a3 }
									local st, spd
									for k = 2, 6 do
										local x = list[k]
										if type(x) == "string" and not st then st = x
										elseif type(x) == "number" and not spd then spd = x end
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
			rec("evade", "hook do estado do jogo: " .. tostring(hookOk))

			-- ===== botão flutuante redondo: toque = liga/desliga; arrastar = muda de lugar (se não estiver travado) =====
			local function makeFloat(label, pos, onTap)
				local b = mk("TextButton", {
					Text = label, Size = UDim2.fromOffset(64, 64), Position = pos, Visible = false,
					BackgroundColor3 = PANEL, BackgroundTransparency = 0.15, TextColor3 = WHITE,
					Font = Enum.Font.GothamBold, TextSize = 11, TextWrapped = true, AutoButtonColor = false, ZIndex = 25,
				}, gui)
				round(b, 32)
				local st = mk("UIStroke", { Thickness = 2, Color = RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, b)
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
			slideBtn, paintSlide = makeFloat("Slide\n∞", UDim2.new(1, -90, 0.42, 0), function()
				EV.slide = not EV.slide
				paintSlide(EV.slide)
				rec("ui", "botão flutuante Infinite Slide -> " .. (EV.slide and "LIGADO" or "desligado"))
				if setSlideMenu then setSlideMenu(EV.slide) end
			end)
			local hopBtn
			hopBtn, paintHop = makeFloat("Auto\nHop", UDim2.new(1, -90, 0.42, 76), function()
				EV.hop = not EV.hop
				paintHop(EV.hop)
				rec("ui", "botão flutuante Auto Hop -> " .. (EV.hop and "LIGADO" or "desligado"))
				if setHopMenu then setHopMenu(EV.hop) end
			end)

			-- detecta se o personagem está deslizando (atributo/animação com "slid" ou "crouch" no nome)
			local function slideActive(c, h)
				local gs = EV.gState
				if type(gs) == "string" and gs ~= "" then
					if gs:find("^Slide") then return true, "estado do jogo " .. gs end
					-- o jogo encerra o slide sozinho quando a velocidade interna dele cai (vira CrouchMove); segue deslizando até sair do agachado
					if EV.wasSliding and gs:find("^Crouch") then return true, "slide estendido (" .. gs .. ")" end
					return false
				end
				for _, o in ipairs({ c, h }) do
					for n, v in pairs(o:GetAttributes()) do
						local ln = n:lower()
						if (ln:find("slid") or ln:find("crouch")) and v == true then return true, "attr " .. n end
						if type(v) == "string" then
							local lv = v:lower()
							if lv:find("slid") or lv:find("crouch") then return true, "attr " .. n .. "=" .. v end
						end
					end
				end
				local an = h:FindFirstChildOfClass("Animator")
				local tracks = (an and an:GetPlayingAnimationTracks()) or {}
				for _, t in ipairs(tracks) do
					local nm = (t.Name or ""):lower()
					local anm = (t.Animation and t.Animation.Name or ""):lower()
					if nm:find("slid") or anm:find("slid") or nm:find("crouch") or anm:find("crouch") then return true, "anim " .. t.Name end
				end
				return false
			end

			-- botão de pular do celular: guarda o toque real que está nele (solta sozinho quando o dedo sai)
			local hooked = setmetatable({}, { __mode = "k" })
			local function hookJumpButton()
				local pg = lp:FindFirstChild("PlayerGui")
				local tg = pg and pg:FindFirstChild("TouchGui")
				local fr = tg and tg:FindFirstChild("TouchControlFrame")
				local jb = fr and fr:FindFirstChild("JumpButton")
				if jb and not hooked[jb] then
					hooked[jb] = true
					table.insert(evConns, jb.InputBegan:Connect(function(i) if isPress(i) then EV.touchIn = i end end))
					table.insert(evConns, jb.InputEnded:Connect(function(i) if isPress(i) then EV.touchIn = nil end end))
					rec("pulo", "botão de pular padrão do celular encontrado: " .. jb:GetFullName())
				end
			end

			local function isJumpKey(i) return i.KeyCode == Enum.KeyCode.Space or i.KeyCode == Enum.KeyCode.ButtonA end
			table.insert(evConns, UIS.InputBegan:Connect(function(i, gp)
				if i.KeyCode ~= Enum.KeyCode.Unknown then
					rec("tecla", "↓ " .. tostring(i.KeyCode) .. (gp and " (interface)" or ""), 20)
					if isJumpKey(i) and not UIS:GetFocusedTextBox() then EV.keyHeld = true end
				end
				if isPress(i) then
					local pg = lp:FindFirstChild("PlayerGui")
					if not pg then return end
					local inset = game:GetService("GuiService"):GetGuiInset()
					local seen, names, isJump = {}, {}, false
					for _, dy in ipairs({ 0, inset.Y }) do
						local ok, objs = pcall(function() return pg:GetGuiObjectsAtPosition(i.Position.X, i.Position.Y - dy) end)
						if ok then
							for _, o in ipairs(objs) do
								if not seen[o] then
									seen[o] = true
									local path = o:GetFullName():gsub("^Players%.[^%.]+%.PlayerGui%.", "")
									names[#names + 1] = path .. "(" .. o.ClassName .. ")"
									if o.Name:lower():find("jump") or (o.Parent and o.Parent.Name:lower():find("jump")) then isJump = true end
								end
							end
						end
					end
					if isJump then EV.touchIn = i end
					rec("toque", "↓ (" .. math.floor(i.Position.X) .. "," .. math.floor(i.Position.Y) .. ") " .. (isJump and "[PULO] " or "")
						.. (#names > 0 and table.concat(names, " ; ", 1, math.min(#names, 5)) or "(nenhum botão do jogo)"), 20)
				end
			end))
			table.insert(evConns, UIS.InputEnded:Connect(function(i)
				if i.KeyCode ~= Enum.KeyCode.Unknown then
					rec("tecla", "↑ " .. tostring(i.KeyCode), 20)
					if isJumpKey(i) then EV.keyHeld = false end
				end
				if isPress(i) then
					if EV.touchIn and i == EV.touchIn then EV.touchIn = nil end
					rec("toque", "↑", 20)
				end
			end))

			-- Infinite Slide: o jogo sobrescreve a velocidade todo frame com uma velocidade interna que decai,
			-- então além de escrever a velocidade usamos um LinearVelocity (o solver da física vence a ordem dos scripts)
			local function killMover()
				if EV.mover then pcall(function() EV.mover:Destroy() end); EV.mover = nil end
				if EV.moverAtt then pcall(function() EV.moverAtt:Destroy() end); EV.moverAtt = nil end
			end
			local function pushMover(r, vx, vz)
				local m = EV.mover
				if not (m and m.Parent) then
					killMover()
					local ok = pcall(function()
						local att = Instance.new("Attachment")
						att.Name = "EvSlideAtt"; att.Parent = r
						local lv = Instance.new("LinearVelocity")
						lv.Name = "EvSlideLV"
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
					rec("slide", "LinearVelocity criado")
				end
				pcall(function() EV.mover.PlaneVelocity = Vector2.new(vx, vz) end)
				return true
			end
			-- LinearVelocity(s) que o PRÓPRIO jogo usa pra mover o personagem no slide (o jogo reescreve o valor todo frame, com a velocidade decaindo)
			local function gameSlideMovers(r)
				local all, pref = {}, {}
				for _, o in ipairs(r:GetChildren()) do
					if o:IsA("LinearVelocity") and o.Name ~= "EvSlideLV" and o.Enabled then
						all[#all + 1] = o
						local an = o.Attachment0 and o.Attachment0.Name or ""
						if an:lower():find("slid") then pref[#pref + 1] = o end
					end
				end
				return #pref > 0 and pref or all
			end
			-- sobe o valor do LinearVelocity do jogo até a velocidade S (mantém a direção que o jogo escolheu)
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
						killMover() -- garante que nenhum "prendedor" de direção da versão antiga fique no personagem
						local lk = Vector3.new(r.CFrame.LookVector.X, 0, r.CFrame.LookVector.Z)
						EV.slideDir = flat.Magnitude > 1 and flat.Unit or (lk.Magnitude > 0.01 and lk.Unit or Vector3.new(0, 0, -1))
						rec("slide", "slide DETECTADO (" .. tostring(why) .. ") vel inicial=" .. string.format("%.1f", EV.slideSpeed))
						local ch = {}
						for _, d in ipairs(r:GetChildren()) do ch[#ch + 1] = d.Name .. ":" .. d.ClassName end
						rec("slide", "filhos do HumanoidRootPart: " .. table.concat(ch, ", "))
						local mv = {}
						for _, d in ipairs(c:GetDescendants()) do
							if d.Name:sub(1, 7) ~= "EvSlide" and (d:IsA("BodyMover") or d:IsA("LinearVelocity") or d:IsA("VectorForce") or d:IsA("AlignPosition")) then
								mv[#mv + 1] = d:GetFullName() .. ":" .. d.ClassName
							end
						end
						rec("slide", "movers do jogo no personagem: " .. (#mv > 0 and table.concat(mv, ", ") or "nenhum"))
							for _, lv in ipairs(r:GetChildren()) do
								if lv:IsA("LinearVelocity") and lv.Name ~= "EvSlideLV" then
									rec("slide", "LV do jogo: att=" .. tostring(lv.Attachment0 and lv.Attachment0.Name) .. " ativo=" .. tostring(lv.Enabled) .. " modo=" .. tostring(lv.VelocityConstraintMode)
										.. " rel=" .. tostring(lv.RelativeTo) .. " vec=" .. ser(lv.VectorVelocity) .. " linha=" .. ser(lv.LineVelocity) .. " plano=" .. tostring(lv.PlaneVelocity), 8)
								end
							end
					end
					EV.wasSliding = true
					-- Infinite Slide: NÃO mexe na direção (quem controla pra onde vai é o jogo, normal). Só impede a velocidade de cair abaixo da do começo.
					if os.clock() - (EV.slideT0 or 0) < 0.25 then
						EV.slideSpeed = math.max(EV.slideSpeed or 0, flat.Magnitude) -- pega o pico logo no início
					end
					local S = EV.slideSpeed or 0
					local gs = EV.gState or ""
					if S > 8 then
						if type(gs) == "string" and gs:find("^Crouch") then
							-- o jogo já largou o slide (virou agachado): continua deslizando com um LinearVelocity nosso, direção = o que você aponta no joystick
							local md = h.MoveDirection
							local dd = Vector3.new(md.X, 0, md.Z)
							if dd.Magnitude > 0.1 then EV.slideDir = dd.Unit end
							if EV.slideDir then pushMover(r, EV.slideDir.X * S, EV.slideDir.Z * S) end
							else
							-- 1) mexe no LinearVelocity do jogo (é ele que manda a velocidade; escrever só AssemblyLinearVelocity era sobrescrito)
								local lifted, gdir = false, nil
							for _, lv in ipairs(gameSlideMovers(r)) do
								local okl, ch, dr = pcall(liftMover, lv, S)
								if okl and ch then lifted = true end
								if okl and dr then gdir = dr end
							end
							-- 3) LinearVelocity nosso na MESMA direção e velocidade do jogo (não briga com ele; garante mesmo se o mover do jogo for outro tipo)
							local pd = gdir or (flat.Magnitude > 0.5 and flat.Unit) or EV.slideDir
							if pd then EV.slideDir = pd; pushMover(r, pd.X * S, pd.Z * S) end
							if lifted then rec("slide", "LinearVelocity do jogo ajustado pra " .. string.format("%.1f", S), 3) end
							-- 2) reforço direto na velocidade (caso o jogo não use LinearVelocity nesse instante)
							if flat.Magnitude > 0.5 and flat.Magnitude < S - 0.3 then
								local dir = flat.Unit
								r.AssemblyLinearVelocity = Vector3.new(dir.X * S, v.Y, dir.Z * S)
								if not lifted then rec("slide", "sem LinearVelocity do jogo pra ajustar; só reforcei a velocidade (era " .. string.format("%.1f", flat.Magnitude) .. ")", 3) end
							end
							end
						end
				else
					if EV.wasSliding then rec("slide", "slide TERMINOU") end
					EV.wasSliding = false
					killMover()
				end
			end

			table.insert(evConns, RunService.Heartbeat:Connect(function()
				local now = os.clock()
				if now - EV.lastHook > 1 then EV.lastHook = now; pcall(hookJumpButton) end
				-- trava de segurança: tecla marcada como segurada mas já foi solta
				if EV.keyHeld and not (UIS:IsKeyDown(Enum.KeyCode.Space) or UIS:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonA)) then
					EV.keyHeld = false
				end
				if EV.touchIn and EV.touchIn.UserInputState == Enum.UserInputState.End then EV.touchIn = nil end
				local c, h, r = lp.Character, hum(), hrp()
				if not (c and h and r) or h.Health <= 0 then return end

				-- telemetria 1x por segundo (só quando está andando ou as animações mudaram)
				if now - EV.lastTick >= 1 then
					EV.lastTick = now
					local v = r.AssemblyLinearVelocity
					local sp = Vector3.new(v.X, 0, v.Z).Magnitude
					local an = h:FindFirstChildOfClass("Animator")
					local names = {}
					if an then
						for _, t in ipairs(an:GetPlayingAnimationTracks()) do names[#names + 1] = tostring(t.Name) end
					end
					table.sort(names)
					local joined = table.concat(names, ",")
					if sp > 5 or joined ~= EV.lastAnims then
						EV.lastAnims = joined
						rec("tick", string.format("estado=%s chao=%s pulo_segurado=%s slideON=%s hopON=%s anims=[%s]",
							tostring(h:GetState()), tostring(h.FloorMaterial), tostring(EV.keyHeld or EV.touchIn ~= nil),
							tostring(EV.slide), tostring(EV.hop), joined), 2)
					end
				end

				-- Auto Hop: pula assim que encosta no chão (só em Running/Landed; antes pulava também no ar e em qualquer estado)
				local gs = EV.gState or ""
				local busyState = gs == "Downed" or gs == "Ragdolling" or gs == "Carried" or gs == "Climbing" or gs:find("^Slide") ~= nil
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
						rec("hop", "pulo automático #" .. EV.hn .. " estado=" .. tostring(st) .. " jogo=" .. gs, 6)
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

			-- o jogo reescreve a velocidade a cada frame; reforçar no Stepped (logo antes da física) garante que o nosso valor vença
			table.insert(evConns, RunService.Stepped:Connect(function()
				if not EV.slide then return end
				local c, h, r = lp.Character, hum(), hrp()
				if not (c and h and r) or h.Health <= 0 then return end
				doSlide(c, h, r)
			end))

			-- ===== menu da aba =====
			section(evp, "Evade")
			toggleRow(evp, "Botão flutuante: Infinite Slide", "Mostra o botão na tela (toque = liga/desliga)", function(v)
				EV.showSlide = v
				slideBtn.Visible = v
				rec("ui", "mostrar botão flutuante Infinite Slide: " .. tostring(v))
			end)
			toggleRow(evp, "Botão flutuante: Auto Hop", "Mostra o botão na tela (toque = liga/desliga)", function(v)
				EV.showHop = v
				hopBtn.Visible = v
				rec("ui", "mostrar botão flutuante Auto Hop: " .. tostring(v))
			end)
			rowBtn(evp, "Travar botões flutuantes", function()
				EV.locked = true
				rec("ui", "botões flutuantes TRAVADOS")
				say("Botões flutuantes travados (não arrastam).")
			end, true)
			rowBtn(evp, "Destravar botões flutuantes", function()
				EV.locked = false
				rec("ui", "botões flutuantes DESTRAVADOS")
				say("Botões flutuantes destravados: arraste pra mover.")
			end, true)
			local _
			_, setSlideMenu = toggleRow(evp, "Infinite Slide", "Liga/desliga direto aqui, sem o botão flutuante", function(v)
				EV.slide = v
				paintSlide(v)
				rec("ui", "menu Infinite Slide -> " .. (v and "LIGADO" or "desligado"))
			end)
			_, setHopMenu = toggleRow(evp, "Auto Hop", "Pula sozinho o tempo todo, sem segurar nada", function(v)
				EV.hop = v
				paintHop(v)
				rec("ui", "menu Auto Hop -> " .. (v and "LIGADO" or "desligado"))
			end)
			toggleRow(evp, "Auto Hop segurando o pulo", "Só fica pulando sozinho enquanto você SEGURA o botão de pular", function(v)
				EV.hopAlways = v
				rec("ui", "Auto Hop segurando -> " .. tostring(v))
			end)

			section(evp, "Log do Evade")
			toggleRow(evp, "Gravar tudo", "Personagem, atributos, animações, estados, toques, teclas e remotes recebidos", function(v)
				EV.rec = v
				if v then bindChar() end
				say(v and "Gravando o log do Evade." or "Gravação do log do Evade pausada.")
			end, true)
			toggleRow(evp, "Gravar remotes enviados", "O que o seu jogo manda pro servidor (usa hook; ligue só pra investigar)", function(v)
				if v and not installSpy() then
					say("Seu executor não suporta hookmetamethod: não dá pra gravar os remotes enviados.")
					return
				end
				EV.spyOut = v
				rec("ui", "gravar remotes enviados: " .. tostring(v))
			end)
			rowBtn(evp, "Copiar log do Evade", function()
				local f = setclipboard or toclipboard
				local txt = table.concat(REC.lines, "\n")
				if txt == "" then say("O log do Evade está vazio."); return end
				if not f then say("Seu executor não tem setclipboard. O log também está no arquivo " .. DSLOG.file); return end
				say(pcall(f, txt) and ("Log do Evade copiado (" .. #REC.lines .. " linhas).") or "Falhou ao copiar.")
			end, true)
			rowBtn(evp, "Limpar log do Evade", function()
				REC.lines = {}
				say("Log do Evade limpo.")
			end, true)

			rec("evade", "aba Evade ativa | PlaceId=" .. tostring(game.PlaceId) .. " | jogo=" .. tostring(game.Name) .. " | toque=" .. tostring(UIS.TouchEnabled))
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
	toggleRow(dp, "Pulo alto", "JumpPower 90", function(v)
		S.jump = v
		if not v then local h = hum(); if h then h.JumpPower = 50 end end
	end)
	toggleRow(dp, "Atravessar paredes", "Noclip", function(v) S.noclip = v end)

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

-- ===== TELA DE CARREGAMENTO (0 a 100% em 5s, verifica ID / executor / versão) =====
do
	local LOAD_URL = "https://i.postimg.cc/52hXnz83/e1d39eb5abfe26de721ee0928f64af67.jpg"
	local TIME = 5 -- segundos
	local sg = mk("ScreenGui", { Name = "ShinHubCarregando", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 999 }, parent)
	local bg = mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(10, 10, 13), BorderSizePixel = 0, Active = true }, sg)
	local img = mk("ImageLabel", {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Crop, ImageTransparency = 0.15,
	}, bg)
	mk("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(10, 10, 13), BackgroundTransparency = 0.55, BorderSizePixel = 0 }, bg)
	-- foto baixada uma vez e reaproveitada (igual às outras)
	local imgReady = false
	task.spawn(function()
		local a = fetchAsset(LOAD_URL, "loading.jpg")
		if a then img.Image = a end
		imgReady = true
	end)

	local box = mk("Frame", { Size = UDim2.new(0.8, 0, 0, 220), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1 }, bg)
	mk("UISizeConstraint", { MaxSize = Vector2.new(420, 220) }, box)
	mk("TextLabel", {
		Text = "Shin Hub", Size = UDim2.new(1, 0, 0, 54), BackgroundTransparency = 1, TextColor3 = WHITE,
		Font = Enum.Font.GothamBlack, TextSize = 40, TextStrokeTransparency = 0.3, TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
	}, box)
	local pct = mk("TextLabel", {
		Text = "0%", Size = UDim2.new(1, 0, 0, 34), Position = UDim2.fromOffset(0, 58), BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(255, 120, 125), Font = Enum.Font.GothamBold, TextSize = 26, TextStrokeTransparency = 0.5,
	}, box)
	local track = mk("Frame", { Size = UDim2.new(1, 0, 0, 12), Position = UDim2.fromOffset(0, 104), BackgroundColor3 = Color3.fromRGB(34, 35, 42), BackgroundTransparency = 0.1 }, box)
	round(track, 6); stroke(track, 1.5)
	local fill = mk("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = RED, BorderSizePixel = 0 }, track)
	round(fill, 6)

	-- executor e versão (esta é a versão de membro)
	local exName = "Desconhecido"
	pcall(function()
		local n, v = identifyexecutor()
		if n then exName = tostring(n) .. (v and (" " .. tostring(v)) or "") end
	end)
	if exName == "Desconhecido" then pcall(function() local n = getexecutorname(); if n then exName = tostring(n) end end) end
	local checks = {
		{ at = 0.00, label = "ID da pessoa", value = tostring(lp.UserId) .. " (@" .. lp.Name .. ")" },
		{ at = 0.30, label = "Executor", value = exName },
		{ at = 0.60, label = "Versão", value = "Membro" },
	}
	local lines = {}
	for i, c in ipairs(checks) do
		lines[i] = mk("TextLabel", {
			Text = "", Size = UDim2.new(1, 0, 0, 16), Position = UDim2.fromOffset(0, 126 + (i - 1) * 17), BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(232, 234, 240), Font = Enum.Font.Gotham, TextSize = 11, TextStrokeTransparency = 0.6,
		}, box)
	end

	-- se a foto ainda não baixou (primeira vez), espera um pouco antes de começar os 5s
	local w = 0
	while not imgReady and w < 2.5 do w = w + task.wait() end

	local t0 = os.clock()
	while true do
		local p = math.clamp((os.clock() - t0) / TIME, 0, 1)
		fill.Size = UDim2.fromScale(p, 1)
		pct.Text = math.floor(p * 100) .. "%"
		for i, c in ipairs(checks) do
			local nextAt = checks[i + 1] and checks[i + 1].at or 0.9
			if p >= c.at then
				if p >= nextAt then
					lines[i].Text = "✓ " .. c.label .. ": " .. c.value
				else
					lines[i].Text = "Verificando " .. c.label:lower() .. "..."
				end
			end
		end
		if p >= 1 then break end
		task.wait()
	end
	pct.Text = "100%"
	task.wait(0.25)
	sg:Destroy()
end

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
		if type(c.rgb) == "boolean" then TAG.rgb = c.rgb end
		if type(c.on) == "boolean" then TAG.on = c.on; TAG.forceOff = (c.on == false) end
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

-- ===== Menu (abas) + botão flutuante =====
-- ===== Aba Efeitos (só no SEU aparelho) =====
local Lighting = game:GetService("Lighting")
local function buildEffects(page, say)
	local E = { colorIdx = 1 }
	local fxSet = {} -- setters dos interruptores (pra desligar tudo quando você morre)
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

	-- ao morrer (ou renascer) os efeitos se desligam: pra você e pra todo mundo que usa o hub
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
		local h = c:FindFirstChildOfClass("Humanoid") or c:WaitForChild("Humanoid", 8)
		if h then h.Died:Connect(function() task.spawn(resetFx) end) end
	end
	local charConn = lp.CharacterAdded:Connect(function(c)
		task.spawn(resetFx)
		task.spawn(watchChar, c)
	end)
	if lp.Character then task.spawn(watchChar, lp.Character) end

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
		TextColor3 = Color3.fromRGB(232, 234, 240), Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, page)
	local colorBtn
	colorBtn = rowBtn(page, "Cor dos efeitos: " .. COLORS[1][1], function()
		E.colorIdx = E.colorIdx % #COLORS + 1
		colorBtn:FindFirstChildOfClass("TextLabel").Text = "Cor dos efeitos: " .. COLORS[E.colorIdx][1]
		refresh()
	end)
	local function fxToggle(label, desc, key)
		fxSet[key] = select(2, toggleRow(page, label, desc, function(v) E[key] = v; refresh() end))
	end
	fxToggle("Fogo", "Chamas no corpo", "fire")
	fxToggle("Fumaça", "Fumaça subindo", "smoke")
	fxToggle("Brilhos", "Faíscas ao redor", "sparkles")
	fxToggle("Estrelas", "Partículas de estrela", "stars")
	fxToggle("Rastro", "Rastro de luz ao andar", "trail")
	fxToggle("Aura", "Contorno brilhante no corpo", "aura")
	fxToggle("Luz", "Ilumina o ambiente em volta", "light")
	fxSet.rainbow = select(2, toggleRow(page, "Efeitos arco-íris", "Troca a cor dos efeitos sem parar", function(v) E.rainbow = v; refresh() end))
	fxSet.neon = select(2, toggleRow(page, "Corpo neon", "Material neon em todas as peças", function(v) E.neon = v; refresh() end))
	fxSet.rainbowBody = select(2, toggleRow(page, "Corpo arco-íris", "Pinta o corpo trocando de cor", function(v) E.rainbowBody = v; refresh() end))
	fxSet.ghost = select(2, toggleRow(page, "Fantasma", "Deixa o corpo meio transparente", function(v) E.ghost = v; refresh() end))
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
			mk("TextLabel", {
				Text = "Ninguém disponível agora.", LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(125, 130, 142), Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
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
				BackgroundColor3 = Color3.fromRGB(20, 21, 26), BackgroundTransparency = 0.3, TextColor3 = WHITE,
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
local MUSIC_CATS = {} -- lista de músicas (preenchida na aba Música e reaproveitada na aba Car)
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
			Text = "", PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(125, 130, 142),
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
			{ "antrsPnEu", "73461924431293" },
			{ "Aniquilação", "135772975027358" },
			{ "Pedra na Praia", "127615454743173" },
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
	MUSIC_CATS = CATS

	local GRAY = Color3.fromRGB(125, 130, 142)
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
		Text = "Letreiro grande em cima de você. Se não escolher um nome, aparece o seu nome de exibição do Roblox. O cargo embaixo (Membro / Influenciador / Sub Dono / Dono) é o Dono quem define.",
		Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(232, 234, 240),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local _, setTagOn = toggleRow(page, "Mostrar tag", "Liga/desliga o letreiro", function(v)
		TAG.on = v; TAG.refresh()
		if TAG.push then TAG.push() end
	end, TAG.on)
	local tagBox = inputRow("Nome da tag (vazio = seu nome de exibição)")
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
		TAG.text = t:sub(1, 16)
		TAG.refresh()
		if TAG.push then TAG.push() end
		say("Tag: " .. (TAG.text ~= "" and TAG.text or lp.DisplayName))
	end, true)
	roleLbl = mk("TextLabel", {
		Text = "Cargo: " .. TAG.role .. " (definido pelo Dono)", Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
	}, page)
	TAG.onChanged = function()
		tagBox.Text = TAG.text
		fontBtn:FindFirstChildOfClass("TextLabel").Text = "Fonte: " .. TAG.font
		roleLbl.Text = "Cargo: " .. TAG.role .. " (definido pelo Dono)"
		setTagOn(TAG.on)
	end

	table.insert(conns, { Disconnect = function() alive = false end })
end

-- ===== Detecta o jogo: cada jogo só mostra as abas dele =====
local GAMES = {
	Brookhaven = { 4924922222 },
	["Natural Disaster"] = { 189707 },
	Evade = { 9872472334 },
}
local function inGame(name)
	for _, id in ipairs(GAMES[name] or {}) do
		if game.PlaceId == id then return true end
	end
	if name == "Evade" then -- reserva: outros lugares do Evade pelo nome do jogo
		local ok, nm = pcall(function() return tostring(game.Name):lower() end)
		return ok and nm:find("evade") ~= nil
	end
	return false
end
-- abas do Brookhaven: cada função é uma aba normal, só aparecem no jogo Brookhaven
local BROOKHAVEN_TABS = { "Nome", "Música", "Tag", "Proteções", "Movimento", "Asa", "Car", "Avatar" }
local function buildTabs(last)
	local t = { "ID", "Créditos", "Scripts" } -- ID e Créditos ficam no início
	if inGame("Brookhaven") then
		for _, n in ipairs(BROOKHAVEN_TABS) do table.insert(t, n) end
	end
	if inGame("Natural Disaster") then table.insert(t, "Natural Disaster") end
	if inGame("Evade") then table.insert(t, "Evade") end
	for _, n in ipairs({ "Mod", "Efeitos", "Extras" }) do table.insert(t, n) end -- comuns aos dois jogos
	for _, n in ipairs(last) do table.insert(t, n) end
	return t
end

-- ===== Registro compartilhado de remotes (usado pelo turbo da aba Car e pela aba Log) =====
local HUBLOG = { list = {}, on = false, self = false, hooked = false, t0 = os.clock(), listeners = {} }
function HUBLOG.ser(v, d)
	d = d or 0
	local t = typeof(v)
	if t == "string" then return string.format("%q", v)
	elseif t == "number" or t == "boolean" or t == "nil" then return tostring(v)
	elseif t == "Color3" then return string.format("Color3.fromRGB(%d,%d,%d)", math.floor(v.R * 255 + 0.5), math.floor(v.G * 255 + 0.5), math.floor(v.B * 255 + 0.5))
	elseif t == "Vector3" then return string.format("Vector3.new(%g,%g,%g)", v.X, v.Y, v.Z)
	elseif t == "CFrame" then local p = v.Position; return string.format("CFrame.new(%g,%g,%g)", p.X, p.Y, p.Z)
	elseif t == "Instance" then return "game." .. v:GetFullName()
	elseif t == "table" then
		if d >= 4 then return "{...}" end
		local out, n = {}, 0
		for k, x in pairs(v) do
			n = n + 1
			if n > 40 then out[#out + 1] = "..."; break end
			out[#out + 1] = (type(k) == "number" and "" or ("[" .. HUBLOG.ser(k, d + 1) .. "]=")) .. HUBLOG.ser(x, d + 1)
		end
		return "{" .. table.concat(out, ", ") .. "}"
	end
	return "<" .. t .. ">"
end
function HUBLOG.path(inst)
	local names, p = {}, inst
	while p and p ~= game do table.insert(names, 1, p.Name); p = p.Parent end
	local svc = table.remove(names, 1) or "?"
	local s = 'game:GetService("' .. tostring(svc) .. '")'
	for _, n in ipairs(names) do s = s .. "[" .. string.format("%q", n) .. "]" end
	return s
end
local function hubPush(line)
	local list = HUBLOG.list
	local last = list[#list]
	if last and last.line == line then last.n = last.n + 1; return end
	list[#list + 1] = { t = os.clock() - HUBLOG.t0, line = line, n = 1 }
	if #list > 2000 then table.remove(list, 1) end
	if DSLOG and DSLOG.ev then DSLOG.ev("INFO", "remote", line) end -- também vai pro arquivo SHIN HUB/log.txt
end
-- chamada que SAIU pra o servidor (incoming=true: evento que o servidor mandou pra você)
function HUBLOG.add(remote, method, args, own, _, incoming)
	local parts = {}
	for i = 1, args.n do parts[i] = HUBLOG.ser(args[i]) end
	hubPush((own and "-- [HUB] " or "") .. (incoming and "<-- " or "") .. HUBLOG.path(remote) .. ":" .. method .. "(" .. table.concat(parts, ", ") .. ")")
end
-- resposta que o servidor devolveu num InvokeServer (ex.: true/false)
function HUBLOG.addResult(remote, res, own)
	local rp = {}
	for i = 1, res.n do rp[i] = HUBLOG.ser(res[i]) end
	hubPush((own and "-- [HUB] " or "") .. "   ↳ resposta de " .. HUBLOG.path(remote) .. " = " .. (res.n > 0 and table.concat(rp, ", ") or "(sem retorno)"))
end
function HUBLOG.mark(text)
	local line = "===== " .. tostring(text) .. " " .. os.date("%H:%M:%S") .. " ====="
	table.insert(HUBLOG.list, { t = os.clock() - HUBLOG.t0, line = line, n = 1 })
	if DSLOG and DSLOG.ev then DSLOG.ev("INFO", "remote", line) end
end
-- eventos que o SERVIDOR manda pra você (OnClientEvent) em ReplicatedStorage
function HUBLOG.watchIncoming(on)
	for _, c in ipairs(HUBLOG.inConns or {}) do pcall(function() c:Disconnect() end) end
	HUBLOG.inConns = {}
	HUBLOG.incoming = on and true or false
	if not on then return end
	local seen = {}
	local function hook(r)
		if seen[r] or not r:IsA("RemoteEvent") then return end
		seen[r] = true
		table.insert(HUBLOG.inConns, r.OnClientEvent:Connect(function(...)
			if HUBLOG.on and HUBLOG.incoming then pcall(HUBLOG.add, r, "OnClientEvent", table.pack(...), false, nil, true) end
		end))
	end
	local RS = game:GetService("ReplicatedStorage")
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
		old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
			local m = getnamecallmethod()
			local own = checkcaller()
			if (m == "FireServer" or m == "InvokeServer") and typeof(self) == "Instance" and (not own or (HUBLOG.self and HUBLOG.on)) then
				local pk = table.pack(...)
				task.defer(function()
					if not own then
						for _, fn in ipairs(HUBLOG.listeners) do pcall(fn, self, m, pk) end
					end
					if HUBLOG.on then pcall(HUBLOG.add, self, m, pk, own) end
				end)
				if m == "InvokeServer" and HUBLOG.on then
					-- registra também o que o servidor RESPONDEU (true/false etc.)
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

-- ===== Sub-aba Car (Brookhaven): velocidade, suspensão, música do carro e log de remotes =====
local function buildCar(page, say)
	local RS = game:GetService("ReplicatedStorage")
	local alive = true
	local cons = {}
	local onFire -- preenchido mais abaixo (hook de FireServer)
	-- o assento fica em um submodelo ("Seats"); o carro de verdade é o modelo mais alto (ex.: Vehicles.NomeCar)
	local function topModel(part)
		local m = part and part:FindFirstAncestorOfClass("Model")
		while m and m.Parent and m.Parent:IsA("Model") do m = m.Parent end
		return m
	end
	-- >>> nomes dos remotes do jogo (sem os "1" do meio). Se algo não funcionar, use o Log lá embaixo
	-- pra ver o nome/argumentos reais e ajuste aqui.
	local CAR_REMOTE = "PlayersCar" -- RE["1Player1sCa1r"] (confirmado pelo log)

	local function reByPlain(plain)
		local re = RS:FindFirstChild("RE")
		if not re then return nil end
		for _, c in ipairs(re:GetChildren()) do
			if (c.Name:gsub("1", "")) == plain then return c end
		end
		return nil
	end
	local function inputRow(placeholder)
		local row = mk("Frame", { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk("TextBox", {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = "", PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(125, 130, 142),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function note(text, h)
		mk("TextLabel", {
			Text = text, Size = UDim2.new(1, 0, 0, h or 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(232, 234, 240),
			Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end
	-- assento de motorista do carro em que você está sentado
	local function currentSeat()
		local h = hum()
		local s = h and h.SeatPart
		if s and (s:IsA("VehicleSeat") or s:IsA("Seat")) then return s end
		return nil
	end
	-- ===== Velocidade =====
	section(page, "Velocidade do carro")
	note("Funciona dirigindo (você controla a física do carro, então todo mundo vê ele andando assim).")
	local spd = { on = false, val = 120, thr = 0, fwd = nil, fwdSeat = nil, warned = nil }
	toggleRow(page, "Turbo do carro", "Vai até a velocidade escolhida enquanto você acelera", function(v) spd.on = v end)
	sliderRow(page, "Velocidade máxima", "studs por segundo", 40, 400, 120, function(v) spd.val = v end)
	-- controles (celular e PC) pra saber se você está acelerando
	local controls
	pcall(function()
		controls = require(lp:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule", 5)):GetControls()
	end)
	-- o jogo manda SetThrottleFloat(1 / 0 / -1) pro servidor (hook em onFire grava em spd.thr);
	-- se o hook não existir, usa ThrottleFloat do assento, os controles ou o teclado
	local function readThrottle(seat)
		if spd.thr ~= 0 then return spd.thr end
		local ok, v = pcall(function() return seat.ThrottleFloat end)
		if ok and type(v) == "number" and v ~= 0 then return v > 0 and 1 or -1 end
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
		if cur < 4 then return end -- deixa o próprio jogo arrancar o carro
		local look = seat.CFrame.LookVector
		local flat = Vector3.new(look.X, 0, look.Z)
		if flat.Magnitude < 0.01 then return end
		flat = flat.Unit
		local along = hv:Dot(flat) -- >0: andando pro lado que o assento aponta
		-- aprende qual lado é a "frente" na primeira vez que você acelera (t>0) em movimento
		if t > 0 and spd.fwd == nil and cur > 6 then spd.fwd = along >= 0 and 1 or -1 end
		if spd.fwd == nil then return end
		local moving = (along * spd.fwd) >= 0 and 1 or -1 -- 1 = indo pra frente, -1 = de ré
		if moving ~= (t > 0 and 1 or -1) then return end -- freando: não empurra
		if cur >= spd.val then return end
		if isnetworkowner and spd.warned ~= root then
			local okN, own = pcall(isnetworkowner, root)
			if okN and own == false then
				spd.warned = root
				say("Turbo: o servidor controla a física desse carro, então o impulso pode não funcionar.")
			end
		end
		local nxt = cur + (spd.val - cur) * 0.08 + 0.4
		root.AssemblyLinearVelocity = hv.Unit * nxt + Vector3.new(0, v.Y, 0)
	end)

	-- ===== Suspensão =====
	section(page, "Suspensão (altura do carro)")
	note("Usa a suspensão do próprio jogo (todo mundo vê). Fique sentado no carro.")
	local function susRemote()
		local folder = RS:FindFirstChild("Remotes")
		return folder and folder:FindFirstChild("SetNextSuspensionHeight")
	end
	local function nextHeight(times)
		local f = susRemote()
		if not f then say("Remote da suspensão não encontrado."); return end
		task.spawn(function()
			local last
			for i = 1, times do
				local ok, res = pcall(function() return f:InvokeServer() end)
				if not ok then say("Falhou: " .. tostring(res):sub(1, 50)); return end
				last = res
				if i < times then task.wait(0.25) end
			end
			say("Altura trocada" .. (last ~= nil and (" (" .. tostring(last) .. ")") or "") .. ".")
		end)
	end
	rowBtn(page, "Próxima altura da suspensão", function() nextHeight(1) end)
	rowBtn(page, "Pular 2 alturas", function() nextHeight(2) end, true)

	-- rebaixar forçando o carro pra baixo (experimental): empurra o carro contra a suspensão
	note("Rebaixar forçando: empurra o carro pra baixo contra a suspensão, indo além da altura mais baixa do jogo. Só funciona se o carro for simulado por você.", 54)
	local low = { on = false, k = 2, vf = nil, root = nil }
	local function lowClear()
		if low.vf then
			pcall(function() low.vf.Attachment0:Destroy() end)
			pcall(function() low.vf:Destroy() end)
		end
		low.vf, low.root = nil, nil
	end
	toggleRow(page, "Rebaixar forçando o carro", "Empurra o carro pra baixo enquanto você está sentado", function(v)
		low.on = v
		if not v then lowClear() end
	end)
	sliderRow(page, "Força do rebaixamento", "Múltiplos do peso do carro (1 a 8)", 1, 8, 2, function(v) low.k = v end)
	task.spawn(function()
		while alive do
			local h = hum()
			local sp = h and h.SeatPart
			local root = sp and sp.AssemblyRootPart
			if low.on and root then
				if low.root ~= root or not low.vf or not low.vf.Parent then
					lowClear()
					local att = mk("Attachment", { Name = "ShinHubLow" }, root)
					low.vf = mk("VectorForce", {
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

	-- o turbo precisa saber quando você acelera: o jogo manda SetThrottleFloat(1 / 0 / -1) pro servidor
	onFire = function(remote, method, a)
		if not alive or method ~= "FireServer" then return end
		if remote.Name == "SetThrottleFloat" then
			local tv = tonumber(a[1])
			if tv then spd.thr = tv end
		end
	end
	HUBLOG.install() -- sempre ligado: o turbo lê o acelerador
	HUBLOG.listen(onFire)

	return function()
		alive = false
		HUBLOG.unlisten(onFire)
		lowClear()
		for _, c in ipairs(cons) do c:Disconnect() end
	end
end

-- ===== Sub-aba Log: registra o que o jogo e o hub mandam pro servidor (remotes) =====
local function buildLog(page, say)
	local RS = game:GetService("ReplicatedStorage")
	local function topModel(part)
		local m = part and part:FindFirstAncestorOfClass("Model")
		while m and m.Parent and m.Parent:IsA("Model") do m = m.Parent end
		return m
	end
	local function inputRow(placeholder)
		local row = mk("Frame", { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk("TextBox", {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = "", PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(125, 130, 142),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function note(text, h)
		mk("TextLabel", {
			Text = text, Size = UDim2.new(1, 0, 0, h or 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(232, 234, 240),
			Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end
	local function copy(txt)
		local f = setclipboard or toclipboard
		if not f then say("Seu executor não tem setclipboard."); return end
		local ok = pcall(f, txt)
		say(ok and "Copiado!" or "Falhou ao copiar.")
	end

	return function() HUBLOG.on = false end
end

-- ===== Copiar avatar de outro jogador (só no Brookhaven; todo mundo com o hub vê) =====
-- Pega os itens do avatar (acessórios, roupas, rosto, partes do corpo) e as cores da pele,
-- e publica junto com os seus mods.
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
		if okA and type(acc) == "table" then
			for _, a in ipairs(acc) do add(a.AssetId) end
		end
		for _, k in ipairs({ "Shirt", "Pants", "GraphicTShirt", "Face", "Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg" }) do
			local okP, v = pcall(function() return desc[k] end)
			if okP then add(v) end
		end
		local function hex(c)
			return string.format("%02x%02x%02x", math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
		end
		local bc = table.concat({
			hex(desc.HeadColor), hex(desc.TorsoColor), hex(desc.LeftArmColor),
			hex(desc.RightArmColor), hex(desc.LeftLegColor), hex(desc.RightLegColor),
		}, ",")
		return ids, bc
	end

	section(page, "Copiar avatar (Brookhaven)")
	mk("TextLabel", {
		Text = "Escolha alguém que está no jogo e copie o avatar. Todo mundo que usa o hub vê em você.",
		Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(232, 234, 240),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local dd
	dd = dropdown(page, "Escolher jogador (nenhum)", function()
		local t = {}
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl ~= lp then
				table.insert(t, { label = pl.DisplayName .. "  (@" .. pl.Name .. ")", value = pl.UserId, name = pl.DisplayName })
			end
		end
		table.sort(t, function(x, y) return x.label:lower() < y.label:lower() end)
		return t
	end, function(it)
		picked = it
		dd.setText("Jogador: " .. it.name)
	end)
	local busy = false
	rowBtn(page, "Copiar avatar do jogador", function()
		if not picked then say("Escolha um jogador primeiro."); return end
		if busy then return end
		busy = true
		task.spawn(function()
			local ids, bc = collect(picked.value)
			busy = false
			if not ids or #ids == 0 then say("Não consegui ler o avatar de " .. picked.name .. "."); return end
			MINE.ids = ids
			MINE.bc = bc
			if MINE.onList then MINE.onList() end
			if publishMods then publishMods() end
			say("Avatar de " .. picked.name .. " copiado (" .. #ids .. " itens). Aparece em alguns segundos.")
		end)
	end)
	rowBtn(page, "Voltar ao meu avatar", function()
		MINE.ids = {}
		MINE.bc = nil
		if MINE.onList then MINE.onList() end
		if publishMods then publishMods() end
		say("Avatar copiado removido.")
	end, true)
end

-- ===== Sub-aba Asa (Brookhaven): blocos do Prop Maker viram uma asa que bate =====
-- Fluxo (igual ao log): equipa o Prop Maker, escolhe o bloco, cria os blocos perto de você,
-- posiciona cada um atrás do personagem e fica atualizando a posição para animar.
-- v2: acha os remotes do bloco na hora (antes um bloco ficava no chão porque os remotes dele ainda
--     não tinham replicado), refaz bloco parado, adota bloco criado em dobro e esconde a interface
--     de edição do Prop Maker (menu e setas).
local function buildWings(page, say)
	local rawSay = say
	local trace, T0 = {}, os.clock()
	local function say(s)
		trace[#trace + 1] = string.format("[%.1fs] %s", os.clock() - T0, tostring(s))
		if #trace > 60 then table.remove(trace, 1) end
		rawSay(s)
	end
	local RS = game:GetService("ReplicatedStorage")
	local alive, animating, busyBuild = true, false, false
	local animGen = 0
	local recs = {}
	local cfg = { per = 3, scale = 10, speed = 5, interval = 300, full = true, hide = true }
	local blockName = "Block3"
	local spacing = 2
	local t0 = os.clock()
	local wconns = {}

	local function inputRow(placeholder, text)
		local row = mk("Frame", { Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = PANEL, BackgroundTransparency = 0.2 }, page)
		round(row, 17); stroke(row, 1.5)
		return mk("TextBox", {
			Size = UDim2.new(1, -28, 1, -8), Position = UDim2.fromOffset(14, 4), BackgroundTransparency = 1,
			Text = text or "", PlaceholderText = placeholder, PlaceholderColor3 = Color3.fromRGB(125, 130, 142),
			TextColor3 = WHITE, Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false,
			TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true,
		}, row)
	end
	local function clip(txt)
		if setclipboard then pcall(setclipboard, txt); say("Copiado.") else say("Seu executor não tem setclipboard.") end
	end
	local function getRoot()
		return lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
	end
	local function remoteRE(name)
		local re = RS:FindFirstChild("RE")
		return re and re:FindFirstChild(name)
	end
	local function propTool()
		local c = lp.Character
		return c and c:FindFirstChild("PropMaker")
	end
	local function findTool(name)
		local c = lp.Character
		local t = c and c:FindFirstChild(name)
		if t then return t, "character" end
		local bp = lp:FindFirstChildOfClass("Backpack")
		t = bp and bp:FindFirstChild(name)
		if t then return t, "backpack" end
		return nil
	end
	local function equipPropMaker(re1)
		local t, where = findTool("PropMaker")
		if t and where == "character" then return t end
		if not t then
			local ok, res = pcall(function() return re1:InvokeServer("PickingTools", "PropMaker") end)
			say("PickingTools: " .. (ok and ("resposta=" .. tostring(res)) or ("erro=" .. tostring(res):sub(1, 60))))
			for _ = 1, 30 do
				task.wait(0.1)
				t, where = findTool("PropMaker")
				if t then break end
			end
		end
		if t and where == "backpack" then
			local h = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
			if h then pcall(function() h:EquipTool(t) end) end
			for _ = 1, 20 do
				task.wait(0.1)
				if lp.Character and lp.Character:FindFirstChild("PropMaker") then break end
			end
		end
		return lp.Character and lp.Character:FindFirstChild("PropMaker")
	end
	local function scanProps(deep)
		local out = {}
		local wc = workspace:FindFirstChild("WorkspaceCom")
		if not wc then return out end
		local want = "Prop" .. lp.Name
		local function isMine(n) return n:sub(1, #want) == want end
		if deep then
			for _, d in ipairs(wc:GetDescendants()) do
				if d.Name == "SetCurrentCFrame" and d.Parent and isMine(d.Parent.Name) then out[d.Parent] = true end
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

	-- ===== bloco: os remotes (Begin/Set/End...) são procurados na hora, não guardados no começo =====
	local REMOTES = { begin = "BeginPreview", setcf = "SetCurrentCFrame", setsc = "SetCurrentScale", endp = "EndPreview", resume = "ResumePropBehavior" }
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
		t = rec.model:FindFirstChild("Touch", true)
		rec.touch = t
		return t
	end
	local function waitRemotes(rec, secs)
		local t = os.clock()
		while os.clock() - t < secs do
			if rem(rec, "begin") and rem(rec, "setcf") and rem(rec, "endp") then return true end
			task.wait(0.1)
		end
		return false
	end
	local function sizeOf(model)
		local ok, s = pcall(function()
			if model:IsA("Model") then return model:GetExtentsSize() end
			return model.Size
		end)
		if ok and typeof(s) == "Vector3" then return s end
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

	-- ===== esconder a interface de edição do Prop Maker (só visual) =====
	-- Aprende quais telas/painéis do jogo aparecem por causa da edição do bloco (menu do Prop Maker,
	-- setas de mover/girar) e mantém eles escondidos enquanto a asa é criada e bate.
	-- Nunca mexe em algo que já estava visível antes de começar (seu HUD continua normal).
	local hide = { on = false, learning = false, expect = 0, base = {}, set = {}, names = {}, count = 0 }
	local ADORN = {
		Handles = true, ArcHandles = true, SelectionBox = true, SelectionSphere = true, SurfaceSelection = true,
		BoxHandleAdornment = true, ConeHandleAdornment = true, CylinderHandleAdornment = true,
		SphereHandleAdornment = true, Highlight = true,
	}
	local function playerGui()
		return lp:FindFirstChildOfClass("PlayerGui")
	end
	local function guiOn(g)
		if g:IsA("ScreenGui") then return g.Enabled end
		if g:IsA("GuiObject") then return g.Visible end
		return false
	end
	local function guiOff(g)
		pcall(function()
			if g:IsA("ScreenGui") then g.Enabled = false elseif g:IsA("GuiObject") then g.Visible = false end
		end)
	end
	-- percorre as telas do jogo (tela > filhos > netos), só descendo em quem está visível
	local function eachGui(fn)
		local pg = playerGui()
		if not pg then return end
		for _, sg in ipairs(pg:GetChildren()) do
			if sg:IsA("ScreenGui") then
				fn(sg, 1)
				if guiOn(sg) then
					for _, c in ipairs(sg:GetChildren()) do
						if c:IsA("GuiObject") then
							fn(c, 2)
							if c.Visible then
								for _, d in ipairs(c:GetChildren()) do
									if d:IsA("GuiObject") then fn(d, 3) end
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
		local want = "Prop" .. lp.Name
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
				if inst:IsA("Highlight") then inst.Enabled = false else inst.Visible = false end
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

	-- posição de cada bloco: i-ésimo bloco da asa (side = 1 direita, -1 esquerda)
	local function targetCF(root, side, i, n, t)
		local freq = 0.2 + cfg.speed * 0.1
		local phase = t * freq * 2 * math.pi - i * 0.45
		local amp = 0.35 + 0.35 * (i / n)
		local flap = 0.25 + amp * math.sin(phase)
		local r = (i - 0.5) * spacing
		return root.CFrame * CFrame.new(side * 0.9, 0.9, 1.4) * CFrame.Angles(0, -side * 0.35, 0)
			* CFrame.Angles(0, 0, side * flap) * CFrame.new(side * r, 0, 0)
	end

	-- um ciclo de edição do bloco, como o jogo faz: (clicar) -> Begin -> Set -> End -> (Resume)
	local function cycle(rec, cf, scale, full)
		local b, s, e = rem(rec, "begin"), rem(rec, "setcf"), rem(rec, "endp")
		if not (b and s and e) then error("bloco sem remotes (ainda replicando)", 0) end
		rec.lastCF = cf
		local tool = propTool()
		local pm = tool and tool:FindFirstChild("Tool_PropMake")
		local touch = touchOf(rec)
		if full and pm and touch then
			hide.expect = os.clock() + 1.2
			pm:FireServer(touch, touch.Position)
		end
		b:InvokeServer()
		local sc = rem(rec, "setsc")
		if scale and sc then sc:InvokeServer(scale) end
		s:InvokeServer(cf)
		e:InvokeServer()
		local rs = rem(rec, "resume")
		if full and rs then rs:InvokeServer() end
	end
	-- roda um ciclo sem deixar dois ciclos do mesmo bloco se atropelarem
	local function runCycle(rec, cf, scale, full)
		-- se um pedido ao servidor travar por mais de 8s, libera o bloco pra não ficar preso pra sempre
		if rec.busy and os.clock() - (rec.busyAt or 0) < 8 then return false, "ocupado" end
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
						if err == "ocupado" then
							-- outro ciclo do mesmo bloco ainda está rodando: pula essa batida
						elseif ok then
							rec.fails = 0
						else
							rec.fails = rec.fails + 1
							rec.lastErr = tostring(err):sub(1, 80)
							if rec.fails >= 3 then rec.forceFull = true end
							if rec.fails == 6 then say("Bloco " .. idx .. " falhando: " .. rec.lastErr) end
						end
					end
					task.wait(cfg.interval / 1000)
				end
				if alive and animating and gen == animGen and not rec.model.Parent then
					say("Bloco " .. idx .. " sumiu do mapa.")
				end
			end)
		end
		-- fiscal: bloco que não sai do lugar (ficou no chão) é refeito com o ciclo completo
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
									say("Bloco " .. idx .. " parado. Refazendo (" .. rec.heals .. "/6)...")
									waitRemotes(rec, 2)
									runCycle(rec, targetCF(root, side, i, per, os.clock() - t0), nil, true)
								end
							end
						end
					end
				end
			end
		end)
		say("Asa batendo.")
	end

	local function buildWing()
		if busyBuild then say("Já estou criando a asa..."); return end
		busyBuild = true
		task.spawn(function()
			stopAnim()
			recs = {}
			if cfg.hide then hideStart(true) end
			local ok, err = pcall(function()
				local root0 = getRoot()
				if not root0 then say("Personagem não encontrado."); return end
				local re1, re2 = remoteRE("1Too1l"), remoteRE("1Clea1rTool1s")
				if not (re1 and re2) then say("Remotes do Prop Maker não encontrados."); return end
				say("Equipando o Prop Maker...")
				local tool = equipPropMaker(re1)
				if not tool then
					say("Prop Maker não apareceu. Use 'Copiar diagnóstico dos blocos'."); return
				end
				local pm = tool:WaitForChild("Tool_PropMake", 3)
				if not pm then say("Tool_PropMake não encontrado dentro do Prop Maker."); return end

				local total = cfg.per * 2
				local per = cfg.per
				-- tudo que já existia antes (de asas antigas ou construções suas) fica de fora
				local known = {}
				for p in pairs(scanProps(false)) do known[p] = true end
				for p in pairs(scanProps(true)) do known[p] = true end
				local scaleF = cfg.scale / 10
				local function selectBlock()
					hide.expect = os.clock() + 1.2
					pcall(function() re2:FireServer("OpenPropMenu") end)
					pcall(function() re2:FireServer("RequestingPropName", blockName, "Building", nil) end)
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
					say("Criando bloco " .. i .. " de " .. total .. "...")
					local found
					for attempt = 1, 3 do
						local r0 = getRoot()
						if not r0 then say("Personagem sumiu."); return end
						local ang = (i / total) * math.pi * 2 + (attempt - 1) * 0.6
						local dist = 10 + (attempt - 1) * 3
						local hit, pos = groundAt(r0.Position.X + math.cos(ang) * dist, r0.Position.Z + math.sin(ang) * dist, r0.Position.Y)
						if hit then
							selectBlock()
							pm:FireServer(hit, pos)
							found = waitNew(2.5)
							if not found and recs[#recs] then
								-- o bloco anterior ainda pode estar "em edição": confirma ele e tenta de novo
								pcall(function()
									local rs = rem(recs[#recs], "resume")
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
						say("Bloco " .. i .. " não apareceu. Seguindo com os outros.")
					else
						known[found] = true
						local rec = makeRec(found)
						recs[#recs + 1] = rec
						pcall(function() re2:FireServer("ClosePropMenu") end)
						-- espera os remotes do bloco replicarem (antes isso era ignorado e o bloco ficava no chão)
						if not waitRemotes(rec, 4) then say("Bloco " .. i .. ": remotes demoraram a replicar.") end

						if #recs == 1 then
							local base = sizeOf(found).X
							spacing = math.clamp(base * scaleF * 0.95, 0.5, 12)
						end
						-- posiciona atrás do personagem e confirma (ResumePropBehavior); tenta até 3 vezes
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
						if not okc then say("Bloco " .. i .. ": " .. tostring(e2):sub(1, 60)) end
						task.wait(0.3)
					end
				end
				pcall(function() re2:FireServer("ClosePropMenu") end)

				-- blocos que apareceram mas não foram registrados (ex.: criado em dobro) entram na asa também
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
					if extra > 0 then say(extra .. " bloco(s) extra entraram na asa.") end
				end
				if #recs == 0 then return end

				-- confere cada bloco e refaz os que não chegaram no lugar
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
				say(good .. " de " .. #recs .. " blocos no lugar.")
			end)
			busyBuild = false
			hide.learning = false
			if not ok then
				say("Erro: " .. tostring(err):sub(1, 70))
				hideStop()
				return
			end
			if #recs > 0 and alive then startAnim() else hideStop() end
		end)
	end

	-- ===== interface =====
	section(page, "Asa de blocos (Prop Maker)")
	mk("TextLabel", {
		Text = "Cria blocos do jogo atrás de você e faz eles bater como uma asa. Precisa ter o Prop Maker e ficar perto do chão. Todos veem os blocos.",
		Size = UDim2.new(1, 0, 0, 44), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(232, 234, 240),
		Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	}, page)
	local nameBox = inputRow("Nome do bloco (padrão Block3)", blockName)
	nameBox.FocusLost:Connect(function()
		local t = nameBox.Text:gsub("%s", "")
		if t ~= "" then blockName = t end
	end)
	sliderRow(page, "Blocos por asa", "2 a 5 por lado", 2, 5, 3, function(v) cfg.per = v end)
	sliderRow(page, "Tamanho do bloco", "10 = normal (5 a 20)", 5, 20, 10, function(v) cfg.scale = v end)
	sliderRow(page, "Velocidade da batida", "1 lento · 10 rápido", 1, 10, 5, function(v) cfg.speed = v end)
	sliderRow(page, "Intervalo (ms)", "menor = mais suave e mais pesado", 150, 600, 300, function(v) cfg.interval = v end)
	toggleRow(page, "Modo completo", "Clica no bloco a cada batida. Desligue se pesar", function(v) cfg.full = v end, true)
	toggleRow(page, "Esconder edição dos blocos", "Some com o menu e as setas do Prop Maker", function(v)
		cfg.hide = v
		if v then
			if animating or busyBuild then hideStart(false) end
		else
			hideStop()
		end
	end, true)
	rowBtn(page, "Criar asa e bater", buildWing, true)
	toggleRow(page, "Bater asas", "Liga/desliga a animação", function(v)
		if v then startAnim() else stopAnim(); say("Animação parada.") end
	end, true)
	rowBtn(page, "Reparar blocos (refaz os que ficaram no chão)", function()
		if #recs == 0 then say("Crie a asa primeiro."); return end
		if busyBuild then say("Espere a criação terminar."); return end
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
						if not okc then say("Bloco " .. idx .. ": " .. tostring(e):sub(1, 60)) end
						task.wait(0.2)
					end
				end
				say("Reparo feito.")
			end
			busyBuild = false
			if was and alive then startAnim() else hideStop() end
		end)
	end, true)
	rowBtn(page, "Copiar diagnóstico dos blocos", function()
		local L = { "-- log da asa:" }
		for _, s in ipairs(trace) do L[#L + 1] = s end
		local function names(inst, limit)
			local out = {}
			if inst then
				for _, c in ipairs(inst:GetChildren()) do
					if #out < (limit or 25) then out[#out + 1] = c.Name .. "[" .. c.ClassName .. "]" end
				end
			end
			return table.concat(out, ", ")
		end
		L[#L + 1] = "PropMaker equipado: " .. tostring(propTool() ~= nil)
		L[#L + 1] = "Character: " .. names(lp.Character)
		L[#L + 1] = "Backpack: " .. names(lp:FindFirstChildOfClass("Backpack"))
		local wc0 = workspace:FindFirstChild("WorkspaceCom")
		L[#L + 1] = "PropLocations: " .. names(wc0 and wc0:FindFirstChild("PropLocations"), 20)
		L[#L + 1] = "esconder edição: " .. tostring(cfg.hide) .. " | interfaces aprendidas: " .. hide.count
		do
			local nm = {}
			for g in pairs(hide.set) do
				if #nm < 15 then
					local full = g:GetFullName()
					nm[#nm + 1] = (full:gsub("^.-PlayerGui%.", ""))
				end
			end
			L[#L + 1] = "interfaces escondidas: " .. table.concat(nm, " | ")
		end
		do
			local sgs = {}
			local pg = playerGui()
			if pg then
				for _, sg in ipairs(pg:GetChildren()) do
					if sg:IsA("ScreenGui") and #sgs < 70 then sgs[#sgs + 1] = sg.Name .. (sg.Enabled and "" or "(off)") end
				end
			end
			L[#L + 1] = "PlayerGui: " .. table.concat(sgs, ", ")
		end
		L[#L + 1] = "blocos registrados: " .. #recs
		for idx, rec in ipairs(recs) do
			local kids = {}
			for _, c in ipairs(rec.model:GetChildren()) do kids[#kids + 1] = c.Name .. "[" .. c.ClassName .. "]" end
			local ok, p = pcall(function() return rec.model:GetPivot().Position end)
			L[#L + 1] = idx .. ") " .. rec.model:GetFullName() .. " pos=" .. (ok and tostring(p) or "?")
			L[#L + 1] = "   remotes: begin=" .. tostring(rem(rec, "begin") ~= nil) .. " set=" .. tostring(rem(rec, "setcf") ~= nil)
				.. " end=" .. tostring(rem(rec, "endp") ~= nil) .. " touch=" .. tostring(touchOf(rec) ~= nil)
				.. " | falhas=" .. rec.fails .. " refeitos=" .. rec.heals .. " erro=" .. tostring(rec.lastErr)
			L[#L + 1] = "   filhos: " .. table.concat(kids, ", ")
		end
		local wc = workspace:FindFirstChild("WorkspaceCom")
		if wc then
			L[#L + 1] = "-- WorkspaceCom (itens com o seu nome ou 'Prop'):"
			local n = 0
			for _, c in ipairs(wc:GetChildren()) do
				if n < 40 and (c.Name:find(lp.Name, 1, true) or c.Name:find("Prop", 1, true)) then
					n = n + 1
					local kids = {}
					for _, k in ipairs(c:GetChildren()) do
						if #kids < 8 then kids[#kids + 1] = k.Name .. "[" .. k.ClassName .. "]" end
					end
					L[#L + 1] = c:GetFullName() .. " -> " .. table.concat(kids, ", ")
				end
			end
		end
		clip(table.concat(L, "\n"))
	end, true)
	rowBtn(page, "Parar e soltar blocos", function()
		stopAnim()
		say("Animação parada. Os blocos ficam no mapa (apague pelo menu do Prop Maker).")
	end, true)

	return function()
		alive = false; animating = false; hide.on = false
		for _, c in ipairs(wconns) do pcall(function() c:Disconnect() end) end
	end
end

-- ===== Aba ID: tempo ativo, nick, executor e ID único por usuário =====
local HUB_START_T = os.time()
local function execName()
	local name, ver
	pcall(function() name, ver = identifyexecutor() end)
	if not name then pcall(function() name = getexecutorname() end) end
	if not name then return "Desconhecido" end
	return tostring(name) .. (ver and (" " .. tostring(ver)) or "")
end
local function toBase36(n)
	local chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	local s = ""
	repeat
		local r = n % 36
		s = chars:sub(r + 1, r + 1) .. s
		n = (n - r) / 36
	until n <= 0
	return s
end
-- ID único por conta: sempre o mesmo pro mesmo usuário (gerado do UserId, com dígito de conferência)
local function hubId(uid)
	return "DS-" .. toBase36(uid) .. "-" .. toBase36((uid * 31 + 7) % 1296)
end
local function buildId(page, say)
	local function fmt(sec)
		sec = math.max(0, math.floor(sec))
		return string.format("%02d:%02d:%02d", math.floor(sec / 3600), math.floor(sec / 60) % 60, sec % 60)
	end
	local function esc(s) return (tostring(s):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")) end
	local DIMC = Color3.fromRGB(150, 155, 168)
	-- cartão de perfil compacto: foto + nome, sem caixas
	local card = mk("Frame", { Size = UDim2.new(1, 0, 0, 64), BackgroundTransparency = 1 }, page)
	local av = mk("ImageLabel", {
		Size = UDim2.fromOffset(54, 54), Position = UDim2.fromOffset(4, 5), BackgroundColor3 = Color3.fromRGB(20, 21, 26),
		Image = "", ScaleType = Enum.ScaleType.Crop,
	}, card)
	mk("UICorner", { CornerRadius = UDim.new(1, 0) }, av)
	local avs = mk("UIStroke", { Thickness = 2, Color = WHITE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, av)
	mk("UIGradient", {
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 62, 74)) }),
		Rotation = 45,
	}, avs)
	task.spawn(function()
		local ok, img = pcall(function()
			return Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
		end)
		if ok and img and av.Parent then av.Image = img end
	end)
	mk("TextLabel", {
		Text = lp.DisplayName, Size = UDim2.new(1, -72, 0, 22), Position = UDim2.fromOffset(68, 11), BackgroundTransparency = 1,
		TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, card)
	mk("TextLabel", {
		Text = "@" .. lp.Name, Size = UDim2.new(1, -72, 0, 16), Position = UDim2.fromOffset(68, 33), BackgroundTransparency = 1,
		TextColor3 = DIMC, Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, card)
	local ln = mk("Frame", { Size = UDim2.new(1, -4, 0, 1), BackgroundColor3 = UI.EDGE, BorderSizePixel = 0, LayoutOrder = 0 }, page)
	mk("UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) }) }, ln)
	-- linhas pequenas, uma embaixo da outra (rótulo apagado + valor)
	local function line(title, value)
		local f = mk("Frame", { Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1 }, page)
		mk("TextLabel", {
			Text = title, Size = UDim2.fromOffset(82, 18), Position = UDim2.fromOffset(6, 0), BackgroundTransparency = 1,
			TextColor3 = DIMC, Font = Enum.Font.Gotham, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
		}, f)
		return mk("TextLabel", {
			Text = value, Size = UDim2.new(1, -92, 1, 0), Position = UDim2.fromOffset(88, 0), BackgroundTransparency = 1,
			TextColor3 = WHITE, Font = Enum.Font.GothamMedium, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}, f)
	end
	local id = hubId(lp.UserId)
	local up = line("Tempo ativo", fmt(0))
	line("Executor", execName())
	line("ID único", id)
	line("UserId", tostring(lp.UserId))
	rowBtn(page, "Copiar meu ID", function()
		local f = setclipboard or toclipboard
		if not f then say("Seu executor não tem setclipboard. Seu ID: " .. id); return end
		say(pcall(f, id) and ("ID copiado: " .. id) or "Falhou ao copiar.")
	end, true)
	task.spawn(function()
		while page.Parent do
			up.Text = fmt(os.time() - HUB_START_T)
			task.wait(1)
		end
	end)
end

-- ===== Sub-aba Avatar (Brookhaven): copiar o avatar do Brookhaven de outro jogador =====
-- Como o jogo veste item (log do avatar do Brookhaven): Remotes.Wear:InvokeServer(idDoItem, nil).
-- Não aparece remote separado pra tirar: chamar Wear num item que já está vestido tira ele.
-- Item que você não tem não é vestido (o jogo pediria compra; o hub não compra nada).
local AVATAR = {
	wear = function(kind, id)
		local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
		local r = folder and folder:FindFirstChild("Wear")
		if not r then error("remote Wear não encontrado") end
		return r:InvokeServer(id, nil)
	end,
}
local function buildAvatar(page, say)
	local target
	local items = {}
	local BODY = { Head = true, Torso = true, LeftArm = true, RightArm = true, LeftLeg = true, RightLeg = true }
	local COLOR_KEYS = { "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor" }
	local SCALE_KEYS = { "HeightScale", "WidthScale", "DepthScale", "HeadScale", "BodyTypeScale", "ProportionScale" }
	local targetEx -- cores, proporções e partes padrão do jogador lido

	-- ===== log dos itens: registra tudo que o hub lê, tira e veste (pra ficar fácil de conferir/copiar) =====
	local alog = { lines = {}, view = nil, t0 = os.clock() }
	local function logLine(text)
		local line = string.format("[%5.1fs] %s", os.clock() - alog.t0, text)
		alog.lines[#alog.lines + 1] = line
		if #alog.lines > 400 then table.remove(alog.lines, 1) end
		if alog.view and alog.view.Parent then
			local bad = text:find("FALHOU", 1, true) or text:find("FALTOU", 1, true) or text:find("NÃO SAIU", 1, true)
			mk("TextLabel", {
				Text = line, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
				TextColor3 = bad and Color3.fromRGB(255, 140, 140) or WHITE, Font = Enum.Font.Code, TextSize = 11,
				TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = #alog.lines,
			}, alog.view)
			local kids = {}
			for _, c in ipairs(alog.view:GetChildren()) do
				if c:IsA("TextLabel") then kids[#kids + 1] = c end
			end
			if #kids > 150 then kids[1]:Destroy() end
		end
	end
	local function ser(v)
		local ok, s = pcall(HUBLOG.ser, v)
		return ok and tostring(s) or tostring(v)
	end

	local function note(text, h)
		return mk("TextLabel", {
			Text = text, Size = UDim2.new(1, 0, 0, h or 34), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(232, 234, 240),
			Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
		}, page)
	end
	-- lê os itens que o jogador está usando (descrição aplicada no personagem dele)
	-- 3º retorno: cores, proporções e partes do corpo sem item (padrão do jogo). O Wear só troca itens,
	-- então isso serve pra conferir (no log) o que a cópia não cobre.
	local function readAvatar(pl)
		local h = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
		if not h then return nil, "o jogador está sem personagem" end
		local ok, d = pcall(function() return h:GetAppliedDescription() end)
		if not ok or not d then return nil, "não consegui ler o avatar dele" end
		local out = {}
		local function add(kind, id)
			id = tonumber(id)
			if id and id > 0 then out[#out + 1] = { kind = kind, id = math.floor(id) } end
		end
		local okA, acc = pcall(function() return d:GetAccessories(true) end)
		if okA and type(acc) == "table" then
			for _, a in ipairs(acc) do add((tostring(a.AccessoryType):gsub("^Enum%.AccessoryType%.", "")), a.AssetId) end
		end
		for _, k in ipairs({ "Shirt", "Pants", "GraphicTShirt", "Face", "Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg" }) do
			local okP, v = pcall(function() return d[k] end)
			if okP then add(k, v) end
		end
		local ex = { colors = {}, scales = {}, zero = {} }
		for _, k in ipairs(COLOR_KEYS) do
			local okC, c = pcall(function() return d[k] end)
			if okC and typeof(c) == "Color3" then ex.colors[k] = c end
		end
		for _, k in ipairs(SCALE_KEYS) do
			local okS, v = pcall(function() return d[k] end)
			if okS and type(v) == "number" then ex.scales[k] = v end
		end
		for k in pairs(BODY) do
			local okZ, v = pcall(function() return d[k] end)
			if okZ and (tonumber(v) or 0) <= 0 then ex.zero[#ex.zero + 1] = k end
		end
		table.sort(ex.zero)
		return out, nil, ex
	end
	local function fmtColor(c)
		return string.format("rgb(%d,%d,%d)", math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
	end
	local function sameColor(a, b)
		return math.abs(a.R - b.R) < 0.012 and math.abs(a.G - b.G) < 0.012 and math.abs(a.B - b.B) < 0.012
	end
	local function logExtra(prefix, ex)
		if not ex then return end
		local cs, ss = {}, {}
		for _, k in ipairs(COLOR_KEYS) do
			if ex.colors[k] then cs[#cs + 1] = (k:gsub("Color$", "")) .. "=" .. fmtColor(ex.colors[k]) end
		end
		for _, k in ipairs(SCALE_KEYS) do
			if ex.scales[k] then ss[#ss + 1] = (k:gsub("Scale$", "")) .. "=" .. string.format("%.2f", ex.scales[k]) end
		end
		logLine(prefix .. "Cores: " .. (#cs > 0 and table.concat(cs, " ") or "?"))
		logLine(prefix .. "Proporções: " .. (#ss > 0 and table.concat(ss, " ") or "?"))
		logLine(prefix .. "Partes do corpo sem item (padrão do jogo): " .. (#ex.zero > 0 and table.concat(ex.zero, ", ") or "nenhuma"))
	end
	-- compara cores e proporções dele com as suas e registra o que ficou diferente
	local function compareExtra(theirs, mine)
		local n = 0
		for _, k in ipairs(COLOR_KEYS) do
			local a, b = theirs.colors[k], mine.colors[k]
			if a and b and not sameColor(a, b) then
				n = n + 1
				logLine("DIFERENTE " .. k .. ": dele " .. fmtColor(a) .. " / seu " .. fmtColor(b))
			end
		end
		for _, k in ipairs(SCALE_KEYS) do
			local a, b = theirs.scales[k], mine.scales[k]
			if a and b and math.abs(a - b) > 0.01 then
				n = n + 1
				logLine(string.format("DIFERENTE %s: dele %.2f / seu %.2f", k, a, b))
			end
		end
		return n
	end

	section(page, "Copiar avatar do Brookhaven")
	note("Copia os itens que a pessoa está usando pro seu avatar do Brookhaven. Só veste o que você já tem; o hub não compra nada.", 44)
	local ddA
	ddA = dropdown(page, "Escolher jogador (nenhum)", function()
		local t = {}
		for _, pl in ipairs(Players:GetPlayers()) do
			if pl ~= lp then
				table.insert(t, { label = pl.DisplayName .. "  (@" .. pl.Name .. ")", value = pl, name = pl.DisplayName })
			end
		end
		table.sort(t, function(a, b) return a.label:lower() < b.label:lower() end)
		return t
	end, function(it)
		target = it.value
		ddA.setText("Jogador: " .. it.name)
	end)
	local summary = note("Nenhum avatar lido ainda.", 34)
	rowBtn(page, "Ler avatar do jogador", function()
		if not target or not target.Parent then say("Escolha um jogador primeiro."); return end
		local list, err, ex = readAvatar(target)
		if not list then logLine("FALHOU ao ler " .. target.Name .. ": " .. tostring(err)); say("Falhou: " .. tostring(err)); return end
		items = list
		local counts, order = {}, {}
		for _, it in ipairs(items) do
			if not counts[it.kind] then counts[it.kind] = 0; order[#order + 1] = it.kind end
			counts[it.kind] = counts[it.kind] + 1
		end
		local parts = {}
		for _, k in ipairs(order) do parts[#parts + 1] = k .. " " .. counts[k] end
		summary.Text = "Itens lidos de " .. target.DisplayName .. ": " .. #items .. (#items > 0 and (" (" .. table.concat(parts, ", ") .. ")") or "")
		logLine("LI avatar de " .. target.DisplayName .. " (@" .. target.Name .. "): " .. #items .. " itens")
		for _, it in ipairs(items) do logLine("   " .. it.kind .. ": " .. it.id) end
		targetEx = ex
		logExtra("   ", ex)
		say(#items .. " itens lidos.")
	end)

	-- itens que você está vestindo agora: set[id] = item, e a lista
	local function wornSet()
		local set, list = {}, readAvatar(lp) or {}
		for _, it in ipairs(list) do set[it.id] = it end
		return set, list
	end
	local SLOT = { Shirt = true, Pants = true, GraphicTShirt = true, Face = true } -- vestir outro troca o antigo
	-- roupas padrão do Brookhaven: o jogo recoloca sozinho quando tira (pelo log: tirar volta "true" mas ela continua lá),
	-- então não adianta ficar tentando. Item que continua depois de 2 tentativas também entra aqui.
	local fixed = { [8907830203] = true, [88270342307378] = true }
	-- liga/desliga um item (o jogo usa o mesmo remote Wear pros dois). O jogo RECUSA (false) se os pedidos
	-- vêm rápido demais (visto no log: ~0,7s entre pedidos), então espaça ~1s e tenta de novo se recusar.
	local lastWear = 0
	local refusedWhy = {} -- id -> o que o jogo respondeu quando recusou (ex.: "Invalid ID")
	local function toggle(it, action)
		for attempt = 1, 3 do
			local gap = 1.0 - (os.clock() - lastWear)
			if gap > 0 then task.wait(gap) end
			-- o Wear devolve (true/false, "mensagem"); no log do jogo: false, "Invalid ID" ou true, "Success"
			local ok, res, msg = pcall(AVATAR.wear, it.kind, it.id)
			lastWear = os.clock()
			local good = ok and res ~= false
			local shown = (ok and (ser(res) .. (msg ~= nil and (", " .. ser(msg)) or "")) or ("erro: " .. tostring(res))):sub(1, 70)
			logLine((good and "" or "FALHOU ") .. action .. " " .. it.kind .. " " .. it.id .. " -> " .. shown
				.. (attempt > 1 and ("  (tentativa " .. attempt .. ")") or ""))
			if good then return true end
			if ok and msg ~= nil then refusedWhy[it.id] = tostring(msg) end
			if msg == "Invalid ID" then break end -- o jogo diz que o ID não vale: repetir não adianta
		end
		return false
	end
	-- tira o que está vestido (partes do corpo ficam; roupa/rosto que o avatar novo vai trocar também ficam)
	-- cada item é desligado UMA vez só (ler de novo logo depois atrasa e já fez religar item sem querer)
	local function removeWorn(keep, action, targetKinds)
		local _, list = wornSet()
		local n = 0
		for _, it in ipairs(list) do
			local replaced = SLOT[it.kind] and targetKinds and targetKinds[it.kind]
			if not BODY[it.kind] and not replaced and not (keep and keep[it.id]) and not fixed[it.id] then
				if toggle(it, action or "TIRAR") then n = n + 1 end
			end
		end
		return n
	end
	local busy = false
	local function run(fn)
		if busy then say("Já está rodando, espera terminar."); return end
		busy = true
		task.spawn(function()
			local ok, err = pcall(fn)
			busy = false
			if not ok then logLine("FALHOU: " .. tostring(err)); say("Falhou: " .. tostring(err):sub(1, 60)) end
		end)
	end
	-- procura a versão "estável" do que está vestido: a leitura do avatar atrasa depois de vestir/tirar,
	-- então lê duas vezes (1,5s entre elas) e só confia no que as duas leituras concordam
	local function stableWorn()
		local a = wornSet()
		task.wait(1.5)
		local b = wornSet()
		local both, either = {}, {}
		for id, it in pairs(a) do either[id] = it; if b[id] then both[id] = it end end
		for id, it in pairs(b) do either[id] = it end
		return both, either
	end
	-- tira tudo (só partes do corpo e o que o avatar novo vai trocar ficam) e CONFERE: o que não saiu, tira de novo (até 2 rodadas)
	local function strip(keep, targetKinds)
		local removed = removeWorn(keep, "TIRAR", targetKinds)
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
					logLine("FIXO (continua mesmo tirando; deve ser padrão do jogo): " .. it.kind .. " " .. it.id)
				end
				break
			end
			logLine("NÃO SAIU " .. #left .. " item(ns), tentando de novo (rodada " .. pass .. ")")
			for _, it in ipairs(left) do
				if toggle(it, "TIRAR (de novo)") then removed = removed + 1 end
			end
		end
		return removed
	end

	-- ===== animação (parado, andar, correr, pular, cair, escalar, nadar) =====
	-- Copia os ids de animação do script Animate dele pro seu Animate e reinicia o seu. A animação do seu
	-- personagem é replicada pro jogo todo, então todo mundo vê. Fica ativa até você voltar ao padrão (reaplica ao renascer).
	local ANIM = { orig = {}, applied = nil, tested = {} }
	local function animateOf(char) return char and char:FindFirstChild("Animate") end
	local function animKey(d) return d.Parent.Name .. "/" .. d.Name end
	local function rigOf(char)
		local h = char and char:FindFirstChildOfClass("Humanoid")
		return h and h.RigType
	end
	local function readAnims(pl)
		local char = pl.Character
		local ids, n = {}, 0
		local an = animateOf(char)
		if an then
			for _, d in ipairs(an:GetDescendants()) do
				if d:IsA("Animation") and d.AnimationId ~= "" then ids[animKey(d)] = d.AnimationId; n = n + 1 end
			end
		end
		if n > 0 then return ids, n end
		-- sem Animate legível: usa as animações da descrição aplicada no avatar dele
		local h = char and char:FindFirstChildOfClass("Humanoid")
		local ok, d = pcall(function() return h and h:GetAppliedDescription() end)
		if not ok or not d then return nil, "não consegui ler a animação dele" end
		local map = {
			IdleAnimation = { "idle/Animation1", "idle/Animation2" }, WalkAnimation = { "walk/WalkAnim" },
			RunAnimation = { "run/RunAnim" }, JumpAnimation = { "jump/JumpAnim" }, FallAnimation = { "fall/FallAnim" },
			ClimbAnimation = { "climb/ClimbAnim" }, SwimAnimation = { "swim/Swim", "swimidle/SwimIdle" },
		}
		for field, keys in pairs(map) do
			local okF, v = pcall(function() return d[field] end)
			v = okF and tonumber(v) or 0
			if v and v > 0 then
				for _, k in ipairs(keys) do ids[k] = "http://www.roblox.com/asset/?id=" .. math.floor(v); n = n + 1 end
			end
		end
		if n == 0 then return nil, "ele está com a animação padrão (nada pra copiar)" end
		return ids, n
	end
	local function reloadAnimate(char)
		local an, hum = animateOf(char), char and char:FindFirstChildOfClass("Humanoid")
		if not (an and hum) then return end
		pcall(function()
			an.Disabled = true
			local animator = hum:FindFirstChildOfClass("Animator")
			for _, tr in ipairs((animator or hum):GetPlayingAnimationTracks()) do tr:Stop(0) end
			task.wait(0.1)
		end)
		pcall(function() an.Disabled = false end)
	end
	local function applyAnims(ids)
		local char = lp.Character
		local an = animateOf(char)
		if not an then return false, "seu personagem está sem o script Animate" end
		local n = 0
		for _, d in ipairs(an:GetDescendants()) do
			if d:IsA("Animation") then
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
				if d:IsA("Animation") then
					local o = ANIM.orig[animKey(d)]
					if o then d.AnimationId = o end
				end
			end
			reloadAnimate(lp.Character)
		end
		ANIM.orig = {}
	end
	-- só o número do asset (o AnimationId vem como "http://www.roblox.com/asset/?id=123")
	local function assetNum(id)
		return tostring(id):match("%d+") or tostring(id)
	end
	-- testa se a animação CARREGA no seu personagem. Animação que o jogo não deixa carregar não toca
	-- (o personagem fica travado nesse estado); true = carregou, false = não carregou, nil = não deu pra testar
	local function canLoadAnim(animId)
		local char = lp.Character
		local h = char and char:FindFirstChildOfClass("Humanoid")
		local animator = h and h:FindFirstChildOfClass("Animator")
		if not animator then return nil end
		local a = Instance.new("Animation")
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
		if not pl or not pl.Parent then return false, "escolha um jogador primeiro" end
		local mine, theirs = rigOf(lp.Character), rigOf(pl.Character)
		if mine and theirs and mine ~= theirs then return false, "rig diferente (R6/R15): a animação dele não funciona no seu" end
		local ids, n = readAnims(pl)
		if not ids then return false, n end
		local an = animateOf(lp.Character)
		if not an then return false, "seu personagem está sem o script Animate" end
		-- 1) identifica: cada animação dele ao lado da sua
		local keys, mineIds = {}, {}
		for k in pairs(ids) do keys[#keys + 1] = k end
		table.sort(keys)
		for _, d in ipairs(an:GetDescendants()) do
			if d:IsA("Animation") then mineIds[animKey(d)] = d.AnimationId end
		end
		-- 2) testa (cada ID uma vez, em paralelo): só aplica o que carrega no seu personagem
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
		-- 3) aplica só as que funcionam e registra tudo no log
		local good, bad, same, onlyTheirs = {}, 0, 0, 0
		for _, k in ipairs(keys) do
			local id = ids[k]
			local label = k .. ": dele " .. assetNum(id)
			if not mineIds[k] then
				onlyTheirs = onlyTheirs + 1
				logLine("ANIM " .. label .. " · você não tem esse estado (não dá pra aplicar)")
			elseif mineIds[k] == id then
				same = same + 1
				logLine("ANIM " .. label .. " · igual à sua")
			else
				local r = results[id]
				if r == false then
					bad = bad + 1
					logLine("ANIM " .. label .. " · seu " .. assetNum(mineIds[k]) .. " · NÃO TOCA (o jogo não carregou); mantive a sua")
				else
					good[k] = id
					logLine("ANIM " .. label .. " · seu " .. assetNum(mineIds[k]) .. " · TROCADA" .. (r == nil and " (não consegui testar)" or " (testada, carrega)"))
				end
			end
		end
		local ok, res = applyAnims(good)
		if not ok then return false, res end
		ANIM.applied = good
		logLine("ANIMAÇÃO de " .. pl.DisplayName .. ": " .. n .. " ids lidos · " .. res .. " trocados · " .. same .. " iguais · " .. bad .. " não tocam · " .. onlyTheirs .. " só dele")
		return true, "animação copiada (" .. res .. " trocadas" .. (bad > 0 and (", " .. bad .. " não tocam e ficaram as suas") or "") .. ")"
	end
	-- ao renascer, aplica de novo a animação copiada
	table.insert(conns, lp.CharacterAdded:Connect(function(char)
		if not ANIM.applied then return end
		task.spawn(function()
			if not char:WaitForChild("Animate", 10) then return end
			task.wait(1.5)
			if ANIM.applied then pcall(applyAnims, ANIM.applied) end
		end)
	end))

	-- itens que o jogo recusou (você não tem no Brookhaven) entram pelo hub: aparecem pra você e pra quem usa o hub
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
	toggleRow(page, "Copiar também a animação", "Parado, andar, correr, pular, cair, escalar e nadar", function(v) withAnim = v end, true)
	local defaultBody = true
	toggleRow(page, "Igualar partes do corpo padrão", "Se o alvo usa perna/braço padrão, tira o seu personalizado", function(v) defaultBody = v end, true)
	rowBtn(page, "Copiar avatar pra mim", function()
		if #items == 0 then say("Leia o avatar de um jogador primeiro."); return end
		run(function()
			logLine("=== COPIAR avatar de " .. (target and target.DisplayName or "?") .. " (" .. #items .. " itens) ===")
			local wornBefore, before = wornSet()
			logLine("Meu avatar antes: " .. #before .. " itens")
			for _, it in ipairs(before) do logLine("   [antes] " .. it.kind .. ": " .. it.id) end
			local keep, kinds = {}, {}
			for _, it in ipairs(items) do keep[it.id] = true; kinds[it.kind] = true end
			-- 1) tira TUDO antes (e confere se saiu)
			say("1/3 Tirando tudo que você está usando (leva uns segundos)...")
			hubRemoveAll()
			local removed = strip(keep, nil)
			-- 2) veste o avatar copiado
			say("2/3 Vestindo o avatar copiado...")
			local done, skipped, failed, refused = 0, 0, {}, {}
			for _, it in ipairs(items) do
				if wornBefore[it.id] then
					skipped = skipped + 1
					logLine("JÁ ESTAVA " .. it.kind .. " " .. it.id)
				elseif toggle(it, "VESTIR") then
					done = done + 1
				else
					failed[#failed + 1] = it.kind
					refused[it.id] = true
				end
			end
			-- 2b) parte do corpo que o alvo usa no padrão (sem item) mas você tem personalizada (ex.: pernas):
			-- o Wear não troca por "nada", então tira a sua (chamar Wear no item vestido tira ele)
			if defaultBody and targetEx then
				local isDefault = {}
				for _, k in ipairs(targetEx.zero) do isDefault[k] = true end
				local nowWorn = wornSet()
				for _, it in ipairs(before) do
					if BODY[it.kind] and isDefault[it.kind] and nowWorn[it.id] then
						say("2/3 Tirando sua " .. it.kind .. " (o alvo usa a padrão)...")
						if toggle(it, "TIRAR (parte padrão do alvo)") then
							logLine("PARTE PADRÃO " .. it.kind .. ": tirei a sua " .. it.id .. " pra ficar igual ao alvo")
						end
					end
				end
			end
			-- 3) confere e corrige (até 2 rodadas); só mexe no que as duas leituras confirmam
			say("3/3 Conferindo...")
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
					for _, it in ipairs(miss) do logLine("FALTOU " .. it.kind .. " " .. it.id .. (refused[it.id] and (" (o jogo respondeu: " .. tostring(refusedWhy[it.id] or "recusou") .. ")") or "")) end
					for _, it in ipairs(left) do logLine("NÃO SAIU " .. it.kind .. " " .. it.id) end
					break
				end
				say("3/3 Corrigindo o que faltou (rodada " .. pass .. ")...")
				for _, it in ipairs(left) do toggle(it, "TIRAR (corrigindo)") end
				for _, it in ipairs(miss) do
					if not refused[it.id] then
						if toggle(it, "VESTIR (corrigindo)") then done = done + 1 end
					end
				end
			end
			-- 3b) cores e proporções: o Wear não muda isso; só confere e registra no log o que ficou diferente
			local diffN = 0
			if targetEx then
				task.wait(1)
				local _, _, mineEx = readAvatar(lp)
				if mineEx then
					logExtra("   [seu agora] ", mineEx)
					diffN = compareExtra(targetEx, mineEx)
				end
			end
			-- o jogo recusou (provavelmente você não tem o item): põe pelo hub
			local viaN = 0
			for _, it in ipairs(items) do
				if refused[it.id] and not BODY[it.kind] and hubAdd(it) then
					viaN = viaN + 1
					logLine("VIA HUB " .. it.kind .. " " .. it.id)
				end
			end
			if viaN > 0 then
				if MINE.onList then MINE.onList() end
				if publishMods then publishMods() end
			end
			local msg = "Tirados: " .. removed .. " · Colocados: " .. done .. " · já estavam: " .. skipped
			if viaN > 0 then
				local why
				for _, w in pairs(refusedWhy) do why = w; break end
				msg = msg .. " · " .. viaN .. " só pelo hub (o jogo respondeu: " .. tostring(why or "recusado") .. "; só quem usa o hub vê)"
			end
			if missing - viaN > 0 then msg = msg .. " · faltaram: " .. (missing - viaN) end
			if stuck > 0 then msg = msg .. " · " .. stuck .. " seu(s) não saíram" end
			if diffN > 0 then msg = msg .. " · " .. diffN .. " cor/proporção diferente (veja o log; o Wear não muda isso)" end
			-- 4) animação
			if withAnim then
				local okA, resA = copyAnim(target)
				msg = msg .. " · " .. (okA and resA or ("animação não copiada: " .. tostring(resA)))
				if not okA then logLine("FALHOU animação: " .. tostring(resA)) end
			end
			logLine("RESUMO: " .. msg)
			say(msg)
		end)
	end)
	rowBtn(page, "Copiar só a animação do jogador", function()
		if not target or not target.Parent then say("Escolha um jogador primeiro."); return end
		task.spawn(function()
			local ok, res = copyAnim(target)
			if not ok then logLine("FALHOU animação: " .. tostring(res)) end
			say(ok and res or ("Falhou: " .. tostring(res)))
		end)
	end, true)
	rowBtn(page, "Copiar IDs das animações dele (texto)", function()
		if not target or not target.Parent then say("Escolha um jogador primeiro."); return end
		local ids, n = readAnims(target)
		if not ids then say("Falhou: " .. tostring(n)); return end
		local keys, lines = {}, {}
		for k in pairs(ids) do keys[#keys + 1] = k end
		table.sort(keys)
		for _, k in ipairs(keys) do
			lines[#lines + 1] = k .. ": " .. assetNum(ids[k])
			logLine("ANIM ID " .. k .. ": " .. assetNum(ids[k]))
		end
		local f = setclipboard or toclipboard
		if not f then say(#keys .. " IDs no log (seu executor não tem setclipboard)."); return end
		say(pcall(f, table.concat(lines, "\n")) and (#keys .. " IDs copiados.") or "Falhou ao copiar.")
	end, true)
	rowBtn(page, "Voltar animação padrão", function()
		restoreAnims()
		logLine("Animação voltou ao padrão")
		say("Animação padrão de volta.")
	end, true)
	rowBtn(page, "Tirar tudo que estou usando", function()
		run(function()
			logLine("=== TIRAR TUDO ===")
			say("Tirando tudo (confere e tenta de novo se algo não sair)...")
			hubRemoveAll()
			local n = strip(nil, nil)
			logLine("RESUMO: tirados " .. n)
			say("Tirados: " .. n .. " itens.")
		end)
	end, true)
	rowBtn(page, "Tirar só os itens copiados", function()
		if #items == 0 then say("Leia o avatar de um jogador primeiro."); return end
		run(function()
			logLine("=== TIRAR SÓ OS COPIADOS ===")
			local worn = wornSet()
			local n = 0
			for _, it in ipairs(items) do
				if worn[it.id] and not BODY[it.kind] then
					if toggle(it, "TIRAR") then n = n + 1 end
					task.wait(0.3)
				end
			end
			logLine("RESUMO: tirados " .. n)
			say("Tirados: " .. n .. " itens.")
		end)
	end, true)
	rowBtn(page, "Copiar lista de itens (texto)", function()
		if #items == 0 then say("Leia o avatar de um jogador primeiro."); return end
		local lines = {}
		for _, it in ipairs(items) do lines[#lines + 1] = it.kind .. ": " .. it.id end
		local f = setclipboard or toclipboard
		if not f then say("Seu executor não tem setclipboard."); return end
		say(pcall(f, table.concat(lines, "\n")) and "Lista copiada." or "Falhou ao copiar.")
	end, true)

	-- (o log dos itens só aparece no hub de ADM; aqui ele registra em memória, sem tela)
	return function() if ANIM.applied then pcall(restoreAnims) end end
end

local win, pages, say = buildWindow(600, 360, "Shin Hub", "Membro", buildTabs({}))
selfCleanup = buildSelf(pages, say)
if pages["Nome"] then buildBrookhaven(pages, say) end
local stopCar = pages["Car"] and buildCar(pages["Car"], say)
AVATAR.stop = pages["Avatar"] and buildAvatar(pages["Avatar"], say)
local stopLog = pages["Log"] and buildLog(pages["Log"], say)
local stopWings = pages["Asa"] and buildWings(pages["Asa"], say)
buildCredits(pages["Créditos"])
if pages["ID"] then buildId(pages["ID"], say) end
local stopMods = buildMods(pages["Mod"], say)
local stopDebug = pages["Debug"] and buildDebug(pages["Debug"], say)
if pages["Nome"] then buildAvatarCopy(pages["Mod"], say) end
local stopFx = buildEffects(pages["Efeitos"], say)
local stopExtras = buildExtras(pages["Extras"], say)
do
	local base = selfCleanup
	selfCleanup = function() if base then base() end; stopMods(); if AVATAR.stop then AVATAR.stop() end; if stopDebug then stopDebug() end; stopFx(); stopExtras(); if stopCar then stopCar() end; if stopLog then stopLog() end; if stopWings then stopWings() end; if TAG.stop then TAG.stop() end end
end

-- (a aba Conexão saiu do menu; o status continua sendo atualizado num texto interno e o "Desativar" foi pra aba Extras)
local shutdown
local info = mk("TextLabel", { Text = "Conectando...", Size = UDim2.new(1, 0, 0, 40), BackgroundTransparency = 1 }, nil)
if pages["Extras"] then
	rowBtn(pages["Extras"], "Desativar (sair do painel)", function() if shutdown then shutdown() end end)
end

-- aviso rápido na tela quando o admin usa um comando
function toast(t)
	local l = mk("TextLabel", {
		Text = t, Size = UDim2.fromOffset(240, 30), Position = UDim2.new(0.5, -120, 0, 60),
		BackgroundColor3 = Color3.fromRGB(46, 48, 58), TextColor3 = WHITE, Font = Enum.Font.GothamBold, TextSize = 12,
	}, gui)
	round(l, 10); stroke(l, 1.5)
	task.delay(4, function() l:Destroy() end)
end

UI.float = floatButton(function() win.Visible = not win.Visible end, win)
task.defer(function() if UI.applyCfg then UI.applyCfg() end end)
-- atalho do teclado (só PC): B minimiza/abre o menu (RightShift também continua funcionando)
table.insert(conns, UIS.InputBegan:Connect(function(i, gp)
	if gp or i.UserInputType ~= Enum.UserInputType.Keyboard then return end
	if UIS:GetFocusedTextBox() then return end -- digitando em uma caixa de texto: ignora
	local isPc = UI.pc or (UIS.KeyboardEnabled and UIS.MouseEnabled)
	if i.KeyCode == Enum.KeyCode.RightShift or (isPc and i.KeyCode == UI.key) then
		win.Visible = not win.Visible
	end
end))
-- aviso rápido (só PC) mostrando o atalho
task.spawn(function()
	if not UI.pc then return end
	local hint = mk("TextLabel", {
		Text = "PC detectado  •  tecle " .. UI.keyName() .. " pra minimizar / abrir o menu", Size = UDim2.fromOffset(320, 26),
		AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 14), BackgroundColor3 = Color3.fromRGB(22, 23, 28),
		BackgroundTransparency = 0.1, TextColor3 = WHITE, Font = Enum.Font.GothamMedium, TextSize = 12,
	}, gui)
	round(hint, 13)
	local hs = mk("UIStroke", { Thickness = 1.5, Color = RED, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, hint)
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
	http("DELETE", "/members/" .. uid .. ".json")
	gui:Destroy()
end

-- presença (a cada 5s) + estado dos efeitos do admin (também enviado na hora que muda)
local beat = 0
local function presenceBody()
	local root = hrp()
	return {
		name = lp.Name, uid = lp.UserId, place = game.PlaceId, job = game.JobId, beat = beat, t = os.time(),
		o = AUTH.id(), ts = { [".sv"] = "timestamp" },
		fire = (root and root:FindFirstChild("ShinFire") ~= nil) or nil,
		rocket = FXS.rocket or nil,
		jail = FXS.jail,
		boom = FXS.boom,
		tag = TAG.avail and TAG.data() or nil,
	}
end
function pushPresence()
	if alive then http("PUT", "/members/" .. uid .. ".json", presenceBody()) end
end
TAG.push = function()
	-- a tag vai pro /mods (todo mundo que usa o hub vê, inclusive outros membros) e pra presença (ADM)
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

-- tag salva por ID (dada pelo Dono) + ativação automática quando o Dono está neste servidor
task.spawn(function()
	local ownerBeat, ownerAt = nil, 0
	while alive do
		local changed = false
		local gb = http("GET", "/cmd/tag_" .. uid .. ".json")
		if gb ~= nil then
			local g
			if gb ~= "null" and gb ~= "" then
				local ok, d = pcall(HttpService.JSONDecode, HttpService, gb)
				if ok and type(d) == "table" and type(d.role) == "string" and d.role ~= "" then g = d end
			end
			local sig = g and (g.role .. "|" .. tostring(g.rgb == true)) or ""
			if sig ~= (TAG.grantSig or "") then
				TAG.grantSig = sig
				if g then
					for _, r in ipairs(TAG_ROLES) do
						if r[1] == g.role then TAG.role = g.role end
					end
					TAG.rgb = (g.rgb == true)
					TAG.granted = true
				else
					TAG.role = "Membro"; TAG.rgb = false; TAG.granted = false
				end
				changed = true
			end
		end
		local ob = http("GET", "/cmd/owner_" .. game.JobId .. ".json")
		if ob ~= nil then
			local force = false
			if ob ~= "null" and ob ~= "" then
				local ok, o = pcall(HttpService.JSONDecode, HttpService, ob)
				if ok and type(o) == "table" and o.gone ~= true then
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
