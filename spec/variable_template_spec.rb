require 'spec_helper'
describe PlayLab::VariableTemplate do

  describe "count pending" do
    let(:count_pending) {PlayLab::VariableTemplate::COUNT_PENDING}
    let(:title) {"GET /api/users/{user_id}/count_pending_messages"}
    let(:regular) {/method=GET path=\/api\/users\/\p{Digit}+\/count_pending_messages/}
    
    it "title must eq with title param" do
      expect(count_pending[:title]).to eq title
    end

    it "regular must eq with regular param" do
      expect(count_pending[:regular]).to eq regular
    end
  end

  describe "message" do
    let(:message) {PlayLab::VariableTemplate::MESSAGE}
    let(:title) {"GET /api/users/{user_id}/get_messages"}
    let(:regular) {/method=GET path=\/api\/users\/\p{Digit}+\/get_messages/}
    
    it "title must eq with title param" do
      expect(message[:title]).to eq title
    end

    it "regular must eq with regular param" do
      expect(message[:regular]).to eq regular
    end
  end

  describe "friends_progress" do
    let(:friends_progress) {PlayLab::VariableTemplate::FRIENDS_PROGRESS}
    let(:title) {"GET /api/users/{user_id}/get_friends_progress"}
    let(:regular) {/method=GET path=\/api\/users\/\p{Digit}+\/get_friends_progress/}
    
    it "title must eq with title param" do
      expect(friends_progress[:title]).to eq title
    end

    it "regular must eq with regular param" do
      expect(friends_progress[:regular]).to eq regular
    end
  end

  describe "friends_score" do
    let(:friends_score) {PlayLab::VariableTemplate::FRIENDS_SCORE}
    let(:title) {"GET /api/users/{user_id}/get_friends_score"}
    let(:regular) {/method=GET path=\/api\/users\/\p{Digit}+\/get_friends_score/}
    
    it "title must eq with title param" do
      expect(friends_score[:title]).to eq title
    end

    it "regular must eq with regular param" do
      expect(friends_score[:regular]).to eq regular
    end
  end

  describe "get_user" do
    let(:get_user) {PlayLab::VariableTemplate::GET_USER}
    let(:title) {"GET /api/users/{user_id}"}
    let(:regular) {/method=GET path=\/api\/users\/\p{Digit}+ /}
    
    it "title must eq with title param" do
      expect(get_user[:title]).to eq title
    end

    it "regular must eq with regular param" do
      expect(get_user[:regular]).to eq regular
    end
  end

  describe "post_user" do
    let(:post_user) {PlayLab::VariableTemplate::POST_USER}
    let(:title) {"POST /api/users/{user_id}"}
    let(:regular) {/method=POST path=\/api\/users\/\p{Digit}+ /}
    
    it "title must eq with title param" do
      expect(post_user[:title]).to eq title
    end

    it "regular must eq with regular param" do
      expect(post_user[:regular]).to eq regular
    end
  end
end