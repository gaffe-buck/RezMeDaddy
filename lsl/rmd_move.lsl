integer listener = 0;
integer CHANNEL = 0;

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
        llRegionSay(CHANNEL, "WHR");
    }

    listen(integer channel, string name, key id, string message)
    {
        llOwnerSay("Mover received: " + message);
        string command = llGetSubString(message, 0, 2);
        if (command == "MOV")
        {
            vector position = (vector)llGetSubString(message, 3, llStringLength(message)-1);
            
            llSetPos(position);
            llListenRemove(listener);    
        }
    }
}