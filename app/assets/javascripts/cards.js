$(function(){
 // window._token = '<%= form_authenticity_token %>';
  $(".draggable").draggable({ 
    revert: "invalid",
    cursor: "move"
  });
  $(".droppable").droppable({
    hoverClass: "ui-state-highlight",
//    tolerance: "fit",
    drop: function(event, ui) {
      var card_id = ui.draggable.attr("id");
      var position = this.parentNode.rowIndex;
      var card_type = this.getAttribute("data-type");
      $.ajax({
        type: "POST",
        url: "/cards/" + card_id,
        data: { "card[position]": position
              , "card[card_type]": card_type
             // , authenticity_token: window._token
              , _method: "patch"
            },
        dataType: "json"
      }).fail(function(msg) {
        alert(msg);
      });
    }
  });
  $('.new_card_link').click(function(event) {
    event.preventDefault();
    var div = $(this).parent();
    div.replaceWith(
      '<input id="title" type="text"></input><a href="#" id="submit" class="btn btn-primary btn-small">Submit</a><a href="#" id="cancel" class="btn btn-danger btn-small">Cancel</a>'
      );
  });
  $('body').on("click","#submit", function(event) {
    //window._token = '<%= form_authenticity_token %>';
    event.preventDefault();
    var title = $('#title').val();
    var position = $(this).parent().data("position");
    var card_type = $(this).parent().data("type");
    var parent_id = $("#parent_card_id").data("parent");
    //console.log(parent_id);
    $.ajax({
      type: "POST",
      url: "/cards",
      data: { "card[title]": title
            , "card[position]": position
            , "card[card_type]": card_type
            , "card[parent_id]": parent_id
           //, authenticity_token: window._token
            , commit: "Create Card"
             },
          dataType: "json"
      }).success(function() {
        location.reload();
    });
  });
  $('body').on("click","#cancel", function(event) {
    //window._token = '<%= form_authenticity_token %>';
    event.preventDefault();
    var div = $(this).parent();
    div.html(
      '<div class="new_card"><a href="#" class="btn btn-block btn-default new_card_link" >New Card</a></div>'
      );
  });
  $('.actions_link').click(function(e){
    e.preventDefault();
    var contentTarget = $(this).attr('href');
    $(contentTarget).slideToggle('fast');
    //$(this).children().toggleClass("icon-chevron-down").toggleClass("icon-chevron-up");
});
});