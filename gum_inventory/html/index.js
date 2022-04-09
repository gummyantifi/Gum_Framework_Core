const contextMenu = document.getElementById("context-menu");
const cnt1 = document.getElementById("cnt1");
const cnt2 = document.getElementById("cnt2");
const scope = document.querySelector("body");
const table_for_delete = document.querySelector('#playerData');
var count_inventory = 0;
var count_winventory = 0;
var count_sinventory = 0;
var max_count_inventory = 0;
var max_count_winventory = 0;
var displayed = false;
var changed = false;
var clicked_id = "";
var clicked_type = "";
var visible = false;
var drag_to_normal = false
var drag_to_other = false
var id_container = 0
var dragged_item_inv = 0
var dragged_witem_inv = 0
var dragged_stor_inv = 0
var dragged = false
var size = 0
var moneysd = 0
var goldsd = 0
var id_for_use_item = -1
var id_for_use_weapon =-1
$(document).keydown(function(e) {
    var close = 27, presse=69;
    switch (e.keyCode) {
        case close:
            $.post('http://gum_inventory/exit', JSON.stringify({id:id_container}));
            contextMenu.classList.remove("visible");
            removeAllChildNodes(table_for_delete);
            changed= false
            id_container = 0
        break;
        case presse:
            if (Number(id_for_use_item) !== -1) {
                if (table_inv[id_for_use_item].usable !== undefined){
                    if (table_inv[id_for_use_item].usable == 1) {
                        $.post('http://gum_inventory/use_item', JSON.stringify({ item: table_inv[id_for_use_item].item }));
                    }
                }
            }
            if (Number(id_for_use_weapon) !== -1) {
                $.post('http://gum_inventory/use_UseWeapon', JSON.stringify({ id: wtable_inv[id_for_use_weapon].id, model:wtable_inv[id_for_use_weapon].name }));
            }
        break;
    }
});

$(document).mousedown(function(e) {
    var close2 = 2;
    switch (e.keyCode) {
        case close2:
            $.post('http://gum_inventory/exit')
            break;

    }
});

$(function() {
    document.getElementById("header").innerHTML = config.language[29].text
    document.getElementById("header_container").innerHTML = config.language[2].text

    function display2(bool) {
        if (bool) {
            $("#container").show();
            $("#container_other").hide();
            $("#show_weapons").hide();
        } else {
            $("#container_other").hide();
            $("#container").hide();
        }
    }

    display2(false)
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "inventory_table") {
            if (item.status == true) {
                table_inv = {}
                wtable_inv = {}
                table_inv = item.table_for_json
                wtable_inv = item.wtable_for_json
                max_count_inventory = item.max_limit_i
                max_count_winventory = item.max_limit_w
                moneysd = Math.round(item.money * 100)/100
                goldsd = item.gold
                loadTableData(table_inv, Math.round(item.money * 100)/100, wtable_inv, item.gold)
                display2(true)
                $("#weaponData").hide();
                $("#tableData").show();
                document.getElementById("id03").innerHTML = ""+config.language[0].text+" : "+Math.round(count_inventory * 100) / 100+" kg / "+max_count_inventory+" kg";
                document.getElementById("id07").innerHTML = ""+config.language[1].text+" : "+count_winventory+" / "+max_count_winventory;
            } else {
                reset_button()
                display2(false)
            }
        }
        if (item.type === "container_table") {
            if (item.status == true) {
                table_inv = {}
                wtable_inv = {}
                storage_inv = {}
                size = 0
                max_count_inventory = 0
                max_count_winventory = 0
                table_inv = item.table_for_json
                wtable_inv = item.wtable_for_json
                max_count_inventory = item.max_limit_i
                max_count_winventory = item.max_limit_w
                moneysd = Math.round(item.money * 100)/100
                goldsd = item.gold
                size = item.size
                id_container = item.id_con
                storage_inv = item.strg_tbl
                loadTableData(table_inv, Math.round(item.money * 100)/100, wtable_inv, item.gold)
                loadstoragedata(storage_inv)
                display2(true)
                $("#weaponData").hide();
                $("#tableData").show();
                document.getElementById("header_container").innerHTML = ""+config.language[2].text+" : "+id_container;
                document.getElementById("id03").innerHTML = ""+config.language[0].text+" : "+Math.round(count_inventory * 100) / 100+" kg / "+max_count_inventory+" kg";
                document.getElementById("id07").innerHTML = ""+config.language[1].text+" : "+count_winventory+" / "+max_count_winventory;
                document.getElementById("id08").innerHTML = ""+config.language[3].text+" : "+Math.round(count_sinventory * 100) / 100+" kg / "+size+" kg";

                $("#container_other").show();
            }
        }
        if (item.type === "inventory_update") {
            if (item.update == true) {
                table_inv = {}
                table_inv = item.table_for_json
                wtable_inv = {}
                wtable_inv = item.wtable_for_json
                loadTableData(table_inv, Math.round(item.money * 100)/100, wtable_inv, item.gold)
            } else {
                table_inv = {}
                table_inv = item.table_for_json
                update_item(table_inv, item.iditem, item.idcount, Math.round(item.money * 100)/100, item.gold)
            }
        }
        if (item.type === "playertable") {
            table_play = item.table_p_for_json
            loadPlayerData(table_play, item.item, item.count)
        }
        if (item.type === "weapon_desc_update") {
            change_active_weapon(item.data_info)
        }

    })

    $("#close").click(function() {
        $.post('http://gum_inventory/exit', JSON.stringify({}));
        return
    })

})

