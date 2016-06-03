# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Goal.create([
{ name: 'get healthy'}, 
{ name: 'lose weight'}, 
{ name: 'stay healthy'}, 
{ name: 'train for professional purposes'},
{ name: 'specific'}
]);

Relationship.create([
{ name: 'SINGLE'}, 
{ name: 'Complicated'}, 
{ name: 'Dating'}, 
{ name: 'Engaged'}, 
{ name: 'Married'}

]);

Industry.create([
{ name: 'Software'}, 
{ name: 'Health'}, 
{ name: 'Machinery'}, 
{ name: 'Cement'}
]);
Profession.create([
{ name: 'Accounting and finance'}, 
{ name: 'Actuarial'}, 
{ name: 'Broadcast engineering'}, 
{ name: 'Economics'},
{ name: 'Emergency management'},
{ name: 'Engineering and geological sciences'},
{ name: 'Geospatial'},
{ name: 'Government'},
{ name: 'Law'},
{ name: 'Information'},
{ name: 'Real estate'},
{ name: 'Military'}
]);


Reason.create([
{ name: 'business'}, 
{ name: 'health and fitness'}, 
{ name: 'meet people'}, 
{ name: 'find people who are interested in what I am'},
{ name: 'networking'}

]);

Activity.create([
{ name: 'boot_camp'}, 
{ name: 'cardio_circuit'}, 
{ name: 'pilates'},
{ name: 'running'}, 
{ name: 'spinning'}, 
{ name: 'swimming'}, 
{ name: 'yoga'}, 
{ name: 'tennis'}
]);
Privacy.create([
{ name: 'Profile Picture',slug: 'profile_pic'}, 
{ name: 'Email Address' ,slug: 'email'}, 
{ name: 'Mobile Number',slug: 'mobile'}, 
{ name: 'Birthday',slug: 'birthday'},
{ name: 'Where you work',slug: 'work'},
{ name: 'City you live',slug: 'location'},
{ name: 'Bio',slug: 'bio'},
]);

Gym.create([
{ name: 'ABC'}, 
{ name: 'XYZ'}, 
{ name: 'PQR'}
]);


