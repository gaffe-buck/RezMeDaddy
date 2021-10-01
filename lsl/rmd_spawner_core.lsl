// state
integer line = 0;
key handle = NULL_KEY;
integer spawning = FALSE;
vector destination_position = <0,0,0>;
rotation destination_rotation = ZERO_ROTATION;

// sort of constants
string SPAWN_LIST = "RezMeDaddy";
integer CHANNEL = 0;

integer get_channel() {
    integer APP = 69;
    return 0x80000000 | ((integer)("0x"+(string)llGetOwner()) ^ APP);
}

shutdown() {
    spawning = FALSE;
    line = 0;
    llRegionSay(CHANNEL, "DIE");
}

default
{    
    state_entry()
    {
        CHANNEL = get_channel();
        llListen(CHANNEL, "", "", "");
    }

    touch_start(integer total_number)
    {
        if (spawning == TRUE) {
            llOwnerSay("Already spawned...");
        }
        else {
            line = 0;
            spawning = TRUE;
            llMessageLinked(LINK_THIS, 0, "BEG", llGetKey());
            handle = llGetNotecardLine(SPAWN_LIST, line);
        }
    }

    dataserver(key queryid, string data)
    {
        if (queryid == handle) {
            if (data == EOF) {
                return;
            }
            integer name_divider = llSubStringIndex(data, "|");
            string name = llGetSubString(data, 0, name_divider - 1);
            string pos_and_rot = llGetSubString(data, name_divider + 1, -1);
            llOwnerSay("pos_and_rot: " + pos_and_rot);
            integer pos_divider = llSubStringIndex(pos_and_rot, "|");
            destination_position = (vector)llGetSubString(pos_and_rot, 0, pos_divider - 1);
            destination_rotation = (rotation)llGetSubString(pos_and_rot, pos_divider + 1, -1);
            vector my_position = llGetPos();
            line = line + 1;

            llRezObject(name, my_position + <0,0,0.125>, ZERO_VECTOR, destination_rotation, 0);
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
        if (command == "WHR")
        {
            llRegionSay(CHANNEL, "MOV" + (string)destination_position);
            handle = llGetNotecardLine(SPAWN_LIST, line);
        }
        else if (command == "DIE") {
            shutdown();
        }
    }
}
