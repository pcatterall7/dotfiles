-- Hammerspoon config
--
-- Right-cmd acts as "hyper". We track right-cmd via flagsChanged and intercept
-- the next keyDown ourselves, swallowing it so cmd-<key> isn't also sent to the
-- focused app.
--
-- Right-cmd + G is a Vim/Emacs-style leader: it enters a secondary modal that
-- lists sub-commands. Press one of the listed keys to run a command; escape to
-- cancel.

local rightCmdDown = false
local hyperBindings = {}

local function bindHyper(key, fn)
  hyperBindings[hs.keycodes.map[key]] = fn
end

local flagsWatcher = hs.eventtap.new(
  { hs.eventtap.event.types.flagsChanged },
  function(event)
    -- keyCode 54 = right command
    if event:getKeyCode() == 54 then
      rightCmdDown = event:getFlags().cmd == true
    end
    return false
  end
)
flagsWatcher:start()

local keyWatcher = hs.eventtap.new(
  { hs.eventtap.event.types.keyDown },
  function(event)
    if rightCmdDown then
      local fn = hyperBindings[event:getKeyCode()]
      if fn then
        fn()
        return true -- swallow; don't let cmd-<key> reach the app
      end
    end
    return false
  end
)
keyWatcher:start()

-- ---------------------------------------------------------------------------
-- Leader modal (hyper + G)
-- ---------------------------------------------------------------------------

local leader = hs.hotkey.modal.new()
local leaderAlertId = nil

local leaderActions = {} -- { {key, label, fn}, ... }

local function registerLeader(key, label, fn)
  table.insert(leaderActions, { key = key, label = label, fn = fn })
  leader:bind('', key, function()
    leader:exit()
    fn()
  end)
end

local function leaderHint()
  local lines = { "-- leader --" }
  for _, a in ipairs(leaderActions) do
    table.insert(lines, string.format("  %s  %s", a.key, a.label))
  end
  table.insert(lines, "  esc  cancel")
  return table.concat(lines, "\n")
end

local leaderAlertStyle = {
  textFont = "JetBrains Mono",
  textSize = 14,
  radius = 8,
  padding = 14,
}

function leader:entered()
  leaderAlertId = hs.alert.show(leaderHint(), leaderAlertStyle, hs.screen.mainScreen(), true)
end

function leader:exited()
  if leaderAlertId then
    hs.alert.closeSpecific(leaderAlertId)
    leaderAlertId = nil
  end
end

leader:bind('', 'escape', function() leader:exit() end)

-- ---------------------------------------------------------------------------
-- Leader actions
-- ---------------------------------------------------------------------------

-- App switcher: chooser of running GUI apps.
local function showAppChooser()
  local choices = {}
  for _, app in ipairs(hs.application.runningApplications()) do
    if app:kind() == 1 and app:bundleID() then
      table.insert(choices, {
        text     = app:name(),
        subText  = app:bundleID(),
        bundleID = app:bundleID(),
        image    = hs.image.imageFromAppBundle(app:bundleID()),
      })
    end
  end
  table.sort(choices, function(a, b) return a.text:lower() < b.text:lower() end)

  hs.chooser.new(function(choice)
    if choice then hs.application.launchOrFocusByBundleID(choice.bundleID) end
  end)
    :choices(choices)
    :searchSubText(true)
    :show()
end

-- Split-screen: pick another window and 50/50 it with the current window.
-- Hold option while selecting for a 70/30 split.
local function showSplitChooser()
  local focused = hs.window.focusedWindow()
  if not focused then
    hs.alert.show("No focused window")
    return
  end

  local choices = {}
  for _, win in ipairs(hs.window.filter.new():getWindows()) do
    if win ~= focused and win:isStandard() and win:title() ~= "" then
      table.insert(choices, {
        text    = win:title(),
        subText = win:application():title(),
        image   = hs.image.imageFromAppBundle(win:application():bundleID() or ""),
        id      = win:id(),
      })
    end
  end

  hs.chooser.new(function(choice)
    if not choice then return end
    local other = hs.window.find(choice.id)
    if not other then return end
    local screen = focused:screen()

    local leftUnit, rightUnit = hs.layout.left50, hs.layout.right50
    if hs.eventtap.checkKeyboardModifiers().alt then
      leftUnit, rightUnit = hs.layout.left70, hs.layout.right30
    end

    hs.window.animationDuration = 0
    hs.layout.apply({
      { nil, focused, screen, leftUnit,  0, 0 },
      { nil, other,   screen, rightUnit, 0, 0 },
    })
    other:raise()
  end)
    :placeholderText("Split with which window? (hold ⎇ for 70/30)")
    :searchSubText(true)
    :choices(choices)
    :show()
end

-- Bin scripts: chooser over ~/bin, runs the selected script in a terminal task.
local function showBinChooser()
  local binDir = os.getenv("HOME") .. "/bin"
  local choices = {}
  for file in hs.fs.dir(binDir) do
    if file ~= "." and file ~= ".." then
      local path = binDir .. "/" .. file
      local attrs = hs.fs.attributes(path)
      if attrs and attrs.mode == "file" then
        table.insert(choices, { text = file, subText = path, path = path })
      end
    end
  end
  table.sort(choices, function(a, b) return a.text:lower() < b.text:lower() end)

  hs.chooser.new(function(choice)
    if not choice then return end
    hs.task.new("/bin/sh", function(exitCode, stdOut, stdErr)
      if exitCode ~= 0 then
        hs.notify.show("Script failed: " .. choice.text, "", stdErr or "")
      elseif stdOut and stdOut ~= "" then
        hs.notify.show("Ran " .. choice.text, "", stdOut:sub(1, 200))
      end
    end, { "-c", choice.path }):start()
  end)
    :placeholderText("Run which script from ~/bin?")
    :searchSubText(true)
    :choices(choices)
    :show()
end

registerLeader('a', 'apps — switch to running app',    showAppChooser)
registerLeader('s', 'split — split current with...',   showSplitChooser)
registerLeader('b', 'bin   — run a script from ~/bin', showBinChooser)

-- ---------------------------------------------------------------------------
-- Top-level hyper bindings
-- ---------------------------------------------------------------------------

bindHyper('g', function() leader:enter() end)
bindHyper('r', function() hs.reload() end)

hs.alert.show("Hammerspoon loaded")
