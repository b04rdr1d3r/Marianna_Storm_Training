local PatrolZone1 = ZONE:New("AA1")

SPAWN:New("Aggressor F1")
  :OnSpawnGroup(
    function(Group)

      local CapPatrol = AI_CAP_ZONE:New(
        PatrolZone1,
        5000,     -- min alt
        15000,    -- max alt
        350,      -- min speed
        500       -- max speed
      )

      CapPatrol:SetControllable(Group)
      CapPatrol:Start()

    end
  )
  :SpawnInZone(PatrolZone1, true)

local PatrolZone2 = ZONE:New("AA2")

SPAWN:New("Aggressor F1")
  :OnSpawnGroup(
    function(Group)

      local CapPatrol = AI_CAP_ZONE:New(
        PatrolZone2,
        5000,     -- min alt
        15000,    -- max alt
        350,      -- min speed
        500       -- max speed
      )

      CapPatrol:SetControllable(Group)
      CapPatrol:Start()

    end
  )
  :SpawnInZone(PatrolZone2, true)