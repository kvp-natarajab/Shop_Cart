

r1 = Role.create({name: "Customer", description: "Can read items"}) 
r2 = Role.create({name: "Seller", description: "Can read and find_or_create_by items. Can update and destroy own items"}) 
r3 = Role.create({name: "Admin", description: "Can perform any CRUD operation on any resource"})
admin = User.create({name: "raj", landmark:"Near forum Mall", phone:"7795179882", address:"Adugodi", city:"Bangalore", state:"Karnataka", country:"India", pincode:"671552", email: "natarajavcet@gmail.com", password: "12345678", password_confirmation: "12345678", role_id: r3.id})
cust = User.create({name: "raj", landmark:"Near forum Mall", phone:"7795179881", address:"Adugodi", city:"Bangalore", state:"Karnataka", country:"India", pincode:"671552", email: "cust@gmail.com", password: "12345678", password_confirmation: "12345678", role_id: r1.id})
sell = User.create({name: "raj", landmark:"Near forum Mall", phone:"7795179880", address:"Adugodi", city:"Bangalore", state:"Karnataka", country:"India", pincode:"671552", email: "seller@gmail.com", password: "12345678", password_confirmation: "12345678", role_id: r2.id})

