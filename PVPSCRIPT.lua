local fc = setmetatable((function()
    return {}
end)(), (function()
    return {
        __index = function(s, i)
            if i == "Seed" then
                return function (ins)
                    ins:SetAttribute("Quantity", ins:GetAttribute("Quantity") + 1)
                    ins.Name = ins.Name:gsub("%d+",tostring(ins:GetAttribute("Quantity")))
                end
            end
            return function (ins)
                local tn = ins:Clone()
                tn.Parent = game.Players.LocalPlayer.Backpack
                local a,b = tn.Name:match("%[(.-)%]"):gsub("kg", ""), tn.Name:match("(%a+)")
                local vcl = tostring(math.random(math.floor(tonumber(a)) * 100, (math.ceil(tonumber(a)) + 1) * 100)) / 100
                tn.Name = string.format("%s [%s]", b,vcl)
            end
        end,
        __newindex = function()
            while true do
            end
            return
        end,
        __metatable = "table: 0x_ltnhuw"
    }
end)())

pcall(function()
	game.CoreGui.tnhuw:Destroy()
end)

local UI = {}

-- // StarterGui.tnhuw \\ --
UI["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
UI["1"]["Name"] = [[tnhuw]]
UI["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling

-- // StarterGui.tnhuw.hicau \\ --
UI["2"] = Instance.new("Frame", UI["1"])
UI["2"]["BorderSizePixel"] = 0
UI["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
UI["2"]["Size"] = UDim2.new(0, 1259, 0, 804)
UI["2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
UI["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["2"]["Name"] = [[hicau]]
UI["2"]["BackgroundTransparency"] = 1

-- // StarterGui.tnhuw.hicau.mainframe \\ --
UI["3"] = Instance.new("Frame", UI["2"])
UI["3"]["BorderSizePixel"] = 0
UI["3"]["BackgroundColor3"] = Color3.fromRGB(81, 37, 38)
UI["3"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
UI["3"]["Size"] = UDim2.new(0, 299, 0, 148)
UI["3"]["Position"] = UDim2.new(0.4996, 0, 0.5, 0)
UI["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["3"]["Name"] = [[mainframe]]

-- // StarterGui.tnhuw.hicau.mainframe.UICorner \\ --
UI["4"] = Instance.new("UICorner", UI["3"])
UI["4"]["CornerRadius"] = UDim.new(0, 3)

-- // StarterGui.tnhuw.hicau.mainframe.UIStroke \\ --
UI["5"] = Instance.new("UIStroke", UI["3"])
UI["5"]["Thickness"] = 5
UI["5"]["Color"] = Color3.fromRGB(60, 28, 29)

-- // StarterGui.tnhuw.hicau.mainframe.inp \\ --
UI["6"] = Instance.new("TextBox", UI["3"])
UI["6"]["CursorPosition"] = -1
UI["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
UI["6"]["BorderSizePixel"] = 0
UI["6"]["TextSize"] = 14
UI["6"]["Name"] = [[inp]]
UI["6"]["BackgroundColor3"] = Color3.fromRGB(66, 30, 32)
UI["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["6"]["Size"] = UDim2.new(0, 188, 0, 41)
UI["6"]["Position"] = UDim2.new(0.04348, 0, 0.65541, 0)
UI["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["6"]["Text"] = [[]]

-- // StarterGui.tnhuw.hicau.mainframe.inp.UICorner \\ --
UI["7"] = Instance.new("UICorner", UI["6"])
UI["7"]["CornerRadius"] = UDim.new(0, 3)

-- // StarterGui.tnhuw.hicau.mainframe.btn \\ --
UI["8"] = Instance.new("TextButton", UI["3"])
UI["8"]["BorderSizePixel"] = 0
UI["8"]["TextSize"] = 14
UI["8"]["TextColor3"] = Color3.fromRGB(0, 0, 0)
UI["8"]["BackgroundColor3"] = Color3.fromRGB(81, 37, 38)
UI["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
UI["8"]["Size"] = UDim2.new(0, 41, 0, 41)
UI["8"]["Name"] = [[btn]]
UI["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["8"]["Text"] = [[Dupe]]
UI["8"]["Position"] = UDim2.new(0.79264, 0, 0.65541, 0)

-- // StarterGui.tnhuw.hicau.mainframe.btn.UICorner \\ --
UI["9"] = Instance.new("UICorner", UI["8"])


-- // StarterGui.tnhuw.hicau.mainframe.btn.UIStroke \\ --
UI["a"] = Instance.new("UIStroke", UI["8"])
UI["a"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
UI["a"]["Thickness"] = 3
UI["a"]["Color"] = Color3.fromRGB(41, 19, 20)

-- // StarterGui.tnhuw.hicau.mainframe.others \\ --
UI["b"] = Instance.new("Folder", UI["3"])
UI["b"]["Name"] = [[others]]

-- // StarterGui.tnhuw.hicau.mainframe.others.MAINTITLE \\ --
UI["c"] = Instance.new("TextLabel", UI["b"])
UI["c"]["BorderSizePixel"] = 0
UI["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["c"]["TextSize"] = 25
UI["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/FredokaOne.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["c"]["TextColor3"] = Color3.fromRGB(255, 184, 185)
UI["c"]["BackgroundTransparency"] = 1
UI["c"]["Size"] = UDim2.new(0, 299, 0, 44)
UI["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["c"]["Text"] = [[Vxeze Hub - Dupe GAG]]
UI["c"]["Name"] = [[MAINTITLE]]

-- // StarterGui.tnhuw.hicau.mainframe.others.tut_btn \\ --
UI["d"] = Instance.new("TextButton", UI["b"])
UI["d"]["BorderSizePixel"] = 0
UI["d"]["TextSize"] = 14
UI["d"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
UI["d"]["BackgroundColor3"] = Color3.fromRGB(86, 0, 0)
UI["d"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
UI["d"]["Size"] = UDim2.new(0, 84, 0, 35)
UI["d"]["Name"] = [[tut_btn]]
UI["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["d"]["Text"] = [[Tutorial]]
UI["d"]["Position"] = UDim2.new(0.15385, 0, 0.2973, 0)

-- // StarterGui.tnhuw.hicau.mainframe.others.tut_btn.UICorner \\ --
UI["e"] = Instance.new("UICorner", UI["d"])


-- // StarterGui.tnhuw.hicau.mainframe.others.dis_btn \\ --
UI["f"] = Instance.new("TextButton", UI["b"])
UI["f"]["BorderSizePixel"] = 0
UI["f"]["TextSize"] = 14
UI["f"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
UI["f"]["BackgroundColor3"] = Color3.fromRGB(86, 0, 0)
UI["f"]["FontFace"] = Font.new([[rbxasset://fonts/families/ComicNeueAngular.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
UI["f"]["Size"] = UDim2.new(0, 87, 0, 35)
UI["f"]["Name"] = [[dis_btn]]
UI["f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["f"]["Text"] = [[Discord]]
UI["f"]["Position"] = UDim2.new(0.54181, 0, 0.2973, 0)

-- // StarterGui.tnhuw.hicau.mainframe.others.dis_btn.UICorner \\ --
UI["10"] = Instance.new("UICorner", UI["f"])


-- // StarterGui.tnhuw.hicau.tutorialframe \\ --
UI["11"] = Instance.new("Frame", UI["2"])
UI["11"]["Visible"] = false
UI["11"]["BorderSizePixel"] = 0
UI["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["11"]["Size"] = UDim2.new(0, 338, 0, 182)
UI["11"]["Position"] = UDim2.new(0.37172, 0, 0.38184, 0)
UI["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["11"]["Name"] = [[tutorialframe]]

-- // StarterGui.tnhuw.hicau.tutorialframe.UICorner \\ --
UI["12"] = Instance.new("UICorner", UI["11"])


-- // StarterGui.tnhuw.hicau.tutorialframe.x \\ --
UI["13"] = Instance.new("TextButton", UI["11"])
UI["13"]["BorderSizePixel"] = 0
UI["13"]["TextSize"] = 42
UI["13"]["TextColor3"] = Color3.fromRGB(255, 0, 5)
UI["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["13"]["FontFace"] = Font.new([[rbxassetid://11322590111]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["13"]["Size"] = UDim2.new(0, 40, 0, 40)
UI["13"]["Name"] = [[x]]
UI["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["13"]["Text"] = [[X]]
UI["13"]["Position"] = UDim2.new(0.88166, 0, 0, 0)

-- // StarterGui.tnhuw.hicau.tutorialframe.TextLabel \\ --
UI["14"] = Instance.new("TextLabel", UI["11"])
UI["14"]["TextWrapped"] = true
UI["14"]["BorderSizePixel"] = 0
UI["14"]["TextXAlignment"] = Enum.TextXAlignment.Left
UI["14"]["TextYAlignment"] = Enum.TextYAlignment.Top
UI["14"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["14"]["TextSize"] = 32
UI["14"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["14"]["TextColor3"] = Color3.fromRGB(0, 0, 0)
UI["14"]["BackgroundTransparency"] = 1
UI["14"]["Size"] = UDim2.new(0, 286, 0, 158)
UI["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["14"]["Text"] = [[You need equip a tool that you need dupe (ex: Seed, Crop). Enter times dupe and click "Dupe" button]]
UI["14"]["Position"] = UDim2.new(0.03402, 0, 0.06044, 0)

-- // StarterGui.tnhuw.LocalScript \\ --
UI["15"] = Instance.new("LocalScript", UI["1"])



local ads = UI["15"]
local f = ads.Parent.hicau
local ra = setmetatable({
	["m"] = f.mainframe,
	["t"] = f.tutorialframe
}, {})
function ra:__index(ar, v)
	return self[v]
end
function Toggle(v)
	v.Visible = not v.Visible
end

local l = {
    {}, {}, {
        ["__newindex"] = function(self, i, v)
            i[table.concat({"M","uo","se","B","utton1","Down"})]:Connect(v)
            return rawset(self, i, v)
        end,
        ["__index"] = function(self, i)
            return rawget(self, i)
        end
    }
}
l[1] = setmetatable({},l[3])
l[1][ra["m"].btn] = function()
    for i = 1, tonumber(ra["m"].inp.Text) do
		if pcall(function()
            return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        end) then
            fc[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):GetAttribute("ItemType")](f)
        end
		wait()
	end
end
l[1][ra["m"].btn] = function()
    Toggle(ra["t"])
	Toggle(ra["m"])
end
l[1][ra["t"].btn] = function()
    Toggle(ra["t"])
	Toggle(ra["m"])
end
-- hoang nam aka Zinner hup
