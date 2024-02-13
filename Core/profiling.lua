local _, mUI  = ...
local data    = {}
local enabled = false

function mUI:EnableProfiling()
	enabled = true
end

function mUI:DisableProfiling()
	enabled = false
end

function mUI:ProfilingResults()
	if not enabled then return end
	SendSystemMessage("<<<")
	for func, totalTime in pairs(data) do
		SendSystemMessage(func .. ": " .. format("%.2f", totalTime) .. "ms")
	end
	SendSystemMessage(">>>")
end

function mUI:StartMeasure(func)
	if not enabled then return end
	data[func] = data[func] or 0
	data[func .. "_startTime"] = debugprofilestop()
end

function mUI:StopMeasure(func)
	if not enabled then return end
	local startTimeKey = func .. "_startTime"
	if data[startTimeKey] then
		data[func] = data[func] + (debugprofilestop() - data[startTimeKey])
		data[startTimeKey] = nil
	end
end

-- Add slash commands to enable/show profiling
SLASH_MANGOPERFORMANCE1 = "/mperformance"
SlashCmdList["MANGOPERFORMANCE"] = mUI.ProfilingResults
