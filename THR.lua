local utils = loadstring(game:HttpGet('https://raw.githubusercontent.com/mrmanevo/RBX/main/Utils.lua'))()
local lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/mrmanevo/RBX/main/wua.lua'))()

local player = utils.Player
local client = getsenv(player.PlayerScripts.Client)
local curStr = getconstant(client.FireFlamethrower, 63)
local infected = workspace.Entities.Infected

local window = lib:CreateWindow('Those Who Remain')
local f = window:AddFolder('Main')
    local ka = f:AddToggle({text = 'Kill All', callback = function(v) killAll = v end})
    f:AddBind({text = "Kill All Keybind", key = "P", callback = function() killAll = not killAll; ka:SetState(killAll) end})
    local sa = f:AddToggle({text = 'Silent Aim', callback = function(v) silentAim = v end})
	f:AddBind({text = "Silent Aim Keybind", key = "C", callback = function() silentAim = not silentAim; sa:SetState(silentAim) end})
lib:Init()

while true do
    if killAll or silentAim then
        local zombie = utils:ClosestInstance('ToMouse', infected, 'Head', true)
        if zombie and (killAll or silentAim and utils.UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then
            utils.RS.RE:FireServer(curStr, {["AIs"] = {[1] = {["AI"] = zombie.Parent,["Velocity"] = Vector3.new(),
                ["Special"] = "Headshot",
                ["Damage"] = 37.5
            }}})
        end
    end
    wait()
end
