class AddsRelationBetweenQuestionsAndTopics < ActiveRecord::Migration
  def up

    create_table :questions_topics, id: false do |t|
      t.references :question
      t.references :topic
    end

  end

  def down
    remove_table :questions_topics
  end

end
