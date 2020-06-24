N Queries Problem

2 main problems (36 ms before now 77ms)

1. We have to find if the user has a vote on every topic one by one.
topic_votes.find_by(user: user)
topic_id 1 and user_id 1

topic.current_user_vote

2. We have to count likes and dislikes for every topic one by one.

