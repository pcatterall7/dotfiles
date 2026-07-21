-- Runs a shell script as an hs.task, with optional on-screen feedback for
-- long-running leader-invoked scripts. See runScript below.

local HOME = os.getenv("HOME")

-- Hammerspoon inherits launchd's minimal PATH, so scripts that shell out to
-- homebrew binaries (choose, jq, etc.) need a fuller PATH to find them.
local SCRIPT_PATH = "/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:"
    .. HOME .. "/bin"

-- Feedback alerts anchor to the bottom edge so they don't collide with the
-- notch / menu bar on notched MacBooks.
local feedbackAlertStyle = {
    textFont = "JetBrains Mono",
    textSize = 14,
    radius = 8,
    padding = 14,
    atScreenEdge = 2,
}

-- Last non-empty line of stdout, trimmed. Scripts that opt into feedback use
-- this to carry a verdict back to Hammerspoon as `OK: …` or `ERR: …`.
local function lastLine(s)
    local last
    for line in (s or ""):gmatch("[^\r\n]+") do
        if line:match("%S") then last = line end
    end
    return last and (last:gsub("^%s+", ""):gsub("%s+$", "")) or nil
end

local M = {}

-- Run a shell script path with optional args.
--
-- opts.feedback — when true, show a persistent "{label}: running…" alert for
-- the duration of the script and a completion alert on exit. The completion
-- alert parses the last stdout line for an `OK:` or `ERR:` prefix (so scripts
-- wrapping non-deterministic work, like LLM calls, can signal success
-- independently of shell exit code).
-- opts.label    — short human label for the alerts. Defaults to the basename.
function M.runScript(path, args, opts)
    opts = opts or {}
    local parts = { string.format("%q", path) }
    for _, a in ipairs(args or {}) do
        table.insert(parts, string.format("%q", a))
    end
    local cmd = table.concat(parts, " ")

    local label = opts.label or path:match("([^/]+)$") or path
    local runningAlertId
    if opts.feedback then
        runningAlertId = hs.alert.show(label .. ": running…", feedbackAlertStyle, hs.screen.mainScreen(), true)
    end

    local task = hs.task.new("/bin/sh", function(exitCode, stdOut, stdErr)
        if runningAlertId then hs.alert.closeSpecific(runningAlertId) end

        if opts.feedback then
            local last = lastLine(stdOut)
            local okMsg = last and last:match("^OK:%s*(.*)$")
            local errMsg = last and last:match("^ERR:%s*(.*)$")
            local text
            if okMsg then
                text = label .. ": " .. okMsg
            elseif errMsg then
                text = label .. ": " .. errMsg
            elseif exitCode == 0 then
                text = label .. ": " .. (last or "done")
            else
                text = label .. ": failed (exit " .. tostring(exitCode) .. ")"
            end
            hs.alert.show(text, feedbackAlertStyle, hs.screen.mainScreen(), 4)
        end

        -- Fallback for scripts that didn't opt into feedback: surface failures
        -- via Notification Center so they aren't silent.
        if not opts.feedback and exitCode ~= 0 then
            hs.notify.show("Script failed", path, (stdErr or ""):sub(1, 300))
        end
    end, { "-c", cmd })

    task:setEnvironment({
        PATH = SCRIPT_PATH,
        HOME = HOME,
        SHELL = os.getenv("SHELL") or "/bin/zsh",
        INVOKED_BY = "hammerspoon",
    })
    task:start()
end

return M