function money_update(money){
    document.getElementById("count_money").innerHTML = ''+Math.round(money * 100)/100+' $';
}


function loadTableData(table_inv, money, wtable_inv, gold) {
    const tableBody = document.getElementById('tableData');
    let dataHtml = '';
    dataHtml += '<div class="item" ><div id="money" class="item-content" " onMouseOver="change_name(-1)"  ondblclick="UseItem(money)"><img src="images/items/money.png" width="50" height="50"  id="item"><div class="bottom-right" id="count_money">'+Math.round(money * 100)/100+'$</div></div></div>'
    dataHtml += '<div class="item" ><div id="gold" class="item-content" " onMouseOver="change_name(-2)"  ondblclick="UseItem(gold)"><img src="images/items/gold.png" width="50" height="50"  id="item"><div class="bottom-right" id="count_gold">'+Math.round(gold * 100)/100+'</div></div></div>'
    count_inventory = 0
    count_winventory = 0
    for (var i in table_inv) {
        count_inventory = table_inv[i].count*table_inv[i].limit+count_inventory
        weight_item = table_inv[i].count*table_inv[i].limit
        dataHtml += '<div class="item"><div id="'+ i +'" class="item-content" onMouseOver="change_name('+ i +')" ondblclick="UseItem('+i+')"><img src="images/items/' + table_inv[i].item + '.png" width="50" height="50"  id="item"><div class="bottom-right" id="count_'+i+'">' + table_inv[i].count + '/'+Math.round(weight_item*100)/100+'kg</div></div></div>'
    }
    for (var i in wtable_inv) {
        count_winventory = count_winventory+1
        dataHtml += '<div class="item"><div id="'+ i +'" class="item-content" onMouseOver="change_name_wep('+ i +')"  ondblclick="UseWeapon(\''+wtable_inv[i].id+'\',\''+wtable_inv[i].name+'\')"><img src="images/items/' + wtable_inv[i].name + '.png" width="60" height="60"  id="weapon"><div class="bottom-right" id="count_'+i+'"></div></div></div>'
    }
    tableBody.innerHTML = dataHtml
    setTimeout(() => {  
        const grid0 = new Muuri('.grid0', {
            dragEnabled: true,
            dragAxis: 'xy',
            dragContainer: document.body,
            }).on('send', data => onDragFinished(data))
            .on('dragStart', function(item) {
                var myDiv = document.getElementById('tableData');
                myDiv.scrollTop = 0;
                dragged = true
               })
            .on('dragReleaseEnd', function() {
                dragged = false
                if (drag_to_other == true) {
                    transfer_to_storage()
                }
    }); }, 5);
}

