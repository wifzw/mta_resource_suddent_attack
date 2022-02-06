local glitches = {"quickreload", "fastmove", "fastfire", 
    "crouchbug", "highcloserangedamage", "hitanim",
    "fastsprint", "baddrivebyhitbox", 
    "quickstand", "kickoutofvehicle_onmodelreplace"
}

function enableGlitches()
   for _, glitch in ipairs(glitches) do
      setGlitchEnabled(glitch, true)
   end 
end

addEventHandler("onResourceStart", resourceRoot, enableGlitches)