--- === Split ===
--- Vendored from https://github.com/evantravers/Split.spoon
--- Pinned to commit 0d7c36cd8c0cad20151759586937e0a03f35c018

local m = {
  name = "Split",
  version = "1.1",
  author = "Evan Travers <evantravers@gmail.com>",
  license = "MIT <https://opensource.org/licenses/MIT>",
  homepage = "https://github.com/evantravers/split.spoon",
}

--- Split:split() -> table
--- Method
--- Presents an hs.chooser to pick a window to split your monitor with
m.split = function()
  local windows = hs.fnutils.map(hs.window.orderedWindows(), function(win)
    if win ~= hs.window.focusedWindow() then
      local option = {
        text = win:title(),
        subText = win:application():title(),
        id = win:id()
      }

      if win:application():bundleID() then
        option["image"] = hs.image.imageFromAppBundle(win:application():bundleID())
      end

      return option
    end
  end)

  -- Local patch: 6px gap between windows and 6px margin from screen edges.
  local padding = 6

  local chooser = hs.chooser.new(function(choice)
    if choice ~= nil then
      local focused = hs.window.focusedWindow()
      local toRead  = hs.window.find(choice.id)
      local f = focused:screen():frame()
      local leftRatio = hs.eventtap.checkKeyboardModifiers()['alt'] and 0.7 or 0.5
      local innerW = f.w - 3 * padding
      local leftW  = math.floor(innerW * leftRatio)
      local rightW = innerW - leftW
      local y, h = f.y + padding, f.h - 2 * padding
      local leftFrame  = { x = f.x + padding, y = y, w = leftW, h = h }
      local rightFrame = { x = f.x + padding + leftW + padding, y = y, w = rightW, h = h }
      hs.window.animationDuration = 0
      focused:setFrame(leftFrame)
      toRead:setFrame(rightFrame)
      toRead:raise()
      focused:focus()
    end
  end)

  chooser
    :placeholderText("Choose window for 50/50 split. Hold ⎇ for 70/30.")
    :searchSubText(true)
    :choices(windows)
    :show()
end

function m:bindHotKeys(mapping)
  local spec = {
    split = hs.fnutils.partial(self.split, self)
  }
  hs.spoons.bindHotkeysToSpec(spec, mapping)

  return self
end


return m
