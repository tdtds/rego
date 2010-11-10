#
# template.rb: REGO Template as a default Block
#
# Copyright (C) 2010 by TADA Tadashi
# Distributed under GPL.
#

module REGO::Block
	class Template
		def initialize( env, &block )
			@env = env
			@child = []
			instance_eval( &block ) if block_given?
			self
		end

		def result
			@child.join( "\n" )
		end

		def method_missing( name, *args, &block )
			if block
				begin
					klass = REGO::Block::const_get( name.to_s.capitalize )
					@child << klass::new( @env, &block ).result
				rescue NameError
					begin
						require name.to_s
					rescue LoadError
						require "rego/block/#{name}"
					end
					retry
				end
			else
				instance_variable_set "@#{name}", args[0]
			end
			self
		end
	end
end
