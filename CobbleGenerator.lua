while true do
	if turtle.detect() then
		turtle.dig()
	end
	while not turtle.dropDown() do
		os.sleep(15)
	end
	os.sleep(1)
end