require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')
require('pry')

Customer.delete_all()

customer1 = Customer.new(
  {
    'name' => 'Conor Wilson',
    'funds' => '100'
  }
)

customer1.save()

binding.pry
nil
