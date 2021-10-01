integer get_channel() {
    integer APP = 69;
    return 0x80000000 | ((integer)("0x"+(string)llGetOwner()) ^ APP);
}

default
{
    touch_start(integer total_number)
    {
        llRegionSay(get_channel(), "DIE");
    }
}