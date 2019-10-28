# Library that contains TCPServer
require 'socket'
require 'pry'

# Create a new instance of TCPServer on Port 9292
server = TCPServer.new(9292)

loop do
  # Wait for a Request
  # When a request comes in, save the connection to a variable
  puts 'Waiting for Request...'
  connection = server.accept

  # Read the request line by line until we have read every line
  puts "Got this Request:"
  request_lines = []
  line = connection.gets.chomp
  while !line.empty?
    request_lines << line
    line = connection.gets.chomp
  end

  # Print out the Request
  puts request_lines
  response = ''
  # Generate the Response
  if request_lines.first == 'GET / HTTP/1.1'
    puts "Sending response."
    output = "<html>Hello from the Server side!</html>"
    status = "http/1.1 200 ok"
    response = status + "\r\n" + "\r\n" + output
  elsif request_lines.first == 'POST / HTTP/1.1'
    puts 'Sending Response'
    output = "<html>You made a post request</html>"
    status = "http/1.1 202 ok"
    response = status + "\r\n" + "\r\n" + output
  elsif request_lines.first == 'PATCH / HTTP/1.1'
    puts 'Sending Response'
    output = "<html>You made a patch request</html>"
    status = "http/1.1 405 ok"
    response = status + "\r\n" + "\r\n" + output
  elsif request_lines.first == 'DELETE / HTTP/1.1'
    puts 'Sending Response'
    output = "<html>You made a delete request</html>"
    status = "http/1.1 401 ok"
    response = status + "\r\n" + "\r\n" + output
  end

  if request_lines.first == 'GET /dogs HTTP/1.1'
    puts "Sending response."
    output = "<html>dogs!<img src = 'https://upload.wikimedia.org/wikipedia/commons/d/d9/Collage_of_Nine_Dogs.jpg'></html>"
    status = "http/1.1 200 ok"
    response = status + "\r\n" + "\r\n" + output
  elsif request_lines.first == 'POST /dogs HTTP/1.1'
    puts 'Sending Response'
    output = "<html>creating a dog!</html>"
    status = "http/1.1 202 ok"
    response = status + "\r\n" + "\r\n" + output
  elsif request_lines.first == 'PATCH /dogs/45 HTTP/1.1'
    puts 'Sending Response'
    output = "<html>updating a dog!</html>"
    status = "HTTP/1.1 405 ok"
    response = status + "\r\n" + "\r\n" + output
  elsif request_lines.first == 'DELETE /dogs/45 HTTP/1.1'
    puts 'Sending Response'
    output = "<html>destroying a dog!</html>"
    status = "http/1.1 401 ok"
    response = status + "\r\n" + "\r\n" + output
  end

  # Send the Response
  connection.puts response

  # close the connection
  connection.close
end
