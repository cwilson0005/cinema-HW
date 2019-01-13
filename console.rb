require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')
require('pry')

Customer.delete_all()
Screening.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new(
  {
    'name' => 'Conor Wilson',
    'funds' => '100'
  }
)

film1 = Film.new(
  {
    'title' => 'Conan the Barbarian',
    'price' => '10'
  }
)

customer1.save()
customer1.funds = '200'

film1.save()
film1.title = 'Conan the Destroyer'
film1.price = '15'


screening1 = Screening.new(
  {
    'show_time' => '20:00'
  }
)

screening1.save()

ticket1 = Ticket.new(
  {
    'customer_id' => customer1.id,
    'film_id' => film1.id,
    'screen_id' => screening1.id
  }
)

ticket1.save()

binding.pry
nil