function transfer_to_storage() {
    if (dragged_item_inv === 'money') {
        $.post('http://gum_inventory/transfer_to_storage', JSON.stringify({weapon:false, item: "money", count: moneysd, container_id:id_container, size:count_sinventory}));
    } else if (dragged_item_inv === 'gold') {
            $.post('http://gum_inventory/transfer_to_storage', JSON.stringify({weapon:false, item: "gold", count: moneysd, container_id:id_container, size:count_sinventory}));
    } else {
        if (dragged_item_inv === undefined) {
            $.post('http://gum_inventory/transfer_to_storage', JSON.stringify({weapon:true, id: wtable_inv[dragged_witem_inv].id, item: wtable_inv[dragged_witem_inv].name, container_id:id_container, used:wtable_inv[dragged_witem_inv].used, size:count_sinventory}));
        } else {
            $.post('http://gum_inventory/transfer_to_storage', JSON.stringify({weapon:false, item: table_inv[dragged_item_inv].item, count: table_inv[dragged_item_inv].count, container_id:id_container, size:count_sinventory, limit:table_inv[dragged_item_inv].limit}));
        }
    }
}
function transfer_from_storage() {
    if (dragged_stor_inv == "money") {
        $.post('http://gum_inventory/transfer_from_storage', JSON.stringify({ item: storage_inv[dragged_stor_inv].item, weapon: storage_inv[dragged_stor_inv].weapon, count: storage_inv[dragged_stor_inv].count, container_id:id_container }));
    } else if (dragged_stor_inv == "gold") {
            $.post('http://gum_inventory/transfer_from_storage', JSON.stringify({ item: storage_inv[dragged_stor_inv].item, weapon: storage_inv[dragged_stor_inv].weapon, count: storage_inv[dragged_stor_inv].count, container_id:id_container }));
    } else {
        $.post('http://gum_inventory/transfer_from_storage', JSON.stringify({ item: storage_inv[dragged_stor_inv].item, weapon: storage_inv[dragged_stor_inv].weapon, count: storage_inv[dragged_stor_inv].count, container_id:id_container, limit:storage_inv[dragged_stor_inv].limit }));
    }
}

function loadstoragedata(strg_dt) {
    $("#expand_container").show();
    const tableBodyStorage = document.getElementById('expand_container');
    let data_storage_Html = '';
    count_sinventory = 0

    for (var i in strg_dt) {
        if (strg_dt[i].weapon == false & strg_dt[i].item === 'money' & strg_dt[i].item !== 'gold') {
            data_storage_Html += '<div class="item"><div id="'+ i +'" class="item-content" onMouseOver="change_name_other('+ i +')" ><img src="images/items/' + strg_dt[i].item + '.png" width="50" height="50"  id="item"><div class="bottom-right" id="count_'+i+'">' + strg_dt[i].count + '</div></div></div>'
        }
    }

    for (var i in strg_dt) {
        if (strg_dt[i].weapon == false & strg_dt[i].item === 'gold' & strg_dt[i].item !== 'money') {
            data_storage_Html += '<div class="item"><div id="'+ i +'" class="item-content" onMouseOver="change_name_other('+ i +')" ><img src="images/items/' + strg_dt[i].item + '.png" width="50" height="50"  id="item"><div class="bottom-right" id="count_'+i+'">' + strg_dt[i].count + '</div></div></div>'
        }
    }

    for (var i in strg_dt) {
        if (strg_dt[i].weapon == false & strg_dt[i].item !== 'money' & strg_dt[i].item !== 'gold') {
            count_sinventory = strg_dt[i].count*strg_dt[i].limit+count_sinventory
            weight_item = strg_dt[i].count*strg_dt[i].limit

            data_storage_Html += '<div class="item"><div id="'+ i +'" class="item-content" onMouseOver="change_name_other('+ i +')" ><img src="images/items/' + strg_dt[i].item + '.png" width="50" height="50"  id="item"><div class="bottom-right" id="count_'+i+'">'+ strg_dt[i].count +'/'+ Math.round(weight_item * 100) / 100 + ' kg</div></div></div>'
        } 
    }

    for (var i in strg_dt) {
        if (strg_dt[i].weapon == true & strg_dt[i].item !== 'money' & strg_dt[i].item !== 'gold'){
            count_sinventory = count_sinventory+1
            data_storage_Html += '<div class="item"><div id="'+ i +'" class="item-content" onMouseOver="change_name_other('+ i +')" ><img src="images/items/' + strg_dt[i].count + '.png" width="50" height="50"  id="item"></div></div>'
        }
    }
    tableBodyStorage.innerHTML = data_storage_Html
    setTimeout(() => {  
        const grid_other = new Muuri('.grid_other', {
            dragEnabled: true,
            dragAxis: 'xy',
            dragContainer: document.body,
            }).on('send', data => onDragFinished(data))
            .on('dragStart', function() {
                dragged = true
                var myDiv = document.getElementById('expand_container');
                myDiv.scrollTop = 0;
               })
            .on('dragReleaseEnd', function() {
                dragged = false
                if (drag_to_normal == true) {
                    transfer_from_storage()
                }
    }); }, 5);
}