State.create([
 {name: 'Alaska', state_code: 'AK'},
 {name:'Alabama', state_code:'AL'},
 {name:'Arkansas', state_code:'AR'},
 {name:'Arizona', state_code:'AZ'},
 {name:'California', state_code:'CA'},
 {name:'Colorado', state_code:'CO'},
 {name:'Connecticut',state_code: 'CT'},
 {name:'District of Columbia',state_code: 'DC'},
 {name:'Delaware',state_code: 'DE'},
 {name:'Florida', state_code:'FL'},
 {name:'Georgia', state_code:'GA'},
 {name:'Hawaii',state_code: 'HI'},
 {name:'Iowa', state_code:'IA'},
 {name:'Idaho', state_code:'ID'},
 {name:'Illinois', state_code:'IL'},
 {name:'Indiana',state_code: 'IN'},
 {name:'Kansas', state_code:'KS'},
 {name:'Kentucky',state_code: 'KY'},
 {name:'Louisiana', state_code:'LA'},
 {name:'Massachusetts',state_code: 'MA'},
 {name:'Maryland', state_code:'MD'},
 {name:'Maine',state_code: 'ME'},
 {name:'Michigan', state_code:'MI'},
 {name:'Minnesota', state_code:'MN'},
 {name:'Missouri', state_code:'MO'},
 {name:'Mississippi', state_code:'MS'},
 {name:'Montana',state_code: 'MT'},
 {name:'North Carolina', state_code:'NC'},
 {name:'North Dakota', state_code: 'ND'},
 {name:'Nebraska',state_code: 'NE'},
 {name:'New Hampshire',state_code: 'NH'},
 {name:'New Jersey',state_code: 'NJ'},
 {name:'New Mexico', state_code:'NM'},
 {name:'Nevada',state_code: 'NV'},
 {name:'New York',state_code: 'NY'},
 {name:'Ohio', state_code:'OH'},
 {name:'Oklahoma', state_code:'OK'},
 {name:'Oregon',state_code: 'OR'},
 {name:'Pennsylvania',state_code: 'PA'},
 {name:'Rhode Island',state_code: 'RI'},
 {name:'South Carolina',state_code: 'SC'},
 {name:'South Dakota',state_code: 'SD'},
 {name:'Tennessee',state_code: 'TN'},
 {name:'Texas',state_code: 'TX'},
 {name:'Utah', state_code:'UT'},
 {name:'Virginia', state_code:'VA'},
 {name:'Vermont', state_code:'VT'},
 {name:'Washington',state_code: 'WA'},
 {name:'Wisconsin', state_code:'WI'},
 {name:'West Virginia', state_code:'WV'},
 {name:'Wyoming',state_code: 'WY'}

]);
City.create([
 { name:'Aaronsburg', state_code:  'PA'},
 { name:'Abbeville', state_code:  'SC'},
 { name:'Abbot', state_code:  'ME'},
 { name:'Abbotsford', state_code:  'WI'},
 { name:'Abbott', state_code:  'TX'},
 { name:'Abbottstown', state_code:  'PA'},
 { name:'Abbyville', state_code:  'KS'},
 { name:'Amsterdam', state_code:  'OH'},
 { name:'Amston', state_code:  'CT'},
 { name:'Anabel', state_code:  'MO'},
 { name:'Anacoco', state_code:  'LA'},
 { name:'Anaconda', state_code:  'MT'},
 { name:'Anacortes', state_code:  'WA'},
 { name:'Anadarko', state_code:  'OK'},
 { name:'Anaheim', state_code:  'CA'},
 { name:'Anahola', state_code:  'HI'},
 { name:'Anahuac', state_code:  'TX'},
 { name:'Anaktuvuk Pass', state_code:  'AK'},
 { name:'Analomink', state_code:  'PA'},
 { name:'Anamoose', state_code:  'ND'},
 { name:'Anamosa', state_code:  'IA'},
 { name:'Anasco', state_code:  'PR'},
 { name:'Anatone', state_code:  'WA'},
 { name:'Anawalt', state_code:  'WV'},
 { name:'Anchor', state_code:  'IL'},
 { name:'Anchor Point', state_code:  'AK'},
  { name:'Banks', state_code:  'AR'},
 { name:'Banks', state_code:  'ID'},
 { name:'Banks', state_code:  'OR'},
 { name:'Bankston', state_code:  'AL'},
 { name:'Banner', state_code:  'KY'},
 { name:'Banner', state_code:  'MS'},
 { name:'Banner', state_code:  'WY'},
 { name:'Banner Elk', state_code:  'NC'},
 { name:'Banning', state_code:  'CA'},
 { name:'Bannister', state_code:  'MI'},
 { name:'Bannock', state_code:  'OH'},
 { name:'Banquete', state_code:  'TX'},
 { name:'Bantam', state_code:  'CT'},
 { name:'Bantry', state_code:  'ND'},
 { name:'Bapchule', state_code:  'AZ'},
 { name:'Baptistown', state_code:  'NJ'},
 { name:'Bar Harbor', state_code:  'ME'},
 { name:'Bar Mills', state_code:  'ME'},
 { name:'Baraboo', state_code:  'WI'},
 { name:'Baraga', state_code:  'MI'},
 { name:'Barataria', state_code:  'LA'},
 { name:'Barbeau', state_code:  'MI'},
 { name:'Barberton', state_code:  'OH'},
 { name:'Barberville', state_code:  'FL'},
 { name:'Barboursville', state_code:  'VA'},
 { name:'Barboursville', state_code:  'WV'},
 { name:'Barbourville', state_code:  'KY'},
 { name:'Barceloneta', state_code:  'PR'},
 { name:'Barclay', state_code:  'MD'},
 { name:'Barco', state_code:  'NC'},
 { name:'Bard', state_code:  'CA'},
 { name:'Bard', state_code:  'NM'},
 { name:'Bardolph', state_code:  'IL'},
 { name:'Bardstown', state_code:  'KY'},
 { name:'Bardwell', state_code:  'KY'},
 { name:'Bienville', state_code:  'LA'},
 { name:'Big Arm', state_code:  'MT'},
 { name:'Big Bar', state_code:  'CA'},
 { name:'Big Bay', state_code:  'MI'},
 { name:'Big Bear City', state_code:  'CA'},
 { name:'Big Bear Lake', state_code:  'CA'},
 { name:'Big Bend', state_code:  'CA'},
 { name:'Big Bend', state_code:  'WI'},
 { name:'Big Bend', state_code:  'WV'},
 { name:'Big Bend National Park', state_code:  'TX'},
 { name:'Big Cabin', state_code:  'OK'},
 { name:'Big Clifty', state_code:  'KY'},
 { name:'Big Cove Tannery', state_code:  'PA'},
 { name:'Big Creek', state_code:  'CA'},
 { name:'Big Creek', state_code:  'KY'},
 { name:'Big Creek', state_code:  'MS'},
 { name:'Big Creek', state_code:  'WV'},
 { name:'Big Falls', state_code:  'MN'},
 { name:'Big Falls', state_code:  'WI'},
 { name:'Big Flat', state_code:  'AR'},
 { name:'Big Flats', state_code:  'NY'},
 { name:'Big Horn', state_code:  'WY'},
 { name:'Big Indian', state_code:  'NY'},
 { name:'Big Island', state_code:  'VA'},
 { name:'Big Lake', state_code:  'AK'},
 { name:'Big Lake', state_code:  'MN'},
 { name:'Big Lake', state_code:  'TX'},
 { name:'Big Laurel', state_code:  'KY'},
 { name:'Big Oak Flat', state_code:  'CA'},
 { name:'Big Pine', state_code:  'CA'},
 { name:'Big Pine Key', state_code:  'FL'},
 { name:'Big Piney', state_code:  'WY'},
 { name:'Big Pool', state_code:  'MD'},
 { name:'Big Prairie', state_code:  'OH'},
 { name:'Big Rapids', state_code:  'MI'},
 { name:'Big Rock', state_code:  'IL'},
 { name:'Big Rock', state_code:  'TN'},
 { name:'Big Rock', state_code:  'VA'},
 { name:'Big Run', state_code:  'PA'},
 { name:'Big Run', state_code:  'WV'},
 { name:'Big Sandy', state_code:  'MT'},
 { name:'Big Sandy', state_code:  'TN'},
 { name:'Big Sandy', state_code:  'TX'},
 { name:'Big Sandy', state_code:  'WV'},
 { name:'Big Sky', state_code:  'MT'},
 { name:'Big Spring', state_code:  'TX'},
 { name:'Big Springs', state_code:  'NE'},
 { name:'Big Springs', state_code:  'WV'},
 { name:'Big Stone City', state_code:  'SD'},
 { name:'Big Stone Gap', state_code:  'VA'},
 { name:'Big Sur', state_code:  'CA'},
 { name:'Big Timber', state_code:  'MT'},
 { name:'Big Wells', state_code:  'TX'},
 { name:'Bigelow', state_code:  'AR'},
 { name:'Bigelow', state_code:  'MN'},
 { name:'Bigfoot', state_code:  'TX'},
 { name:'Bigfork', state_code:  'MN'},
 { name:'Bigfork', state_code:  'MT'},
 { name:'Biggers', state_code:  'AR'},
 { name:'Biggs', state_code:  'CA'},
 { name:'Biggsville', state_code:  'IL'},
 { name:'Bighill', state_code:  'KY'},
 { name:'Bighorn', state_code:  'MT'},
 { name:'Bigler', state_code:  'PA'},
 { name:'Biglerville', state_code:  'PA'},
 { name:'Billerica', state_code:  'MA'},
 { name:'Billings', state_code:  'MO'},
 { name:'Billings', state_code:  'MT'},
 { name:'Billings', state_code:  'NY'},
 { name:'Billings', state_code:  'OK'},
 { name:'Billingsley', state_code:  'AL'},
 { name:'Biloxi', state_code:  'MS'},
 { name:'Bim', state_code:  'WV'},
 { name:'Bimble', state_code:  'KY'},
 { name:'Binford', state_code:  'ND'},
 { name:'Bingen', state_code:  'WA'},
 { name:'Binger', state_code:  'OK'},
 { name:'Bingham', state_code:  'IL'},
 { name:'Bingham', state_code:  'ME'},
 { name:'Bingham', state_code:  'NE'},
 { name:'Bingham Canyon', state_code:  'UT'},
 { name:'Bingham Lake', state_code:  'MN'},
 { name:'Binghamton', state_code:  'NY'},
 { name:'Biola', state_code:  'CA'},
 { name:'Bippus', state_code:  'IN'},
 { name:'Birch Harbor', state_code:  'ME'},
 { name:'Birch River', state_code:  'WV'},
 { name:'Birch Run', state_code:  'MI'},
 { name:'Birch Tree', state_code:  'MO'},
 { name:'Birchdale', state_code:  'MN'},
 { name:'Birchleaf', state_code:  'VA'},
 { name:'Birchrunville', state_code:  'PA'},
 { name:'Birchwood', state_code:  'TN'},
 { name:'Birchwood', state_code:  'WI'},
 { name:'Bird City', state_code:  'KS'},
 { name:'Bird In Hand', state_code:  'PA'},
 { name:'Bird Island', state_code:  'MN'},
 { name:'Birds Landing', state_code:  'CA'},
 { name:'Birdsboro', state_code:  'PA'},
 { name:'Birdseye', state_code:  'IN'},
 { name:'Birdsnest', state_code:  'VA'},
 { name:'Birmingham', state_code:  'AL'},
 { name:'Birmingham', state_code:  'IA'},
 { name:'Birmingham', state_code:  'MI'},
 { name:'Birmingham', state_code:  'NJ'},
 { name:'Birmingham', state_code:  'OH'},
 { name:'Birnamwood', state_code:  'WI'},
 { name:'Birney', state_code:  'MT'},
 { name:'Bisbee', state_code:  'AZ'},
 { name:'Bisbee', state_code:  'ND'},
 { name:'Biscoe', state_code:  'AR'},
 { name:'Biscoe', state_code:  'NC'},
 { name:'Bishop', state_code:  'CA'},
 { name:'Bishop', state_code:  'GA'},
 { name:'Bishop', state_code:  'TX'},
 { name:'Bishop', state_code:  'VA'},
 { name:'Bishop Hill', state_code:  'IL'},
 { name:'Bishopville', state_code:  'MD'},
 { name:'Bishopville', state_code:  'SC'},
 { name:'Bismarck', state_code:  'AR'},
 { name:'Bismarck', state_code:  'IL'},
 { name:'Bismarck', state_code:  'MO'},
 { name:'Bismarck', state_code:  'ND'},
 { name:'Bison', state_code:  'KS'},
 { name:'Bison', state_code:  'OK'},
 { name:'Bison', state_code:  'SD'},
 { name:'Bitely', state_code:  'MI'},
 { name:'Bittinger', state_code:  'MD'},
 { name:'Bivalve', state_code:  'MD'},
 { name:'Bivins', state_code:  'TX'},
 { name:'Biwabik', state_code:  'MN'},
 { name:'Bixby', state_code:  'MO'},
 { name:'Bixby', state_code:  'OK'},
 { name:'Blachly', state_code:  'OR'},
 { name:'Black', state_code:  'AL'},
 { name:'Black', state_code:  'MO'},
 { name:'Black Canyon City', state_code:  'AZ'},
 { name:'Black Creek', state_code:  'NC'},
 { name:'Black Creek', state_code:  'NY'},
 { name:'Black Creek', state_code:  'WI'},
 { name:'Black Diamond', state_code:  'WA'},
 { name:'Black Eagle', state_code:  'MT'},
 { name:'Black Earth', state_code:  'WI'},
 { name:'Black Hawk', state_code:  'CO'},
 { name:'Black Hawk', state_code:  'SD'},
 { name:'Black Lick', state_code:  'PA'},
 { name:'Black Mountain', state_code:  'NC'},
 { name:'Black Oak', state_code:  'AR'},
 { name:'Black River', state_code:  'MI'},
 { name:'Black River', state_code:  'NY'},
 { name:'Black River Falls', state_code:  'WI'},
 { name:'Black Rock', state_code:  'AR'},
 { name:'Blackburn', state_code:  'MO'},
 { name:'Blackduck', state_code:  'MN'},
 { name:'Blackey', state_code:  'KY'},
 { name:'Blackfoot', state_code:  'ID'},
 { name:'Blackford', state_code:  'KY'},
 { name:'Blacklick', state_code:  'OH'},
 { name:'Blacksburg', state_code:  'SC'},
 { name:'Blacksburg', state_code:  'VA'},
 { name:'Blackshear', state_code:  'GA'},
 { name:'Blackstock', state_code:  'SC'},
 { name:'Blackstone', state_code:  'IL'},
 { name:'Blackstone', state_code:  'MA'},
 { name:'Blackstone', state_code:  'VA'},
 { name:'Blacksville', state_code:  'WV'},
 { name:'Blackville', state_code:  'SC'},
 { name:'Blackwater', state_code:  'MO'},
 { name:'Blackwater', state_code:  'VA'},
 { name:'Blackwell', state_code:  'MO'},
 { name:'Blackwell', state_code:  'OK'},
 { name:'Blackwell', state_code:  'TX'},
 { name:'Blackwood', state_code:  'NJ'},
 { name:'Bladen', state_code:  'NE'},
 { name:'Bladenboro', state_code:  'NC'},
 { name:'Bladensburg', state_code:  'MD'},
 { name:'Bladensburg', state_code:  'OH'},
 { name:'Blain', state_code:  'PA'},
 { name:'Blaine', state_code:  'KY'},
 { name:'Blaine', state_code:  'ME'},
 { name:'Blaine', state_code:  'OH'},
 { name:'Blaine', state_code:  'TN'},
 { name:'Blaine', state_code:  'WA'},
 { name:'Blair', state_code:  'NE'},
 { name:'Blair', state_code:  'OK'},
 { name:'Blair', state_code:  'SC'},
 { name:'Blair', state_code:  'WI'},
 { name:'Blair', state_code:  'WV'},
 { name:'Blairs', state_code:  'VA'},
 { name:'Blairs Mills', state_code:  'PA'},
 { name:'Blairsburg', state_code:  'IA'},
 { name:'Blairsden-graeagle', state_code:  'CA'},
 { name:'Blairstown', state_code:  'IA'},
 { name:'Blairstown', state_code:  'MO'},
 { name:'Blairstown', state_code:  'NJ'},
 { name:'Blairsville', state_code:  'GA'},
 { name:'Blairsville', state_code:  'PA'},
 { name:'Blakely', state_code:  'GA'},
 { name:'Blakely Island', state_code:  'WA'},
 { name:'Blakesburg', state_code:  'IA'},
 { name:'Blakeslee', state_code:  'OH'},
 { name:'Blakeslee', state_code:  'PA'},
 { name:'Blanca', state_code:  'CO'},
 { name:'Blanch', state_code:  'NC'},
 { name:'Blanchard', state_code:  'IA'},
 { name:'Blanchard', state_code:  'ID'},
 { name:'Blanchard', state_code:  'LA'},
 { name:'Blanchard', state_code:  'MI'},
 { name:'Blanchard', state_code:  'ND'},
 { name:'Blanchard', state_code:  'OK'},
 { name:'Blanchard', state_code:  'PA'},
 { name:'Blanchardville', state_code:  'WI'},
 { name:'Blanchester', state_code:  'OH'},
 { name:'Blanco', state_code:  'NM'},
 { name:'Blanco', state_code:  'OK'},
 { name:'Blanco', state_code:  'TX'},
 { name:'Bland', state_code:  'MO'},
 { name:'Bland', state_code:  'VA'},
 { name:'Blandburg', state_code:  'PA'},
 { name:'Blandford', state_code:  'MA'},
 { name:'Blanding', state_code:  'UT'},
 { name:'Bluff City', state_code:  'KS'},
 { name:'Bluff City', state_code:  'TN'},
 { name:'Bluff Dale', state_code:  'TX'},
 { name:'Bluff Springs', state_code:  'IL'},
 { name:'Bluffs', state_code:  'IL'},
 { name:'Bluffton', state_code:  'AR'},
 { name:'Bluffton', state_code:  'GA'},
 { name:'Bluffton', state_code:  'IN'},
 { name:'Bluffton', state_code:  'MN'},
 { name:'Bluffton', state_code:  'OH'},
 { name:'Bluffton', state_code:  'SC'},
 { name:'Bluffton', state_code:  'TX'},
 { name:'Bluford', state_code:  'IL'},
 { name:'Blum', state_code:  'TX'},
 { name:'Blunt', state_code:  'SD'},
 { name:'Bly', state_code:  'OR'},
 { name:'Blythe', state_code:  'CA'},
 { name:'Blythe', state_code:  'GA'},
 { name:'Blythedale', state_code:  'MO'},
 { name:'Blytheville', state_code:  'AR'},
 { name:'Blythewood', state_code:  'SC'},
 { name:'Boalsburg', state_code:  'PA'},
 { name:'Board Camp', state_code:  'AR'},
 { name:'Boardman', state_code:  'OR'},
 { name:'Boaz', state_code:  'AL'},
 { name:'Boaz', state_code:  'KY'},
 { name:'Bob White', state_code:  'WV'},
 { name:'Bobtown', state_code:  'PA'},
 { name:'Boca Grande', state_code:  'FL'},
 { name:'Boca Raton', state_code:  'FL'},
 { name:'Bock', state_code:  'MN'},
 { name:'Bode', state_code:  'IA'},
 { name:'Bodega', state_code:  'CA'},
 { name:'Bodega Bay', state_code:  'CA'},
 { name:'Bodfish', state_code:  'CA'},
 { name:'Boelus', state_code:  'NE'},
 { name:'Boerne', state_code:  'TX'},
 { name:'Bogalusa', state_code:  'LA'},
 { name:'Bogard', state_code:  'MO'},
 { name:'Bogart', state_code:  'GA'},
 { name:'Bogata', state_code:  'TX'},
 { name:'Boggstown', state_code:  'IN'},
 { name:'Bogota', state_code:  'NJ'},
 { name:'Bogota', state_code:  'TN'},
 { name:'Bogue', state_code:  'KS'},
 { name:'Bogue Chitto', state_code:  'MS'},
 { name:'Bohannon', state_code:  'VA'},
 { name:'Bohemia', state_code:  'NY'},
 { name:'Boiceville', state_code:  'NY'},
 { name:'Boiling Springs', state_code:  'NC'},
 { name:'Boiling Springs', state_code:  'PA'},
 { name:'Boiling Springs', state_code:  'SC'},
 { name:'Bois D Arc', state_code:  'MO'},
 { name:'Boise', state_code:  'ID'},
 { name:'Boise City', state_code:  'OK'},
 { name:'Boissevain', state_code:  'VA'},
 { name:'Bokchito', state_code:  'OK'},
 { name:'Bokeelia', state_code:  'FL'},
 { name:'Bokoshe', state_code:  'OK'},
 { name:'Bolckow', state_code:  'MO'},
 { name:'Boles', state_code:  'AR'},
 { name:'Boles', state_code:  'IL'},
 { name:'Boley', state_code:  'OK'},
 { name:'Boligee', state_code:  'AL'},
 { name:'Bolinas', state_code:  'CA'},
 { name:'Boling', state_code:  'TX'},
 { name:'Bolingbroke', state_code:  'GA'},
 { name:'Bolingbrook', state_code:  'IL'},
 { name:'Bolivar', state_code:  'MO'},
 { name:'Bolivar', state_code:  'NY'},
 { name:'Bolivar', state_code:  'OH'},
 { name:'Bolivar', state_code:  'PA'},
 { name:'Bolivar', state_code:  'TN'},
 { name:'Bolivia', state_code:  'NC'},
 { name:'Bolt', state_code:  'WV'},
 { name:'Bolton', state_code:  'CT'},
 { name:'Bolton', state_code:  'MA'},
 { name:'Bolton', state_code:  'MS'},
 { name:'Bolton', state_code:  'NC'},
 { name:'Bolton Landing', state_code:  'NY'},
 { name:'Bombay', state_code:  'NY'},
 { name:'Bomont', state_code:  'WV'},
 { name:'Bomoseen', state_code:  'VT'},
 { name:'Bon Air', state_code:  'AL'},
 { name:'Bon Aqua', state_code:  'TN'},
 { name:'Bon Secour', state_code:  'AL'},
 { name:'Bon Wier', state_code:  'TX'},
 { name:'Bonaire', state_code:  'GA'},
 { name:'Bonanza', state_code:  'OR'},
 { name:'Bonanza', state_code:  'UT'},
 { name:'Bonaparte', state_code:  'IA'},
 { name:'Boncarbo', state_code:  'CO'},
 { name:'Bond', state_code:  'CO'},
 { name:'Bondsville', state_code:  'MA'},
 { name:'Bonduel', state_code:  'WI'},
 { name:'Bondurant', state_code:  'IA'},
 { name:'Bondurant', state_code:  'WY'},
 { name:'Bondville', state_code:  'IL'},
 { name:'Bondville', state_code:  'VT'},
 { name:'Bone Gap', state_code:  'IL'},
 { name:'Bonesteel', state_code:  'SD'},
 { name:'Boneville', state_code:  'GA'},
 { name:'Bonfield', state_code:  'IL'},
 { name:'Bonham', state_code:  'TX'},
 { name:'Bonifay', state_code:  'FL'},
 { name:'Bonita', state_code:  'CA'},
 { name:'Bonita', state_code:  'LA'},
 { name:'Bonita Springs', state_code:  'FL'},
 { name:'Bonlee', state_code:  'NC'},
 { name:'Bonne Terre', state_code:  'MO'},
 { name:'Bonneau', state_code:  'SC'},
 { name:'Bonner', state_code:  'MT'},
 { name:'Bonner Springs', state_code:  'KS'},
 { name:'Bonnerdale', state_code:  'AR'},
 { name:'Bonners Ferry', state_code:  'ID'},
 { name:'Bonney Lake', state_code:  'WA'},
 { name:'Bonnie', state_code:  'IL'},
 { name:'Bonnieville', state_code:  'KY'},
 { name:'Bonnots Mill', state_code:  'MO'},
 { name:'Bonnyman', state_code:  'KY'},
 { name:'Bono', state_code:  'AR'},
 { name:'Bonsall', state_code:  'CA'},
 { name:'Boody', state_code:  'IL'},
 { name:'Booker', state_code:  'TX'},
 { name:'Boomer', state_code:  'NC'},
 { name:'Boomer', state_code:  'WV'},
 { name:'Boon', state_code:  'MI'},
 { name:'Boone', state_code:  'CO'},
 { name:'Boone', state_code:  'IA'},
 { name:'Boone', state_code:  'NC'},
 { name:'Boone Grove', state_code:  'IN'},
 { name:'Boones Mill', state_code:  'VA'},
 { name:'Booneville', state_code:  'AR'},
 { name:'Booneville', state_code:  'IA'},
 { name:'Booneville', state_code:  'KY'},
 { name:'Booneville', state_code:  'MS'},
 { name:'Boons Camp', state_code:  'KY'},
 { name:'Boonsboro', state_code:  'MD'},
 { name:'Boonton', state_code:  'NJ'},
 { name:'Boonville', state_code:  'CA'},
 { name:'Boonville', state_code:  'IN'},
 { name:'Boonville', state_code:  'MO'},
 { name:'Boonville', state_code:  'NC'},
 { name:'Boonville', state_code:  'NY'},
 { name:'Booth', state_code:  'AL'},
 { name:'Boothbay', state_code:  'ME'},
 { name:'Boothbay Harbor', state_code:  'ME'},
 { name:'Boothville', state_code:  'LA'},
 { name:'Boqueron', state_code:  'PR'},
 { name:'Bordelonville', state_code:  'LA'},
 { name:'Borden', state_code:  'IN'},
 { name:'Bordentown', state_code:  'NJ'},
 { name:'Borderland', state_code:  'WV'},
 { name:'Borger', state_code:  'TX'},
 { name:'Boring', state_code:  'MD'},
 { name:'Boring', state_code:  'OR'},
 { name:'Boron', state_code:  'CA'},
 { name:'Borrego Springs', state_code:  'CA'},
 { name:'Borup', state_code:  'MN'},
 { name:'Boscobel', state_code:  'WI'},
 { name:'Bosler', state_code:  'WY'},
 { name:'Bosque', state_code:  'NM'},
 { name:'Bosque Farms', state_code:  'NM'},
 { name:'Boss', state_code:  'MO'},
 { name:'Bossier City', state_code:  'LA'},
 { name:'Bostic', state_code:  'NC'},
 { name:'Boston', state_code:  'GA'},
 { name:'Boston', state_code:  'IN'},
 { name:'Boston', state_code:  'KY'},
 { name:'Boston', state_code:  'MA'},
 { name:'Boston', state_code:  'NY'},
 { name:'Zwolle', state_code:  'LA'}

]);
Specialty.create([
{ name: 'Aerobic'}, 
{ name: 'Athletic Clubs'}, 
{ name: 'Boxing'},
{ name: 'Cross Fit'},
{ name: 'Dance'},
{ name: 'Fitness'},
{ name: 'Kick Boxing'},
{ name: 'MMA'},
{ name: 'Pilates'},
{ name: 'Weights (Strength and Conditioning)'},
{ name: 'Yoga'},
{ name: 'Others'}
]);

