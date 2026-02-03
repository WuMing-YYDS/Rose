--Vex23SY公益(不加密)
-- 力量传奇 自动换服击杀 精简版
local VU=game:GetService("VirtualUser")
local P=game:GetService("Players")
local TS=game:GetService("TeleportService")
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local LP=P.LocalPlayer
local C=LP.Character or LP.CharacterAdded:Wait()
local H=C:WaitForChild("Humanoid")
local R=C:WaitForChild("HumanoidRootPart")
local CFG={K=Enum.KeyCode.F,T=true,H=30,D=100,A=true,I=0.5}

local function T()
    local S=game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    local R=S.data[math.random(1,#S.data)]
    if R and R.id~=game.JobId then TS:TeleportToPlaceInstance(game.PlaceId,R.id,LP) end
end

local function F()
    local N=nil local M=math.huge
    for _,p in pairs(P:GetPlayers())do
        if p~=LP and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health>0 then
            local r=p.Character:FindFirstChild("HumanoidRootPart")
            if r then local d=(R.Position-r.Position).Magnitude if d<M and d<=CFG.D then M=d N=p end end
        end
    end
    return N
end

local function A(T)
    if not T or not T.Character then return end
    local h=T.Character:FindFirstChild("Humanoid")
    local r=T.Character:FindFirstChild("HumanoidRootPart")
    if h and h.Health>0 and r then
        LP.PlayerCamera:SetSubject(r)
        VU:CaptureController()VU:ClickButton1(Vector2.new(0,0))
        UIS:PressKey(CFG.K)wait(CFG.I)UIS:ReleaseKey(CFG.K)
    end
end

H.HealthChanged:Connect(function(n)if CFG.T and n<=CFG.H then T()end end)
RS.RenderStepped:Connect(function()if LP and C and CFG.A then local t=F()if t then A(t)end end end)
while task.wait(30)do VU:CaptureController()VU:MoveMouse(Vector2.new(math.random(1,100),math.random(1,100)))end
warn("脚本加载成功")
