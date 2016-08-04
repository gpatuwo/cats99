# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
c1 = Cat.create!(birth_date: "1987/10/05", color: "brown", name: "Michael", sex: "M", description: "cool cat")
c2 = Cat.create!(birth_date: "1990/07/20", color: "orange", name: "Jangmi", sex: "F", description: "cool cat")
c3 = Cat.create!(birth_date: "2008/09/25", color: "black", name: "Grace", sex: "F", description: "cool cat")
c4 = Cat.create!(birth_date: "2014/08/01", color: "white", name: "Forest", sex: "M", description: "cool cat")

r1 = CatRentalRequest.create!(cat_id: c1.id, start_date: "2016/09/10", end_date: "2016/09/20")
r2 = CatRentalRequest.create!(cat_id: c2.id, start_date: "2016/10/01", end_date: "2016/10/10")
r3 = CatRentalRequest.create!(cat_id: c3.id, start_date: "2016/12/24", end_date: "2016/12/25")
