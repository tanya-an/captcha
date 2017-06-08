require "net/http"
require "uri"

PROXY = "127.0.0.1"
PROXY_PORT = "8080"


theurl = 'http://127.0.0.1/captcha/captcha3.php'

uri = URI.parse(theurl)
	req = Net::HTTP::Post.new(uri.path)
	req.add_field("Content-Type", "application/x-www-form-urlencoded")
	req.body = "g-recaptcha-response=InvalidAnswerOfCAPTCHA&submit=SUBMIT"
	
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