local config = require("tri_viet_config")

tri_viet = {}

function tri_viet.translator(input, seg)
	yield(Candidate(input, seg.start, seg._end, config.keyboard[3], " "))
end

function tri_viet.filter(input, env)
	local context = env.engine.context
	local composition = context.composition

	local candidates = {}
	for cand in input:iter() do
		table.insert(candidates, cand)
	end

	if #candidates > 0 then
		local cand_text = candidates[1].text or ""
	end
end

return tri_viet
