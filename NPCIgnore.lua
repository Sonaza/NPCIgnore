------------------------------------------------------------
-- NPCIgnore by Sonaza
-- All rights reserved
-- http://sonaza.com
------------------------------------------------------------

local DefaultIgnoreList = {
	["topper mcnabb"] = true,
	["rhonin"] = true,
};

local function stfu(self, event, message, name)
	IgnoreList = IgnoreList or DefaultIgnoreList;
	
	local name = string.lower(name);
	return name and IgnoreList[name];
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", stfu);
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", stfu);
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_WHISPER", stfu);
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_PARTY", stfu);
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_EMOTE", stfu);

local function addmessage(msg, ...)
	DEFAULT_CHAT_FRAME:AddMessage(string.format("|cff92e116NPCIgnore|r %s", string.format(msg, ...)));
end

SLASH_NPCIGNORE1 = "/npcignore";
SlashCmdList["NPCIGNORE"] = function(name)
	local ignorename = strtrim(strlower(name) or "")
	if(strlen(ignorename) == 0) then
		if(not UnitIsPlayer("target") and UnitName("target")) then
			name = UnitName("target");
			ignorename = strlower(UnitName("target"));
		else
			addmessage("Usage: |cffffdd00/npcignore name|r or target an NPC and use the command.");
			return;
		end
	end
	
	if(not IgnoreList[ignorename]) then
		IgnoreList[ignorename] = true;
		addmessage("Ignored NPC |cffffdd00%s|r.", strtrim(name));
	else
		IgnoreList[ignorename] = nil;
		addmessage("Unignored NPC |cffffdd00%s|r.", strtrim(name));
	end
end
