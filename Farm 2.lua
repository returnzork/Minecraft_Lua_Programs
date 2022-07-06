-- Number of tiles per plot
depth = 15
-- Number of plots to harvest
width = 15
refuelLevel = 10

harvestState = 3

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

end

function RefuelIfNeeded()
	if turtle.getFuelLevel() < refuelLevel then
		assert(turtle.refuel(1))
	end
end

function PlaceItemsInChest()
	for i=2,16 do
		turtle.select(i)
		turtle.dropDown()
	end
	turtle.select(1)
end

function HarvestRow()
	for x=1,depth do
		HarvestAndReplant()
		if x ~= depth then
			RefuelIfNeeded()
			assert(turtle.forward())
			curX = curX + 1
		end
	end
end

function GoHome()
	if curY % 2 == 0 then
		turtle.turnLeft()
	else
		turtle.turnRight()
	end
	if curY == -1 then
		return nil
	end
	for y=1,curY do
		RefuelIfNeeded()
		assert(turtle.forward())
		curY = curY - 1
	end
	turtle.turnRight()
	for x=1,curX do
		RefuelIfNeeded()
		assert(turtle.back())
		curX = curX - 1
	end
end

function MainHarvest()
	for currentPlot=1,width do
		HarvestRow()
		if curX > depth then
			curX = 1
		end
		if currentPlot ~= width then
			-- if we are on an odd numbered plot, we need to turn right
			if currentPlot % 2 == 1 then
				turtle.turnRight()
				turtle.forward()
				turtle.turnRight()
				curY = curY + 1
			else
				turtle.turnLeft()
				turtle.forward()
				turtle.turnLeft()
				curY = curY + 1
			end
		end
	end
end

function Main()
	turtle.forward()
	curX = curX + 1
	MainHarvest()
	GoHome()
	PlaceItemsInChest()
end

Main()