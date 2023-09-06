local a = peripheral.wrap("back")

local function broadcast(thing)
	a.transmit(0, 0, {"sillyremote",thing})
end

local w,h = term.getSize()
term.clear()
for y=1,4 do
	term.setCursorPos(1,y)
	term.blit((" "):rep(26),("5"):rep(13)..("e"):rep(13),("5"):rep(13)..("e"):rep(13))
end
for y=5,12 do
	term.setCursorPos(1,y)
	term.blit((" "):rep(26),("a"):rep(26),("a"):rep(26))
end
for y=13,20 do
	term.setCursorPos(1,y)
	term.blit((" "):rep(26),("b"):rep(26),("b"):rep(26))
end

while "" do
	local event, button, x, y = os.pullEvent("mouse_click")
	if button == 1 then
		if y <= 4 then
			if x < 14 then
				broadcast("on")
			else
				broadcast("off")
			end
		elseif y > 4 then
			if y > 12 then
				broadcast("channelDown")
				sleep(1/10)
				broadcast("on")
			else
				broadcast("channelUp")
				sleep(1/10)
				broadcast("on")
			end
		end
	end
end