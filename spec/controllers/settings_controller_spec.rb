require 'spec_helper'

describe SettingsController do
  
  let(:expected_theme) { "events" }
  let(:expected_section) { "Settings" }
  
  describe "GET 'dates'" do
  
    context "Authenticated with the correct username and password" do
      before (:each) do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(ENV["HTTP_USERNAME"],ENV["HTTP_PASSWORD"])
      end
      
      it "should be successful" do
        get :dates
        response.should be_success
      end
      
      it "sets the cache headers to no-cache" do
        get :dates
        response.headers['Cache-Control'].should == 'no-cache'
      end
      
      it "assigns @theme" do
        get :dates
        assigns[:theme].should eq(expected_theme)
      end
      
      it "assigns @section" do
        get :dates
        assigns[:section].should eq(expected_section)
      end
      
      it "assigns @title" do
        get :dates
        assigns[:title].should eq("Settings - Festival Dates")
      end
      
      it "assigns @heading" do
         get :dates
         assigns[:heading].should eq("Festival Dates")
       end
       
       it "uses bootstrap" do
         get :dates
         assigns[:use_bootstrap].should == true
       end
      
      it "assigns @festival_start_date as d/m/Y" do
        Festival.stub(:start_date).and_return(Date.parse('2011-08-13'))
        get :dates
        assigns[:festival_start_date].should == "13/08/2011"
      end
      
      it "assigns @festival_end_date as d/m/Y" do
        Festival.stub(:end_date).and_return(Date.parse('2011-08-29'))
        get :dates
        assigns[:festival_end_date].should == "29/08/2011"
      end
      
    end
    
    context "Not authenticated" do
    
      before (:each) do
        request.env['HTTP_AUTHORIZATION'] = ""
      end
      
      it "should issue an authentication challenge" do
        get :dates
        response.code.should == "401"
      end
      
      it "should identify the realm as Edbookfest-mobile administration" do
        get :dates
        response.headers["WWW-Authenticate"].should == 'Basic realm="Edbookfest-mobile administration"'
      end
      
      it "should return an access denied response" do
        get :dates
        response.body.should == "HTTP Basic: Access denied.\n"
      end
    end
    
  end
  
  describe "POST 'dates'" do
    context "Authenticated with the correct username and password" do
    
      before (:each) do
          request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(ENV["HTTP_USERNAME"],ENV["HTTP_PASSWORD"])
      end
    
      context "When valid dates are set" do
        before (:each) do
          post :dates, {"festival_start_date" => "11/08/2012", "festival_end_date" => "27/08/2012"}
        end
        
        it "updates the festival date setting values" do
          Setting.festival_start_date.should == '2012-08-11'
          Setting.festival_end_date.should == '2012-08-27'
        end
        
        it "redirects the user to the date settings page" do
          response.should redirect_to(settings_dates_url)
        end
        
      end
      
      context "When the start date is invalid" do
        before (:each) do
          post :dates, {"festival_start_date" => "99/08/2012", "festival_end_date" => "27/08/2012"}
        end

        it "should be successful" do
          response.should be_success
        end
        
        it "does not update the festival date setting values" do
          Setting.festival_start_date.should == '2011-08-13'
          Setting.festival_end_date.should == '2011-08-29'
        end
        
        it "assigns an error message" do
          assigns[:errors].should have_key :festival_start_date
        end
        
        it "assigns festival_start_date to be the date the user entered" do
          assigns[:festival_start_date].should == "99/08/2012"
        end
      end
      
      context "When the end date is invalid" do
        before (:each) do
          post :dates, {"festival_start_date" => "13/08/2012", "festival_end_date" => "99/08/2012"}
        end

        it "should be successful" do
          response.should be_success
        end
        
        it "does not update the festival date setting values" do
          Setting.festival_start_date.should == '2011-08-13'
          Setting.festival_end_date.should == '2011-08-29'
        end
        
        it "assigns an error message" do
          assigns[:errors].should have_key :festival_end_date
        end
        
        it "assigns festival_end_date to be the date the user entered" do
          assigns[:festival_end_date].should == "99/08/2012"
        end
      end
      
      context "When the end date is before the start date" do
        before (:each) do
          post :dates, {"festival_start_date" => "27/08/2012", "festival_end_date" => "13/08/2012"}
        end

        it "should be successful" do
          response.should be_success
        end
        
        it "does not update the festival date setting values" do
          Setting.festival_start_date.should == '2011-08-13'
          Setting.festival_end_date.should == '2011-08-29'
        end
        
        it "assigns an error message" do
          assigns[:errors].should have_key :festival_end_date
        end

        it "shows the user the date they entered" do
          assigns[:festival_start_date].should == "27/08/2012"
          assigns[:festival_end_date].should == "13/08/2012"
        end

      end
    end
    
    context "Not authenticated" do
      before (:each) do
        request.env['HTTP_AUTHORIZATION'] = ""
      end
      
      it "should issue an authentication challenge" do
        post :dates
        response.code.should == "401"
      end
      
      it "should identify the realm as Edbookfest-mobile administration" do
        post :dates
        response.headers["WWW-Authenticate"].should == 'Basic realm="Edbookfest-mobile administration"'
      end
      
      it "should return an access denied response" do
        post :dates
        response.body.should == "HTTP Basic: Access denied.\n"
      end
    end
  end

end
