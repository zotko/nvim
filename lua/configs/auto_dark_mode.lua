local theme_utils = require "nvchad.themes.utils"

local function apply_theme(name, background)
    -- Set background FIRST, then reload theme
    vim.api.nvim_set_option_value("background", background, {})

    if require("nvconfig").base46.theme ~= name then
        theme_utils.reload_theme(name)
    end
end

return {
    set_dark_mode = function()
        apply_theme("gruvbox", "dark")
    end,
    set_light_mode = function()
        apply_theme("one_light", "light")
    end,
    update_interval = 3000,
    fallback = "dark",
    sync_start = true, -- Synchronous first poll to prevent flash
}
