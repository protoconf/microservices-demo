build:
	black src --include="\.m?p(inc|conf|roto-validator)"
	protoconf compile .
