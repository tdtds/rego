$: << 'lib'
require 'cbcms'

describe CBCMS, 'clone copy' do
	before do
		@cbcms = CBCMS::new
	end

	it 'should as same as source' do
		src = "test"
		@cbcms.clone_copy( src ).should eql( 'test' )
	end

	it 'should be clone' do
		src = "test"
		@cbcms.clone_copy( src ).should_not equal( src )
	end

	after do
		@cmcms = nil
	end
end
