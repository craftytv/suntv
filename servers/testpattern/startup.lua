--silly speaker stuff
local dfpwm = require("cc.audio.dfpwm")
local modem = peripheral.find("modem")
local channel = 667
local chunkDivider = 2
local owner = "USERNAME HERE"
local station = "Test Station"
local program = "Test Pattern 1"
--directories
local audiodir = "/disk/"
local audio1dir = "/disk1/"
local broadcastType = "video"
--fallback video
local fallback ={ 	{"Hello, world!  ","123456789abcdef","000000000000000"},
					{"Hello, world!  ","000000000000000","123456789abcdef"},
					{"Hello, world!  ","123456789abcdef","000000000000000"},
					{"Hello, world!  ","000000000000000","123456789abcdef"},
					{"Hello, world!  ","123456789abcdef","000000000000000"},
					{"Hello, world!  ","000000000000000","123456789abcdef"},
					{"Hello, world!  ","123456789abcdef","000000000000000"},
					{"Hello, world!  ","000000000000000","123456789abcdef"},
					{"Hello, world!  ","123456789abcdef","000000000000000"},
					{"Hello, world!  ","000000000000000","123456789abcdef"}}
					
function replace_char(pos, str, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end

local a = false
function makeScaryFrame() --SCARY frame!!!
	local blank = {}
	local text = ("Hello, world!"):rep(4).."Hello"
	local color1 = ("0"):rep(57)
	local color2 = ("123456789abcd"):rep(4).."12345"
	math.randomseed(os.epoch("utc"))
	local num = math.random(1,2)
	a = not a
	for i=1,38 do -- width 57
		if a then
			if i % 2 == 0 then
				blank[i] = {text,color1,color2}
			else
				blank[i] = {text,color2,color1}
			end
		else
			if i % 2 == 0 then
				blank[i] = {text,color2,color1}
			else
				blank[i] = {text,color1,color2}
			end
		end
	end
	return blank
end
--generate the alarm beforehand for alerts
alertbuffer = {0}
alertbuffer1 = {0}
local t, dt = 0, 2 * math.pi * 853 / 48000
local t1, dt1 = 0, 2 * math.pi * 960 / 48000
for i = 1, 48000 do
    alertbuffer[i] = math.floor(math.sin(t) * 127)
    t = (t + dt) % (math.pi * 2)
end
for i = 1, 48000 do
    alertbuffer1[i] = math.floor(math.sin(t1) * 127)
    t = (t1 + dt1) % (math.pi * 2)
end
--main
while "" do --silly goofball loop
	while true do
		buffer = alertbuffer
		buffer1 = alertbuffer1
		local data = { --transmit with audio so 1fps is around 12k bytes
            protocol = "stereovideo",
            type = broadcastType,
            audio = {
                left = buffer,
                right = buffer1
            },
            video = makeScaryFrame(),
			meta = {
				name = station,
				title = program,
				owner = owner
			}
        }
		modem.transmit(channel, channel, data)
        sleep(1/chunkDivider)
	end
	data.close()
	data1.close()
    sleep(1/chunkDivider)
end