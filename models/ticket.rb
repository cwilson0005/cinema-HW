require_relative("../db/sql_runner")

class Ticket

  attr_accessor(:customer_id, :film_id, :screen_id)
  attr_reader(:id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screen_id = options['screen_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, screen_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@customer_id, @film_id, @screen_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id, screen_id) = ($1, $2, $3) WHERE id = $4"
    values = [@customer_id, @film_id, @screen_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map {|ticket| Ticket.new(ticket)}
    return result
  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql, values)
    return Film.new(film)
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer = SqlRunner.run(sql, values)
    return Customer.new(customer)
  end

  def screening()
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [@screen_id]
    screening = SqlRunner.run(sql, values)
    return Screening.new(screening)
  end

end
