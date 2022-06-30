var shared_table = {}
var weapon_table = {}
var ammo_table = {}
var comp_table = {}
var buy_table = {}
var value = 1
var block_spam = false
var value_ammo = 1

$(document).keydown(function(e){
	var close = 27, close2 = 8;
	switch (e.keyCode) {
		case close:
			$.post('http://gum_weapons/exit')
		break;
        case close2:
			$.post('http://gum_weapons/exit')
		break;

	}
});


$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
            $("#shared_table").show();
            $("#back_arrow").hide();
            $("#pay_weapos").show();
        } else {
            $("#container").hide();
        }
    }
    function display_buy(bool) {
        if (bool) {
            $("#container_buying").show();
            $("#weapon_table").show();

            $("#ammo_table").hide();
            $("#weapon_table").show();
            
            $("#ammo_store").show();
            $("#weapon_store").hide();
            $("#buy_weapon").show();
            $("#buy_ammo").hide();
        } else {
            $("#container_buying").hide();
        }
    }

    display(false)
    display_buy(false)


    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "customization_menu") {
            if (item.status == true) {
                display(true)
                shared_table = item.table_shared
                global_table = item.table_glob
                comp_table = item.table_comps
                shared_data(item.table_shared, item.table_glob)
                document.getElementById('component_for_buy').innerHTML = "Cena";
            } else {
                display(false)
            }
        }
        if (item.type === "buying_menu") {
            if (item.status == true) {
                display_buy(true)
                weapon_table = item.weapon_table
                weapon_store(item.weapon_table)
                ammo_table = item.ammo_table
                ammo_store(item.ammo_table)
            } else {
                display_buy(false)
            }
        }
        if (item.type === "price_for_load") {
            if (item.status == true) {
                load_price(item.price, item.wep_name)
            }
        }
        if (item.type === "price_for_ammo") {
            if (item.status == true) {
                load_ammo_price(item.price, item.amm_name)
            }
        }
        if (item.type === "compo_price") {
            document.getElementById('component_for_buy').innerHTML = "Cena : </br>"+item.comp_price+"$";
        }
    })

    $("#close").click(function () {
        $.post('http://gum_weapons/exit', JSON.stringify({}));
        return
    })

})

function weapon_store(weapon_store){
    const tableBody = document.getElementById('weapon_table');
    let dataHtml = '';
    for(var key in weapon_store){
        dataHtml += '<div class="wep_grid-item2">'+key+'</div>'
        dataHtml += '<div class="wep_grid-item""><div id="wep_right" onclick="wep_switch_right(\''+ key +'\')"></div><div id="input_value_'+key+'" class="wep_input_value">Zvolit</div></div>';
        dataHtml += '</br></br></br></br>'
   }

   tableBody.innerHTML = dataHtml
}

function ammo_store(ammo_table){
    const tableBody = document.getElementById('ammo_table');
    let dataHtml = '';
    for(var key in ammo_table){
        dataHtml += '<div class="wep_grid-item2">'+key+'</div>'
        dataHtml += '<div class="wep_grid-item"><div id="wep_right" onclick="wep_switch_right2(\''+ key +'\')"></div><div id="input_value2_'+key+'" class="wep_input_value">Zvolit</div></div>';
        dataHtml += '</br></br></br></br>'
    }
    tableBody.innerHTML = dataHtml
}
function switch_to_weapon(){
    $("#weapon_table").show();
    $("#ammo_table").hide();
    $("#buy_weapon").show();
    $("#buy_ammo").hide();

    $("#ammo_store").show();
    $("#weapon_store").hide();
    document.getElementById('weapon_for_buy').innerHTML = "Cena";
    $.post('http://gum_weapons/delete_prop', JSON.stringify({}));
}
function switch_to_ammo(){
    $.post('http://gum_weapons/delete_prop', JSON.stringify({}));
    $("#ammo_table").show();
    $("#weapon_table").hide();
    $("#buy_ammo").show();
    $("#buy_weapon").hide();

    $("#ammo_store").hide();
    $("#weapon_store").show();
    document.getElementById('weapon_for_buy').innerHTML = "Cena";
}


