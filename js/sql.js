function logout(){
    if (window.confirm("Really want to Logout?")) {
      location.href = "logout.jsp";
    }
}

function sys_admin(){
    location.href="auth.jsp?mode=admin"
}

function drop_tb(table){
    if (window.confirm("Drop table '"+table+"'?")) {
      parent.frames["main"].location.href = "run_sql.jsp?type=drop_tb&table=" + table;
    }
}

function drop_fd(table, field){
    if (window.confirm("Delete field '"+field+"'?")) {
      parent.frames["main"].location.href = "run_sql.jsp?type=drop_fd&table=" + table +"&field=" + field;
    }
}

function drop_key(table, key){
    if (window.confirm("Drop key '"+key+"'?")) {
      parent.frames["main"].location.href = "run_sql.jsp?type=drop_key&table=" + table +"&key=" + key;
    }
}

function mod_fd(table, field){
      parent.frames["main"].location.href = "mod_field.jsp?table=" + table +"&field=" + field;
}

function empty_tb(table){
    if (window.confirm("Empty table '"+table+"'?")) {
      parent.frames["main"].location.href = "run_sql.jsp?type=empty_tb&table=" + table;
    }
}

function new_pk(table, field){
    if (window.confirm("Do you really want to use `"+field+"` as the Primary Key of `"+table+"` ?")) {
      parent.frames["main"].location.href = "run_sql.jsp?type=new_pk&table=" + table + "&field=" + field;
    }
}
function new_uni(table, field){
    if (window.confirm("Do you really want to make `"+field+"` as Unique of `"+table+"` ?")) {
      parent.frames["main"].location.href = "run_sql.jsp?type=new_uni&table=" + table + "&field=" + field;
    }
}
function new_idx(table, field){
    if (window.confirm("Do you really want to add `"+field+"` as the Index of `"+table+"` ?")) {
      parent.frames["main"].location.href = "run_sql.jsp?type=new_idx&table=" + table + "&field=" + field;
    }
}

function browse(table){
   parent.frames["main"].location.href = "run_sql.jsp?type=browse&table=" + table;
}

function proper(table){

    parent.frames["main"].location.href = "show_table.jsp?table=" + table;
}
function hist_run(rec){
    location.href="mod_hist.jsp?type=history&hist_rec=" + rec;
}
function hist_remove(rec){
    location.href="history.jsp?type=remove&hist_rec=" + rec;
}
function hist_clear(){
    location.href="history.jsp?type=remove";
}

function change_text(dis_obj, chk_obj, choice, chg_val){
    if(chk_obj.selectedIndex.index == choice){
        dis_obj.disabled = true;
        dis_obj.value = chg_val;
    }else{
        dis_obj.disabled = false;
        dis_obj.value = "";
    }
}
