local sonarRemote = game:GetService("ReplicatedStorage")
    :WaitForChild("References")
    :WaitForChild("Comm")
    :WaitForChild("Events")
    :WaitForChild("Sonar")

local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()

    if method == "FireServer" and self == sonarRemote then
        local mode = "block" -- hoặc "log"

        if mode == "block" then
            warn("[Bypass] Đã chặn Sonar:FireServer với dữ liệu:", ...)
            return nil
        elseif mode == "log" then
            warn("[Bypass-Log] Sonar:FireServer được gọi với:", ...)
        end
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)