function wep_switch_right(keys2){
    if (block_spam == false ){
        for(var key in weapon_table){
            if (key == keys2){
                for (var key2 in weapon_table[key]){
                    if (Object.keys(weapon_table[key])[value] == undefined){
                        value = 0
                    } else {
                        document.getElementById('input_value_'+key).innerHTML = Object.keys(weapon_table[key])[value];
                    }
                }
                var update_value = document.getElementById('input_value_'+key).innerHTML;
                $.post('http://gum_weapons/show_store_weapons', JSON.stringify({ weapon_name: update_value}));
            }
        }
        block_spam = true
        value = value+1
        setTimeout(function() {
            block_spam = false
        }, 500);
    }
}

function buy_ammo(){
    $.post('http://gum_weapons/buy_weapon', JSON.stringify({}));
}
function buy_weapon(){
    $.post('http://gum_weapons/buy_ammo', JSON.stringify({}));
}
function wep_switch_right2(keys3){
    if (block_spam == false ){
        for(var key in ammo_table){
            if (key == keys3){
                for (var key2 in ammo_table[key]){
                    if (Object.keys(ammo_table[key])[value_ammo] == undefined){
                        value_ammo = 0
                    } else {
                        document.getElementById('input_value2_'+key).innerHTML = Object.keys(ammo_table[key])[value_ammo];
                    }
                }
                var update_value = document.getElementById('input_value2_'+key).innerHTML;
                $.post('http://gum_weapons/ammo_price_weapons', JSON.stringify({ ammo_name: update_value}));
            }
        }
        block_spam = true
        value_ammo = value_ammo+1
        setTimeout(function() {
            block_spam = false
        }, 500);
    }
}

function load_price(price_value, weapon_name){
    document.getElementById('weapon_for_buy').innerHTML = weapon_name+"</br>"+price_value+"$";
}

function load_ammo_price(price_value, ammo_name){
    document.getElementById('weapon_for_buy').innerHTML = ammo_name+"</br>"+price_value+"$";
}


