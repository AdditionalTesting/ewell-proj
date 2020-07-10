class CreateWebsites < ActiveRecord::Migration[6.0]
  def change
    create_table :websites do |t|
      t.string :url
      t.belongs_to :member, foreign_key: true
      t.string :headings, array: true, default: []
      t.string :short_url
    end
  end
end