var frs1 = document.getElementById('grid0');
if(frs1){
    document.getElementById("grid0").addEventListener("mouseenter", function() {drag_to_other=false ,drag_to_normal=true;});
}
var frst2 = document.getElementById('grid0');
if(frst2){
    document.getElementById("grid1").addEventListener("mouseenter", function() {drag_to_other=false ,drag_to_normal=true;});
}

document.getElementById("container_other").addEventListener("mouseenter", function() {drag_to_other=true,drag_to_normal=false;});
document.getElementById("expand_container").addEventListener("mouseenter", function() {drag_to_other=true,drag_to_normal=false;});
document.getElementById("container").addEventListener("mouseenter", function() {drag_to_other=false ,drag_to_normal=true;});


function removeAllChildNodes(parent) {
    while (parent.firstChild) {
        parent.removeChild(parent.firstChild);
    }
}
function put_clothe(num){
    $.post('http://gum_inventory/put_clothe', JSON.stringify({ clothe: num}));
}
function clean_clothe() {
    document.getElementById("id01").innerHTML = "";
    document.getElementById("id02").innerHTML = "";
}
function show_clothe(num) {
    if (num == 1){
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[5].text;
    } else if (num == 2) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[6].text;
    } else if (num == 3) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[7].text;
    } else if (num == 4) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[8].text;
    } else if (num == 5) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[9].text;
    } else if (num == 6) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[10].text;
    } else if (num == 7) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[11].text;
    } else if (num == 8) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[12].text;
    } else if (num == 9) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[13].text;
    } else if (num == 10) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[14].text;
    } else if (num == 11) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[15].text;
    } else if (num == 12) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[16].text;
    } else if (num == 13) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[17].text;
    } else if (num == 14) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[18].text;
    } else if (num == 15) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[19].text;
    } else if (num == 16) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[20].text;
    } else if (num == 17) {
        document.getElementById("id01").innerHTML = config.language[4].text;
        document.getElementById("id02").innerHTML = config.language[21].text;
    }
}

function Show_Items(){
    document.getElementById("id01").innerHTML = '';
    document.getElementById("id02").innerHTML = '';
    document.getElementById("id03").innerHTML = ""+config.language[0].text+" : "+count_inventory+" / "+max_count_inventory;
    document.getElementById("id07").innerHTML = ""+config.language[1].text+" : "+count_winventory+" / "+max_count_winventory;
    $("#tableData").show();
}

function reset_button(){
    document.getElementById("id01").innerHTML = '';
    document.getElementById("id02").innerHTML = '';
}
function loadPlayerData(table_play, id_item, count) {
    const tablePlayer = document.getElementById('playerData');
    let dataHHtml = '<div id="itemek" class="item2" onclick=CloseList()>'+config.language[28].text+'</div>';
    if (count > 0 ){
        for (var i in table_play) {
            dataHHtml += '<div id="itemek" class="item2" onclick=GiveItemNow(\''+table_play[i].id+'\',\''+id_item+'\',\''+count+'\')>['+table_play[i].id+'] '+table_play[i].name+'</div>'
        }
        tablePlayer.innerHTML = dataHHtml
    }
}
function CloseList() {
    removeAllChildNodes(table_for_delete);
}

function GiveItemNow(id_player, item, count){
    removeAllChildNodes(table_for_delete);
    if (item == "money") {
        $.post('http://gum_inventory/give_checked_item', JSON.stringify({ id: id_player, item: item, count: count, is:clicked_type }));
    } else if (item == "gold") {
            $.post('http://gum_inventory/give_checked_item', JSON.stringify({ id: id_player, item: item, count: count, is:clicked_type }));
    } else {
        $.post('http://gum_inventory/give_checked_item', JSON.stringify({ id: id_player, item: item, count: Math.floor(count), is:clicked_type }));
    }
}


$(document).on("contextmenu", ".item-content", function(evt) {
    if (!$(evt.target).hasClass("item-content")){
        var clickedid = $(this).attr('id');
        const { clientX: mouseX, clientY: mouseY } = evt;
        if (evt.target.id == "weapon"){
            clicked_id = wtable_inv[clickedid].id
        } else if (clickedid == "money") {
            clicked_id = "money"
        } else if (clickedid == "gold") {
            clicked_id = "gold"
        } else {
            clicked_id = table_inv[clickedid].item
        }

        clicked_type = evt.target.id

        contextMenu.style.top = `${mouseY}px`;
        contextMenu.style.left = `${mouseX}px`;
        contextMenu.classList.add("visible");
    }
 })

 scope.addEventListener("click", (e) => {
    if (e.target.offsetParent != contextMenu ) {
        table_for_delete.classList.remove("visible");
        contextMenu.classList.remove("visible");
    }
  });

  
