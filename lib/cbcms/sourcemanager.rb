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
	end
end
