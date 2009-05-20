$: << 'lib'
require 'cbcms/filter'

describe CBCMS::Filter, 'clone copy' do
	before do
		@filter = CBCMS::Filter::new
	end

	it 'should as same as source' do
		src = "test"
		@filter.clone_copy( src ).should eql( 'test' )
	end

	it 'should be clone' do
		src = "test"
		@filter.clone_copy( src ).should_not equal( src )
	end

	after do
		@filter = nil
	end
end
