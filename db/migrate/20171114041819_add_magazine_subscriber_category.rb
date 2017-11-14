class AddMagazineSubscriberCategory < ActiveRecord::Migration[5.1]
  def change
    create_table :magazines do |t|
      t.string :name
      t.timestamps
    end

    create_table :subscribers do |t|
      t.string :name
      t.timestamps
    end

    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :categories_magazines do |t|
      t.belongs_to :magazine
      t.belongs_to :category
      t.timestamps
    end
    add_index :categories_magazines, [:magazine_id, :category_id], :unique => true

    create_table :categories_subscribers do |t|
      t.belongs_to :subscriber
      t.belongs_to :category
      t.timestamps
    end
    add_index :categories_subscribers, [:subscriber_id, :category_id], :unique => true

  end
end
