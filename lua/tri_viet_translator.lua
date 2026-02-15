local config = require("tri_viet_config")

config.key_position = {}
for i, key in ipairs(config.keyboard) do
	config.key_position[key] = i
end

local function make_syllable(code, cfg)
	if type(code) ~= "string" then
		return {error = "code is not a string"}
	end
	if #code ~= 3 then
		return {error = "length of code != 3"}
	end

	local key_position = cfg.key_position

	local onset = cfg.onset_map[key_position[string.sub(code,1,1)]]
	if not onset then
		return {error = "Failed to find onset: key = " .. string.sub(code,1,1)}
	end

	return onset
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
	syllable = make_syllable(code, config)
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
