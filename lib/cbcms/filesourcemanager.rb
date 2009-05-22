#
# filesourcemanager.rb: File Source Manager of CBCMS
#
# Copyright (C) 2009 by TADA Tadashi
# Distributed under GPL
#
require 'cbcms/sourcemanager'

module CBCMS
	class FileSourceManager < SourceManager
		attr_reader :path

		def initialize( path )
			@path = path
			raise ArgumentError unless FileTest::exist?( @path )
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
