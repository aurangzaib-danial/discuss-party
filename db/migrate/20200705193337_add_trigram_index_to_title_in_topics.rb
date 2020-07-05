class AddTrigramIndexToTitleInTopics < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    execute('CREATE INDEX CONCURRENTLY index_topics_on_title_trigram ON topics USING gin(title gin_trgm_ops);')
  end
end
