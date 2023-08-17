local pxpService = game:GetService("ProximityPromptService")
local tweenService = game:GetService("TweenService")
-- get required services

pxpService.PromptTriggered:Connect(function(px,trig)
	if px.Name == "doorPrompt" then
		local hinge = px.Parent.Parent:WaitForChild("Frame"):WaitForChild("Hinge")
    -- put the hinge into a variable for easier access
		
		if hinge:WaitForChild("status").Value == false then
      -- execute if value is false, aka door is closed
			tweenService:Create(hinge,TweenInfo.new(2,Enum.EasingStyle.Back),{CFrame = hinge.CFrame * CFrame.Angles(0,90,0)}):Play()
			-- opening tween, using EasingStyle.Back for a more natural look, can be changed.
			hinge:WaitForChild("status").Value = true
      -- setting a value inside the hinge to true to show its open
		else
			tweenService:Create(hinge,TweenInfo.new(2,Enum.EasingStyle.Back),{CFrame = hinge.CFrame * CFrame.Angles(0,-90,0)}):Play()
      -- closing tween
			hinge:WaitForChild("status").Value = false
      -- setting value to false to show its closed
		end
		
		px.Enabled = false
    -- disabling prompt so it cant be spammed
		wait(2)
    -- waiting
		px.Enabled = true
    -- enabling the prompt so it can be used againa
      
	end
end)
