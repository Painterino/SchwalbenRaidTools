local L = SRTLocals;

-- Create a frame for the General Options
SRT_GeneralOptions = CreateFrame("Frame");
SRT_GeneralOptions:Hide();

-- Create and set the title for the General Options
local title = SRT_GeneralOptions:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
title:SetPoint("TOP", 0, -16);
title:SetText(L.OPTIONS_TITLE);

-- Create and set the tab info for the General Options
local tabinfo = SRT_GeneralOptions:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
tabinfo:SetPoint("TOPLEFT", 16, -16);
tabinfo:SetText(L.OPTIONS_GENERAL_TITLE);

-- Create and set the author info for the General Options
local author = SRT_GeneralOptions:CreateFontString(nil, "ARTWORK", "GameFontNormal");
author:SetPoint("TOPLEFT", 450, -20);
author:SetText(L.OPTIONS_AUTHOR);

-- Create and set the version info for the General Options
local version = SRT_GeneralOptions:CreateFontString(nil, "ARTWORK", "GameFontNormal");
version:SetPoint("TOPLEFT", author, "BOTTOMLEFT", 0, -10);
version:SetText(L.OPTIONS_VERSION);

-- Create and set the info border for the General Options
local infoBorder = SRT_GeneralOptions:CreateTexture(nil, "BACKGROUND");
infoBorder:SetTexture("Interface\\GMChatFrame\\UI-GMStatusFrame-Pulse.PNG");
infoBorder:SetWidth(530);
infoBorder:SetHeight(120);
infoBorder:SetTexCoord(0.11,0.89,0.24,0.76);
infoBorder:SetPoint("TOP", 0, -85);

-- Create and set the info text for the General Options
local info = SRT_GeneralOptions:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
info:SetPoint("TOPLEFT", infoBorder, "TOPLEFT", 10, -25);
info:SetSize(510, 200);
info:SetText(L.OPTIONS_GENERAL_INFO);
info:SetWordWrap(true);
info:SetJustifyV("TOP");


local generalText = SRT_GeneralOptions:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); 
generalText:SetText(L.OPTIONS_GENERALSETTINGS_TEXT);
generalText:SetPoint("CENTER", 0, -10); -- Updated position relative to the frame's center

local vcText = SRT_GeneralOptions:CreateFontString(nil, "ARTWORK", "GameFontWhite");
vcText:SetText(L.OPTIONS_VERSIONCHECK_TEXT);
vcText:SetPoint("TOP", generalText, "BOTTOM", 0, -10);  -- below generalText

local vcButton = CreateFrame("Button", "SRT_VCButton", SRT_GeneralOptions, "UIPanelButtonTemplate");
vcButton:SetSize(150, 35);
vcButton:SetPoint("TOP", vcText, "BOTTOM", 0, -10);  -- Positioned below vcText
vcButton:SetText(L.OPTIONS_VERSIONCHECK_BUTTON_TEXT);
vcButton:HookScript("OnClick", function(self)
    C_ChatInfo.SendAddonMessage("SRT_VC", "vc", "RAID");
end);