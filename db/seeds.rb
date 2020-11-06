# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
WeekendPrice.create :price => '0.00'
ViewType.create([{view:'Ocean',price:'40'},{view:'Parking lot',price:'15'},{view:'Pool',price:'30'},{view:'Garden',price:'25'}])
RoomType.create([{room:'single beds',price:'30'},{room:'double beds',price:'40'},{room:'Queen beds',price:'50'},{room:'king beds',price:'60'}])
Room.create([{room_num:1,num_of_guess:1,room_type_id:1,view_type_id:1,deleted:false},
              {room_num:2,num_of_guess:1,room_type_id:1,view_type_id:2,deleted:false},
              {room_num:3,num_of_guess:2,room_type_id:1,view_type_id:3,deleted:false},
              {room_num:4,num_of_guess:2,room_type_id:2,view_type_id:4,deleted:false},
              {room_num:5,num_of_guess:3,room_type_id:2,view_type_id:1,deleted:false},
              {room_num:6,num_of_guess:3,room_type_id:2,view_type_id:2,deleted:false},
              {room_num:7,num_of_guess:4,room_type_id:3,view_type_id:3,deleted:false},
              {room_num:8,num_of_guess:4,room_type_id:3,view_type_id:4,deleted:false},
              {room_num:9,num_of_guess:3,room_type_id:3,view_type_id:1,deleted:false},
              {room_num:10,num_of_guess:2,room_type_id:4,view_type_id:2,deleted:false},
              {room_num:11,num_of_guess:1,room_type_id:4,view_type_id:3,deleted:false},
              {room_num:12,num_of_guess:4,room_type_id:4,view_type_id:4,deleted:false},
              {room_num:13,num_of_guess:2,room_type_id:1,view_type_id:1,deleted:false},
              {room_num:14,num_of_guess:3,room_type_id:1,view_type_id:1,deleted:false},
              {room_num:15,num_of_guess:4,room_type_id:1,view_type_id:1,deleted:false},
              {room_num:16,num_of_guess:2,room_type_id:2,view_type_id:2,deleted:false},
              {room_num:17,num_of_guess:3,room_type_id:2,view_type_id:2,deleted:false},
              {room_num:18,num_of_guess:4,room_type_id:2,view_type_id:2,deleted:false},
              {room_num:19,num_of_guess:1,room_type_id:3,view_type_id:3,deleted:false},
              {room_num:20,num_of_guess:2,room_type_id:3,view_type_id:3,deleted:false},
              {room_num:21,num_of_guess:3,room_type_id:1,view_type_id:3,deleted:false},
              {room_num:22,num_of_guess:4,room_type_id:1,view_type_id:4,deleted:false},
              {room_num:23,num_of_guess:1,room_type_id:4,view_type_id:4,deleted:false}])
