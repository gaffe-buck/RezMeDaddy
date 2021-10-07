# RezMeDaddy
A tool for rezzing and derezzing things from far away

## lsl
Scripts for the RezMeDaddy system.

### kill

#### kill
Add this script to an object. When the object is clicked, any object with the `rmd_die` script will delete itself.

### prop

#### die
Add this script to any props you want rezzed by the system. When `rmd_kill` is activated, objects with this script will delete themselves.

#### get line
Add this script to a prop you want rezzed by the system, place the object where you want it rezzed, then click. The output in chat is what should be copied into `RezMeDaddy` notecard. Remove the script from the object once you'd updated the notecard or otherwise preserved the output.

#### move
Add this script to a prop you want rezzed by the system. The script receives commands from the spawner to move the object into the location specified by the `RezMeDaddy` notecard.

### spawner

#### RezMeDaddy
This notecard contains the name, location, and rotation of objects that you want to be spawned and placed. Use `rmd_get_line` to get properly formatted lines to add to the notecard. Add the notecard to an object with `rmd_spawner_core` and `rmd_spawner_timeout`.

#### spawner core
The core functionality of the spawner object. Add this script to the spawner object with the `RezMeDaddy` notecard and `rmd_spawner_timeout`.

#### spawner timeout
Will delete all spawned object in two hours (configurable, please inspect the script). If you change the timeout to something other than two hours, you may want to change one of the `llSay` lines in `rmd_spawner_core` to reflect that change.

### util

#### give landmark
Place this in an object along with a landmark. When the object is clicked, the landmark will be given to the avatar that clicked.

#### host board
Place in an object and change the object's description to an avatar key. The avatar's profile picture will be set as the texture to one of the faces of the object and floating text will appear with the avatar's name and online status. Clicking the object will open the avatar's profile. Change the `NAME` variable in the script to a name or nickname for the avatar.

#### load url on click
Place in an object and change the `INFO` and `URL` variables to a short description of the URL and the URL, respectively. Users that click on the object will navigate to the URL.

## Fright at The Chateau 2021
Some Fright-related goodies of interest to no one except myself, however it does include a good example of a `RezMeDaddy` notecard.

### Assets
The assets notecard for the Fright tome used for the Fright at The Chateau 2021 event.

### RezMeDaddy
The `RezMeDaddy` notecard for the Fright environment use for the Fright at The Chateau 2021 event.