$:.unshift( "#{File.dirname( __FILE__ )}/.." )
require 'spec_helper'
require 'cbcms/sourcemanager'
require 'cbcms/filesourcemanager'

describe CBCMS::SourceManager, 'when making instance by new' do
	it 'should raise StandardError' do
		begin
			CBCMS::SourceManager::new
			violated 'fail'
		rescue
			$!.class.should eql( StandardError )
		end
	end
end

describe CBCMS::SourceManager, 'when giving a path of directory' do
	before do
		@path = 'src'
		@files = make_source_files( @path )
	end

	it 'should return a instance of FileSourceManager' do
		CBCMS::SourceManager::create( @path ).class.should eql( CBCMS::FileSourceManager )
	end

	after do
		delete_source_files( @path )
	end
end
