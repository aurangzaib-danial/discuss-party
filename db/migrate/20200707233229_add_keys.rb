class AddKeys < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key "comments", "topics"
    remove_foreign_key "comments", "users"
    remove_foreign_key "topics", "users", column: "creator_id"
    add_foreign_key "comments", "topics", on_update: :cascade, on_delete: :cascade
    add_foreign_key "comments", "users", on_update: :cascade, on_delete: :cascade
    add_foreign_key "topic_tags", "tags", name: "topic_tags_tag_id_fk", on_update: :cascade, on_delete: :cascade
    add_foreign_key "topic_tags", "topics", name: "topic_tags_topic_id_fk", on_update: :cascade, on_delete: :cascade
    add_foreign_key "topic_votes", "topics", name: "topic_votes_topic_id_fk", on_update: :cascade, on_delete: :cascade
    add_foreign_key "topic_votes", "users", name: "topic_votes_user_id_fk", on_update: :cascade, on_delete: :cascade
    add_foreign_key "topics", "users", column: "creator_id", on_update: :cascade, on_delete: :cascade
    add_foreign_key "viewers", "topics", name: "viewers_topic_id_fk", on_update: :cascade, on_delete: :cascade
    add_foreign_key "viewers", "users", name: "viewers_user_id_fk", on_update: :cascade, on_delete: :cascade
  end
end
