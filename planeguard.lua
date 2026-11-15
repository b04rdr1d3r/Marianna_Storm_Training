
-- Rescue Helo object

-- Ensure CVN-72 exists before starting the script
local CarrierUnit = UNIT:FindByName("CVN-72")
if not CarrierUnit then
    BASE:E("*** ERROR: Unit 'CVN-72' is not found in the DCS Mission Editor! RescueHelo script halted. ***")
    return
end

-- Ensure the CarrierOps zone is defined
local CarrierZone = ZONE:FindByName("CarrierOps")
if not CarrierZone then
    BASE:E("*** ERROR: Trigger Zone 'CarrierOps' is not defined in the DCS Mission Editor! RescueHelo script halted. ***")
    return
end

local RescueHelo = RESCUEHELO:New(CarrierUnit, "Planeguard")
RescueHelo:SetRespawnOn()
RescueHelo:SetTakeoffHot()

-- Spawn the helo initially
RescueHelo:Start()

------------------------- code below for the activity monitoring
-- State variables for monitoring
local InactiveTime = 0
local Timeout = 120 -- seconds
local CheckInterval = 10 -- check every 10 seconds
local AltitudeLimit = 2000 * 0.3048 -- 2000 feet converted to meters (~609.6m)

local ClientSet = SET_CLIENT:New()
ClientSet:FilterCoalitions("blue")
-- ClientSet:FilterActive()
ClientSet:FilterStart()

-- Scheduler to monitor client presence in the CarrierOps zone below 2000 ft
TIMER:New(function()
  local clientInZoneBelow2k = false
 
     -- Iterate through active clients
    ClientSet:ForEachClient(function(client)
        if client then
            -- Get the underlying DCS unit wrapper from the client slot
            if client:IsAlive() and client:IsInZone(CarrierZone) then
                local alt = client:GetAltitude() -- Altitude MSL in meters
                if alt <= AltitudeLimit then
                    clientInZoneBelow2k = true
                    BASE:I("CarrierOps: Client detected below 2000ft in CarrierOps zone")
                end
            end
        end
    end)

    if clientInZoneBelow2k then
        -- Reset inactive timer when client is active in the zone
        InactiveTime = 0

        -- If the helo had previously RTB'd or stopped, restart/respawn it
        if RescueHelo:IsStopped() or RescueHelo:IsReturning() then
            BASE:I("CarrierOps: Client detected below 2000ft. Restarting/respawning RescueHelo.")
            RescueHelo:Start()
        end
    else
        -- Increment inactive time if no client is found in the zone below 2000 ft
        if RescueHelo:IsRunning() and not RescueHelo:IsReturning() then
            InactiveTime = InactiveTime + CheckInterval
            -- Trigger RTB if timeout is reached
            if InactiveTime >= Timeout then
                BASE:I("CarrierOps: No client detected below 2000ft for " .. Timeout .. " seconds. Sending RescueHelo to RTB.")
                RescueHelo:Stop()
                InactiveTime = 0
            end
        end
    end
end):Start(0, CheckInterval)