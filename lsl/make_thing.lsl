vector where = <0,0,0>;
string THING = "thing";
vector myPos = <0,0,0>;

default
{    
    state_entry()
    {
        llListen(6969, "", "", "");
    }

    listen( integer channel, string name, key id, string message )
    {
        string command = llGetSubString(message, 0, 2);
        if (command == "WHR")
        {
            llOwnerSay("I'm telling it where.");
            llRegionSay(6969, "MOV" + (string)(myPos + <0,0,height>));
            height = height + HEIGHT_INCREMENT;
        }
    }

    touch_start(integer total_number)
    {
        myPos = llGetPos();
        vector newThingPos = myPos + <0, 0, 0.125>;
        height = height + HEIGHT_INCREMENT;
        llOwnerSay("Making the thing.");
        llRezObject(THING, newThingPos, <0,0,0>, ZERO_ROTATION, 0);
    }
}
