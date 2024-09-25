local json = require("cjson")

-- Function to read the contents of a file
local function read_file(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local content = file:read("*all")
    file:close()
    return content
end

local function print_customer_info(customer_id, customer_name)
    print(string.format("%d\t%s", customer_id, customer_name))
end

local home = os.getenv("HOME")
local file_path = home .. "/aiq-misc/scripts/customers.json"
local content = read_file(file_path)
if not content then
    print("Error: Unable to read the file")
    os.exit(1)
end

local data = json.decode(content)
local arg = arg[1]
for _, customer in ipairs(data.success) do
    if not arg or string.find(customer.customerId, arg) or string.find(customer.customerName, arg) then
        print_customer_info(customer.customerId, customer.customerName)
    end
end
