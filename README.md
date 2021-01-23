# stereo-audioplayer-ios
Configure volume level for left and right channels in a stereo audio in Swift


### About

This is more as a reference project of an implementation of dynamic volume level changing for stereo audio player, but it's fully working player that can be used right away. 

`AVPlayer` and `MTAudioProcessingTap` are used under the hood. 

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

