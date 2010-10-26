#
# app.rb: REGO Application 
#
# Copyright (C) 2010 by TADA Tadashi
# Distributed under GPL.
#
require 'pathname'

module REGO
	class REGOError < ::StandardError; end
	class MakeLink < REGOError; end

	class App
		def initialize( src, dest )
			@src, @dest = src, dest
		end

		def run
			Pathname::glob( "#{@src}/**/*" ) do |src|
				relative = src.to_s[@src.size, src.to_s.size]

				if src.directory?
					Pathname::new( @dest + relative ).mkpath
				else
					case src.to_s
					when /\.rego$/
						processing( src, @dest, relative.sub( /\.rego$/, '' ), :template )
					when /\.ignore$/
						# ignore this file
					else
						d = 
						processing( src, @dest, relative, :symlink )
					end
				end
			end
		end

		def processing( src_file, dest_path, relative_file, filter )
			result = ''
			begin
				File::open( src_file, 'r:utf-8' ) do |f|
					result = __send__( filter, f.read, relative_file )
				end
				File::open( dest_path + relative_file, 'w' ) do |f|
					f.write( result )
				end
			rescue MakeLink
				dest.make_symlink( src_file ) rescue Errno::EEXIST
			end
		end

		def template( tmpl, relative )
			tmpl.insert( 0, "do_template {\nrelative '#{relative}'" ) << "\n}"
			eval tmpl
		end

		def do_template( &block )
			REGO::Block::Template::new( &block ).result
		end

		def dead_copy( tmpl, relative )
			tmpl
		end

		def symlink( tmpl, relative )
			raise MakeLink::new
		end
	end
end

