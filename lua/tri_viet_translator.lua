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

local function apply_orthography(syllable)
	syllable = syllable:gsub("c([iye])", "k%1")
	syllable = syllable:gsub("cê", "kê")
	syllable = syllable:gsub("g([iye])", "gh%1")
	syllable = syllable:gsub("gê", "ghê")

	return syllable
end

local function make_syllable(code, maps)
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
	if not onset then return {error = "no onset for key: " .. keys[1]} end

	local group = maps.key2group[keys[2]]
	if not group then return {error = "no group for key: " .. keys[2]} end

	local tone = maps.key2tone[keys[2]]
	if not tone then return {error = "no tone for key: " .. keys[2]} end

	local rime = maps.rime_groups[group][maps.key_position[keys[3]]]
	if not rime then return {error = "no rime for key: " .. keys[3]} end

	local syllable = onset .. rime
	syllable = apply_orthography(syllable)

	return syllable
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
	local syllable = make_syllable(code, maps)
	if syllable.error then
		yield(Candidate(input, seg.start, seg._end, syllable.error, " "))
		return
	end

	local context = env.engine.context

	-- Completed syllable plus one more code:
	--   commit the syllable with a space at the end
	--   start a syllable with the extra code
	if #input > 3 then
		env.engine:commit_text(syllable .. " ")
		context:clear()
		context:push_input(string.sub(input, 4))
	end

	yield(Candidate(input, seg.start, seg._end, syllable, " "))
end

return M
