local args = {...}

a = peripheral.wrap("back")
a.transmit(0, 0, {"sillyremote",args[1]})
print('{"sillyremote","'..args[1]..'"}')