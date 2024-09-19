local http = require("socket.http")
local ltn12 = require("ltn12")

function encode_url(str)
    return string.gsub(str, "([^%w])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
end

function dump(table)
    for k, v in pairs(table) do
        print(k .. ": " .. v)
    end
end

local baseUrl = "https://is.gd/create.php"
local longUrl = "https://www.hammerspoon.org/docs/index.html"
local encodedUrl = encode_url(longUrl)
local request_url = string.format("https://is.gd/create.php?format=simple&url=%s", longUrl)

local response = {}
http.request{
    url = request_url,
    method = "GET",
    sink = ltn12.sink.table(response)
}

dump(response)
