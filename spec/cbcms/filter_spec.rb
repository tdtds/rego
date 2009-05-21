$: << 'lib'
require 'cbcms/filter'

describe 'CBCMS::Filter#clone_copy' do
	before do
		@filter = CBCMS::Filter::new
	end

	it 'should return as same as source' do
		src = "test"
		@filter.clone_copy( src ).should eql( 'test' )
	end

	it 'should be clone of source' do
		src = "test"
		@filter.clone_copy( src ).should_not equal( src )
	end

	after do
		@filter = nil
	end
end
