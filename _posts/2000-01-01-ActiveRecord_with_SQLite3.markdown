#### database.yaml

    development:
       adapter: sqlite3
       database: cruises.db

#### Ruby Code

    require 'active_record'
    ActiveRecord::Base.logger = Logger.new(STDERR)
    db_config = YAML::load(File.open('database.yml'))
    ActiveRecord::Base.establish_connection(db_config["development"])

<Category:SQLite> <Category:ActiveRecord> <Category:Ruby>
