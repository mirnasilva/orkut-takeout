require  'rails_helper'

describe JSONExporter do 
    let(:exporter) { JSONExporter.new }
    
    let(:current_user_hash){
       {
        "_id" => "56608bd7edd9adc72c1b48ee",
        "provider" => "local",
        "name" => "Pedro",
        "email" => "pedrohrs08@gmail.com",
        "password" => "081289",
        "__v" => 0,
        "role" => "user"
       }
   }
    
    let(:friends_hash){
      JSON.parse(%Q([{"_id":"56ab7fc22e481306042c151d","user":{"_id":"56ab7ee72e481306042c1518","name":"QA Couse User 1","email":"qacourseuser1@avenuecode.com"}},{"_id":"56ab7fd22e481306042c151e","user":{"_id":"56ab7ef12e481306042c1519","name":"QA Couse User 2","email":"qacourseuser2@avenuecode.com"}},{"_id":"56ab7fd82e481306042c151f","user":{"_id":"56ab7efb2e481306042c151a","name":"QA Couse User 3","email":"qacourseuser3@avenuecode.com"}},{"_id":"56ab7fe22e481306042c1520","user":{"_id":"56ab7f042e481306042c151b","name":"QA Couse User 4","email":"qacourseuser4@avenuecode.com"}},{"_id":"56ab7fec2e481306042c1521","user":{"_id":"56ab7f102e481306042c151c","name":"QA Couse User 5","email":"qacourseuser5@avenuecode.com"}}]))
    }

    let(:friends15){
      friends_array = []
      
      15.times do 
           friends_array << %Q({
                             "_id": "56ab7fc22e481306042c151d",
                              "user": {
                               "_id": "56ab7ee72e481306042c1518",
                               "name": "QA Couse User 1",
                               "email": "qacourseuser1@avenuecode.com"
                              }
                            })
      end
      friends_string = friends_array.join(",")

      JSON.parse("[#{friends_string}]")
    }

    let(:friends10){
      friends_array = []
      
      10.times do 
           friends_array << %Q({
                             "_id": "56ab7fc22e481306042c151d",
                              "user": {
                               "_id": "56ab7ee72e481306042c1518",
                               "name": "QA Couse User 1",
                               "email": "qacourseuser1@avenuecode.com"
                              }
                            })
      end
      friends_string = friends_array.join(",")

      JSON.parse("[#{friends_string}]")
    }

    let(:social_80perc){
      friends_array = []
      
      13.times do 
           friends_array << %Q({
                             "_id": "56ab7fc22e481306042c151d",
                              "user": {
                               "_id": "56ab7ee72e481306042c1518",
                               "name": "QA Couse User 1",
                               "email": "qacourseuser1@avenuecode.com"
                              }
                            })
      end
      friends_string = friends_array.join(",")

      JSON.parse("[#{friends_string}]")
    }

    let(:social_30perc_80perc){
      friends_array = []
      
      8.times do 
           friends_array << %Q({
                             "_id": "56ab7fc22e481306042c151d",
                              "user": {
                               "_id": "56ab7ee72e481306042c1518",
                               "name": "QA Couse User 1",
                               "email": "qacourseuser1@avenuecode.com"
                              }
                            })
      end
      friends_string = friends_array.join(",")

      JSON.parse("[#{friends_string}]")
    }


    let(:social_30perc){
      friends_array = []
      
      2.times do 
           friends_array << %Q({
                             "_id": "56ab7fc22e481306042c151d",
                              "user": {
                               "_id": "56ab7ee72e481306042c1518",
                               "name": "QA Couse User 1",
                               "email": "qacourseuser1@avenuecode.com"
                              }
                            })
      end
      friends_string = friends_array.join(",")

      JSON.parse("[#{friends_string}]")
    }


    # context "JSON format" do 
    #   #exercise
    #   it "should export friends list as JSON document" do
    #     #setup
    #     json_exporter = exporter.export_friends(friends_hash, current_user_hash)
    #     json_exporter = JSON.parse(json_exporter)
    #     #verify
    #     expect(json_exporter).to include('"user"=>{"name"=>"'+current_user_hash["name"]+'", "email"=>"'+current_user_hash["email"]+'"')
    #   end
    # end

    context "social_percentage" do
      #exercise
      it "should have more than 15 friends and social percentage attribute should show 100%" do
        #setup
        json_exporter = exporter.export_friends(friends15, current_user_hash)
        json_exporter = JSON.parse(json_exporter)
        #verify
        expect(json_exporter["user"]["socialPercentage"]).to eq ("100%")
      end

      #exercise
      it "should have 10 friends and social percentage attribute should show 66%" do
        #setup
        json_exporter = exporter.export_friends(friends10, current_user_hash)
        json_exporter = JSON.parse(json_exporter)
        #verify
        expect(json_exporter["user"]["socialPercentage"]).to eq ("66%")
      end
    end

    
    context "social_type" do
      #exercise
      it "should have social percentage greater than 80% and social type attribute should say 'Super Friendly'" do
        #setup
        json_exporter = exporter.export_friends(social_80perc, current_user_hash)
        json_exporter = JSON.parse(json_exporter)
        #verify
        expect(json_exporter["user"]["socialType"]).to eq ("Super Friendly")
      end

      #exercise
      it "should have social percentage greater than 30% and lower than 80%, and social type attribute should say 'Friendly'" do
        #setup
        json_exporter = exporter.export_friends(social_30perc_80perc, current_user_hash)
        json_exporter = JSON.parse(json_exporter)
        #verify
        expect(json_exporter["user"]["socialType"]).to eq ("Friendly")
      end

       #exercise
      it "should have social percentage lower than 30% and social type attribute should say 'Not So Friendly'" do
        #setup
        json_exporter = exporter.export_friends(social_30perc, current_user_hash)
        json_exporter = JSON.parse(json_exporter)
        #verify
        expect(json_exporter["user"]["socialType"]).to eq ("Not So Friendly")
      end
    end


  end