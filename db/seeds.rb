# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

r1 = Role.find_or_create_by({name: "Customer", description: "Can read items"})
r2 = Role.find_or_create_by({name: "Seller", description: "Can read and find_or_create_by items. Can update and destroy own items"})
r3 = Role.find_or_create_by({name: "Admin", description: "Can perform any CRUD operation on any resource"})

# u1 = User.find_or_create_by({name: "raj", email: "raj@gmail.com", password: "12345678", password_confirmation: "12345678", role_id: r1.id})
# u2 = User.find_or_create_by({name: "raj", email: "raja@example.com", password: "12345678", password_confirmation: "12345678", role_id: r2.id})
u3 = User.create({name: "raj", landmark:"Near forum Mall", phone:"7795179882", address:"Adugodi", city:"Bangalore", state:"Karnataka", country:"India", email: "admin@example.com", password: "12345678", password_confirmation: "12345678", role_id: r3.id}) unless User.find_by_email("admin@example.com")
# u4 = User.find_or_create_by({name: "raj", phone: "8792226597", address:"Kasaragod", email: "nataraja.b@kvpcorp.com", password: "12345678", password_confirmation: "12345678", role_id: r1.id})


