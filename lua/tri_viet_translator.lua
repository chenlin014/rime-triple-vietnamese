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

	local code = string.sub(input, 1, 3)
	local remaining = string.sub(input, 4)

	local syllable = decode_syllable(code, maps)
	if syllable.error then
		yield(Candidate(input, seg.start, seg._end, syllable.error, " "))
		return
	end

	local context = env.engine.context

	-- Completed syllable plus one more code:
	--   commit the syllable with a space at the end
	--   start a syllable with the extra code
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
