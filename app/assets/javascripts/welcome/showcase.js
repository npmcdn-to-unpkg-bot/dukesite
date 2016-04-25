// $(function(){
//   // Change visible status
//   $(".category-list #cat-status").each(function(){
//     var $this    = $( this );
//     $this.click(function(){
//       visible  = $this.attr( "data-visible" ),
//       edit_url = $this.attr( "data-edit" );
//       if (visible == "false" ) {
//         var visible = true;
//       } else {
//         var visible = false;
//       };
//       $.ajax({
//         url: edit_url,
//         method: "PUT",
//         data: { category: 
//                 { visible: visible }
//               },
//         success: function(data) {
//           var visible = data.cat_status;
//           $this.text( function(){
//             return visible ? "visible" : "hidden";
//           });
//           $this.attr("data-visible", visible.toString() );
//           $this.toggleClass("btn-primary");
//           $this.toggleClass("btn-default");
//         }
//       });
//       // end of ajax
//     });
//     // end of click 
//   });
// });
