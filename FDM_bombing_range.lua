-- setup the Farralon bombing range

FDMRange = RANGE:New("FDM")

FDMRange:SetRangeZone(ZONE:New("FDM"))
FDMRange:SetRangeCeiling(20000)
FDMRange:EnableRangeCeiling(true)

local bombing_target = GROUP:FindByName("Target_Trucks")
local strafing_target = GROUP:FindByName("Target_BTR")

FDMRange:AddBombingTargetGroup(bombing_target, 50, false)
FDMRange:AddStrafePitGroup(strafing_target, 3000, 300, 270, 90, 15, 500)

-- BASE:TraceOnOff(true)
-- BASE:TraceLevel(1)
-- BASE:TraceClass("RANGE")
-- FDMRange:DebugON()

FDMRange:Start()