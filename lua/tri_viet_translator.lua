local config = require("tri_viet_config")

local maps = {}
maps.key_position = {}
maps.key2onset = {}
maps.key2group = {}
maps.key2tone = {}
maps.rime_groups = config.rime_groups
for i, key in ipairs(config.keyboard) do
	maps.key_position[key] = i
	maps.key2onset[key] = config.onset_map[i]
	maps.key2group[key] = config.group_map[i]
	maps.key2tone[key]  = config.tone_map[i]
end

tonal_letters = {}
tonal_letters["a"] = {"á", "à", "ả", "ã", "ạ"}
tonal_letters["ă"] = {"ắ", "ằ", "ẳ", "ẵ", "ặ"}
tonal_letters["â"] = {"ấ", "ầ", "ẩ", "ẫ", "ậ"}
tonal_letters["e"] = {"é", "è", "ẻ", "ẽ", "ẹ"}
tonal_letters["ê"] = {"ế", "ề", "ể", "ễ", "ệ"}
tonal_letters["i"] = {"í", "ì", "ỉ", "ĩ", "ị"}
tonal_letters["o"] = {"ó", "ò", "ỏ", "õ", "ọ"}
tonal_letters["ô"] = {"ố", "ồ", "ổ", "ỗ", "ộ"}
tonal_letters["ơ"] = {"ớ", "ờ", "ở", "ỡ", "ợ"}
tonal_letters["u"] = {"ú", "ù", "ủ", "ũ", "ụ"}
tonal_letters["ư"] = {"ứ", "ừ", "ử", "ữ", "ự"}
tonal_letters["y"] = {"ý", "ỳ", "ỷ", "ỹ", "ỵ"}

diacritical_letters = "ăâêôơư"

lower2upper = {}
lower2upper["a"] = "A"
lower2upper["b"] = "B"
lower2upper["c"] = "C"
lower2upper["d"] = "D"
lower2upper["e"] = "E"
lower2upper["f"] = "F"
lower2upper["g"] = "G"
lower2upper["h"] = "H"
lower2upper["i"] = "I"
lower2upper["j"] = "J"
lower2upper["k"] = "K"
lower2upper["l"] = "L"
lower2upper["m"] = "M"
lower2upper["n"] = "N"
lower2upper["o"] = "O"
lower2upper["p"] = "P"
lower2upper["q"] = "Q"
lower2upper["r"] = "R"
lower2upper["s"] = "S"
lower2upper["t"] = "T"
lower2upper["u"] = "U"
lower2upper["v"] = "V"
lower2upper["w"] = "W"
lower2upper["x"] = "X"
lower2upper["y"] = "Y"
lower2upper["z"] = "Z"

