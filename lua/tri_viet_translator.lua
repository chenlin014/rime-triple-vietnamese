local config = require("tri_viet_config")

local M={}

function M.init(env)
end

function M.fini(env)
end

function M.func(input, seg, env)
	yield(Candidate(input, seg.start, seg._end, "aa", " "))
end

return M
