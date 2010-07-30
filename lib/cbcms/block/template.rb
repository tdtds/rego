#
# template.rb: CBCMS Template as a default Block
#
# Copyright (C) 2010 by TADA Tadashi
# Distributed under GPL.
#

module CBCMS::Block
	class Template
		def initialize( &block )
			@child = []
			instance_eval( &block )
		end

		def result
			@child.join( "\n" )
		end

		def method_missing( name, *args, &block )
			if block
				eval "
					retried = false
					begin
						@child << #{name.to_s.capitalize}::new( &block ).result
					rescue NameError
						unless $!.to_s.include?( 'CBCMS::Block::Template::#{name.to_s.capitalize}' ) then
							raise
						end
						raise if retried
						retried = true
						require 'cbcms/block/#{name}'
						retry
					end
				"
			else
				eval "@#{name}, = args"
			end
		end
	end
end
