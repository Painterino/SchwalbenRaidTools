SRTLocals = {};
local L = SRTLocals;
local addon = ...;

L.OPTIONS_TITLE = "SchwalbenTools";
L.OPTIONS_AUTHOR = "Author: " .. GetAddOnMetadata(addon, "Author");
L.OPTIONS_VERSION = "Version: " .. GetAddOnMetadata(addon, "Version");
L.OPTIONS_DIFFICULTY = "Difficulty:"
L.OPTIONS_ENABLED = "Enabled";

L.OPTIONS_VERSIONCHECK_TEXT = "Version Check Raid Members";
L.OPTIONS_VERSIONCHECK_BUTTON_TEXT = "Check Raiders";

L.OPTIONS_INFOBOXSETTINGS_TEXT = "Infobox Settings";
L.OPTIONS_INFOBOX_BUTTON_TEXT = "Move Infobox Text";

L.OPTIONS_MINIMAP_CLICK = "Click to open the settings";
L.OPTIONS_MINIMAP_MODE_TEXT = "Show minimap button:";

L.OPTIONS_GENERAL_INFO = "Das ist das Addon SchwalbenTools, entwickelt für die Schwalben, kA ist noch nen Platzhalter";
L.OPTIONS_GENERALSETTINGS_TEXT = "General Settings:";
L.OPTIONS_GENERAL_TITLE = "General Options";
L.OPTIONS_RESETPOSITIONS_BUTTON = "Reset";
L.OPTIONS_RESETPOSITIONS_TEXT = "Reset to default SRT positions";

L.OPTIONS_READYCHECK_TITLE = "Ready Check Module";
L.OPTIONS_READYCHECK_INFO = "|cFF00FFFFRaiders:|r If you are in a raid and you are either AFK or decline a ready check you will get a button show up on your screen that will inform the raid that you are ready once you press it.\n|cFF00FFFFRaid leader(sender):|r If you have this enabled and send a ready check a list will show up of players that are AFK/not ready after the Blizzard ready check finished that updates in real time as the players presses their SRT ready button.";
L.OPTIONS_READYCHECK_PREVIEW = "|cFF00FFFFRaiders:|r\n|cFFFFFFFFPreview of the button that appears if you press not ready or AFK for a ready check.|r\n\n|cFF00FFFFRaid leader(sender):|r\n|cFFFFFFFFPreview of the list that appears for the players that pressed not ready or was AFK\nThe list updates in real time.|r";
L.OPTIONS_READYCHECK_FLASHING = "Flash Ready Check Button \nWarning for those sensitive to pulsating light.";
L.OPTIONS_READYCHECK_WATCHER = "Show list of unready players even when you did not initiate the ready check.";

L.WARNING_OUTOFDATEMESSAGE = "There is a newer version of SchwalbenTools available on overwolf/curseforge!";
L.WARNING_RESETPOSITIONS_DIALOG = "Are you sure you want to reset positions?";
L.WARNING_DELETE_OLD_FOLDER = "|cFFFFFFFFHello dear |r|cFF00FFFFEndless Raid Tools|r|cFFFFFFFF user!\n|cFF00FFFFEndless Raid Tools|r |cFFFFFFFFhas changed name to |r|cFF00FFFFInfinite Raid Tools|r, |cFF00FFFF/enrt|r |cFFFFFFFFwill still work for now but will eventually be removed, the new command is: |cFF00FFFF/SRT|r.\n|cFFFF0000Please delete the|r |cFF00FFFFEndless Raid Tools|r |cFFFF0000folder to avoid possible bugs and interference.|r \n|cFFFFFFFFThe folder can be found from your WoW installation then _retail_/Interface/AddOns/EndlessRaidTools\n Thank you for using|r |cFF00FFFFInfinite Raid Tools|r|cFFFFFFFF! Coming in Shadowlands: Consumable Check update and 6 new boss modules for Castle Nathria!|r\n |cFFFF0000Auto-disabling old |r|cFF00FFFFEndless Raid Tools|r|cFFFF0000 for now, new|r |cFF00FFFFInfinite Raid Tools|r |cFFFF0000will still be loaded. Please hit reload ui.|r";