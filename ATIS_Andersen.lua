-- ATIS_Andersen.lua
atisAndersen = ATIS:New("Andersen AFB", 140.0)
atisAndersen:SetTACAN(54)
atisAndersen:SetRadioRelayUnitName("Radio Relay Andersen")
atisAndersen:SetActiveRunway("06R")
atisAndersen:SetTowerFrequencies({126.200})
atisAndersen:AddILS(110.1, "06R")
atisAndersen:Start()