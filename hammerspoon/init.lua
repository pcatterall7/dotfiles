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
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

--------------------------------------
----------- Countdown ----------------
--------------------------------------

countDown=hs.loadSpoon("CountDown")
countDown.defaultDuration = 25
countDown.menuBarAlwaysShow = true
countDown.warningFormat = "%02d minutes remaining"
countDown.menuBarIconActive = "⏰"
countDown.menuBarIconIdle = "⏲️"


--------------------------------------
-------- Recursive Keybindings -------
--------------------------------------
hs.loadSpoon("RecursiveBinder")
spoon.RecursiveBinder.escapeKey = {{}, 'escape'}  -- Press escape to abort
local singleKey = spoon.RecursiveBinder.singleKey

function openDirectory(path)
    local shell_command = "open " .. path
    hs.execute(shell_command)
end

if hs.host.localizedName() == 'ActionIQ-philipcatterall' then
    keyMap = {
        [singleKey('f', 'finder+')] = {
            [singleKey('a', 'applications')] = function() openDirectory('~/Applications') end,
            [singleKey('d', 'downloads')] = function() openDirectory('~/Downloads') end,
            [singleKey('t', 'tmp')] = function() openDirectory('~/tmp') end
        },
        [singleKey('b', 'bookmarks+')] = {
            [singleKey('g', 'github+')] = {
                [singleKey('a', 'aiq')] = function() hs.urlevent.openURL('https://www.github.com/ActionIQ/aiq') end,
                [singleKey('d', 'datascience')] = function() hs.urlevent.openURL('https://github.com/ActionIQ/datascience/tree/master/databricks-analytics-pipelines') end,
                [singleKey('s', 'sandbox')] = function() hs.urlevent.openURL('https://www.github.com/ActionIQ/sandbox/tree/master/user/phil') end
            },
            [singleKey('j', 'jira+')] = {
                [singleKey('e', 'dpe')] = function() hs.urlevent.openURL('https://actioniq.atlassian.net/jira/software/projects/DP/boards/242/backlog?epics=visible') end,
                [singleKey('d', 'design')] = function() hs.urlevent.openURL('https://actioniq.atlassian.net/jira/software/projects/PD/boards/237') end,
                [singleKey('t', 'docs')] = function() hs.urlevent.openURL('https://actioniq.atlassian.net/jira/software/projects/DOC/boards/214') end,
            }
        },
        [singleKey('t', 'timer+')] = {
            [singleKey('s', 'start')] = function() countDown:startFor(25) end,
            [singleKey('p', 'pause/resume')] = function() countDown:pauseOrResume() end,
            [singleKey('c', 'cancel')] = function() countDown:cancel() end
        },
        [singleKey('n', 'nightshift')] = function() hs.execute('shortcuts run "Toggle Night Shift"') end
    }
elseif hs.host.localizedName() == "Philip’s MacBook Air" then
    keyMap = {
        [singleKey('f', 'finder+')] = {
            [singleKey('a', 'applications')] = function() openDirectory('/Applications') end,
            [singleKey('d', 'downloads')] = function() openDirectory('~/Downloads') end,
            [singleKey('t', 'tmp')] = function() openDirectory('~/tmp') end
        },
        [singleKey('b', 'bookmarks+')] = {
            [singleKey('g', 'gmail')] = function() hs.urlevent.openURL('https://gmail.com') end,
            [singleKey('c', 'cal')] = function() hs.urlevent.openURL('https://calendar.google.com') end
        },
        [singleKey('t', 'timer+')] = {
            [singleKey('s', 'start')] = function() countDown:startFor(25) end,
            [singleKey('p', 'pause/resume')] = function() countDown:pauseOrResume() end,
            [singleKey('c', 'cancel')] = function() countDown:cancel() end
        },
        [singleKey('n', 'nightshift')] = function() hs.execute('shortcuts run "Toggle Night Shift"') end
    }
else
    keyMap = {}
    hs.alert.show('Host not recognized')
end

spoon.RecursiveBinder.helperFormat = {atScreenEdge=2, strokeColor={ white = 0, alpha = 2 }, textFont='SF Mono', textSize=14}
hs.hotkey.bind({'option'}, 'space', spoon.RecursiveBinder.recursiveBind(keyMap))

------------------------------------


