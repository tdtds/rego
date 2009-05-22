$:.unshift( 'lib' )

def make_source_files( path )
	files = %w(a b c d e)
	Dir::mkdir( path ) unless FileTest::exist?( path )
	files.each do |file|
		open( "#{path}/#{file}", 'w' ) {|f| f.write( file ) }
	end
	files
end

def delete_source_files( path )
	system( "rm -rf #{path}" )
end
