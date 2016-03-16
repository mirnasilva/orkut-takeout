require 'rails_helper'

describe CSVExporter do

	let(:exporter){ CVSExporter.new }

	it "should return a header on the firts line of the file" do
		csv_return = exporter.export_friends
		expect(csv_return).to start_with "my_name,my_email,friend_name,friend_email"

	end

	context "content" do
		it "should include a line containing my email and name" do
			exporter.export_friends

		end



end