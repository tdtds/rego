$: << 'lib'
require 'cbcms/filesourcemanager'

describe CBCMS::FileSourceManager, 'when given bad path' do
	it 'should raise ArgumentError' do
		begin
			CBCMS::FileSourceManager::new( 'bad path name' )
			violated 'fail'
		rescue
			$!.class.should eql( ArgumentError )
		end
	end
end

describe CBCMS::FileSourceManager, 'when given existent path' do
	before do
		@path = 'src'
		@files = %w(a b c d e)
		Dir::mkdir( @path ) unless FileTest::exist?( @path )
		@files.each do |file|
			open( "#{@path}/#{file}", 'w' ) {|f| f.write( file ) }
		end
		@fsm = CBCMS::FileSourceManager::new( @path + '/' )
	end

	it 'should have path' do
		@fsm.path.should eql( @path + '/' )
	end

	it 'should be count of files' do
		@fsm.size.should == @files.size
	end

	it 'should be enumerable files' do
		[].tap {|a|
			@fsm.each do |item|
				a << item
			end
		}.should eql( @files.sort )
	end

	after do
		system( "rm -rf #{@path}" )
		@fsm = nil
	end
end
