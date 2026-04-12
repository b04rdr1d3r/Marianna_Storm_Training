fox=FOX:New()

-- Add training zones.
fox:AddSafeZone(ZONE:New("Aggro"))
fox:AddSafeZone(ZONE:New("Aggro2"))

-- Start missile trainer.
fox:Start()