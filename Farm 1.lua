depth = 16

harvestState = 7

curX = 0
curY = 0

function HarvestAndReplant()
	hasBlock, blockInfo = turtle.nspectDown()
	if hasBlock then
		if blockInfo.tags["minecraft:crops"] ~= nil then
			if blockInfo.state["age"] == harvestState then
				turtle.digDown()
				turtle.placeDown()
			end
		end
	end
end

for x=0,depth do
	HarvestAndReplant()
	assert(turtle.forward())
	curX = curX + 1
end

for x=0,curX do
	assert(turtle.back())
	curX = curX - 1
end