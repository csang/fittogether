class CreateCmsPages < ActiveRecord::Migration
  def change
    create_table :cms_pages do |t|
      t.string :name
      t.text :content
      t.string :meta_title
      t.string :seo_url
      t.text :meta_desc
      t.text :meta_keyword
      t.boolean :status, :default => true
      t.boolean :show_in_footer, :default =>true

      t.timestamps
    end
  end
end
