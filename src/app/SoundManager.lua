local SoundManager = {}

local LANGUAGE_COMMON = 2 -- 2是普通话,1是长沙方言
local SEX_MAX = 1

-- local LANGUAGE_TYPE = {"common", "changsha"}
-- local SEX_TYPE = {"man", "woman"}

SoundManager.NAME_LIST = {
	queyise = "js_xh_queyise",
	banbanhu = "js_xh_banbanhu",
	sixi = "js_xh_dasixi",
	liuliushun = "js_xh_liuliushun",

	haohuaxiaoqidui = "js_dh_haohuaqixiaodui",
	-- "haohuaxiaoqidui" = "js_dh_haohuaqixiaodui_zimo",

	qixiaodui = "js_dh_qixiaodui",
	-- "qixiaodui" = "js_dh_qixiaodui_zimo",

	qingyise = "js_dh_qingyise",
	-- "qingyise" = "js_dh_qingyise_zimo",

	jiangjianghu = "js_dh_jiangjianghu",
	-- "jiangjianghu" = "js_dh_jiangjianghu_zimo",

	pengpenghu = "js_dh_pengpenghu",
	-- "pengpenghu" = "js_dh_pengpenghu_zimo",

	quanqiuren = "js_dh_quanqiuren",
	-- "quanqiuren" = "js_dh_quanqiuren_zimo",

	gangshangkaihua = "js_dh_gangshangkaihua",
	-- "gangshangkaihua" = "js_dh_gangshangkaihua_zimo",

	gangshangpao = "js_dh_gangshangpao",

	haidilaoyue = "js_dh_haidilaoyue",
	-- "haidilaoyue" = "js_dh_haidilaoyue_zimo",

	haidipao = "js_dh_haidipao",

	qiangganghu = "js_dh_qiangganghu",

	hu = {
		"hu1",
		"hu2",
	},
	huMore = {
		"hu1",
		"hu2",
		"hu3",
	},
	zimo = {
		"zimo1",
		"zimo2",
	},
	gang = {
		"gang1",
		"gang2",
	},
	gangMore = {
		"gang1",
		"gang2",
		"gang3",
	},
	peng = {
		--"peng1",
		--"peng2",
		"peng3",
		--"peng4",
	},
	pengMore = {
		--"peng1",
		--"peng2",
		"peng3",
		"peng4",
		"peng5",
	},
	chi = {
		"chi1",
		--"chi2",
		--"chi3",
	},
	chiMore = {
		"chi1",
		--"chi2",
		--"chi3",
		"chi4",
	},
	buzhang = "buzhang",
}

function SoundManager:PlaySpeakSound(sex, _type, roomPlayer)
	if _type=="angang" then -- 语音中无暗杠,暂时用杠替代
		_type="gang"
	end
	if roomPlayer then
		if _type=="gang" and (#roomPlayer.mjTileBrightBars+#roomPlayer.mjTileDarkBars)>=8 then
			_type = "gangMore"
		end
		if _type=="peng" and #roomPlayer.mjTilePungs>3 then
			_type = "pengMore"
		end
		if _type=="chi" and #roomPlayer.mjTileEat>3 then
			_type = "chiMore"
		end
		if _type=="hu" and roomPlayer.isFirstHu>=2 then
			_type = "huMore"
		end
	end

	local path = SoundManager:getPath(sex)

	local result = SoundManager.NAME_LIST[_type]
	if result then
		if type(result) == "table" then
			result = result[math.random(1, #result)]
		end
		gt.soundEngine:playEffect(string.format("%s/%s", path, result))
	end
end

function SoundManager:PlayCardSound(sex, color, number)
	local path = SoundManager:getPath(sex)
	gt.soundEngine:playEffect(string.format("%s/mjt%d_%d", path, color, number))
end

function SoundManager:PlayFixSound(sex, id)
	local path = SoundManager:getPath(sex)
	gt.log("path = " .. path .. ", id = " .. id)
	gt.soundEngine:playEffect(string.format("%s/fix_msg_%d", path, id))
end

function SoundManager:getPath(sex)
	local languageTpye = cc.UserDefault:getInstance():getIntegerForKey("Language_type", 1)
	if languageTpye == LANGUAGE_COMMON then
		if sex == SEX_MAX then
			return "common_man"
		else
			return "common_woman"
		end
	else
		if sex == SEX_MAX then
			return "changsha_man"
		else
			return "changsha_woman"
		end
	end
end

return SoundManager