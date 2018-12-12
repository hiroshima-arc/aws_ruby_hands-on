class CreateMovies < ActiveRecord::Migration
  def up
    migration = Aws::Record::TableMigration.new(Movie)
    migration.create!(
                 provisioned_throughput: {
                     read_capacity_units: 1,
                     write_capacity_units: 1
                 }
    )
    migration.wait_until_available
  end

  def down
    migration = Aws::Record::TableMigration.new(Movie)
    migration.delete!
  end
end
