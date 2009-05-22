$: << 'lib'
require 'cbcms/sourcemanager'

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