lower2upper["a"] = "A"
lower2upper["á"] = "Á"
lower2upper["à"] = "À"
lower2upper["ả"] = "Ả"
lower2upper["ã"] = "Ã"
lower2upper["ạ"] = "Ạ"
lower2upper["ă"] = "Ă"
lower2upper["ắ"] = "Ắ"
lower2upper["ằ"] = "Ằ"
lower2upper["ẳ"] = "Ẳ"
lower2upper["ẵ"] = "Ẵ"
lower2upper["ặ"] = "Ặ"
lower2upper["â"] = "Â"
lower2upper["ấ"] = "Ấ"
lower2upper["ầ"] = "Ầ"
lower2upper["ẩ"] = "Ẩ"
lower2upper["ẫ"] = "Ẫ"
lower2upper["ậ"] = "Ậ"
lower2upper["e"] = "E"
lower2upper["é"] = "É"
lower2upper["è"] = "È"
lower2upper["ẻ"] = "Ẻ"
lower2upper["ẽ"] = "Ẽ"
lower2upper["ẹ"] = "Ẹ"
lower2upper["ê"] = "Ê"
lower2upper["ế"] = "Ế"
lower2upper["ề"] = "Ề"
lower2upper["ể"] = "Ể"
lower2upper["ễ"] = "Ễ"
lower2upper["ệ"] = "Ệ"
lower2upper["i"] = "I"
lower2upper["í"] = "Í"
lower2upper["ì"] = "Ì"
lower2upper["ỉ"] = "Ỉ"
lower2upper["ĩ"] = "Ĩ"
lower2upper["ị"] = "Ị"
lower2upper["o"] = "O"
lower2upper["ó"] = "Ó"
lower2upper["ò"] = "Ò"
lower2upper["ỏ"] = "Ỏ"
lower2upper["õ"] = "Õ"
lower2upper["ọ"] = "Ọ"
lower2upper["ô"] = "Ô"
lower2upper["ố"] = "Ố"
lower2upper["ồ"] = "Ồ"
lower2upper["ổ"] = "Ổ"
lower2upper["ỗ"] = "Ỗ"
lower2upper["ộ"] = "Ộ"
lower2upper["ơ"] = "Ơ"
lower2upper["ớ"] = "Ớ"
lower2upper["ờ"] = "Ờ"
lower2upper["ở"] = "Ở"
lower2upper["ỡ"] = "Ỡ"
lower2upper["ợ"] = "Ợ"
lower2upper["u"] = "U"
lower2upper["ú"] = "Ú"
lower2upper["ù"] = "Ù"
lower2upper["ủ"] = "Ủ"
lower2upper["ũ"] = "Ũ"
lower2upper["ụ"] = "Ụ"
lower2upper["ư"] = "Ư"
lower2upper["ứ"] = "Ứ"
lower2upper["ừ"] = "Ừ"
lower2upper["ử"] = "Ử"
lower2upper["ữ"] = "Ữ"
lower2upper["ự"] = "Ự"
lower2upper["y"] = "Y"
lower2upper["ý"] = "Ý"
lower2upper["ỳ"] = "Ỳ"
lower2upper["ỷ"] = "Ỷ"
lower2upper["ỹ"] = "Ỹ"
lower2upper["ỵ"] = "Ỵ"

lower2upper["đ"] = "Đ"

local function make_syllable(onset, rime, tone)
	if type(onset) ~= "string" then
		return {error = "apply_tone: onset is not a string"}
	end
	if type(rime) ~= "string" then
		return {error = "apply_tone: rime is not a string"}
	end
	if math.type(tone) ~= "integer" then
		return {error = "apply_tone: tone is not an integer"}
	end
	if tone < 0 or tone > 5 then
		return {error = "apply_tone: tone must be between 0 and 5"}
	end

	if onset == "c" and (rime:find("^[iye]") or rime:find("^ê")) then
		onset = "k"
	end
	if onset:find("g$") and (rime:find("^[iye]") or rime:find("^ê")) then
		onset = onset:gsub("g", "gh")
	end
	if onset == "gi" and rime:find("^i") then
		onset = "g"
	end

	if tone == 0 then return onset .. rime end

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
		return onset .. "o" .. tonal_letters["o"][tone]
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

	local onset = maps.key2onset[keys[1]]
	if not onset then return {error = "no onset for " .. keys[1]} end

	local group = maps.key2group[keys[2]]
	if not group then return {error = "no group for " .. keys[2]} end

	local tone = maps.key2tone[keys[2]]
	if not tone then return {error = "no tone for " .. keys[2]} end

	local rime = maps.rime_groups[group][maps.key_position[keys[3]]]
	if not rime then 
		return {error = "no rime for " .. keys[3] .. " in group " .. group}
	end

	return make_syllable(onset, rime, tone)
end

local M={}

function M.init(env)
end

function M.fini(env)
end

function M.func(input, seg, env)
	if #input < 3 then
		return
	end

	local capitalize = false
	if input:find("^[A-Z]") then
		capitalize = true
		input = input:lower()
	end

	local code = string.sub(input, 1, 3)
	local remaining = string.sub(input, 4)

	local syllable = decode_syllable(code, maps)
	if syllable.error then
		yield(Candidate(input, seg.start, seg._end, syllable.error, " "))
		return
	end

	if capitalize then
		local offset = utf8.offset(syllable, 2)
		local first = syllable:sub(1,offset-1)
		first = lower2upper[first] or first
		syllable = first .. syllable:sub(offset)
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
		end
	else
		yield(Candidate(input, seg.start, seg._end, syllable, " "))
	end
end

return M
