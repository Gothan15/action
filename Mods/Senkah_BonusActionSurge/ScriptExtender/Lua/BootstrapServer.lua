local function GetMembersInSquadAndCamp()
    local membersInSquadAndCamp = {}
    local players = Osi.DB_Players:Get(nil)
    for _, player in pairs(players) do
        table.insert(membersInSquadAndCamp, player[1])
    end
    local origins = Osi.DB_Origins:Get(nil)
    for _, origin in pairs(origins) do
        table.insert(membersInSquadAndCamp, origin[1])
    end
    local summons = Osi.DB_PlayerSummons:Get(nil)
    for _, summon in pairs(summons) do
        table.insert(membersInSquadAndCamp, summon[1])
    end
    -- Remove duplicates
    local seen = {}
    local i = 1
    while i <= #membersInSquadAndCamp do
        if seen[membersInSquadAndCamp[i]] then
            table.remove(membersInSquadAndCamp, i)
        else
            seen[membersInSquadAndCamp[i]] = true
            i = i + 1
        end
    end
    return membersInSquadAndCamp
end

Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level, isEditorMode)
    local membersInSquadAndCamp = GetMembersInSquadAndCamp()
    for _, k in pairs(membersInSquadAndCamp) do
        Osi.AddSpell(k, "Senkah_Shout_BonusActionSurge", 1, 1)
    end
end)

Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function(character)
    Osi.AddSpell(character, "Senkah_Shout_BonusActionSurge", 1, 1)
end)