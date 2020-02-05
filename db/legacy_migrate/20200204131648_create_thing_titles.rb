class CreateThingTitles < ActiveRecord::Migration[6.0]
  def change
    create_view :thing_titles
  end
end
