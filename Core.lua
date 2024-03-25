local L = SRTLocals;
local f = CreateFrame("Frame");
local addon = ...; -- The name of the addon folder
local version = GetAddOnMetadata(addon, "Version");
SLASH_INFINITERAIDTOOLS1 = "/schwalben";
SLASH_INFINITERAIDTOOLS2 = "/schwalbentools";
SLASH_INFINITERAIDTOOLS3 = "/stools";
SLASH_INFINITERAIDTOOLS4 = "/ST";
local playersChecked = {};
local initCheck = false;
local recievedOutOfDateMessage = false;
local rangeIdList = {
	[4] = 90175,
	[6] = 37727,
	[8] = 8149,
	[10] = 3,
	[11] = 2,
	[13] = 32321,
	[18] = 6450,
	[23] = 21519,
	[30] = 1,
	[33] = 1180,
	[43] = 34471,
	[48] = 32698,
	[53] = 116139,
	[60] = 32825,
	[80] = 35278,
	[100] = 41058
};

local UnitBuff = UnitBuff;
local UnitDebuff = UnitDebuff;


function SRT_OnAddonCompartmentClick(addonName, buttonName)
	Settings.OpenToCategory(SRT_GetSubcategory("Parent"):GetID());
end

function SRT_GetRangeMeasurement(yards)
	-- Check if the exact index exists
	if (rangeIdList[yards]) then
		return rangeIdList[yards];
	else
		local closestHigherIndex = nil
		-- Find the closest higher existing index
		for index, _ in pairs(rangeIdList) do
			if (index > yards and (not closestHigherIndex or index < closestHigherIndex)) then
				closestHigherIndex = index;
			end
		end
		if (closestHigherIndex) then
			return rangeIdList[closestHigherIndex];
		else
			return rangeIdList[100]; -- No values found
		end
	end
end

SlashCmdList["INFINITERAIDTOOLS"] = handler;
f:RegisterEvent("CHAT_MSG_ADDON");
f:RegisterEvent("ADDON_LOADED");
f:RegisterEvent("PLAYER_LOGIN");
f:RegisterEvent("GROUP_ROSTER_UPDATE");
C_ChatInfo.RegisterAddonMessagePrefix("ST_VC");
C_ChatInfo.RegisterAddonMessagePrefix("ST_CRVC");
C_ChatInfo.RegisterAddonMessagePrefix("STUPDATE");

local function renameWarning()
	local warningFrame = CreateFrame("Frame", nil, nil, BackdropTemplateMixin and "BackdropTemplate");
	warningFrame:SetSize(1000, 170);
	warningFrame:SetPoint("CENTER");
	warningFrame:SetMovable(false);
	warningFrame:EnableMouse(false);
	warningFrame:SetFrameLevel(3);
	warningFrame:SetFrameStrata("TOOLTIP");
	warningFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", --Set the background and border textures
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	});
	warningFrame:SetBackdropColor(0.27,0.5,1,1);
	--warningFrame:SetBackdropColor(0.2,0.4,0.92,1);
	--warningFrame:SetBackdropColor(0.27,0.56,0.92,1);
	--warningFrame:SetBackdropColor(0.13,0.29,0.60,1);

	local warningText = warningFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	warningText:SetPoint("TOP", 0, -10);
	warningText:SetJustifyV("TOP");
	warningText:SetJustifyH("CENTER");
	warningText:SetSpacing(8);
	warningText:SetText(L.WARNING_DELETE_OLD_FOLDER);
	DisableAddOn("EndlessRaidTools");

	local closeButton = CreateFrame("Button", nil, warningFrame, "UIPanelButtonTemplate");
	closeButton:SetPoint("BOTTOM", 0, 10);
	closeButton:SetSize(80,25);
	closeButton:SetText("Reload UI");
	closeButton:SetScript("OnClick", function(self)
		ReloadUI();
	end);
	warningFrame:Show();
end

