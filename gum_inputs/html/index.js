
$(function () {
    function display_input(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }
    function display_answer(bool) {
        if (bool) {
            $("#container2").show();
        } else {
            $("#container2").hide();
        }
    }
    display_input(false)
    display_answer(false)

    window.addEventListener('message', function(event) {
        if (event.data.type == "open_inputs"){
            if (event.data.status == true) {
                display_input(true)
                set_input_info(event.data.title, event.data.subtext)
            } else {
                display_input(false)  
            }
        }
        if (event.data.type == "open_answer"){
            if (event.data.status == true) {
                display_answer(true)
                set_input_answer(event.data.title, event.data.first, event.data.second)
            } else {
                display_answer(false)  
            }
        }
    })
})

function set_input_info(title, subtext) {
    document.getElementById("header").innerHTML = title;
    document.getElementById("button_2").innerHTML = subtext;
}
function set_input_answer(title, first, second) {
    document.getElementById("header2").innerHTML = title;

    document.getElementById("button_2_ans").innerHTML = first;
    document.getElementById("button_1_ans").innerHTML = second;
}

function send_values() {
    if (document.getElementById("text_input").value === "") {
        document.getElementById("form_id").reset();
        $.post('http://gum_inputs/button_1', JSON.stringify({ text: "close" }));
    } else {
        $.post('http://gum_inputs/button_2', JSON.stringify({ text: document.getElementById("text_input").value }));
        document.getElementById("form_id").reset();
    }
}

function close_input() {
    document.getElementById("form_id").reset();
  $.post('http://gum_inputs/button_1', JSON.stringify({ text: "close" }));
}

function yes_func() {
    document.getElementById("form_id").reset();
  $.post('http://gum_inputs/yes', JSON.stringify({ text: "yes" }));
}

function no_func() {
    document.getElementById("form_id").reset();
  $.post('http://gum_inputs/no', JSON.stringify({ text: "no" }));
}
