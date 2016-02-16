# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

carousel_products = Product.create([{
                          url: 'https://images.unsplash.com/photo-1432107294469-414527cb5c65?crop=entropy&fit=crop&fm=jpg&h=725&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1325', 
                          carousel: true,
                          title: 'Coffee', 
                          description: 'Existentia quascunque ne collabitur an is ii.'
                          },
                        {
                          url: 'https://images.unsplash.com/photo-1442975631115-c4f7b05b8a2c?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=653bd326afdaa08d7cdda2215ef3ec85', 
                          title: 'Coffee', 
                          carousel: true,
                          description: 'Existentia quascunque ne collabitur an is ii.'
                          },
                        {
                          url: 'https://images.unsplash.com/photo-1418479631014-8cbf89db3431?crop=entropy&fit=crop&fm=jpg&h=775&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1150',
                          title: 'Coffee', 
                          carousel: true,
                          description: 'Existentia quascunque ne collabitur an is ii.'
                          },
                        {
                          url: 'https://images.unsplash.com/photo-1422207215953-98b4bc18c3d9?crop=entropy&fit=crop&fm=jpg&h=775&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1150',
                          title: 'Coffee', 
                          carousel: true,
                          description: 'Existentia quascunque ne collabitur an is ii.'
                          },
                        {
                          url: 'https://images.unsplash.com/photo-1449198063792-7d754d6f3c80?crop=entropy&fit=crop&fm=jpg&h=775&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1150',
                          title: 'Coffee', 
                          carousel: true,
                          description: 'Existentia quascunque ne collabitur an is ii.'
                          },

                        {
                          url: 'https://images.unsplash.com/photo-1452088245938-06c460393db9?crop=entropy&fit=crop&fm=jpg&h=725&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1325', 
                          title: 'Coffee',
                          carousel: true, 
                          description: 'Existentia quascunque ne collabitur an is ii.'
                          }])

showcases = Showcase.create([{
                               title: "2016 selection",
                               feature_img: "https://images.unsplash.com/5/unsplash-bonus.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=bdb8645a7dec56f25f598d1faaa718d3",
                               },
                             {
                               title: "features",
                               feature_img: "https://images.unsplash.com/photo-1415226581130-91cb7f52f078?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=276f62cfceb487bafa5b2acdd6c92706",
                               },
                             {
                               title: "New",
                               feature_img: "https://images.unsplash.com/photo-1445116572660-236099ec97a0?crop=entropy&fit=crop&fm=jpg&h=775&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1400",
                               },
                               ])

for i in 1..10 do
  Products.create([{
                 url: 'https://images.unsplash.com/reserve/F8x8NPwTQEmVdXOHjO8o_Espresso.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=2148c3785d65f5faefa3a386bd3e0c25', 
                 title: 'Coffee', 
                 description: 'test',
                 showcase_id: 1
                 },
               {
                 url: 'https://images.unsplash.com/photo-1422056244210-46cc641fb1fe?crop=entropy&fit=crop&fm=jpg&h=775&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1400', 
                 title: 'Coffee', 
                 description: 'test',
                 showcase_id: 2
                 },
               {
                 url: 'https://images.unsplash.com/4/cuba-cup.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=91970aa8954caa297e0eabc4595987de', 
                 title: 'Coffee', 
                 description: 'test',
                 showcase_id: 3
                 }])
end
