local function GetArrayIndexStart(ui, arrayName)
    local i = 0
    while ui:GetValue(arrayName, nil, i) ~= nil do
        i = i + 1
    end
    return i
end

local raceTalents = {["Lizard_Persuasion"] = {94, "ha4af67a7g7112g4e66gbaedg6bf024feb097"},
                    ["Elf_Lore"]           = {89, "hcfd646bdg491dg4d9cgaf1ag2ca5f4421f7b"}, 
                    ["Dwarf_Sneaking"]     = {92, "h429e53b9ge574g4c77gbc1ag2cfd9844252f"}, 
                    ["Human_Civil"]        = {88, "h6c44d6c0g4603g429ag9f5bgc4ba0460fdec"}, 
                    ["Lizard_Resistance"]  = {93, "h7b9a0d2egff87g42afgbec4g6c01c4303401"}, 
                    ["Elf_CorpseEating"]   = {90, "h8fcf368eg0abeg4314gacdcgb495473a9ade"}, 
                    ["Dwarf_Sturdy"]       = {91, "h477b8976gfac3g4cdag954bg5617876c6ef7"}, 
                    ["Human_Inventive"]    = {87, "h2646745cgf1b5g44a2gaf6ageef8ee73a923"}}

local function FixRaceTalents(ui, call, ...)
    local charHandle = ui:GetPlayerHandle()
    local stats = Ext.GetCharacter(charHandle).Stats

    local j = GetArrayIndexStart(ui, "talent_array")
    local k = 0

    for talent, info in pairs(raceTalents) do

        if stats["TALENT_" .. talent] then
            
            local str = Ext.GetTranslatedString(info[2], talent)

            ui:SetValue("talent_array", str, j + 3*k)
            ui:SetValue("talent_array", info[1], j + 1 + 3*k)
            ui:SetValue("talent_array", 0, j + 2 + 3*k)

            k = k + 1
        end

    end
end

local function SessionLoaded()
    local ui = Ext.GetBuiltinUI("Public/Game/GUI/characterSheet.swf")
    Ext.RegisterUIInvokeListener(ui, "updateArraySystem", FixRaceTalents)
end

Ext.RegisterListener("SessionLoaded", SessionLoaded)