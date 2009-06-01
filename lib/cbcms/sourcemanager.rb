#
# filesourcemanager.rb: File Source Manager of CBCMS
#
# Copyright (C) 2009 by TADA Tadashi
# Distributed under GPL
#

module CBCMS
	class SourceManager
		def initialize
			raise StandardError::new( "#{self.class} cannot make a instance." )
		end

		def self.create( src )
			case
			when src =~ %r|/$|
				FileSourceManager::new( src )
			else
				raise ArgumentError( 'unknown path type' )
			end
		end
	end
end