f:SetScript("OnEvent", function(self, event, ...)
	if (event == "CHAT_MSG_ADDON") then
		local prefix, msg, channel, sender = ...;
		if (prefix == "SRT_VC" and UnitName("player") ~= Ambiguate(sender, "short")) then
			if (msg == "vc") then
				sender = Ambiguate(sender, "none");
				if (sender:match("%-")) then
					C_ChatInfo.SendAddonMessage("SRT_CRVC", sender .. " " .. version, "RAID");
				else
					C_ChatInfo.SendAddonMessage("SRT_VC", version, "WHISPER", sender);
				end
			--[[
			elseif (msg:find("vco") and not recievedOutOfDateMessage) then
			local head, tail, ver = msg:find("([^vco-].*)");
			if (tonumber(ver) ~= nil) then
				if (tonumber(ver) > tonumber(version)) then
					DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00" .. L.WARNING_OUTOFDATEMESSAGE);
					recievedOutOfDateMessage = true;
				end
			end]]
			else
				sender = Ambiguate(sender, "short");
				playersChecked[#playersChecked+1] = sender;
				print(sender .. "-" .. msg);
			end
		elseif (prefix == "SRT_CRVC" and UnitName("player") ~= Ambiguate(sender, "short")) then
			local target, vers = strsplit(" ", msg);
			local shortName, serverName = UnitFullName("player");
			local fullName = shortName .. "-" .. serverName;
			if (UnitIsUnit(target, fullName)) then
				sender = Ambiguate(sender, "short");
				playersChecked[#playersChecked+1] = sender;
				print(sender .. "-" .. vers);
			end
		elseif (prefix == "SRT_UPDATE" and UnitName("player") ~= Ambiguate(sender, "short") and not recievedOutOfDateMessage) then
			if (tonumber(msg) ~= nil) then
				if (tonumber(msg) > tonumber(version)) then
					DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. L.WARNING_OUTOFDATEMESSAGE .. "|r");
					recievedOutOfDateMessage = true;
				end
			end
		end
	elseif (event == "GROUP_ROSTER_UPDATE") then
		if (IsInRaid(LE_PARTY_CATEGORY_INSTANCE) or IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
			C_ChatInfo.SendAddonMessage("ST_UPDATE", version, "INSTANCE_CHAT");
		elseif (IsInRaid(LE_PARTY_CATEGORY_HOME)) then
			C_ChatInfo.SendAddonMessage("ST_UPDATE", version, "RAID");
		elseif (IsInGroup(LE_PARTY_CATEGORY_HOME)) then
			C_ChatInfo.SendAddonMessage("ST_UPDATE", version, "PARTY");
		end
	elseif (event == "ADDON_LOADED") then
		local loadedAddon = ...;
		if (loadedAddon == "EndlessRaidTools") then
			renameWarning();
		elseif (loadedAddon == addon) then
			if (IsAddOnLoaded("EndlessRaidTools")) then
				renameWarning();
			end
			if (SRT_PopupTextPosition ~= nil) then
				SRT_PopupSetPosition(SRT_PopupTextPosition.point, SRT_PopupTextPosition.relativeTo, SRT_PopupTextPosition.relativePoint, SRT_PopupTextPosition.xOffset, SRT_PopupTextPosition.yOffset);
			end
			if (SRT_PopupTextFontSize == nil) then
				SRT_PopupTextFontSize = 28;
			end
			if (SRT_InfoBoxPosition ~= nil) then
				SRT_InfoBoxSetPosition(SRT_InfoBoxPosition.point, SRT_InfoBoxPosition.relativeTo, SRT_InfoBoxPosition.relativePoint, SRT_InfoBoxPosition.xOffset, SRT_InfoBoxPosition.yOffset);
			end
			if (SRT_InfoBoxTextFontSize == nil) then
				SRT_InfoBoxTextFontSize = 14;
			end
			--if (SRT_MinimapDegree) then SRT_SetMinimapPoint(SRT_MinimapDegree); end
			--if (SRT_MinimapMode == nil) then SRT_MinimapMode = "Always"; end
			if (SRT_AutoKitPosition ~= nil) then
				SRT_AutoKitSetPosition(SRT_AutoKitPosition.point, SRT_AutoKitPosition.relativeTo, SRT_AutoKitPosition.relativePoint, SRT_AutoKitPosition.xOffset, SRT_AutoKitPosition.yOffset);
			end
			if (SRT_AutoOilPosition ~= nil) then
				SRT_AutoOilSetPosition(SRT_AutoOilPosition.point, SRT_AutoOilPosition.relativeTo, SRT_AutoOilPosition.relativePoint, SRT_AutoOilPosition.xOffset, SRT_AutoOilPosition.yOffset);
			end
			SRT_PopupUpdateFontSize();
			SRT_InfoBoxUpdateFontSize();
		end
	elseif (event == "PLAYER_LOGIN") then
		--[[
		if (SRT_MinimapMode == "Always") then
			SRT_MinimapButton:Show();
		else
			SRT_MinimapButton:Hide();
		end
		]]
		if (IsInGuild()) then
			C_ChatInfo.SendAddonMessage("ST_UPDATE", version, "GUILD");
		end
	end
end);
function SRT_FindMissingPlayers()
	for i = 1, GetNumGroupMembers() do
		local raider = Ambiguate(GetUnitName("raid"..i, true), "short");
		if (not SRT_Contains(playersChecked, raider) and UnitName("raid"..i) ~= UnitName("player")) then
			print(GetUnitName("raid"..i, true) .. " - not installed");
		end
	end
end
--[[
	Checking if a table contains a given value and if it does, what index is the value located at
	param(arr) table
	param(value) T - value to check exists
	return boolean or integer / returns false if the table does not contain the value otherwise it returns the index of where the value is locatedd
]]
function SRT_Contains(arr, value)
	if (value == nil) then
		return false;
	end
	if (arr == nil) then
		return false;
	end
	for k, v in pairs(arr) do
		if (v == value) then
			return k;
		end
	end
	return false;
end

--[[
	Checking if a table contains a given value and if it does, what index is the value located at
	param(arr) table
	param(value) T - value to check exists
	return boolean or integer / returns false if the table does not contain the value otherwise it returns the index of where the value is locatedd
]]
function SRT_ContainsKey(arr, value)
	if (value == nil or arr == nil) then
		return false;
	end
	if (arr[value]) then
		return true;
	else
		return false;
	end
end

function SRT_UnitBuff(unit, spellName)
	if (unit and spellName) then
		for i = 1, 100 do
			local name, rank, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitBuff(unit, i);
			if (not name) then
				return
			end
			if (name == spellName) then
				return name, rank, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3;
			end
		end
	end
	return
end

function SRT_UnitDebuff(unit, spellName)
	if (unit and spellName) then
		for i = 1, 100 do
			local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff(unit, i);
			if (not name) then
				return;
			end
			if (name == spellName) then
				return name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId;
			end
		end
	end
	return;
end

function SRT_GetRaidLeader()
	for i = 1, GetNumGroupMembers() do
		local raider = "raid"..i;
		if select(2, GetRaidRosterInfo(i)) == 2 then
			return GetUnitName(raider, true);
		end
	end
	return "";
end

function SRT_SendAddonCrossRealmMessage(prefix, target, msg)
	if (target:match("%-")) then
		return C_ChatInfo.SendAddonMessage(prefix, target .. " " .. msg, "RAID");
	else
		return C_ChatInfo.SendAddonMessage(prefix, msg, "WHISPER", target);
	end
end

--[[
	To check if message is to me: (UnitIsUnit(target, playerName) or target == nil)
	To check if message is to raid: (channel == "RAID" and target == nil)
]]--
function SRT_DecodeCrossRealmAddonMessage(sender, channel, msg)
	if (channel == "RAID") then
		local target, text = strsplit(" ", msg, 2); --look at this
		local shortName = Ambiguate(target, "short")
		if (UnitInRaid(shortName)) then
			return text, shortName;
		else
			return msg;
		end
	else
		return msg;
	end
end

function SRT_ClassColorName(name)
	if (UnitIsConnected(name)) then
		return string.format("\124c%s%s\124r", RAID_CLASS_COLORS[select(2, UnitClass(name))].colorStr, Ambiguate(name, "short"));
	else
		return name;
	end
end

function SRT_SetFlagIcon(texture, index)
	local iconSize = 32;
	local columns = 256/iconSize;
	local rows = 64/iconSize;
	local l = mod(index, columns) / columns;
	local r = l + (1/columns);
	local t = floor(index/columns) / rows;
	local b = t + (1/rows);
	texture:SetTexCoord(l,r,t,b);
end

function SRT_NotifyPlayer(ticker, text, channel, length, fq)
	if (fq == nil) then
		fq = 1.75;
	end
	if (ticker) then
		ticker:Cancel();
		ticker = nil;
	end
	if (ticker == nil and text and fq and length) then
		SendChatMessage(text, channel);
		ticker = C_Timer.NewTicker(fq, function()
			SendChatMessage(text, channel);
		end, length);
		return ticker;
	end
end

function SRT_GetName(player, server)
	if (server == nil or server) then
		return Ambiguate(GetUnitName(player), "none");
	else
		return Ambiguate(GetUnitName(player), "short");
	end
end

--[[
function SRT_GetSubcategory(name)
	local category = Settings.GetCategory("Infinite Raid Tools");
	if (category:HasSubcategories()) then
		for index, subcategory in pairs(category.subcategories) do
			if (subcategory.name == name) then
				return subcategory;
			end
		end
	end
	return nil;
end
]]
--[==[@debug@
function SRT_Log(boss, msg)
	if (SRT_DebugLog == nil) then
		SRT_DebugLog = {};
	end
	SRT_DebugLog[#SRT_DebugLog+1] = tostring(date("%y/%m/%d %H:%M:%S")) .. " " .. boss .." | " .. msg;
	print(msg);
end
--@end-debug@]==]