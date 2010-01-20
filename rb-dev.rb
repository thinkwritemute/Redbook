require 'time'
require 'facets'

@post = []
@old_post = "\t\t\t<!--\n\t\t\tOld Post\n\t\t\t-->"
def format_to_header(time,location)
	return %{\n\t\t\t<div class="post">\n\t\t\t\t<div class="date">#{time}</div>\n\t\t\t\t<div class="location">#{location}</div>\n}
end
def format_to_paragraph(body)
	return %{\n\t\t\t\t<div class="paragraph">\n\t\t\t\t\t#{body}\n\t\t\t\t</div>\n}
end
def format_to_quote(body)
	return %{\n\t\t\t\t<div class="quote">\n\t\t\t\t\t#{body}\n\t\t\t\t</div>\n}
end

time_format = '(%Y.%m.%d) %H:%M:%S'
time = Time.now.strftime(time_format)
print 'The time is: ' + time + ', where are you? '
location = gets.chomp

input = format_to_header time, location
@post << input

puts 'Entering post writer... (Use .e or .end to finish)'
state = true
until state == false
	print 'Write:: '
	input = gets.chomp
	case input
		when /#(.+)/
			puts 'picture found'
			puts 'picture uploaded'
			puts 'picture link added'
		when />(.+)/
			input = format_to_quote($1)
			@post << input
		when /\.e/ || /\.end/
			state = false
		when /(.+)/
			input = format_to_paragraph($1)
			@post << input
	end
end

@new_post = @old_post + @post.join + "\n\t\t\t</div>\n"
File.rewrite('index.html', mode = "b") do |file|
	file.gsub(@old_post,@new_post)
end
