local config = require("tri_viet_config")

local maps = {}
maps.key_position = {}
maps.key2onset = {}
maps.key2group = {}
maps.key2tone = {}
maps.rime_maps = config.rime_maps
for i, key in ipairs(config.keyboard) do
	maps.key_position[key] = i
	maps.key2onset[key] = config.onset_map[i]
	maps.key2group[key] = config.group_map[i]
	maps.key2tone[key]  = config.tone_map[i]
end

tonal_letters = {
	["a"] = {"á", "à", "ả", "ã", "ạ"},
	["ă"] = {"ắ", "ằ", "ẳ", "ẵ", "ặ"},
	["â"] = {"ấ", "ầ", "ẩ", "ẫ", "ậ"},
	["e"] = {"é", "è", "ẻ", "ẽ", "ẹ"},
	["ê"] = {"ế", "ề", "ể", "ễ", "ệ"},
	["i"] = {"í", "ì", "ỉ", "ĩ", "ị"},
	["o"] = {"ó", "ò", "ỏ", "õ", "ọ"},
	["ô"] = {"ố", "ồ", "ổ", "ỗ", "ộ"},
	["ơ"] = {"ớ", "ờ", "ở", "ỡ", "ợ"},
	["u"] = {"ú", "ù", "ủ", "ũ", "ụ"},
	["ư"] = {"ứ", "ừ", "ử", "ữ", "ự"},
	["y"] = {"ý", "ỳ", "ỷ", "ỹ", "ỵ"}
}

diacritical_letters = "ăâêôơư"

lower2upper = {
	["a"] = "A",
	["b"] = "B",
	["c"] = "C",
	["d"] = "D",
	["e"] = "E",
	["f"] = "F",
	["g"] = "G",
	["h"] = "H",
	["i"] = "I",
	["j"] = "J",
	["k"] = "K",
	["l"] = "L",
	["m"] = "M",
	["n"] = "N",
	["o"] = "O",
	["p"] = "P",
	["q"] = "Q",
	["r"] = "R",
	["s"] = "S",
	["t"] = "T",
	["u"] = "U",
	["v"] = "V",
	["w"] = "W",
	["x"] = "X",
	["y"] = "Y",
	["z"] = "Z",
	["a"] = "A",
	["á"] = "Á",
	["à"] = "À",
	["ả"] = "Ả",
	["ã"] = "Ã",
	["ạ"] = "Ạ",
	["ă"] = "Ă",
	["ắ"] = "Ắ",
	["ằ"] = "Ằ",
	["ẳ"] = "Ẳ",
	["ẵ"] = "Ẵ",
	["ặ"] = "Ặ",
	["â"] = "Â",
	["ấ"] = "Ấ",
	["ầ"] = "Ầ",
	["ẩ"] = "Ẩ",
	["ẫ"] = "Ẫ",
	["ậ"] = "Ậ",
	["e"] = "E",
	["é"] = "É",
	["è"] = "È",
	["ẻ"] = "Ẻ",
	["ẽ"] = "Ẽ",
	["ẹ"] = "Ẹ",
	["ê"] = "Ê",
	["ế"] = "Ế",
	["ề"] = "Ề",
	["ể"] = "Ể",
	["ễ"] = "Ễ",
	["ệ"] = "Ệ",
	["i"] = "I",
	["í"] = "Í",
	["ì"] = "Ì",
	["ỉ"] = "Ỉ",
	["ĩ"] = "Ĩ",
	["ị"] = "Ị",
	["o"] = "O",
	["ó"] = "Ó",
	["ò"] = "Ò",
	["ỏ"] = "Ỏ",
	["õ"] = "Õ",
	["ọ"] = "Ọ",
	["ô"] = "Ô",
	["ố"] = "Ố",
	["ồ"] = "Ồ",
	["ổ"] = "Ổ",
	["ỗ"] = "Ỗ",
	["ộ"] = "Ộ",
	["ơ"] = "Ơ",
	["ớ"] = "Ớ",
	["ờ"] = "Ờ",
	["ở"] = "Ở",
	["ỡ"] = "Ỡ",
	["ợ"] = "Ợ",
	["u"] = "U",
	["ú"] = "Ú",
	["ù"] = "Ù",
	["ủ"] = "Ủ",
	["ũ"] = "Ũ",
	["ụ"] = "Ụ",
	["ư"] = "Ư",
	["ứ"] = "Ứ",
	["ừ"] = "Ừ",
	["ử"] = "Ử",
	["ữ"] = "Ữ",
	["ự"] = "Ự",
	["y"] = "Y",
	["ý"] = "Ý",
	["ỳ"] = "Ỳ",
	["ỷ"] = "Ỷ",
	["ỹ"] = "Ỹ",
	["ỵ"] = "Ỵ",
	["đ"] = "Đ"
}

for l, u in pairs(config.lower_to_upper or {}) do
	lower2upper[l] = u
end

