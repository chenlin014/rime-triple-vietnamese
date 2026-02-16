-- keyboard: [
--   "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "]",
--   "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'",
--   "z", "x", "c", "v", "b", "n", "m", ",", ".", "/"
-- ]

local config = {}

config.keyboard = {
	"q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "]",
	"a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'",
	"z", "x", "c", "v", "b", "n", "m", ",", ".", "/"
}

config.onset_map = {
	"qu", "p",  "c",  "t",  "ch",  nil, "ng", "r", "s", "gi", nil,
	"h",  "b",  "g",  "d",  "đ",  "nh", "n",  "v", "l", " ",  nil,
	"x",  "ph", "kh", "th", "tr", "",   "m"
}

config.rime_groups = {
  a = {
	"ưă", "ui", "ia", "ai", "ưu", nil,  "oi", "ôi", "ơi", "iêu", "êu",
	"ư",  "u",  "i",  "a",  "y",  "eo", "o",  "ô",  "ơ",  "e",   "ê",
	"ưu", "ua", "iu", "au", nil,  nil,  "ao", "ay", "ây", "âu"
  },
  oa = {
	  nil,   "ươi", "uya", "oai", nil, nil, nil,  nil,  nil,   nil,   nil,
	  "oay", "uơ",  "uy",  "oa",  nil, nil, "oe", "uê", "uây", "oeo", nil,
	  nil,   "ươu", "uyu", "oao"
  },
  an = {
	"am",  "ăm",  "âm",  "em",  "êm",  "im",  "om",  "ôm",  "ơm",  "um", nil,
	"an",  "ăn",  "ân",  "en",  "ên",  "in",  "on",  "ôn",  "ơn",  "un", nil,
	"ang", "ăng", "âng", "eng", "ênh", "inh", "ong", "ông", "anh", "ung"
  },
  oan = {
	"oang", "oăng", "oong", "ưng", "uông", "iêng", "ương", "uâng", "uynh", nil,
	"oan",  "oăn",  "oen",  "ưn",  "uôn",  "iên",  "ươn",  "uân",  "uyn",  "uênh",
	"oam",  "oăm",  "oem",  "ưm",  "uôm",  "iêm",  "ươm",  "oanh", "uyên"
  },
  at = {
	"ac", "ăc", "âc", "ec", "êch", "ich", "oc", "ôc", "ooc", "uc", "ưc",
	"at", "ăt", "ât", "et", "êt",  "it",  "ot", "ôt", "ơt",  "ut", "ưt",
	"ap", "ăp", "âp", "ep", "êp",  "ip",  "op", "ôp", "ơp",  "up"
  },
  oat = {
	nil,   "uôc", "iêc", "oac", nil, nil,    "uych", "ươc", "oăc", nil,   nil,
	"uât", "uôt", "iêt", "oat", nil, "uyêt", "uyt",  "ươt", "oăt", "oet", nil,
	nil,   "uôp", "iêp", "oap", nil, nil,    "uyp",  "ươp", "oach"
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
