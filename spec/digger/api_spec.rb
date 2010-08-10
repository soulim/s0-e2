require 'spec_helper'

module Digger
  describe Api do
    subject { Api.new }
    
    it 'delegates methods to Digger::Request' do
      subject.story.should be_a_kind_of(Digger::Request)
    end
    
    it 'does test request' do
      subject.story.getInfo.options(:story_id => 23167292).fetch
    end
  end
end