# Author: Kurtis Rainbolt-Greene
# Build Time: 20:22:43 [2010.01.17] 
# 
# = Description =
# A small journaling system that outputs in HTML.

require 'time'
require 'facets'

def post_head(date,location)
	return <<-HTML
			<div class="post">
				<div class="date">#{date}</div>
				<div class="location">#{location}</div>
	HTML
end

def post_body(body)
	return <<-HTML
				<div class="paragraph">
					#{body}
				</div>
	HTML
end

def quote_body(body)
	return <<-HTML
				<div class="quote">
					#{body}
				</div>
	HTML
end

system('clear')

time_format = '%Y.%m.%d-(%H:%M:%S)'
@date = Time.now.strftime(time_format)
puts 'Time: ' + @date

print 'Where are you? '
@location = gets.chomp

@post = []
@post << post_head(@date,@location)


loop do
	print '>> '
	input = gets.chomp
	case input
	when /\/q/i
		break
	when /q=(.+)/i
		@post << quote_body($1)
	when /.+/i
		@post << post_body(input)
	end
end

@new_post = "\t\t\t<!--\n\t\t\t\tOld Post\n\t\t\t-->" + @post.join

File.rewrite('index.html', mode = "b") do |file|
	file.gsub(/\t\t\t<!--\n\t\t\t\tOld Post\n\t\t\t-->/i,@new_post)
end

puts 'Posting complete.'
