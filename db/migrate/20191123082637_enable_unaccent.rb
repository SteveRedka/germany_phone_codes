class EnableUnaccent < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'unaccent'
  end
end
