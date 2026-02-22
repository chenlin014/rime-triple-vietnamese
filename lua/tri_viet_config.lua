local config = {}

config.keyboard = {
	"q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "]",
	"a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'",
	"z", "x", "c", "v", "b", "n", "m", ",", ".", "/"
}

config.lower_to_upper = {
	["`"] = "~",
	["1"] = "!",
	["2"] = "@",
	["3"] = "#",
	["4"] = "$",
	["5"] = "%",
	["6"] = "^",
	["7"] = "&",
	["8"] = "*",
	["9"] = "(",
	["0"] = ")",
	["-"] = "_",
	["="] = "+",
	["["] = "{",
	["]"] = "}",
	["\\"] = "|",
	[";"] = ":",
	["'"] = '"',
	[","] = "<",
	["."] = ">",
	["/"] = "?"
}

config.onset_map = {
	"qu", "p",  "c",  "t",  "ch",  nil, "ng", "s", "r", "gi", nil,
	"h",  "b",  "g",  "d",  "đ",  "nh", "n",  "v", "l", " ",  nil,
	"x",  "ph", "kh", "th", "tr", "",   "m"
}

config.rime_maps = {
  a = {
	nil,  nil,  "ia", "ai", nil, "ây", "ui", "oi", "ôi", "ơi", nil,
	"ê",  "e",  "i",  "a",  "y", "âu", "u",  "o",  "ô",  "ơ",  nil,
	"êu", "eo", "iu", "au", nil,  nil, "ua", "ao", "ay"
  },
  oa = {
	nil,   nil,   "uya", "oai", nil,   nil,   "ưi", "ươi", nil,  nil,  nil,
	"oe",  "iêu", "uy",  "oa",  "oay", "uây", "ư",  "uơ",  "ưa", "uê", nil,
	"oeo", nil,   "uyu", "oao", nil,   nil,   "ưu", "ươu"
  },
  an = {
	"ênh", "eng", "inh", "ang", "ăng", "âng", "ung", "ong", "ông", nil, nil,
	"ên",  "en",  "in",  "an",  "ăn",  "ân",  "un",  "on",  "ôn",  "ơn", "anh",
	"êm",  "em",  "im",  "am",  "ăm",  "âm",  "um",  "om",  "ôm",  "ơm"
  },
  oan = {
	"oem",  "iêng", "uynh", "oang", "oăng", "uâng", "ưng", "ương", "uông", "uênh", nil,
	"oen",  "iên",  "uyn",  "oan",  "oăn",  "uân",  "ưn",  "ươn",  "uôn",  "uyên", "oanh",
	"oong", "iêm",  nil,    "oam",  "oăm",  nil,    "ưm",  "ươm",  "uôm"
  },
  at = {
	"êch", "ec", "ich", "ac", "ăc", "âc", "uc", "oc", "ôc", nil,  nil,
	"êt",  "et", "it",  "at", "ăt", "ât", "ut", "ot", "ôt", "ơt", "ooc",
	"êp",  "ep", "ip",  "ap", "ăp", "âp", "up", "op", "ôp", "ơp"
  },
  oat = {
	nil,   "iêc", "uych", "oac", "oăc", "oach", "ưc", "ươc", "uôc", "uêch", nil,
	"oet", "iêt", "uyt",  "oat", "oăt", "uât",  "ưt", "ươt", "uôt", "uyêt", nil,
	nil,   "iêp", "uyp",  "oap", nil,   nil,    nil,  "ươp", "uôp"
  }
}

config.group_map = {
	"oa", "oa", "a", "a", "oat", "oat", "an", "an", "oan", "oan", nil,
	"oa", "oa", "a", "a", "at",  "at",  "an", "an", "oan", "oan", nil,
	"oa", "oa", "a", "a",  nil,   nil,  "an", "an", "oan", "oan"
}

config.tone_map = {
	3, 2, 3, 2,  1,   5,  2, 3, 2, 3, nil,
	1, 0, 1, 0,  1,   5,  0, 1, 0, 1, nil,
	5, 4, 5, 4, nil, nil, 4, 5, 4, 5
}

return config
