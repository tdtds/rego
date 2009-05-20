#
# filesourcemanager.rb: File Source Manager of CBCMS
#
# Copyright (C) 2009 by TADA Tadashi
# Distributed under GPL
#

module CBCMS
	class FileSourceManager
		attr_reader :path

		def initialize( path )
			@path = path
			@files = Dir["#{@path}*"].sort.map{|f| f.sub( /#{path}/, '' )}
		end

		def size
			@files.size
		end

		def each
			@files.each do |file|
				yield file
			end
		end
	end
end
