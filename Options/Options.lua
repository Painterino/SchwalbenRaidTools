-- Define a local variable 'L' to reference the SRTLocals table
local L = SRTLocals;

-- Create a frame for SRT options and hide it initially
SRT_Options = CreateFrame("Frame");
SRT_Options:Hide();

-- Initialize a table to store subcategories
local subcategories = {};

-- Register a canvas layout category for the SRT options frame
local category, layout = Settings.RegisterCanvasLayoutCategory(SRT_Options, L.OPTIONS_TITLE);
local cID = category:GetID();
layout:AddAnchorPoint("TOPLEFT", 0, 0);
layout:AddAnchorPoint("BOTTOMRIGHT", 0, 0);

-- Create a title font string for the SRT options frame
local title = SRT_Options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
title:SetPoint("TOP", 0, -16);
title:SetText(L.OPTIONS_TITLE);

-- Create an author font string for the SRT options frame
local author = SRT_Options:CreateFontString(nil, "ARTWORK", "GameFontNormal");
author:SetPoint("TOPLEFT", 450, -20);
author:SetText(L.OPTIONS_AUTHOR);

-- Create a version font string for the SRT options frame
local version = SRT_Options:CreateFontString(nil, "ARTWORK", "GameFontNormal");
version:SetPoint("TOPLEFT", author, "BOTTOMLEFT", 0, -10);
version:SetText(L.OPTIONS_VERSION);


local mainHintergrund = SRT_Options:CreateTexture(nil, "BACKGROUND");
mainHintergrund:SetTexture("Interface\\addons\\SchwalbenTools\\Res\\mainhintergrund.tga");
mainHintergrund:SetPoint("Center");
mainHintergrund:SetSize(512, 256);


-- Add the 'Parent' subcategory to the subcategories table
subcategories["Parent"] = category;

-- Register the add-on category for the SRT options frame
Settings.RegisterAddOnCategory(category);



local subcategoryGM = Settings.RegisterCanvasLayoutSubcategory(category, SRT_GeneralOptions, "General Options");

local subcategoryGM = Settings.RegisterCanvasLayoutSubcategory(category, SRT_ReadyCheckOptions, "Ready Check Module");



