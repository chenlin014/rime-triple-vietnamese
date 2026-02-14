local config = require("tri_viet_config")

local M={}

function M.init(env)
end

function M.fini(env)
end

function M.func(input, seg, env)
	local context = env.engine.context

	if #input > 3 then
		env.engine:commit_text(input .. " ")
		context:clear()
		context:push_input(string.sub(input, 4))
	end

	yield(Candidate(input, seg.start, seg._end, input, " "))
end

return M
