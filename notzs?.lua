    local zsAiming = loadstring(game:HttpGet("https://pastebin.com/raw/YmUFTisy", true))()
                            zsAiming.TeamCheck(false)
                             
                            
                            local Workspace = game:GetService("Workspace")
                            local Players = game:GetService("Players")
                            local RunService = game:GetService("RunService")
                            local UserInputService = game:GetService("UserInputService")
                            
                            
                            local LocalPlayer = Players.LocalPlayer
                            local Mouse = LocalPlayer:GetMouse()
                            local CurrentCamera = Workspace.CurrentCamera
                            
                            local zsSettings = {
                                SilentAim = true,
                                AimLock = false,
                                Prediction = 0.14,
                                AimLockKeybind = Enum.KeyCode.Q
                            }
                            getgenv().zsSettings = zsSettings
                            
                            
                            function zsAiming.Check()
                            -------------
                                if not (zsAiming.Enabled == true and zsAiming.Selected ~= LocalPlayer and zsAiming.SelectedPart ~= nil) then
                                    return false
                                end
                            
                                local Character = zsAiming.Character(zsAiming.Selected)
                                local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
                                local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
                            
                                if (KOd or Grabbed) then
                                    return false
                                end
                            
                              
                                return true
                            end
                            
                     
                            local __index
                            __index = hookmetamethod(game, "__index", function(t, k)
                                if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and zsAiming.Check()) then
                                    local SelectedPart = zsAiming.SelectedPart
                            
                                    if (zsSettings.SilentAim and (k == "Hit" or k == "Target")) then
                                        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * zsSettings.Prediction)
                            
                                        return (k == "Hit" and Hit or SelectedPart)
                                    end
                                end
                            
                                return __index(t, k)
                            end)
                            
                            RunService:BindToRenderStep("AimLock", 0, function()
                                if (zsSettings.AimLock and zsAiming.Check() and UserInputService:IsKeyDown(zsSettings.AimLockKeybind)) then
                                    local SelectedPart = zsAiming.SelectedPart
                            
                                    local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * zsSettings.Prediction)
                            
                                    CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, Hit.Position)
                                end
                                end)
