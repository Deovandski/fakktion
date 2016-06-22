require 'test_helper'

class Api::V1::CommentVotesControllerTest < ActionController::TestCase
  setup do
    @testUser = User.new( display_name: 'TESTT', full_name: 'TESTT',
      date_of_birth: DateTime.parse("20010429162748"),legal_terms_read: true, privacy_terms_read: true,
      show_full_name: true, reputation: 0, posts_count: 0, is_admin: false,
      is_super_user: false, is_legend: false, webpage_url: "", facebook_url: "",
      twitter_url: "", email: "email@fakktion.com", password: "12345678")
    @testUser2 = User.new( display_name: 'TESTSTE', full_name: 'DSDSDSDSD',
      date_of_birth: DateTime.parse("20010429162748"),legal_terms_read: true, privacy_terms_read: true,
      show_full_name: true, reputation: 0, posts_count: 0, is_admin: false,
      is_super_user: false, is_legend: false, webpage_url: "", facebook_url: "",
      twitter_url: "", email: "fakktion@fakktion.com", password: "12345678")
    @testPost = Post.first
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @user = User.find_by_email('user@example.com')
    sign_in @user
  end
  # Called after test
  def teardown
    @testUser = nil
    @testUser2 = nil
    @testPost = nil
  end
  test "CommentsVote - API - CREATE 200" do
    @testUser.reputation = 0
    @testUser.save
    testComment = Comment.new(user_id: @testUser.id, post_id: @testPost.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    testComment.save
    @testUser2.reputation = 0
    @testUser2.save
    sign_in @testUser2
    @testCommentVote = CommentVote.new(user_id: @testUser2.id, comment_id: testComment.id, recorded_vote: 0, positive_vote: true)
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    assert_response :ok
  end
  test "CommentsVote - API - CREATE 401" do
    @testUser.reputation = 0
    @testUser.save
    testComment = Comment.new(user_id: @testUser.id, post_id: @testPost.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    testComment.save
    @testUser2.reputation = 0
    @testUser2.save
    sign_out @user
    @testCommentVote = CommentVote.new(user_id: @testUser2.id, comment_id: testComment.id, recorded_vote: 0, positive_vote: true)
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    assert_response :unauthorized
  end
  test "CommentsVote - API - CREATE 422" do
    @testUser.reputation = 0
    @testUser.save
    testComment = Comment.new(user_id: @testUser.id, post_id: @testPost.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    testComment.save
    @testUser2.reputation = 0
    @testUser2.save
    sign_out @user
    sign_in @testUser2
    @testCommentVote = CommentVote.new(user_id: @testUser2.id, comment_id: testComment.id, recorded_vote: 0, positive_vote: true)
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    assert_response :unprocessable_entity
  end
  test "CommentsVote - API - CREATE BY OWNER - 403" do
    @testUser.reputation = 0
    @testUser.save
    testComment = Comment.new(user_id: @testUser.id, post_id: @testPost.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    testComment.save
    sign_in @testUser
    @testCommentVote = CommentVote.new(user_id: @testUser.id, comment_id: testComment.id, recorded_vote: 0, positive_vote: true)
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    assert_response :forbidden
  end
  test "CommentsVote - API - ACHIEVE SUPER USER TEST" do
    @testUser.reputation = 499
    @testUser.save
    testComment = Comment.new(user_id: @testUser.id, post_id: @testPost.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    testComment.save
    @testUser2.reputation = 499
    @testUser2.save
    sign_in @testUser2
    @testCommentVote = CommentVote.new(user_id: @testUser2.id, comment_id: testComment.id, recorded_vote: 0, positive_vote: true)
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    updatedTestUser = User.find_by_email('email@fakktion.com')
    assert_equal(updatedTestUser.reputation, 500)
    assert updatedTestUser.is_super_user
    assert_not updatedTestUser.is_admin
    assert_not updatedTestUser.is_legend
  end
  test "CommentsVote - API - LOSE SUPER USER TEST" do
    @testUser.reputation = 500
    @testUser.save
    testComment = Comment.new(user_id: @testUser.id, post_id: @testPost.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    testComment.save
    @testUser2.reputation = 499
    @testUser2.save
    sign_in @testUser2
    @testCommentVote = CommentVote.new(user_id: @testUser2.id, comment_id: testComment.id, recorded_vote: 0, positive_vote: false)
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    updatedTestUser = User.find_by_email('email@fakktion.com')
    assert_equal(updatedTestUser.reputation, 499)
    assert_not updatedTestUser.is_super_user
    assert_not updatedTestUser.is_admin
    assert_not updatedTestUser.is_legend
  end
  test "CommentsVote - API - GAIN ADMIN TEST" do
    @testUser.reputation = 1499
    @testUser.save
    testComment = Comment.new(user_id: @testUser.id, post_id: @testPost.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    testComment.save
    @testUser2.reputation = 1499
    @testUser2.save
    sign_in @testUser2
    @testCommentVote = CommentVote.new(user_id: @testUser2.id, comment_id: testComment.id, recorded_vote: 0, positive_vote: true)
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    updatedTestUser = User.find_by_email('email@fakktion.com')
    assert_equal(updatedTestUser.reputation, 1501)
    assert updatedTestUser.is_super_user
    assert updatedTestUser.is_admin
    assert_not updatedTestUser.is_legend
  end
  test "CommentsVote - API - LOSE ADMIN TEST" do
    @testUser.reputation = 1501
    @testUser.save
    testComment = Comment.new(user_id: @testUser.id, post_id: @testPost.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    testComment.save
    @testUser2.reputation = 1501
    @testUser2.save
    sign_in @testUser2
    @testCommentVote = CommentVote.new(user_id: @testUser2.id, comment_id: testComment.id, recorded_vote: 0, positive_vote: false)
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    updatedTestUser = User.find_by_email('email@fakktion.com')
    assert_equal(updatedTestUser.reputation, 1498)
    assert updatedTestUser.is_super_user
    assert_not updatedTestUser.is_admin
    assert_not updatedTestUser.is_legend
  end
  test "CommentsVote - API - GAIN LEGEND TEST" do
    @testUser.reputation = 2998
    @testUser.save
    testComment = Comment.new(user_id: @testUser.id, post_id: @testPost.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    testComment.save
    @testUser2.reputation = 2998
    @testUser2.save
    sign_in @testUser2
    @testCommentVote = CommentVote.new(user_id: @testUser2.id, comment_id: testComment.id, recorded_vote: 0, positive_vote: true)
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    updatedTestUser = User.find_by_email('email@fakktion.com')
    assert_equal(updatedTestUser.reputation, 3001)
    assert updatedTestUser.is_super_user
    assert updatedTestUser.is_admin
    assert updatedTestUser.is_legend
  end
  test "CommentsVote - API - LOSE LEGEND TEST" do
    @testUser.reputation = 3001
    @testUser.save
    testComment = Comment.new(user_id: @testUser.id, post_id: @testPost.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    testComment.save
    @testUser2.reputation = 3001
    @testUser2.save
    sign_in @testUser2
    @testCommentVote = CommentVote.new(user_id: @testUser2.id, comment_id: testComment.id, recorded_vote: 0, positive_vote: false)
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    updatedTestUser = User.find_by_email('email@fakktion.com')
    assert_equal(updatedTestUser.reputation, 2997)
    assert updatedTestUser.is_super_user
    assert updatedTestUser.is_admin
    assert_not updatedTestUser.is_legend
  end
  test "CommentsVote - API - BANNED TEST" do
    @testUser.reputation = 0
    @testUser.save
    testComment = Comment.new(user_id: @testUser.id, post_id: @testPost.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    testComment.save
    @testUser2.reputation = -201
    @testUser2.save
    sign_in @testUser2
    @testCommentVote = CommentVote.new(user_id: @testUser2.id, comment_id: testComment.id, recorded_vote: 0, positive_vote: false)
    post :create, ActiveModelSerializers::SerializableResource.new(@testCommentVote).as_json
    assert_response :forbidden
    updatedTestUser = User.find_by_email('email@fakktion.com')
    assert_equal(updatedTestUser.reputation, 0)
    assert_not updatedTestUser.is_super_user
    assert_not updatedTestUser.is_admin
    assert_not updatedTestUser.is_legend
  end
end
