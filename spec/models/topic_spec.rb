require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:public) { true }
  let(:topic) { Topic.create!(name: name, description: description) }

  it { is_expected.to have_many(:posts) }

  describe 'attributes' do
    it 'has name, description, and public attributes' do
      expect(topic).to have_attributes(name: name, description: description, public: public)
    end

    it 'is public by default' do
      expect(topic.public).to be(true)
    end
  end

  describe 'POST create' do
  it 'increases the number of topics by 1' do
    expect { post :create, topic: { name: RandomData.random_sentence, description: RandomData.random_paragraph } }}.to change(Topic, :count).by(1)
  end

  it 'assigns Topic.last to @topic' do
    post :create, topic: { name: RandomData.random_sentence, description: RandomData.random_paragraph }
    expect(assigns(:topic)).to eq Topic.last
  end

  it 'redirects to the new topic' do
    post :create, topic: { name: RandomData.random_sentence, description: RandomData.random_paragraph }
    expect(response).to redirect_to Topic.last
  end
  end
end
