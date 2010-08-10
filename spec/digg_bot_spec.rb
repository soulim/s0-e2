require 'spec_helper'

describe DiggBot do
  subject { DiggBot.new }
  before(:each) do
    bot = mock('IRC bot', :on => nil, :plugin => nil, :run => nil)
    Cinch.stub!(:setup).and_return(bot)
    @digg_api = mock('Digg API').as_null_object
    Digger::Api.stub!(:new).and_return(@digg_api)
  end
  
  it 'gets top stories' do
    @digg_api.stub!(:fetch).and_return([Digger::Story.new])
    subject.top_stories.should_not be_empty
  end
  
  it 'gets list of containers' do
    @digg_api.stub!(:fetch).and_return([Digger::Container.new])
    subject.containers.should_not be_empty
  end
  
  it 'gets hot stories for given container' do
    @digg_api.stub!(:fetch).and_return([Digger::Story.new])
    subject.hot_stories_from.should_not be_empty
  end
end