function update_item(table_inv, name, count, money, gold) {
    for (var i in table_inv) {
        if (table_inv[i].item == name) {
            document.getElementById("count_"+i+"").innerHTML = count;
            document.getElementById("count_money").innerHTML = money;
            document.getElementById("count_gold").innerHTML = gold;
        }
    }
}

function change_name(id) {
    id_for_use_item = -1
    document.getElementById("id05").innerHTML = "";
    if (dragged == false) {
        if (id == -1){
            document.getElementById("id01").innerHTML = config.language[22].text;
            document.getElementById("id02").innerHTML = config.language[23].text;      
            dragged_item_inv = 'money'
        } else if (id == -2) {
            document.getElementById("id01").innerHTML = config.language[24].text;
            document.getElementById("id02").innerHTML = config.language[25].text;      
            dragged_item_inv = 'gold'
        } else{
            if (document.getElementById("id01").innerHTML !== undefined) {
                id_for_use_item = id
                id_for_use_weapon = -1
                document.getElementById("id01").innerHTML = ''+table_inv[id].label+'';
                dragged_item_inv = id
                dragged_witem_inv = undefined
                if (table_inv[id].description == undefined) {
                    document.getElementById("id02").innerHTML = '';
                } else {
                    document.getElementById("id02").innerHTML = ''+table_inv[id].description+'';
                }
            }
        }
    }
}

function change_name_wep(id) { 
    id_for_use_weapon = id
    id_for_use_item = -1
    document.getElementById("id05").innerHTML = "";
    if (dragged == false) {
        if (wtable_inv[id].used !== undefined) {
            document.getElementById("id01").innerHTML = ''+wtable_inv[id].label+'';
            dragged_witem_inv = id
            dragged_item_inv = undefined
            if (wtable_inv[id].used == 1){
                document.getElementById("id02").innerHTML = config.language[26].text;
            } else{
                document.getElementById("id02").innerHTML = config.language[27].text;
            }
        }
    }
}

function change_name_other(id) {
    id_for_use_weapon = -1
    id_for_use_item = -1
    document.getElementById("id01").innerHTML = "";
    document.getElementById("id02").innerHTML = "";
    if (dragged === false) {
        if (id == -1){
            document.getElementById("id05").innerHTML = config.language[22].text;
            dragged_stor_inv = 'money'
        } else if (id == -2){
                document.getElementById("id05").innerHTML = config.language[24].text;
                dragged_stor_inv = 'money'
        } else{
            document.getElementById("id05").innerHTML = ''+storage_inv[id].label+'';
            dragged_stor_inv = id
        }
    }
}

function change_active_weapon(id){
    for (var i in wtable_inv) {
        if (wtable_inv[i].id == id) {
            if (wtable_inv[i].used == 1){
                wtable_inv[i].used = 0
            } else{
                wtable_inv[i].used = 1
            }
            if (wtable_inv[i].used == 1){
                document.getElementById("id02").innerHTML = config.language[26].text;
            } else{
                document.getElementById("id02").innerHTML = config.language[27].text;
            }
        }
    }
}
function UseItem(id) {
    if (table_inv[id].usable !== undefined){
        if (table_inv[id].usable == 1) {
            $.post('http://gum_inventory/use_item', JSON.stringify({ item: table_inv[id].item }));
        }
    }
}

function UseWeapon(id, model) {
    $.post('http://gum_inventory/use_UseWeapon', JSON.stringify({ id: id, model:model }));
}

function DropItem(count) {
    contextMenu.classList.remove("visible");
    if (count !== 0) {
        $.post('http://gum_inventory/drop_item', JSON.stringify({ item: clicked_id, count: Math.floor(count), is_weapon:clicked_type }));
    }
}

function GiveItem(count) {
    contextMenu.classList.remove("visible");
    if (count !== 0) {
        $.post('http://gum_inventory/give_item', JSON.stringify({ item: clicked_id, count: count }));
    }
}

function Show_Weap() {
    contextMenu.classList.remove("visible");
    $.post('http://gum_inventory/show_weapon', JSON.stringify({}));
}
