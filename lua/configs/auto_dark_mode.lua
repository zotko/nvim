local theme_utils = require "nvchad.themes.utils"

local function apply_theme(name, background)
    if require("nvconfig").base46.theme == name then
        vim.api.nvim_set_option_value("background", background, {})
        return
    end

    theme_utils.reload_theme(name)
    vim.api.nvim_set_option_value("background", background, {})
end

return {
    set_dark_mode = function()
        apply_theme("gruvbox", "dark")
    end,
    set_light_mode = function()
        apply_theme("gruvbox_light", "light")
    end,
    update_interval = 3000,
    fallback = "dark",
}
