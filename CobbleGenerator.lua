while true do
	if turtle.detect() and turtle.getItemCount() < 64 then
		turtle.dig()
	end
	while not turtle.dropDown() do
		os.sleep(15)
	end
	os.sleep(1)
end