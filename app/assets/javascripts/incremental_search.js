$(function() {

  var search_list = $("#user-search-result")
  var member = $("#member")

  function appendUser(user) {
    var html = `  <div class="chat-group-user clearfix">
                    <p class="chat-group-user__name">${ user.name }</p>
                    <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ user.id }" data-user-name="${ user.name }">追加</a>
                  </div>`
    search_list.append(html);
  }

  function appendMenber(user_id, user_name) {
    var html = `  <div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
                    <input name='chat_group[user_ids][]' type='hidden' value='${ user_id }'>
                    <p class='chat-group-user__name'>${ user_name }</p>
                    <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
                  </div>`
    member.append(html);
  }

  $(".chat-group-form__input").on("keyup", function() {
    var input = $("#user-search-field.chat-group-form__input").val();
    $.ajax({
      type: 'GET',
      url: "/chat_groups",
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(users) {
      $("#user-search-result").empty();
      if (input !== "") {
        if (users.length !== 0) {
          users.forEach(function(user){
            appendUser(user);
          });
        }
        else {
          $("#user-search-result").append("no users");
        }
      }
    })
  });

  $(document).on("click", "#user-search-result > div > a", function () {
    $(this).parent().remove();
    var user_id = $(this).attr("data-user-id");
    var user_name = $(this).attr("data-user-name");
    appendMenber(user_id, user_name);
  });

  $(document).on("click", "#member > div > a", function () {
    $(this).parent().remove();
  });

});
