local base64 = require("base64lib")

while true do
	io.write("Input source text:")
	source = io.read()
	print(base64.encode(source))
end