function shared_data(shared_table_pars, specifi_table_pars){
    const tableBody = document.getElementById('shared_table');
    let dataHtml = '';
    buy_table = {}
    dataHtml += '<div class="grid-item2">Upgrade</div></br>'
    number_set = -1
    for(var key in shared_table_pars){
        if ((!key.match(/ENGRAVING/g)) && (!key.match(/MATERIAL/g))) {
            for (var i = 0; i < 20; i++) {
                for (var key2 in comp_table){
                    if (shared_table_pars[key][i] == comp_table[key2]){
                        number_set = i
                    }
                }
            }
            dataHtml += '<div class="grid-item" onclick="set_camera(\''+ key +'\')"><div id="left" onclick="switch_left(\''+ key +'\')"></div><div id="right" onclick="switch_right(\''+ key +'\')"></div><div id="input_value_'+key+'" class="input_value">'+number_set+'</div>'+key.replace("_", " ")+'</div>';
       }
   }
   dataHtml += '</br></br></br>'
   dataHtml += '<div class="grid-item2">Material</div></br>'
   number_set = -1
   for(var key in shared_table_pars){
        if ((!key.match(/ENGRAVING/g)) && (key.match(/MATERIAL/g))) {
            for (var i = 0; i < 20; i++) {
                for (var key2 in comp_table){
                    if (shared_table_pars[key][i] == comp_table[key2]){
                        number_set = i
                    }
                }
            }
        dataHtml += '<div class="grid-item" onclick="set_camera(\''+ key +'\')"><div id="left" onclick="switch_left(\''+ key +'\')"></div><div id="right" onclick="switch_right(\''+ key +'\')"></div><div id="input_value_'+key+'" class="input_value">'+number_set+'</div>'+key.replace("_", " ")+'</div>';
        }
    }
    dataHtml += '</br></br></br>'
    dataHtml += '<div class="grid-item2">Engraving</div></br>'
    number_set = -1
    for(var key in shared_table_pars){
       if ((key.match(/CYLINDER_ENGRAVING/g)) && (!key.match(/CYLINDER_ENGRAVING_MATERIAL/g))) {
            for (var i = 0; i < 20; i++) {
                for (var key2 in comp_table){
                    if (shared_table_pars[key][i] == comp_table[key2]){
                        number_set = i
                    }
                }
            }
        dataHtml += '<div class="grid-item" onclick="set_camera(\''+ key +'\')" ><div id="left" onclick="switch_left(\''+ key +'\')"></div><div id="right" onclick="switch_right(\''+ key +'\')"></div><div id="input_value_'+key+'" class="input_value">'+number_set+'</div>'+key.replace("_", " ")+'</div>';
        }
    }
    number_set = -1
    for(var key in shared_table_pars){
        if ((key.match(/ENGRAVING/g)) && (!key.match(/ENGRAVING_MATERIAL/g)) && (!key.match(/CYLINDER_ENGRAVING/g)) && (!key.match(/GRIPSTOCK_ENGRAVING/g))) {
                for (var i = 0; i < 20; i++) {
                    for (var key2 in comp_table){
                        if (shared_table_pars[key][i] == comp_table[key2]){
                            number_set = i
                        }
                    }
                }
        dataHtml += '<div class="grid-item" onclick="set_camera(\''+ key +'\')"><div id="left" onclick="switch_left(\''+ key +'\')"></div><div id="right" onclick="switch_right(\''+ key +'\')"></div><div id="input_value_'+key+'" class="input_value">'+number_set+'</div>'+key.replace("_", " ")+'</div>';
        }
     }
     number_set = -1
     for(var key in shared_table_pars){
        if ((key.match(/ENGRAVING/g)) && (!key.match(/ENGRAVING_MATERIAL/g)) && (!key.match(/CYLINDER_ENGRAVING/g)) && (key.match(/GRIPSTOCK_ENGRAVING/g))) {
            for (var i = 0; i < 20; i++) {
                for (var key2 in comp_table){
                    if (shared_table_pars[key][i] == comp_table[key2]){
                        number_set = i
                    }
                }
            }
            dataHtml += '<div class="grid-item" onclick="set_camera(\''+ key +'\')"><div id="left" onclick="switch_left(\''+ key +'\')"></div><div id="right" onclick="switch_right(\''+ key +'\')"></div><div id="input_value_'+key+'" class="input_value">'+number_set+'</div>'+key.replace("_", " ")+'</div>';
        }
     }
     dataHtml += '</br>'
     number_set = -1
     for(var key in shared_table_pars) {
       if (key.match(/ENGRAVING_MATERIAL/g)) {
        for (var i = 0; i < 20; i++) {
            for (var key2 in comp_table){
                if (shared_table_pars[key][i] == comp_table[key2]){
                    number_set = i
                }
            }
        }
        dataHtml += '<div class="grid-item" onclick="set_camera(\''+ key +'\')"><div id="left" onclick="switch_left(\''+ key +'\')"></div><div id="right" onclick="switch_right(\''+ key +'\')"></div><div id="input_value_'+key+'" class="input_value">'+number_set+'</div>'+key.replace("_", " ")+'</div>';
       }
    }
    dataHtml += '</br></br></br>'
    dataHtml += '<div class="grid-item2">Styling</div></br>'
    number_set = -1
    for(var key in specifi_table_pars){
        for (var i = 0; i < 20; i++) {
            for (var key2 in comp_table){
                if (specifi_table_pars[key][i] == comp_table[key2]){
                    number_set = i
                }
            }
        }
        dataHtml += '<div class="grid-item" onclick="set_camera(\''+ key +'\')"><div id="left" onclick="switch_left2(\''+ key +'\')"></div><div id="right" onclick="switch_right2(\''+ key +'\')"></div><div id="input_value_'+key+'" class="input_value">'+number_set+'</div>'+key.replace("_", " ")+'</div>';
    }
    tableBody.innerHTML = dataHtml
    load_components()
}

