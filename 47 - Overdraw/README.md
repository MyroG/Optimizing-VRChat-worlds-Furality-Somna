When you launch the scene in play mode, and using the Frame debugger, you'll notice that the wall on the back gets rendered first, then the picture frame => Overdraw

To fix that issue, there are two solutions :
- Increase the render queue of the wall
- Separate the wall from the rest of the room, and disable static batching (that's the "RoomEdited" mesh)