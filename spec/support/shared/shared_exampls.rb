shared_examples_for 'api_unauthenticate' do
  context 'when user do not authenticate' do
    let(:token) { nil }

    it { expect(response.status).to eq(401) }
  end

  context 'when user send not valid auth' do
    let(:token) { 'invalid' }

    it { expect(response.status).to eq(401) }
  end
end

shared_examples_for 'create_comment' do |comment_on_type, type, class_name|
  context 'when comment on question' do
    let!(:comment_on) { create(comment_on_type) }
    let(:text) { Faker::Lorem.sentence }
    let(:type) { type }

    it 'shod be created' do
      expect { subject }.to change(Object.const_get(class_name), :count).by(1)
      expect(Object.const_get(class_name).last.comment_on_id).to eq(comment_on.id)
      expect(Object.const_get(class_name).last.text).to eq(text)
    end
  end
end

shared_examples_for 'show_question' do |type|
  let(:question) { create(:question) }

  before { get type, params: { id: question.id } }

  it { expect(assigns(:question)).to eq(question) }
  it { expect(response).to render_template(type) }
end

shared_examples_for 'create_vote' do |vote_for_type, type, class_name, commit|
  context "when vote for #{vote_for_type}" do
    let!(:vote_for) { create(vote_for_type) }
    let(:type) { type }
    let(:commit) { commit }

    it 'shod be created' do
      expect { subject }.to change(Object.const_get(class_name), :count).by(1)
      expect(Object.const_get(class_name).last.vote_for_id).to eq(vote_for.id)
      expect(Object.const_get(class_name).last.vote).to eq(commit.downcase.tr(' ', '_'))
    end
  end
end

shared_examples_for 'delete_vote' do |vote_for_type, type, class_name|
  context "owner can vote for #{vote_for_type}" do
    let!(:user) { owner }
    let!(:vote_for) { create(vote_for_type) }
    let(:vote) { create("#{vote_for_type}_vote", :"#{vote_for_type}" => vote_for, :voter => owner) }
    let(:type) { type }

    before { vote.reload }

    it { expect { subject }.to change(Object.const_get(class_name), :count).by(-1) }
  end
end

shared_examples_for 'camnnot_delete_vote' do |vote_for_type, type, class_name|
  context 'other user cannot vote for question' do
    let!(:user) { other_user }
    let!(:vote_for) { create(vote_for_type) }
    let(:vote) { create("#{vote_for_type}_vote", :"#{vote_for_type}" => vote_for, :voter => owner) }
    let(:type) { type }

    before { vote.reload }

    it { expect { subject }.not_to change(Object.const_get(class_name), :count) }
  end
end

shared_examples_for 'create_answer' do |answer, count|
  context "when #{answer} data" do
    let(:answer_attributes) do
      attributes_for(answer).merge(question_id: question.id, owner_id: user.id)
    end

    it { expect { subject }.to change(Answer, :count).by(count) }
    it { expect(subject).to render_template 'answers/create' }
  end
end
