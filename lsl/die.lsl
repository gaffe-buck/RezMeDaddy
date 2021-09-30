default
{
     state_entry()
    {
        llListen(6969, "", "", "DIE");
    }

    listen( integer channel, string name, key id, string message )
    {
        llDie();
    }
}