Amenity.create([
{ name: 'Swimming Pool'}, 
{ name: 'Basketball'}, 
{ name: 'Day Care'}, 
{ name: 'Dry Cleaning'},
{ name: 'Food/Juice Bar'},
{ name: 'Guest Services '},
{ name: 'Locker Rooms'},
{ name: 'Massage'},
{ name: 'Nutrition'},
{ name: 'Parking'},
{ name: 'Racquetball'},
{ name: 'Squash'},
{ name: 'Sauna'},
{ name: 'Steam'},
{ name: 'Tennis Courts'}
]);
Category.create([
{ name: 'Most Steps', ctype: 'challenge'}, 
{ name: 'Most Calories', ctype: 'challenge'}, 
{ name: 'Most Miles', ctype: 'challenge'}, 
{ name: 'General Feedback', ctype: 'feedback'}, 
{ name: 'Something Wrong', ctype: 'feedback'},
{ name: 'Photos', ctype: 'feedback'}, 
{ name: 'Messages', ctype: 'feedback'}, 
{ name: 'Posts', ctype: 'feedback'}, 
{ name: 'Events', ctype: 'feedback'}, 
{ name: 'Groups', ctype: 'feedback'},
{ name: 'Login', ctype: 'feedback'}, 
{ name: 'Chellenges', ctype: 'feedback'}, 
{ name: 'Goals', ctype: 'feedback'}, 
{ name: 'Notifications', ctype: 'feedback'}, 
{ name: 'Profile', ctype: 'feedback'}, 
{ name: 'Location', ctype: 'feedback'} 

]);

EmailSetting.create([
{ name: 'New Rating',slug: 'new_rating'}, 
{ name: 'New Appointment Request' ,slug: 'new_appointment_request'}, 
{ name: 'New Review',slug: 'new_review'}, 
{ name: 'Appointment Approval',slug: 'appointment_approve'},
{ name: 'Fitspot Invitation',slug: 'group_invitation'},
{ name: 'Mentioned In Post/Comment',slug: 'mentioned_in'},
{ name: 'Comment on Post',slug: 'comment_on_post'}
]);


