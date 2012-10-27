# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#AdminUser.first.add_role "Admin"
Role.create(name: 'Admin')
Role.create(name: 'Korwaswil')
Role.create(name: 'Kabidwas')
Role.create(name: 'Direksi')
Role.create(name: 'Kepala SPI')
Role.create(name: 'Staff')
Role.create(name: 'Staff Tata Usaha')
Role.create(name: 'Ketua Tim')
Role.create(name: 'Anggota Tim')