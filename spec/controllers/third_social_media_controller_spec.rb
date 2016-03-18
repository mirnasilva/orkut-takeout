require 'rails_helper'

describe ThirdSocialMediaController do

  let(:current_user_json){
    %Q({
         "_id":"56608bd7edd9adc72c1b48ee",
         "provider":"local",
         "name":"Pedro",
         "email":"pedrohrs08@gmail.com",
         "password":"081289",
         "__v" : 0,
         "role" : "user"
    })
  }

  let(:friends_json){
    %Q([{"_id":"56ab7fc22e481306042c151d","user":{"_id":"56ab7ee72e481306042c1518","name":"QA Couse User 1","email":"qacourseuser1@avenuecode.com"}},{"_id":"56ab7fd22e481306042c151e","user":{"_id":"56ab7ef12e481306042c1519","name":"QA Couse User 2","email":"qacourseuser2@avenuecode.com"}},{"_id":"56ab7fd82e481306042c151f","user":{"_id":"56ab7efb2e481306042c151a","name":"QA Couse User 3","email":"qacourseuser3@avenuecode.com"}},{"_id":"56ab7fe22e481306042c1520","user":{"_id":"56ab7f042e481306042c151b","name":"QA Couse User 4","email":"qacourseuser4@avenuecode.com"}},{"_id":"56ab7fec2e481306042c1521","user":{"_id":"56ab7f102e481306042c151c","name":"QA Couse User 5","email":"qacourseuser5@avenuecode.com"}}])
  }

  let(:user_response){
    user_response = double()
    allow(user_response).to receive(:body).and_return(current_user_json)
    user_response
  }

  let(:friends_response){
    friends_response = double()
    allow(friends_response).to receive(:body).and_return(friends_json)
    friends_response
  }

  let(:sign_in_response){
    sign_in_response = double()
    allow(sign_in_response).to receive(:body).and_return("my token")
    sign_in_response
  }


  it "should throw an error if login parameters are not passed" do
    expect { get :export }.to raise_error(/User missing/)
  end

  it "should export my friends list as JSON document" do
    allow(RestClient).to receive(:post).and_return(sign_in_response)

    allow(RestClient::Request).to receive(:execute)
    .with(hash_including(url:/friendships\/me/)).and_return(friends_response)

    allow(RestClient::Request).to receive(:execute)
    .with(hash_including(url:/users\/me/)).and_return(user_response)

    get :export, user: "my_user@me", password: "my_password"

    json_response = JSON.parse(response.body)
    user_parsed_json = ActiveSupport::JSON.decode(current_user_json)
    friends_parsed_json = ActiveSupport::JSON.decode(friends_json)

    
    #verify user name and email
    expect(json_response["user"]["name"]).to eq(user_parsed_json["name"])
    expect(json_response["user"]["email"]).to eq(user_parsed_json["email"])
    expect(json_response["friends"].size).to eq(friends_parsed_json.size)

    #verify list of friends, checking their name and email
    for i in 0..json_response["friends"].size - 1
      expect(json_response["friends"][i]["name"]).to eq(friends_parsed_json[i]["user"]["name"])
      expect(json_response["friends"][i]["email"]).to eq(friends_parsed_json[i]["user"]["email"])
    end    
  end
  
end