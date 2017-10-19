require 'sqlite3'
require 'singleton'


#inheritting from the SQL database allows you to do SQL stuff
#like execute strings of text
class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    #tells it which database it should be accessing
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play

  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
    #RETURNS AN ARRAY OF PLAY OBJECTS, BASED ON THE DATABASE
  end

  def self.find_by_title(title)
    play = PlayDBConnection.instance.execute(<<-SQL, title)
      --RECEIVES ALL INFORMATION ABOUT THAT PLAY
      SELECT
        *
      FROM
        plays
      WHERE
        title = ?
    SQL
    return nil unless play.length > 0

    #AFTER RECEIVING ALL INFORMATION ABOUT THAT PLAY, CREATES
    #A NEW PLAY CLASS INSTANCE

    Play.new(play.first) # play is stored in an array!
  end

  def self.find_by_playwright(name)
    #LOOK AT THIS LATER
    playwright = Playwright.find_by_name(name)
    #THIS IS A PLAYWRIGHT OBJECT
    raise "#{name} not found in DB" unless playwright
    # Playwright.find_by_name(name) wil return nil if the playwright does not exist


    plays = PlayDBConnection.instance.execute(<<-SQL, playwright.id)
      SELECT
        *
      FROM
        plays
       WHERE --THIS ? WILL REFER TO THE FIRST ARGUMENT IN EXECUTE, WHICH IS PLAYWRIGHT.ID
        playwright_id = ?
    SQL

    plays.map { |play| Play.new(play) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id

    # USING THE SQL3 GEM, YOU CAN USE EXECUTE, AND PASS IN VALUES
    # TO THE STRING BELOW

    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
      -- USING THE QUESsTION MARKS SANITIZES THE INPUTS, ESCAPES ANY CHARACTERS
      -- ABOVE THAT MIGHT BE MALICIOUS
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

class Playwright
  attr_accessor :name, :birth_year
  attr_reader :id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    person = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = ?
    SQL
    return nil unless person.length > 0 # person is stored in an array!

    Playwright.new(person.first)
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    raise "#{self} not in database" unless @id
    plays = PlayDBConnection.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
    SQL
    plays.map { |play| Play.new(play) }
  end

end
