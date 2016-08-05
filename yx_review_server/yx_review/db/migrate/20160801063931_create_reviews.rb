class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :cover_image
      t.string :summary
      t.string :score

      t.timestamps null: false
    end
  end
end
