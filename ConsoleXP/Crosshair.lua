local addonName, addon = ...

ConsoleXPSettings = ConsoleXPSettings or {}
if ConsoleXPSettings.enableCrosshair == nil then
    ConsoleXPSettings.enableCrosshair = true
end

local Crosshair = CreateFrame("Frame", "ConsoleXP_Crosshair", UIParent)
Crosshair:SetSize(48, 48)

Crosshair.texture = Crosshair:CreateTexture(nil, "OVERLAY")
Crosshair.texture:SetAllPoints()
Crosshair.texture:SetTexture("Interface\\AddOns\\ConsoleXP\\Assets\\Crosshair.blp")

local function PositionCrosshair()
    Crosshair:ClearAllPoints()
    Crosshair:SetPoint("CENTER", UIParent, "CENTER", 0, UIParent:GetHeight() * 0.045)
end

PositionCrosshair()
Crosshair:RegisterEvent("PLAYER_LOGIN")
Crosshair:RegisterEvent("PLAYER_ENTERING_WORLD")
Crosshair:RegisterEvent("DISPLAY_SIZE_CHANGED")
Crosshair:RegisterEvent("UI_SCALE_CHANGED")
Crosshair:SetScript("OnEvent", PositionCrosshair)

Crosshair:SetScript("OnUpdate", function(self)
    if not ConsoleXPSettings.enableCrosshair then
        Crosshair.texture:Hide()
        return
    end
    if not ConsoleXPSettings.alwaysShowCrosshair and not IsMouselooking() then
        Crosshair.texture:Hide()
        return
    end
    Crosshair.texture:Show()
end)
