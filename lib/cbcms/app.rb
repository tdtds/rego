#
# app.rb: CBCMS Application 
#
# Copyright (C) 2010 by TADA Tadashi
# Distributed under GPL.
#
require 'pathname'

module CBCMS
	class CBCMSError < ::StandardError; end
	class MakeLink < CBCMSError; end

	class App
		def initialize( src, dest )
			@src, @dest = src, dest
		end

		def run
			Pathname::glob( "#{@src}/**" ) do |pathname|
				case pathname.to_s
				when /\.cbcms$/
					d = @dest + pathname.to_s[@src.size,pathname.to_s.size].sub( /\.cbcms$/, '' )
					processing( pathname, Pathname::new( d ), :template )
				when /\.ignore$/
					# ignore this file
				else
					d = @dest + pathname.to_s[@src.size,pathname.to_s.size]
					processing( pathname, Pathname::new( d ), :symlink )
				end
			end
		end

		def processing( src, dest, filter )
			result = ''
			begin
				File::open( src, 'r:utf-8' ) do |f|
					result = __send__( filter, f.read )
				end
				File::open( dest, 'w' ) do |f|
					f.write( result )
				end
			rescue MakeLink
				dest.make_symlink( src ) rescue Errno::EEXIST
			end
		end

		def template( tmpl )
			tmpl.insert( 0, "do_template {\n" ) << "\n}"
			eval tmpl
		end

		def do_template( &block )
			CBCMS::Block::Template::new( &block ).result
		end

		def dead_copy( tmpl )
			tmpl
		end

		def symlink( tmpl )
			raise MakeLink::new
		end
	end
end

