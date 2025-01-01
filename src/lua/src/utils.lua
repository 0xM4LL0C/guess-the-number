Utils = {}

---get user input
---@param prompt? string
---@return string
function Utils.input(prompt)
    if prompt then
        io.write(prompt)
    end

    return io.read()
end

return Utils
