function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

--------------------------------------
-- Recursive Keybindings            --
--------------------------------------
hs.loadSpoon("RecursiveBinder")
spoon.RecursiveBinder.escapeKey = {{}, 'escape'}  -- Press escape to abort
local singleKey = spoon.RecursiveBinder.singleKey

function openDirectory(path)
    local shell_command = "open " .. path
    hs.execute(shell_command)
end

local keyMap = {
    [singleKey('f', 'finder+')] = {
        [singleKey('a', 'applications')] = function() openDirectory('~/Applications') end,
        [singleKey('d', 'downloads')] = function() openDirectory('~/Downloads') end,
        [singleKey('t', 'tmp')] = function() openDirectory('~/tmp') end

    }
}

hs.hotkey.bind({'option'}, 'space', spoon.RecursiveBinder.recursiveBind(keyMap))

