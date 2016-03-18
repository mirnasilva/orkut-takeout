 require 'rails_helper'

 describe SignInController do
 
 	it "should throw an error if export is empty" do
 		expect { get :export }.to raise_error ActiveRecord::RecordNotFound 
 	end

 	it "should redirect to social_network_1 when parameter is social_network_1" do
 		#setup
 		get :export, {:export => 'social_network_1'}

 		#verify
 		expect(response).to be_redirect
 		expect(response.body).to include ('social_network_1')
 	end

 	it "should redirect to social_network_2 when parameter is social_network_2" do
 		#setup
 		get :export, {:export => 'social_network_2'}

 		#verify
 		expect(response).to be_redirect
 		expect(response.body).to include ('social_network_2')
 	end

 	it "should redirect to social_network_3 when parameter is social_network_3" do
 		#setup
 		get :export, {:export => 'social_network_3'}

 		#verify
 		expect(response).to be_redirect
 		expect(response.body).to include ('social_network_3')
 	end

 end