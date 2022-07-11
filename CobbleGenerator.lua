while true do
	if turtle.detect() then
		turtle.dig()
	end
	turtle.dropDown()
	os.sleep(1)
end