depth = 16
refuelLevel = 10

harvestState = 7

curX = 0
curY = 0

function HarvestAndReplant()
	hasBlock, blockInfo = turtle.inspectDown()
	if hasBlock then
		if blockInfo.tags["minecraft:crops"] ~= nil then
			if blockInfo.state["age"] == harvestState then
				turtle.digDown()
				PlantItem()
			end
		end
	else
		turtle.digDown()
		PlantItem()
	end
end

function PlantItem()
	turtle.select(2)
	turtle.placeDown()
	turtle.select(1)
end

function RefuelIfNeeded()
	if turtle.getFuelLevel() < refuelLevel then
		assert(turtle.refuel())
	end
end

function PlaceItemsInChest()
	turtle.select(2)
	turtle.dropDown(turtle.getItemCount() - 1)
	for i=3,16 do
		turtle.select(i)
		turtle.dropDown()
	end
	turtle.select(1)
end


function Main()
	for x=1,depth do
		RefuelIfNeeded()
		assert(turtle.forward())
		curX = curX + 1
		HarvestAndReplant()
	end

	for x=1,curX do
		RefuelIfNeeded()
		assert(turtle.back())
		curX = curX - 1
	end
	PlaceItemsInChest()
end

Main()