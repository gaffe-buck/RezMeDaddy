integer listener = 0;
integer CHANNEL = 0;
integer thing_id = 0;

integer get_channel() {
    integer APP = 69;
    return 0x80000000 | ((integer)("0x"+(string)llGetOwner()) ^ APP);
}

default
{    
    on_rez(integer start_param)
    {
        CHANNEL = get_channel();
        listener = llListen(CHANNEL, "", "", "");
        string command = "WHR" + (string)start_param;
        llOwnerSay("mover says: " + command);
        llRegionSay(CHANNEL, command);
        thing_id = start_param;
    }

    listen(integer channel, string name, key id, string message)
    {
        llOwnerSay("Mover received: " + message);
        string command = llGetSubString(message, 0, 2);
        integer divider = llSubStringIndex(message, "|");
        integer command_id = (integer)llGetSubString(message, 3, divider - 1);
        if (command == "MOV" && command_id == thing_id)
        {
            vector position = (vector)llGetSubString(message, divider + 1, -1);
            
            llSetPos(position);
            llListenRemove(listener);
        }
    }
}