local base64 = require("base64lib")

while true do
	io.write("Input cipher text:")
	source = io.read()
	print(base64.decode(source))
end
