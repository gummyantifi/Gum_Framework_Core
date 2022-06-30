var telegram_table = {}
var display_bank = false
var price_calc = 0

$(document).keydown(function(e) {
    var close = 27, close2 = 8;
    switch (e.keyCode) {
        case close:
            document.getElementById("city").innerHTML = "";
            document.getElementById("first").innerHTML = "";
            document.getElementById("last").innerHTML = "";
            document.getElementById("money").innerHTML = "";
            document.getElementById("gold").innerHTML = "";
            document.getElementById("signature").innerHTML = "";
            $.post('http://gum_bank_new/exit')
            $("#container").hide();
            $("#read_telegram").hide();
            $("#write_telegram").hide();
        break;
    }
});

$(function() {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }
    display(false)
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "open_bank") {
            city = item.city
            firstname = item.firstname
            lastname = item.lastname
            money = item.money
            gold = item.gold
            display_bank = item.display
            console.log(item.city, item.firstname, item.lastname, item.money, item.gold)
            load_bank_book(item.city, item.firstname, item.lastname, item.money, item.gold)
            display(true)
        } 
    })
})

function load_bank_book(city, first, last, money, gold) {
    document.getElementById("city").innerHTML = city;
    document.getElementById("first").innerHTML = first;
    document.getElementById("last").innerHTML = last;
    document.getElementById("money").innerHTML = money;
    document.getElementById("gold").innerHTML = gold;
    document.getElementById("signature").innerHTML = first.charAt(0)+". "+last;
}

function addmoney() {
    if (document.getElementById("add_money").value !== "") {
        $.post('http://gum_bank_new/add_money', JSON.stringify({ value: document.getElementById('add_money').value, city:city, havem:money, haveg:gold}));
    }
}
function takemoney() {
    if (document.getElementById("take_money").value !== "") {
        $.post('http://gum_bank_new/take_money', JSON.stringify({ value: document.getElementById('take_money').value, city:city, havem:money, haveg:gold}));
    }
}

function addgold() {
    if (document.getElementById("add_gold").value !== "") {
        $.post('http://gum_bank_new/add_gold', JSON.stringify({ value: document.getElementById('add_gold').value, city:city, havem:money, haveg:gold}));
    }
}

function takegold() {
    if (document.getElementById("take_gold").value !== "") {
        $.post('http://gum_bank_new/take_gold', JSON.stringify({ value: document.getElementById('take_gold').value, city:city, havem:money, haveg:gold}));
    }
}

function borrowmoney() {
    if (isNaN(document.getElementById("borrow_money").value)) 
    {
      return false;
    }
    $.post('http://gum_bank_new/borrow_money', JSON.stringify({ value: Number(document.getElementById("borrow_money").value), add: Number(price_calc), city:city}));
}
function borrowinfo() {
    $.post('http://gum_bank_new/borrow_info');
}
function calculation() {
    if (document.getElementById("borrow_money").value >= 10) {
        if (document.getElementById("borrow_money").value >= 40) {
            price_calc = document.getElementById("borrow_money").value/100*30
        } else if (document.getElementById("borrow_money").value >= 30) {
            price_calc = document.getElementById("borrow_money").value/100*35
        } else if (document.getElementById("borrow_money").value >= 20) {
            price_calc = document.getElementById("borrow_money").value/100*40
        } else if (document.getElementById("borrow_money").value >= 10) {
            price_calc = document.getElementById("borrow_money").value/100*45
        } else if (document.getElementById("borrow_money").value >= 0) {
            price_calc = document.getElementById("borrow_money").value/100*50
        }
        document.getElementById("borrow_calculation").innerHTML = "+"+price_calc+"$";
    } else {
        document.getElementById("borrow_calculation").innerHTML = "You can't this value";
    }
    // console.log(document.getElementById("borrow_calculation").value)
}