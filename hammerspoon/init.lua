-- Hammerspoon config
--
-- Leader key: the real trigger (right-cmd + g) is remapped to F18 by
-- Karabiner-Elements — see karabiner/karabiner.json. Hammerspoon just listens
-- for F18 and opens a modal that hints the available sub-commands.
--
-- Helpers live under ./lib/:
--   lib/script.lua — runScript (with OK:/ERR: feedback for long-running calls)
--   lib/modal.lua  — build (nested leader modal)

local HOME = os.getenv("HOME")

hs.loadSpoon("Split")

local runScript = require("lib.script").runScript
local buildModal = require("lib.modal").build

-- Prompt for a customer name, then run the new-customer-note script with
-- feedback so the user knows whether the doc was actually created.
local function newCustomerNote()
    local button, name = hs.dialog.textPrompt(
        "New customer note",
        "Customer name:",
        "",
        "OK",
        "Cancel"
    )
    if button ~= "OK" then return end
    name = (name or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if name == "" then return end
    runScript(HOME .. "/bin/databricks/new-customer-note.sh", { name },
        { feedback = true, label = "customer-note" })
end

local leader = buildModal("leader", {
    { "b", "bookmarks — chrome bookmarks", function() runScript(HOME .. "/bin/databricks/chrome-bookmarks.py") end },
    { "s", "split     — split with window", function() spoon.Split.split() end },
    { "m", "meetings  ▸", {
        { "m", "picker  — today's meetings", function() runScript(HOME .. "/bin/databricks/meeting-picker.sh") end },
        { "r", "refresh — reload meetings", function()
            runScript(HOME .. "/bin/databricks/claude-morning/run.sh", nil,
                { feedback = true, label = "meetings" })
        end },
        { "n", "new     — customer note", newCustomerNote },
    } },
    -- { "o", "other     ▸", {
    --   { "p", "paste   — fix clipboard", function() runScript(HOME .. "/bin/fix-paste") end },
    -- } },
    { "r", "reload    — hammerspoon config", hs.reload },
})

hs.hotkey.bind({}, "f18", function()
    if leader.active then
        leader:exit()
    else
        leader:enter()
    end
end)

hs.alert.show("Hammerspoon loaded")
