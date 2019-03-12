require('pg')

class Bounty
attr_accessor :name, :species, :bounty_value, :fave_weapon
attr_reader :id

  def initialize(options)
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i
    @fave_weapon = options['fave_weapon']
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect( {dbname: 'bounty', host: 'localhost'} )

    sql = "INSERT INTO bounty (
    name, species, bounty_value, fave_weapon
    )
    VALUES(
      $1, $2, $3, $4
      )
      RETURNING *;"

      values = [@name, @species, @bounty_value, @fave_weapon]

      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]["id"].to_i
      db.close()
  end

  def Bounty.all()
    db = PG.connect( {dbname: 'bounty', host: 'localhost'} )

    sql = "SELECT * FROM bounty;"

    db.prepare("all", sql)
    all_bounties = db.exec_prepared("all")
    db.close

    return all_bounties.map { |hash | Bounty.new(hash) }
  end

  def update()
    db = PG.connect( {dbname: 'bounty', host: 'localhost'} )

    sql = "UPDATE bounty SET (
    name, species, bounty_value, fave_weapon
    )
    = (
      $1, $2, $3, $4
      )
      WHERE id = $5;"

      values = [@name, @species, @bounty_value, @fave_weapon, @id]

      db.prepare("update", sql)
      db.exec_prepared("update", values)
      db.close
  end

  def delete()
    db = PG.connect( {dbname: 'bounty', host: 'localhost'} )

    sql = "DELETE FROM bounty WHERE id = $1;"
    values = [@id]

    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close
  end

  def Bounty.delete_all()
    db = PG.connect( {dbname: 'bounty', host: 'localhost'} )

    sql = "DELETE FROM bounty;"

    db.prepare("all", sql)
    db.exec_prepared("all")
    db.close
  end

  def Bounty.find_by_name(ask_name)
    db = PG.connect( {dbname: 'bounty', host: 'localhost'} )

    sql = "SELECT * FROM bounty WHERE name = $1;"

    values = [ask_name]

    db.prepare("find_name", sql)
    found_name = db.exec_prepared("find_name", values)
    db.close

    if found_name.ntuples == 0
      return nil
    end

    bounty_hash = found_name[0]

   bounty =   Bounty.new(bounty_hash)
   return bounty

  end

  def Bounty.find_by_id(ask_id)
    db = PG.connect( {dbname: 'bounty', host: 'localhost'} )

    sql = "SELECT * FROM bounty WHERE id = $1;"

    values = [ask_id]

    db.prepare("find_id", sql)
    found_id = db.exec_prepared("find_id", values)

    db.close
    if found_id.ntuples == 0
      return nil
    end
    id_hash = found_id[0]

   bounty = Bounty.new(id_hash)
   return bounty
  end
end
