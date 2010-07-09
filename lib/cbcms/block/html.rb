#
# html.rb: CBCMS HTML and elements Block
#
# Copyright (C) 2010 by TADA Tadashi
# Distributed under GPL.
#

module CBCMS::Block
	class Html < Template
		def result
			<<-HTML.gsub( /^\t*/, '' )
			<html>
			#{super}
			</html>
			HTML
		end
	end

	class Head < Template
		def result
			raise ::StandardError::new( 'no title in head' ) unless @title
			<<-HTML
				<title>#{@title}</title>
			HTML
		end
	end

	class Body < Template
		def result
			<<-HTML
			<body>
			<h1>#{@h1}</h1>
			</body>
			HTML
		end
	end
end
