local pxpService = game:GetService("ProximityPromptService")
local tweenService = game:GetService("TweenService")
-- get required services

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
-- get player and character

pxpService.PromptShown:Connect(function(px)
	if px.Name == "doorPrompt" then
      -- check if the prompt is a doorPrompt, useful if there are multiple proximityprompts in the game
		for i,v in ipairs(px.Parent:GetChildren()) do
			if v.ClassName == "SurfaceGui" and px.Enabled then
				-- checking for enabled for a smoother tween
				tweenService:Create(v:WaitForChild("Primary"):WaitForChild("KeyCodeText"),TweenInfo.new(0.3),{TextTransparency = 0}):Play()
				tweenService:Create(v:WaitForChild("Primary"):FindFirstChildWhichIsA("UIStroke"),TweenInfo.new(0.3),{Transparency = 0}):Play()
				-- tween the text and outline transparency to 0
				v.Parent:WaitForChild("Beam").Attachment1 = char:WaitForChild("Torso").BodyFrontAttachment
				tweenService:Create(v.Parent:WaitForChild("Beam"):WaitForChild("Value"),TweenInfo.new(0.3),{Value = 0}):Play()
				-- attach the beam to the torso, and tween the value inside of the beam to 0
				v.Parent:WaitForChild("Beam"):WaitForChild("Value").Changed:Connect(function(val)
					v.Parent:WaitForChild("Beam").Transparency = NumberSequence.new(val)
				end)
        -- modify the NumberSequence of the beam's property to match the value
			end
		end
	end
end)

pxpService.PromptHidden:Connect(function(px)
	if px.Name == "doorPrompt" then
		for i,v in ipairs(px.Parent:GetChildren()) do
			if v.ClassName == "SurfaceGui" then

				tweenService:Create(v:WaitForChild("Primary"):WaitForChild("KeyCodeText"),TweenInfo.new(0.3),{TextTransparency =1}):Play()
				tweenService:Create(v:WaitForChild("Primary"):FindFirstChildWhichIsA("UIStroke"),TweenInfo.new(0.3),{Transparency = 1}):Play()
        -- tween text and stroke to 1
				v.Parent:WaitForChild("Beam").Attachment1 = nil
				tweenService:Create(v.Parent:WaitForChild("Beam"):WaitForChild("Value"),TweenInfo.new(0.3),{Value = 1}):Play()
        -- de-attach beam from torso and tween to 1
				v.Parent:WaitForChild("Beam"):WaitForChild("Value").Changed:Connect(function(val)
					v.Parent:WaitForChild("Beam").Transparency = NumberSequence.new(val)
				end)

			end
		end
	end
end)

pxpService.PromptButtonHoldBegan:Connect(function(px)
	if px.Name == "doorPrompt" then
		for i, v in ipairs(px.Parent:GetChildren()) do
			if v.ClassName == "SurfaceGui" then
				local fillTween = tweenService:Create(v:WaitForChild("Primary"):WaitForChild("FillFrame"),TweenInfo.new(px.HoldDuration),{Size = UDim2.fromScale(1,1)})
				fillTween:Play()
        -- start increasing the size of the Frame, filling up the box
				
				pxpService.PromptButtonHoldEnded:Connect(function(px)
					fillTween:Cancel()
				-- cancel tween if button is let go
					tweenService:Create(v:WaitForChild("Primary"):WaitForChild("FillFrame"),TweenInfo.new(0.2),{Size = UDim2.fromScale(1,0)}):Play()
        -- tween the part's size back down to nought on the y axis
				end)
			end
		end
	end
end)
