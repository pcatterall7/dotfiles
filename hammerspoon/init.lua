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
------------- Countdown --------------
--------------------------------------

countDown=hs.loadSpoon("CountDown")
countDown.defaultDuration = 25
countDown.menuBarAlwaysShow = true
countDown.warningFormat = "%dh %dm minutes remaining"
countDown.menuBarIconActive = "⏰"
countDown.menuBarIconIdle = "⏲️"
countDown.barCanvasHeight = 0
-- countDown.barTransparency = 0.8
-- countDown.barFillColorPassed = hs.drawing.color.osx_black
-- countDown.barFillColorToPass = hs.drawing.color.x11.whitesmoke

--------------------------------------
-------- AIQ Customer Finder  --------
--------------------------------------
-- TODO: get this working
-- local query = hs.dialog.textPrompt("Customer", "Enter an ID or Name")

--------------------------------------
-------------- Snippets --------------
--------------------------------------

-- Function to create a hotkey that pastes content and preserves clipboard
function pasteSnippet(snippet)
    -- save current clipboard data
    tempClipboard = hs.pasteboard.uniquePasteboard()
    hs.pasteboard.writeAllData(tempClipboard, hs.pasteboard.readAllData(nil))

    -- load content into clipboard and paste
    hs.pasteboard.writeObjects(snippet)
    hs.eventtap.keyStroke({'cmd'}, 'v')

    -- recall clipboard data
    hs.pasteboard.writeAllData(nil, hs.pasteboard.readAllData(tempClipboard))
    hs.pasteboard.deletePasteboard(tempClipboard)
end

monday = os.date("%Y-%m-%d")
weeklyLogEntry = [[## Week of %s
### Log

Mon

Tue

Wed

Thu

Fri

### Recap

**What did I do last week?**

**Plans for next week**
]]
weeklyLogEntrySnippet = string.format(weeklyLogEntry, monday)

--------------------------------------
--------- Window Management  ---------
--------------------------------------

function focusApp()
    screen = hs.screen.mainScreen()
    fullFrame = screen:fullFrame()
    focusedWindow = hs.window.focusedWindow()

    allWindows = hs.window.allWindows()

    for _, w in ipairs(allWindows) do
        if w:id() ~= focusedWindow:id() and w:isVisible() then
            w:minimize()
        end
    end

    targetUnitSize = hs.geometry(0.2, 0.1, 0.6, 0.8)
    targetSize = targetUnitSize:fromUnitRect(fullFrame)
    focusedWindow:move(targetSize)
end

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

if hs.host.localizedName() == 'ActionIQ-philipcatterall' or hs.host.localizedName() == 'ActionIQ-phil' then
    keyMap = {
        [singleKey('f', 'finder+')] = {
            [singleKey('a', 'applications')] = function() openDirectory('/Applications') end,
            [singleKey('d', 'downloads')] = function() openDirectory('~/Downloads') end,
            [singleKey('t', 'tmp')] = function() openDirectory('~/tmp') end
        },
        [singleKey('c', 'chrome+')] = {
            [singleKey('g', 'github+')] = {
                [singleKey('a', 'aiq')] = function() hs.urlevent.openURL('https://www.github.com/ActionIQ/aiq') end,
                [singleKey('d', 'datascience')] = function() hs.urlevent.openURL('https://github.com/ActionIQ/datascience/tree/master/databricks-analytics-pipelines') end,
                [singleKey('s', 'sandbox')] = function() hs.urlevent.openURL('https://www.github.com/ActionIQ/sandbox/tree/master/user/phil') end
            },
            [singleKey('j', 'jira+')] = {
                [singleKey('d', 'dashboard')] = function() hs.urlevent.openURL('https://actioniq.atlassian.net/jira/dashboards/10188') end,
                [singleKey('e', 'dpe')] = function() hs.urlevent.openURL('https://actioniq.atlassian.net/jira/software/projects/DP/boards/242/backlog?epics=visible') end,
                [singleKey('m', 'design')] = function() hs.urlevent.openURL('https://actioniq.atlassian.net/jira/software/projects/PD/boards/237') end,
                [singleKey('j', 'docs')] = function() hs.urlevent.openURL('https://actioniq.atlassian.net/jira/software/projects/DOC/boards/214') end,
            }
        },
        [singleKey('t', 'timer+')] = {
            [singleKey('s', 'start')] = function() countDown:startFor(25) end,
            [singleKey('p', 'pause/resume')] = function() countDown:pauseOrResume() end,
            [singleKey('c', 'cancel')] = function() countDown:cancel() end
        },
        [singleKey('s', 'shortcuts+')] = {
            [singleKey('n', 'nightshift')] = function() hs.execute('shortcuts run "Toggle Night Shift"') end,
            [singleKey('r', 'make rich text')] = function() hs.execute('shortcuts run "Convert Markdown to Rich Text"') end
        },
        [singleKey('w', 'window')] = function() focusApp() end 
        -- [singleKey('s', 'snippettest')] = function() pasteSnippet(weeklyLogEntrySnippet) end
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

spoon.RecursiveBinder.helperFormat = {atScreenEdge=2, strokeColor={ white = 0, alpha = 2 }, textFont='Menlo', textSize=14}
hs.hotkey.bind({'option'}, 'space', spoon.RecursiveBinder.recursiveBind(keyMap))

------------------------------------


