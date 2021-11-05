local Utility = {
    Player = game.Players.LocalPlayer,
    Cam = workspace.CurrentCamera,
    RS = game:GetService('ReplicatedStorage'),
    TS = game:GetService('TweenService'),
    UIS = game:GetService('UserInputService'),
    PFS = game:GetService('PathfindingService')
}

function Utility:ReturnRoot()
    local Char = self.Player.Character or self.Player.CharacterAdded:wait()
    return Char:WaitForChild('HumanoidRootPart')
end

function Utility:Tween(Target, Speed)
    local Tween = self.TS:Create(self:ReturnRoot(), 
        TweenInfo.new(self.Player:DistanceFromCharacter(Target.Position)/(Speed*100), Enum.EasingStyle.Linear),  
        {CFrame = Target.CFrame})
    Tween:Play()
    Tween.completed:wait()
end

function Utility:ClosestInstance(Type, Path, PartName, OnScreen, WithinDistance) -- Types are ToCharacter and ToMouse
    local Closest, Distance, NewDistance, Visible = nil, WithinDistance or math.huge, 0, false
    for _,v in next, Path:GetChildren() do
        v = (v.Name == PartName and v) or (v:FindFirstChild(PartName) and v[PartName]) or Path == game.Players and (v.Character:FindFirstChild(PartName) and v.Character[PartName]) or nil
        if v and not v:GetFullName():match(self.Player.Name) then
            local Viewport, Vis = self.Cam:WorldToViewportPoint(v.Position); Visible = Vis
            if Type == 'ToCharacter' then
                NewDistance = self.Player:DistanceFromCharacter(v.Position)
            else
                local Mouse = self.Player:GetMouse()
                NewDistance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Viewport.X, Viewport.Y)).magnitude 
            end
            --or not OnScreen 
            if NewDistance < Distance and (OnScreen and Visible) then 
                Distance = NewDistance; Closest = v
            end
        end
    end
    return Closest
end

return Utility
