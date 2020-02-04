class CreatePostTitles < ActiveRecord::Migration[6.0]
  def change
    create_view :post_titles
  end
end
