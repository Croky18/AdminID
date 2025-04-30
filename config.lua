Config = {}

Config.BotToken = "JOUW_BOT_TOKEN" -- Bot Token [DEEL JE TOKEN NIET]
Config.GuildId = "JOUW_DISCORD_GUILD_ID" -- Discord ID

Config.TextOptions = {
    Font = 0, --Letter type van 0 = standaart 4 = GTA Type [Werk alleen 0/2/4]
    Scale = 0.60,  -- De grote van je latter type
    Color = { r = 60, g = 179, b = 113, a = 215 }, -- Letter type clore 
    Background = { r = 0, g = 0, b = 0, a = 0 } -- Background coler [0, 0, 0, 0,] staat hij uit
}

Config.RoleIDs = {
    ["🙋‍♂️ BETA Tester"] = "DISCORD_ROLE_ID",
    ["🙋‍♂️ Burger"] = "DISCORD_ROLE_ID",
    -- Voeg meer rollen en hun Discord Rol-ID's hier in
}

Config.RolePriority = {  --- ZORG ER VOOR DAT DE ROLLEN van hoogste naar laagste word gezet zo als in je discord
    "👑 Owner",
    "👑 Bestuur",
-- Voeg meer rollen toe in volgorde van hoogste naar laagste prioriteit
}

Config.AdminRoleId = "DISCORD_ADMIN_ROLE_ID" -- 🔰 Staff rol ID dat discord rol zorg dat de persoon met die rol kan de command gebruiken
Config.OnlyAdminsCheckAllRoles = true