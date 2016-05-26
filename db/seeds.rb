# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Showcase.create([{
                  title: "2016 Selection",
                  show_on_landing_page: true
                  },{
                  title: "Features",
                  show_on_landing_page: true
                  },{
                  title: "New",
                  show_on_landing_page: true
                  }])

Category.create([{ name: "Shirts", visible: "true" }, 
                  { name: "Hoodies", visible: "true" },
                  { name: "Socks", visible: "true" },
                  { name: "Long Sleeve", visible: "true" },
                  { name: "T-shirts", visible: "true" },
                  { name: "Pants", visible: "true" },
                  { name: "Hats", visible: "true" },
                  { name: "Socks", visible: "true" },
                  { name: "Jerseys", visible: "true" }])
  
Product.create([{
                 asin: "B01BY3PEUM",
                 title: "Test 1", 
                 description: "Lorem ipsum Sit ullamco Ut deserunt adipisicing esse nostrud sit enim irure in Ut.",
                 image_url: 'http://ecx.images-amazon.com/images/I/61SduIacvTL._UL1500_.jpg',
                 url: "http://www.amazon.com/Devils-Basketball-Womens-Shirt-Sleeves/dp/B01BY3PEUM/ref=sr_1_3?ie=UTF8&qid=1456140250&sr=8-3&keywords=duke+womens+basketball+t-shirts+pink",
                 published: true
                 },{ 
                 asin: "B019RIOJNY",
                 title: "Test 2", 
                 description: "Lorem ipsum In tempor fugiat velit laboris culpa ad et eu aliquip ut Duis.",
                 image_url: 'http://ecx.images-amazon.com/images/I/51Qcg6t75lL._UL1500_.jpg',
                 url: "http://www.amazon.com/CHENGXINGDA-Womens-Basketball-Hoodied-Sweatshirt/dp/B019UU1H98/ref=sr_1_14?ie=UTF8&qid=1456140250&sr=8-14&keywords=duke+womens+basketball+t-shirts+pink",
                 published: true
                 }, {
                 asin: "B0181P6WNY",
                 title: "Test 3", 
                 description: 'Lorem ipsum Nisi dolor exercitation pariatur eu ut dolor incididunt labore amet culpa dolor mollit laborum anim.',
                 image_url: 'http://ecx.images-amazon.com/images/I/41pZ5k7ufxL.jpg',
                 url: "http://www.amazon.com/Yang-Womens-Devils-Basketball-Sleeve/dp/B0181P6WNY%3Fpsc%3D1%26SubscriptionId%3DAKIAJ65NRQ7WQJUWTDDA%26tag%3Dgermanpudding-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB0181P6WNY",
                 published: true
                 }, {
                 asin: "B019RIOJNY",
                 title: "Test 4", 
                 description: 'Lorem ipsum Adipisicing aute Ut aliquip velit laborum officia reprehenderit eiusmod deserunt occaecat deserunt occaecat.',
                 image_url: 'http://ecx.images-amazon.com/images/I/41TmUAV92OL.jpg',
                 url: "http://www.amazon.com/Youth-Online-Unique-Devils-T-Shirt/dp/B018JOC402%3FSubscriptionId%3DAKIAJ65NRQ7WQJUWTDDA%26tag%3Dgermanpudding-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB018JOC402",
                 published: false
                 }])

ProductCategory.create([{ product_id: 1, category_id: 1 }, 
                        { product_id: 2, category_id: 2 }, 
                        { product_id: 3, category_id: 3 }])

ProductShowcase.create([{ product_id: 1, showcase_id: 1 }, 
                        { product_id: 2, showcase_id: 2 },
                        { product_id: 3, showcase_id: 3 }])

SocialNetworkAccount.create([{
                              platform_name: 'Facebook',
                              platform_url: 'https://www.google.de/search?q=facebook',
                              visible: true
                              },{
                              platform_name: 'Twitter',
                              platform_url: 'https://www.google.de/search?q=twitter',
                              visible: true,
                              },{
                              platform_name: 'Instagram',
                              platform_url: 'https://www.google.de/search?q=instagram',
                              visible: false
                              },{
                              platform_name: 'Pinterest',
                              platform_url: 'https://www.google.de/search?q=pinterest',
                              visible: true
                              }])

SiteConfig.create([{ 
                    key: "Site Name", 
                    value: "Duke Girls", 
                    maxlength: 70,
                    note: ""
                    },{ 
                    key: "description",
                    value: "Lorem ipsum Eu officia occaecat.",
                    maxlength: 160,
                    note: "A good and simple description helps SEO."
                    },{ 
                    key: "Our Belief", 
                    value: "Lorem ipsum Veniam quis fugiat laborum veniam sit magna nisi in pariatur laborum consequat nulla aliquip occaecat nulla ea eiusmod dolore ut.",
                    maxlength: 160
                    },{
                    key: "SEO",
                    maxlength: 255,
                    note: "Recommended keywords tag length: up to 255 characters, 20 words."
                    },{
                    key: "Favorite icon",
                    note: "Add a browser tab icon (16 x 16 pixel)."
                    },{
                    key: "Icon",
                    note: "Add a webiste icon."
                    },{
                    key: "Our Story"
                    },{
                    key: "Join Us"
                    }])
