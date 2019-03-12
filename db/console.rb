require_relative('../models/bounty')

bounty1 = Bounty.new( {'name' => 'Nettle', 'species' => 'Kharqren', 'bounty_value' => '15000','fave_weapon' => 'galactic gunfighter'})
bounty2 = Bounty.new({'name' => 'Virgil \'the Gentle\' McGowan', 'species' => 'Streigaeth', 'bounty_value' => '50000', 'fave_weapon' => 'laser crossbow'})

Bounty.delete_all

bounty1.save()
bounty2.save()


# all = Bounty.all()
# p all

# bounty1.name = "Russell \'Demon Eyes\' Wolf"
#
# bounty1.update()

# Bounty.delete_all

# found = Bounty.find_by_name('jgijghoidsf')
# p found

found = Bounty.find_by_id(30)
p found

# all = Bounty.all()
# p all
