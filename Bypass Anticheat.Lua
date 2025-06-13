-- Lấy đúng RemoteEvent
local sonarRemote = game:GetService("ReplicatedStorage")
    :WaitForChild("References")
    :WaitForChild("Comm")
    :WaitForChild("Events")
    :WaitForChild("Sonar")

-- Hook __namecall
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()

    -- So khớp object cụ thể và phương thức gọi
    if method == "FireServer" and self == sonarRemote then
        local mode = "block" -- hoặc "log"

        if mode == "block" then
            warn("[Bypass] Đã chặn Sonar:FireServer với dữ liệu:", ...)
            return nil
        elseif mode == "log" then
            warn("[Bypass-Log] Sonar:FireServer được gọi với:", ...)
            -- Cho phép gọi tiếp
        end
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)
