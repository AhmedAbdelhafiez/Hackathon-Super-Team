class InstallNeighborVector < ActiveRecord::Migration[7.0]
  def change
    #enable_extension "vector"
    ActiveRecord::Base.connection.execute("CREATE EXTENSION IF NOT EXISTS vector;")
  end
end
