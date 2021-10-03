default
{
    touch_start(integer total_number)
    {
        llOwnerSay(llGetObjectName() + "|" + (string)llGetPos() + "|" + (string)llGetRot());
    }
}