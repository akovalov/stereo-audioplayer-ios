# stereo-audioplayer-ios
Configure volume level for left and right channels in a stereo audio in Swift


### About

This is more as a reference project of an implementation of dynamic volume level changing for stereo audio player, but it's fully working player that can be used right away. 

`AVPlayer` and `MTAudioProcessingTap` are used under the hood. 

Mono mode is made via two AVPlayers to play original left and right channel in both channels. It should be possible to make in `process(` function of `AudioTap.m` file by manipulating audio buffers and have just one AVPlayer, but I couldn't do it so made a simple solution with two players.

### Usage

Try out the Demo project

```
let url = Bundle.main.url(forResource: "stereo-test", withExtension: "mp3")!
let player = StereoAudioPlayer(contentsOf: url)
player.play()

player.leftLevel = 0.5
player.rightLevel = 1
```

### Credits

StackOverflow<br>
[https://stackoverflow.com/a/37763490/1236681](https://stackoverflow.com/a/37763490/1236681)

Processing AVPlayer’s audio with MTAudioProcessingTap<br>
[https://chritto.wordpress.com/2013/01/07/processing-avplayers-audio-with-mtaudioprocessingtap/](
https://chritto.wordpress.com/2013/01/07/processing-avplayers-audio-with-mtaudioprocessingtap/)

