require_relative("../db/sql_runner")

class Screening

  attr_accessor(:show_time)
  attr_reader(:id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @show_time = options['show_time']
  end

  def save()
    sql = "INSERT INTO screenings (show_time) VALUES ($1) RETURNING id"
    values = [@show_time]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE screenings SET (show_time) = ($1) WHERE id = $2"
    values = [@show_time, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    result = screenings.map {|screening| Screening.new(screening)}
    return result
  end

  # def customers()
  #   sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
  #   values = [@id]
  #   customer_data = SqlRunner.run(sql, values)
  #   return Customer.map_items(customer_data)
  # end

end
