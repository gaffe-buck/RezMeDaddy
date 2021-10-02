// state
integer line = 0;
key handle = NULL_KEY;
integer spawning = FALSE;
integer loading = FALSE;
list things = [];

// sort of constants
string SPAWN_LIST = "RezMeDaddy";
integer CHANNEL = 0;

integer get_channel() {
    integer APP = 69;
    return 0x80000000 | ((integer)("0x"+(string)llGetOwner()) ^ APP);
}

shutdown() {
    llSetLinkPrimitiveParamsFast(LINK_THIS, [PRIM_FULLBRIGHT, ALL_SIDES, TRUE]);
    spawning = FALSE;
    line = 0;
    llRegionSay(CHANNEL, "DIE");
}

spawn_all() {
    integer i;
    integer lines = llGetListLength(things);
    while (i < lines) {
        string data = llList2String(things, i);
        integer name_divider = llSubStringIndex(data, "|");
        string name = llGetSubString(data, 0, name_divider - 1);
        string pos_and_rot = llGetSubString(data, name_divider + 1, -1);
        integer pos_divider = llSubStringIndex(pos_and_rot, "|");
        rotation destination_rotation = (rotation)llGetSubString(pos_and_rot, pos_divider + 1, -1);
        vector my_position = llGetPos();
        line = line + 1;

        llRezObject(name, my_position + <0,0,0.125>, ZERO_VECTOR, destination_rotation, i);
        i = i + 1;
    }
}

default
{    
    state_entry()
    {   
        loading = FALSE;
        handle = llGetNotecardLine(SPAWN_LIST, line);
        CHANNEL = get_channel();
        llListen(CHANNEL, "", "", "");
    }

    touch_start(integer total_number)
    {
        if (loading == TRUE) {
            llSay(0, "Still loading...");
        }
        else if (spawning == TRUE) {
            llSay(0, "The clutter will be removed in 1 hour.");
            llMessageLinked(LINK_THIS, 0, "BEG", llGetKey());
        }
        else {
            line = 0;
            spawning = TRUE;
            llMessageLinked(LINK_THIS, 0, "BEG", llGetKey());
            llSetLinkPrimitiveParamsFast(LINK_THIS, [PRIM_FULLBRIGHT, ALL_SIDES, FALSE]);
            spawn_all();
        }
    }

    dataserver(key queryid, string data)
    {
        if (queryid == handle) {
            if (data == EOF) {
                llSay(0, "Loaded " + (string)llGetListLength(things) + " things!");
                loading = FALSE;
                return;
            }
            things = things + [data];
            line = line + 1;
            handle = llGetNotecardLine(SPAWN_LIST, line);
        }
    }

    link_message(integer sender_num, integer num, string str, key id)
    {
        if (id != llGetKey()) {
            if (str == "DIE") {
                shutdown();
            }
        }
    }

    listen(integer channel, string name, key id, string message)
    {
        string command = llGetSubString(message, 0, 2);
        if (command == "WHR" && spawning == TRUE)
        {
            integer index = (integer)llGetSubString(message, 3, -1);
            string data = llList2String(things, index);
            integer name_divider = llSubStringIndex(data, "|");
            string pos_and_rot = llGetSubString(data, name_divider + 1, -1);
            integer pos_divider = llSubStringIndex(pos_and_rot, "|");
            vector destination_position = (vector)llGetSubString(pos_and_rot, 0, pos_divider - 1);
            string response = "MOV" + (string)index + "|" + (string)destination_position;
            llRegionSay(CHANNEL, response);
        }
        else if (command == "DIE") {
            shutdown();
        }
    }

    changed(integer change)
    {
        if (change & CHANGED_INVENTORY) {
            llResetScript();
        }
    }
}
