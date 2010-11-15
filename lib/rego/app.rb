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
		def initialize( src, dest, opt = {} )
			@src, @dest, @opt = src, dest, opt
			@src.chop! if %r|/$| =~ @src
			@dest.chop! if %r|/$| =~ @dest
			@env = {
				:src => @src,
				:dest => @dest
			}.update( @opt )
		end

		def run
			Pathname::glob( "#{@src}/**/{.*,*}" ) do |src|
				relative = src.to_s[@src.size, src.to_s.size]
				@env[:src_file] = relative
				@env[:dest_file] = relative.dup

				if src.directory?
					Pathname::new( @dest + relative ).mkpath
				else
					case src.to_s
					when /\.rego$/
						@env[:dest_file] = relative.sub( /\.rego$/, '' )
						begin
							next if !@opt[:force] && (src.mtime < Pathname::new( dest_file( @env ) ).mtime)
						rescue Errno::ENOENT
						end
						$stderr.puts relative if @opt[:verbose]
						processing( @env, :template )
					when /\.ignore$/
						# ignore this file
					else
						processing( @env, :symlink )
					end
				end
			end
		end

	private
		def src_file( env )
			env[:src] + env[:src_file]
		end

		def dest_file( env )
			env[:dest] + env[:dest_file]
		end

		def processing( env, filter )
			result = ''
			begin
				File::open( src_file( env ), 'r:utf-8' ) do |f|
					result = __send__( filter, f.read, env )
				end
				File::open( dest_file( env ), 'w' ) do |f|
					f.write( result )
				end
			rescue MakeLink
				Pathname::new( dest_file( env ) ).make_symlink( src_file( env ) ) rescue Errno::EEXIST
			end
		end

		def template( tmpl, env )
			tmpl.insert( 0, "do_template( env ) {\n" ) << "\n}"
			instance_eval( tmpl )
		end

		def do_template( env, &block )
			REGO::Block::Template::new( env, &block ).result
		end

		def dead_copy( tmpl, env )
			tmpl
		end

		def symlink( tmpl, env )
			raise MakeLink::new
		end
	end
end

