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
  
for i in 1..10 do
  Product.create([{
                   asin: "B01BY3PEUM",
                   title: "WASH Duke Blue Devils Basketball Women's T Shirt Short Sleeves", 
                   description: "Our t-shirts are professionally printed with the eco-friendly ink, the materials are stretch and soft. You deserve to own such a fantastic shirt with reasonable price and great quality. It's adorable and well worth the money. Our shirts are reliable choices for you.",
                   image_url: 'http://ecx.images-amazon.com/images/I/61SduIacvTL._UL1500_.jpg',
                   url: "http://www.amazon.com/Devils-Basketball-Womens-Shirt-Sleeves/dp/B01BY3PEUM/ref=sr_1_3?ie=UTF8&qid=1456140250&sr=8-3&keywords=duke+womens+basketball+t-shirts+pink",
                   published: true,
                   },{ 
                   asin: "B019RIOJNY",
                   title: "CHENGXINGDA Women's Duke Basketball Logo Hooded Sweatshirt XXL Pink", 
                   description: 'ZHENGXING Duke Basketball Logo 50% Cotton 50% Polyester Hooded Sweatshirt, A fantastic printed item you can wear or present as a gift.',
                   image_url: 'http://ecx.images-amazon.com/images/I/51Qcg6t75lL._UL1500_.jpg',
                   url: "http://www.amazon.com/CHENGXINGDA-Womens-Basketball-Hoodied-Sweatshirt/dp/B019UU1H98/ref=sr_1_14?ie=UTF8&qid=1456140250&sr=8-14&keywords=duke+womens+basketball+t-shirts+pink",
                   published: true,
                   }])
end

for i in 1..20 do
  ProductCategory.create([{ product_id: i, category_id: 1 }, 
                          { product_id: i, category_id: 2 }, 
                          { product_id: i, category_id: 3 }])

  ProductShowcase.create([{ product_id: i, showcase_id: 1 }, 
                          { product_id: i, showcase_id: 2 },
                          { product_id: i, showcase_id: 3 }])
end

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
