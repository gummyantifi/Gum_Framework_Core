
function health_bar(){
    var health_active = $("#health_active");
    var prec = health_active.children().children().text();
    if (prec > 100)
        prec = 100;
    var deg = prec*3.6;
    if (deg <= 180){
        health_active.css('background-image','linear-gradient(' + (90+deg) + 'deg, transparent 50%, #000000 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
    else{
        health_active.css('background-image','linear-gradient(' + (deg-90) + 'deg, transparent 50%, #ffffff 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
}

function stamina_bar(){
    var stamina_active = $("#stamina_active");
    var prec = stamina_active.children().children().text();
    if (prec > 100)
        prec = 100;
    var deg = prec*3.6;
    if (deg <= 180){
        stamina_active.css('background-image','linear-gradient(' + (90+deg) + 'deg, transparent 50%, #000000 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
    else{
        stamina_active.css('background-image','linear-gradient(' + (deg-90) + 'deg, transparent 50%, #ffffff 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
}


function hunger_bar(){
    var hunger_active = $("#hunger_active");
    var prec = hunger_active.children().children().text();
    if (prec > 100)
        prec = 100;
    var deg = prec*3.6;
    if (deg <= 180){
        hunger_active.css('background-image','linear-gradient(' + (90+deg) + 'deg, transparent 50%, #000000 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
    else{
        hunger_active.css('background-image','linear-gradient(' + (deg-90) + 'deg, transparent 50%, #ffffff 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
}

function thirst_bar(){
    var thirst_active = $("#thirst_active");
    var prec = thirst_active.children().children().text();
    if (prec > 100)
        prec = 100;
    var deg = prec*3.6;
    if (deg <= 180){
        thirst_active.css('background-image','linear-gradient(' + (90+deg) + 'deg, transparent 50%, #000000 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
    else{
        thirst_active.css('background-image','linear-gradient(' + (deg-90) + 'deg, transparent 50%, #ffffff 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
}


function horse_health_bar(){
    var horse_health_active = $("#horse_health_active");
    var prec = horse_health_active.children().children().text();
    if (prec > 100)
        prec = 100;
    var deg = prec*3.6;
    if (deg <= 180){
        horse_health_active.css('background-image','linear-gradient(' + (90+deg) + 'deg, transparent 50%, #000000 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
    else{
        horse_health_active.css('background-image','linear-gradient(' + (deg-90) + 'deg, transparent 50%, #ffffff 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
}

function horse_stamina_bar(){
    var horse_stamina_active = $("#horse_stamina_active");
    var prec = horse_stamina_active.children().children().text();
    if (prec > 100)
        prec = 100;
    var deg = prec*3.6;
    if (deg <= 180){
        horse_stamina_active.css('background-image','linear-gradient(' + (90+deg) + 'deg, transparent 50%, #000000 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }else{
        horse_stamina_active.css('background-image','linear-gradient(' + (deg-90) + 'deg, transparent 50%, #ffffff 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
}

function progress_bar(){
    var progress_active = $("#progress_active");
    var prec = progress_active.children().children().text();
    if (prec > 100)
        prec = 100;
    var deg = prec*3.6;
    if (deg <= 180){
        progress_active.css('background-image','linear-gradient(' + (90+deg) + 'deg, transparent 50%, #000000 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }else{
        progress_active.css('background-image','linear-gradient(' + (deg-90) + 'deg, transparent 50%, #ffffff 50%),linear-gradient(90deg, #000000 50%, transparent 50%)');
    }
}

$(document).ready(function () {
    $("#progress_active").hide(); 
    window.addEventListener("message", function (event) {
            if (event.data.progress===true) {
                $("#progress_active").show();
                set_progress(event.data.time)
            } else if (event.data.progress===false){
                $("#progress_active").hide(); 
            }
            if (event.data.show===true) {
                show_hud(event.data.show);
                set_health(event.data.health);
                set_hunger(event.data.hunger);
                set_thirst(event.data.thirst);
                set_stamina(event.data.stamina);
                set_horse_health(event.data.horse_health);
                set_horse_stamina(event.data.horse_stamina);
                show_horse_stats(event.data.on_horse)
            } else{
                show_hud(event.data.show);
            }

    });
});

$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.compass == true) {
            $("#compass").show();
            $('#compass').css('transform','rotate(' + event.data.angle + 'deg)');
        } else if (item.compass == false) {
            $("#compass").hide();
        }
    });
});


function show_hud(show_hud) {
    if (show_hud) {
        $("#hunger_active").show();
        $("#thirst_active").show();
        $("#health_active").show();
        $("#stamina_active").show();
    } else {
        $("#hunger_active").hide();
        $("#thirst_active").hide();
        $("#health_active").hide();
        $("#stamina_active").hide();
        $("#horse_health_active").hide();
        $("#horse_stamina_active").hide();
    }
}


function show_horse_stats(horse_hud) {
    if (horse_hud) {
        $("#horse_stamina_active").show();
        $("#horse_health_active").show();
    } else {
        $("#horse_stamina_active").hide();
        $("#horse_health_active").hide();
    }
}
function set_horse_health(value) {
    var horseh = document.getElementsByClassName('horse_health_perc')[0];
    horseh.innerHTML = value;
    horse_health_bar()
}
function set_horse_stamina(value) {
    var horses = document.getElementsByClassName('horse_stamina_perc')[0];
    horses.innerHTML = value;
    horse_stamina_bar()
}



function set_health(value) {
    var health = document.getElementsByClassName('health_perc')[0];
    health.innerHTML = value;
    health_bar()
}

function set_hunger(value) {
    var hunger = document.getElementsByClassName('hunger_perc')[0];
    hunger.innerHTML = value;
    hunger_bar()
}

function set_thirst(value) {
    var thirst = document.getElementsByClassName('thirst_perc')[0];
    thirst.innerHTML = value;
    thirst_bar()
}
function set_stamina(value) {
    var stamina = document.getElementsByClassName('stamina_perc')[0];
    stamina.innerHTML = value;
    stamina_bar()
}
function set_progress(value) {
    var progress = document.getElementsByClassName('progress_perc')[0];
    progress.innerHTML = value;
    progress_bar()
}

