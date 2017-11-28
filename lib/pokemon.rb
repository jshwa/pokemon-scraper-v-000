require 'pry'

class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id:, name:, type:, db:, hp: nil)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id, db)
    pokemon = db.execute("SELECT * FROM pokemon WHERE pokemon.id = ?", id)
    # binding.pry
    db.execute("UPDATE pokemon SET hp = 60 WHERE id = ?", id) if pokemon[0][3] == nil
    Pokemon.new(id:id, name: "#{pokemon[0][1]}", type: "#{pokemon[0][2]}", db: db, hp: pokemon[0][3]})
  end

  def alter_hp(hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", hp, self.id)
  end
end
