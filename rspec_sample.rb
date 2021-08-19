require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe IntervalsController, type: :controller do
    
  before (:all) do
    @utility = FactoryBot.create(:utility)
    @interval = Interval.create(utility: @utility, meter_id: 1) 
  end

  describe "#Index" do
    it  'should render_template index'  do 
      user = User.create(name:'Test User',email: "XYZ@solr.com", password: 123456, active: true)
      warden.set_user(user, scope: :user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :index, params: {"meter_id" => "1", page: 1} 
      expect(response).to render_template(:index)
      expect(response.content_type).to eq("text/html")
    end 
  end

  describe "#New" do
    it  'should render_template new ' do    
      user = User.create(name:'Test User',email: "XYZ@solr.com", password: 123456, active: true)
      warden.set_user(user, scope: :user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :new, params: {"meter_id" => "1"}
      expect(response).to render_template(:new)
      expect(response.content_type).to eq("text/html")
    end
  end

  describe "#Create" do
    before :each do
      user = User.create(name:'Test User',email: "XYZ@solr.com", password: 123456, active: true)
      warden.set_user(user, scope: :user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end
  end

  describe "#update" do
    before :each do
      user = User.create(name:'Test User',email: "XYZ@solr.com", password: 123456, active: true)
      warden.set_user(user, scope: :user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end
  end

  describe "#clear_meter" do
    before :each do
      user = User.create(name:'Test User',email: "XYZ@solr.com", password: 123456, active: true)
      warden.set_user(user, scope: :user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end
  end

  describe "#Check_routes" do
    describe "#Index" do
      it 'if should routes /meters/:meter_id/intervals' do
        {:get => '/meters/1/intervals'}.should route_to({:controller => 'intervals', :action => 'index', "meter_id" => "1"})
      end
    end

    describe "#New" do
      it 'if should routes /meters/:meter_id/intervals/new' do
        {:get => '/meters/1/intervals/new'}.should route_to({:controller => 'intervals', :action => 'new', "meter_id" => "1"})
      end
    end

    describe "#Create" do
      it 'if should routes /meters/:meter_id/intervals' do
        {:post => '/meters/1/intervals'}.should route_to({:controller => 'intervals', :action => 'create', "meter_id" => "1"})
      end
    end

    describe "#update" do
      it 'if should routes /meters/:meter_id/intervals/:id' do
        {:put => '/meters/1/intervals/1'}.should route_to({:controller => 'intervals', :action => 'update', "meter_id" => "1", "id" => "1"})
        {:patch => '/meters/1/intervals/1'}.should route_to({:controller => 'intervals', :action => 'update', "meter_id" => "1", "id" => "1"})
      end
    end

    describe "#destroy" do
      it 'if should routes /meters/:meter_id/intervals/:id' do
        {:delete => '/meters/1/intervals/1'}.should route_to({:controller => 'intervals', :action => 'destroy', "meter_id" => "1", "id" => "1"})
      end
    end

    describe "#import" do
      it 'if should routes /meters/:meter_id/intervals/import' do
        {:post => '/meters/1/intervals/import'}.should route_to({:controller => 'intervals', :action => 'import', "meter_id" => "1"})
      end
    end

    describe "#clear_meter" do
      it 'if should routes /clear_interval_for_meter' do
        {:get => '/clear_interval_for_meter'}.should route_to({:controller => 'intervals', :action => 'clear_meter'})
      end
    end
  end  
end