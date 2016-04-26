# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

showcases = Showcase.create([{
                              title: "2016 Selection",
                              feature_img_url: "https://images.unsplash.com/5/unsplash-bonus.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=bdb8645a7dec56f25f598d1faaa718d3",
                              show_on_landing_page: true,
                              },{
                              title: "Features",
                              feature_img_url: "https://images.unsplash.com/photo-1415226581130-91cb7f52f078?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=276f62cfceb487bafa5b2acdd6c92706",
                              show_on_landing_page: true,
                              },{
                              title: "New",
                              feature_img_url: "https://images.unsplash.com/photo-1445116572660-236099ec97a0?crop=entropy&fit=crop&fm=jpg&h=775&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1400",
                              show_on_landing_page: true,
                              }])

categories = Category.create([{ name: "Shirts", visible: "true" }, 
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
                 published: true,
                 },{ 
                 asin: "B019RIOJNY",
                 title: "Test 2", 
                 description: "Lorem ipsum In tempor fugiat velit laboris culpa ad et eu aliquip ut Duis.",
                 image_url: 'http://ecx.images-amazon.com/images/I/51Qcg6t75lL._UL1500_.jpg',
                 url: "http://www.amazon.com/CHENGXINGDA-Womens-Basketball-Hoodied-Sweatshirt/dp/B019UU1H98/ref=sr_1_14?ie=UTF8&qid=1456140250&sr=8-14&keywords=duke+womens+basketball+t-shirts+pink",
                 published: true,
                 }, {
                 asin: "B0181P6WNY",
                 title: "Test 3", 
                 description: 'Lorem ipsum Nisi dolor exercitation pariatur eu ut dolor incididunt labore amet culpa dolor mollit laborum anim.',
                 image_url: 'http://ecx.images-amazon.com/images/I/41pZ5k7ufxL.jpg',
                 url: "http://www.amazon.com/Yang-Womens-Devils-Basketball-Sleeve/dp/B0181P6WNY%3Fpsc%3D1%26SubscriptionId%3DAKIAJ65NRQ7WQJUWTDDA%26tag%3Dgermanpudding-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB0181P6WNY",
                 published: true,
                 }, {
                 asin: "B019RIOJNY",
                 title: "Test 4", 
                 description: 'Lorem ipsum Adipisicing aute Ut aliquip velit laborum officia reprehenderit eiusmod deserunt occaecat deserunt occaecat.',
                 image_url: 'http://ecx.images-amazon.com/images/I/41TmUAV92OL.jpg',
                 url: "http://www.amazon.com/Youth-Online-Unique-Devils-T-Shirt/dp/B018JOC402%3FSubscriptionId%3DAKIAJ65NRQ7WQJUWTDDA%26tag%3Dgermanpudding-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB018JOC402",
                 published: false,
                 }])

ProductCategory.create([{ product_id: 1, category_id: 1 }, 
                        { product_id: 2, category_id: 2 }, 
                        { product_id: 3, category_id: 3 }])

ProductShowcase.create([{ product_id: 1, showcase_id: 1 }, 
                        { product_id: 2, showcase_id: 2 },
                        { product_id: 3, showcase_id: 3 }])

Image.create([{
               title: 'cover1',
               description: 'Existentia quascunque ne collabitur an is ii.',
               url: 'http://thedudeminds.de/images/cover1.jpg', 
               set_as_carousel: true,
              },{
               title: 'cover2',
               description: 'Existentia quascunque ne collabitur an is ii.',
               url: 'http://thedudeminds.de/images/cover2.jpg', 
               set_as_carousel: true,
               },{
               title: 'cover3',
               description: 'Existentia quascunque ne collabitur an is ii.',
               url: 'http://thedudeminds.de/images/cover3.jpg', 
               set_as_carousel: true,
               },{
               title: 'cover4',
               description: 'Existentia quascunque ne collabitur an is ii.',
               url: 'http://thedudeminds.de/images/cover4.jpg', 
               set_as_carousel: true,
               },{
               title: 'cover5',
               description: 'Existentia quascunque ne collabitur an is ii.',
               url: 'http://thedudeminds.de/images/cover5.jpg', 
               set_as_carousel: true,
               }])

SocialNetworkAccount.create([{
                              platform_name: 'Facebook',
                              platform_url: 'https://www.google.de/search?q=facebook',
                              img_url: 'http://thedudeminds.de/images/facebook-3-32.png',
                              visible: true,
                              },{
                              platform_name: 'Twitter',
                              platform_url: 'https://www.google.de/search?q=twitter',
                              img_url: 'http://thedudeminds.de/images/twitter-3-32.png',
                              visible: true,
                              },{
                              platform_name: 'Instagram',
                              platform_url: 'https://www.google.de/search?q=instagram',
                              img_url: 'http://thedudeminds.de/images/instagram-3-32.png',
                              visible: false,
                              },{
                              platform_name: 'Pinterest',
                              platform_url: 'https://www.google.de/search?q=pinterest',
                              img_url: 'http://thedudeminds.de/images/pinterest-3-32.png',
                              visible: true,
                              }])