upper2lower = {}
for l, u in pairs(lower2upper) do
	upper2lower[u] = l
end

local cap_type = {
	no_caps = 0,
	head_cap = 1,
	all_caps = 2
}

local function make_syllable(onset, rime, tone)
	if onset == "c" and (rime:find("^[iye]") or rime:find("^ê")) then
		onset = "k"
	end
	if onset:find("g$") and (rime:find("^[iye]") or rime:find("^ê")) then
		onset = onset:gsub("g", "gh")
	end
	if onset == "gi" and rime:find("^i") then
		onset = "g"
	end
	if onset == "" and rime:find("^iê") then
		rime = rime:gsub("^i", "y")
	end

	if tone == 0 then return onset .. rime end
	if rime == "" then return onset end

	local nucleus = rime:gsub("[mngptch]", "")

	if utf8.len(nucleus) == 1 then
		return onset .. rime:gsub(nucleus, tonal_letters[nucleus][tone])
	end

	local last_dl = nil
	for _, code in utf8.codes(nucleus) do
		local char = utf8.char(code)
		if diacritical_letters:find(char) then
			last_dl = char
		end
	end
	if last_dl then
		return onset .. rime:gsub(last_dl, tonal_letters[last_dl][tone])
	end

	if nucleus == "oo" then
		return onset .. "o" .. rime:sub(2):gsub(
			"o", tonal_letters["o"][tone]
		)
	end

	if nucleus == rime then
		return onset .. rime:gsub(
			nucleus:sub(-2,-2),
			tonal_letters[nucleus:sub(-2,-2)][tone]
		)
	end

	return onset .. rime:gsub(
		nucleus:sub(-1, -1),
		tonal_letters[nucleus:sub(-1,-1)][tone]
	)
end

local function decode_syllable(code, maps)
	if type(code) ~= "string" then
		return {error = "code is not a string"}
	end
	if #code ~= 3 then
		return {error = "length of code != 3"}
	end

	local keys = {}
	keys[1] = string.sub(code,1,1)
	keys[2] = string.sub(code,2,2)
	keys[3] = string.sub(code,3,3)

	local onset = maps.key2onset[keys[1]] or ""

	local rime_map = maps.rime_maps[maps.key2group[keys[2]]] or {}

	local tone = maps.key2tone[keys[2]] or 0

	local rime = rime_map[maps.key_position[keys[3]]] or ""

	return make_syllable(onset, rime, tone)
end

local function capitalization_state(text)
	local head = text:sub(1,1)
	local head_state
	if head:match("[A-Z]") or upper2lower[head] then
		head_state = cap_type.head_cap
	else
		head_state = cap_type.no_caps
	end

	for i=2, #text do
		local char = text:sub(i,i)
		if (not char:match("[A-Z]")) and (not upper2lower[char]) then
			return head_state
		end
	end

	if head_state == cap_type.head_cap then
		return cap_type.all_caps
	else
		return cap_type.no_caps
	end
end

local function lowercase(text)
	ltext = ""
	for _, code in utf8.codes(text) do
		local char = utf8.char(code)
		ltext = ltext .. (upper2lower[char] or char:lower())
	end

	return ltext
end

-- lua translator module
local M={}

function M.init(env)
end

function M.fini(env)
end

-- function for processing input
function M.func(input, seg, env)
	local code = string.sub(input, 1, 3)
	local remaining = string.sub(input, 4)

	code = code:gsub(" $", "")
	local capitalization = capitalization_state(code)
	code = lowercase(code)

	if #code == 1 then
		code = code .. "XX"
	elseif #code == 2 then
		code = "X" .. code
	end

	local syllable = decode_syllable(code, maps)
	if syllable.error then
		yield(Candidate(input, seg.start, seg._end, syllable.error, " "))
		return
	end

	local next_onset = ""
	if remaining ~= "" then
		next_onset = decode_syllable(remaining .. "XX", maps)
	end

	if capitalization == cap_type.head_cap then
		local offset = utf8.offset(syllable, 2)
		local head = syllable:sub(1,offset-1)
		head = lower2upper[head] or head:upper()
		syllable = head .. syllable:sub(offset)
	elseif capitalization == cap_type.all_caps then
		local utext = ""
		for _, code in utf8.codes(syllable) do
			local char = utf8.char(code)
			utext = utext .. (lower2upper[char] or char:upper())
		end
		syllable = utext
	end

	local context = env.engine.context

	if #input > 3 then
		if remaining:find("[^A-Za-z]") then
			env.engine:commit_text(syllable .. remaining)
			context:clear()
		else
			env.engine:commit_text(syllable .. " ")
			context:clear()
			context:push_input(remaining)
			yield(Candidate(input, seg.start, seg._end, next_onset, " "))
		end
	elseif input:match(" $") then
		env.engine:commit_text(syllable .. " ")
		context:clear()
	else
		yield(Candidate(input, seg.start, seg._end, syllable, " "))
	end
end

return M
