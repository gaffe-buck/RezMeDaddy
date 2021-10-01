integer get_channel() {
    integer APP = 69;
    return 0x80000000 | ((integer)("0x"+(string)llGetOwner()) ^ APP);
}

default
{
    state_entry()
    {
        llListen(get_channel(), "", "", "DIE");
    }

    listen(integer channel, string name, key id, string message)
    {
        llDie();
    }
}
