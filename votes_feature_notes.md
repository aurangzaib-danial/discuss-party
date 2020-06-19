# Votes feature
user can either like a topic or dislike it
user can only do it once
  - if the user presses like then it will update count
  - if the user presses the like button again then the vote will be removed
  - Vice versa for dislike
  However
  - if the user presses dislike and its already like then it will update the vote
user has_many topic_votes


topic_vote = TopicVote.new(topic: topic, user: user, vote: 'like')

topic.like(user) #=> expects a user object only
topic.dislike(user) #=> expects a user object only

.like
  removes dislike
  removes like if already liked

.dislike
  removes like
  remove dislike if already disliked

AssociationTypeMismatch

topic.likes
topic.dislikes

topic.liked?(user)

topic.disliked?(user)