function load_components(){
    for (var key in comp_table){
        // console.log(key+" "+comp_table[key])
    }
}

function buy_components(){
    $.post('http://gum_weapons/buy_components', JSON.stringify({ table_comp: buy_table}));
}

function switch_left(data){
    var update_value = document.getElementById('input_value_'+data).innerHTML;
    var checked_value = (Number(update_value) - 1);
    for (var key in shared_table){
        if (key == data) {
            if (update_value == 0) {
                document.getElementById('input_value_'+data).innerHTML = (Number(update_value) - 1);
                $.post('http://gum_weapons/reset_skin', JSON.stringify({}));
                console.log(key)
                buy_table[key] = {value:-1, component:shared_table[data][document.getElementById('input_value_'+data).innerHTML]}
            } else if (shared_table[data][checked_value] !== undefined) {
                document.getElementById('input_value_'+data).innerHTML = (Number(update_value) - 1);
                $.post('http://gum_weapons/set_skin', JSON.stringify({ load_now: shared_table[data][document.getElementById('input_value_'+data).innerHTML] }));
                buy_table[key] = {value:checked_value, component:shared_table[data][document.getElementById('input_value_'+data).innerHTML]}
            }
        }
    }
}

function switch_left2(data){
    var update_value = document.getElementById('input_value_'+data).innerHTML;
    var checked_value = (Number(update_value) - 1);
    for (var key in global_table){
        if (key == data) {
            if (update_value == 0) {
                document.getElementById('input_value_'+data).innerHTML = (Number(update_value) - 1);
                $.post('http://gum_weapons/reset_skin', JSON.stringify({sended:"global", what:document.getElementById('input_value_'+data).innerHTML}));
                buy_table[key] = {value:checked_value, component:global_table[data][document.getElementById('input_value_'+data).innerHTML]}
            } else if (global_table[data][checked_value] !== undefined) {
                document.getElementById('input_value_'+data).innerHTML = (Number(update_value) - 1);
                $.post('http://gum_weapons/set_skin', JSON.stringify({ load_now: global_table[data][document.getElementById('input_value_'+data).innerHTML]}));
                buy_table[key] = {value:checked_value, component:global_table[data][document.getElementById('input_value_'+data).innerHTML]}
            }
        }
    }
}

function switch_right(data){
    var update_value = document.getElementById('input_value_'+data).innerHTML;
    var checked_value = (Number(update_value) + 1);
    for (var key in shared_table){
        if (key == data) {
            if (shared_table[data][checked_value] !== undefined){ 
                document.getElementById('input_value_'+data).innerHTML = (Number(update_value) + 1);
                $.post('http://gum_weapons/set_skin', JSON.stringify({ load_now: shared_table[data][document.getElementById('input_value_'+data).innerHTML] }));
                buy_table[key] = {value:checked_value, component:shared_table[data][document.getElementById('input_value_'+data).innerHTML]}
            }
        }
    }
 }

function switch_right2(data){
    var update_value = document.getElementById('input_value_'+data).innerHTML;
    var checked_value = (Number(update_value) + 1);
    for (var key in global_table){
        if (key == data) {
            if (global_table[data][checked_value] !== undefined){ 
                document.getElementById('input_value_'+data).innerHTML = (Number(update_value) + 1);
                $.post('http://gum_weapons/set_skin', JSON.stringify({ load_now: global_table[data][document.getElementById('input_value_'+data).innerHTML]}));
                buy_table[key] = {value:checked_value, component:global_table[data][document.getElementById('input_value_'+data).innerHTML]}
            }
        }
    }
 }


 function set_camera(data){
    $.post('http://gum_weapons/set_camera', JSON.stringify({ weapon_cam: data }));
}