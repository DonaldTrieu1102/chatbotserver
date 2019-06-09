$(function() {
    var socket = io.connect('http://localhost:3000');

    socket.on("send", (data) => {
        console.log(data);
        var username = data.username;
        var messaging = data.messaging;
     
        var id = $('user').attr('id');
        //check if new user
        if (username.isActive) {
            var newUser = `<div class="peers fxw-nw ai-c p-20 bdB bgc-white bgcH-grey-50 cur-p">
            <div class="peer"><img src="` + username.profile_pic + `" alt=""
                class="w-3r h-3r bdrs-50p"></div>
            <div class="peer peer-greed pL-20">
              <h6 class="mB-0 lh-1 fw-400">` + username.last_name + ` ` + username.first_name + `</h6><small class="lh-1 c-green-500">Online</small>
              <span class="badge badge-danger float-right">1</span>
            </div>
          </div>`;
          $('#list-user').prepend(newUser);
        }
        else if (username._id === id){
            var newMsg = `<div class="peers fxw-nw">
            <div class="peer mR-20"><img class="w-2r bdrs-50p" src="` + username.profile_pic + `" alt=""></div>
            <div class="peer peer-greed">
              <div class="layers ai-fs gapY-5">
                <div class="layer">
                  <div class="peers fxw-nw ai-c pY-3 pX-10 bgc-white bdrs-2 lh-3/2">
                    <div class="peer mR-10"><small>` + messaging.timestamp + `</small></div>
                    <div class="peer-greed"><span>` + messaging.message.text + `</span></div>
                  </div>
                </div>
              </div>
            </div>
          </div>`;
          $('#msg-content').append(newMsg);
        }
        else {
            var notice = '#' + username._id + '-notice';
            $(notice).append(`<span class="badge badge-danger float-right">1</span>`);
        }

    })

    $('#message').on('click', () => {
        socket.emit('send', {});
    })
})