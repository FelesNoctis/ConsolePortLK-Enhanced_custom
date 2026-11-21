local addonName, addon = ...

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

-- ConsoleXP Config Options Table (Crosshair Only)
local options = {
    name = "ConsoleXP Crosshair",
    type = "group",
    args = {
        cxp_enableMouselookCrosshair = {
            type = "toggle",
            name = "Enable Mouselook Crosshair",
            desc = "Show the crosshair reticle on screen.",
            get = function() return ConsoleXPSettings.enableCrosshair end,
            set = function(_, val) ConsoleXPSettings.enableCrosshair = val end,
            order = 1,
        },
        cxp_alwaysShowMouselookCrosshair = {
            type = "toggle",
            disabled = function()
                return not ConsoleXPSettings.enableCrosshair
            end,
            name = "Always Show Crosshair",
            desc = "Always show crosshair instead of only during Mouselook.",
            get = function() return ConsoleXPSettings.alwaysShowCrosshair end,
            set = function(_, val) ConsoleXPSettings.alwaysShowCrosshair = val end,
            order = 2,
        },
    },
}

-- Register settings in Blizzard Interface Options
AceConfig:RegisterOptionsTable("ConsoleXP", options)
AceConfigDialog:AddToBlizOptions("ConsoleXP", "ConsoleXP")

-- Register settings panel inside ConsolePort config (/cp)
local WindowMixin = {}

function WindowMixin:CreateLayoutModule()
    local AceGUI = LibStub("AceGUI-3.0")
    local layout = AceGUI:Create("InlineGroup")
    layout:SetLayout("Fill")
    layout:SetWidth(600)
    layout:SetHeight(600)

    layout.frame:SetParent(self)
    layout.frame:ClearAllPoints()
    layout.frame:SetPoint("TOPLEFT", self, "TOPLEFT", 32, -32)
    layout.frame:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -32, 32)

    AceConfigDialog:Open("ConsoleXP", layout)

    self.Layout = layout
    self.CreateLayoutModule = nil
    return layout
end

local function CreateConsolePortConfig()
    if ConsolePortOldConfig and ConsolePortOldConfig.AddPanel then
        ConsolePortOldConfig:AddPanel({
            name = 'ConsoleXP',
            header = "ConsoleXP",
            mixin = WindowMixin,
            onLoad = function(self)
                if not self.Layout then
                    self:CreateLayoutModule()
                end
            end,
        })
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, loadedAddon)
    if loadedAddon == "ConsolePort" then
        CreateConsolePortConfig()
    end
end)

if IsAddOnLoaded("ConsolePort") then
    CreateConsolePortConfig()
end
