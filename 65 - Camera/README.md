The camera renders at 15FPS thanks to the "FramerateLimiter" script attached to the camera.

The camera turns on and start rendering when the main camera (player) is looking directly at the "Screen" GameObject (This is done inside the "SurveillanceCamera" script)
When you only look at the "ScreenWithoutScript" GameObject, the image will freeze

You can imagine here that the "Screen" GameObject is the surveillance camera screen : You only want the camera to work if you look at the screen!