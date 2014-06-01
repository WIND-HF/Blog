class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :name
      t.string :filetype
      t.string :path

      t.timestamps
    end
  end
end
