-- Leader modal with nested submenus. Each entry is { key, label, action }
-- where action is either a function (invoked on key press) or a list of
-- child entries (opens a nested modal).

local alertStyle = {
    textFont = "JetBrains Mono",
    textSize = 14,
    radius = 8,
    padding = 14,
}

local M = {}

local function buildModal(title, entries)
    local modal = hs.hotkey.modal.new()
    local alertId

    local hintLines = { title }
    for _, e in ipairs(entries) do
        table.insert(hintLines, string.format("  %s  %s", e[1], e[2]))
    end
    table.insert(hintLines, "  esc  cancel")
    local hint = table.concat(hintLines, "\n")

    modal.active = false

    function modal:entered()
        self.active = true
        alertId = hs.alert.show(hint, alertStyle, hs.screen.mainScreen(), true)
    end

    function modal:exited()
        self.active = false
        if alertId then
            hs.alert.closeSpecific(alertId)
            alertId = nil
        end
    end

    for _, e in ipairs(entries) do
        local key, _, action = e[1], e[2], e[3]
        if type(action) == "function" then
            modal:bind('', key, function()
                modal:exit()
                action()
            end)
        else
            local submenu = buildModal(e[2], action)
            modal:bind('', key, function()
                modal:exit()
                submenu:enter()
            end)
        end
    end

    modal:bind('', 'escape', function() modal:exit() end)

    return modal
end

M.build = buildModal

return M
