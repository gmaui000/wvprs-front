<template>
  <div class="flv-player-container">
    <video 
      ref="videoElement"
      class="flv-player"
      :style="{ height: height + 'px', maxHeight: '100%' }"
      controlsList="noplaybackrate noseek"
      controls
    ></video>
  </div>
</template>

<script>
import flvjs from 'flv.js'

export default {
  name: 'FlvPlayer',
  props: {
    videoUrl: {
      type: String,
      required: true
    },
    height: {
      type: Number,
      default: 400
    },
    autoplay: {
      type: Boolean,
      default: true
    }
  },
  data() {
    return {
      flvPlayer: null
    }
  },
  watch: {
    videoUrl: {
      handler(newUrl) {
        this.destroyPlayer()
        if (newUrl) {
          this.$nextTick(() => {
            this.initPlayer()
          })
        }
      }
    }
  },
  methods: {
    initPlayer() {
      if (flvjs.isSupported()) {
        const videoElement = this.$refs.videoElement
        this.flvPlayer = flvjs.createPlayer({
          type: 'flv',
          url: this.videoUrl
        })
        this.flvPlayer.attachMediaElement(videoElement)
        this.flvPlayer.load()
        if (this.autoplay) {
          this.flvPlayer.play()
        }
      }
    },
    destroyPlayer() {
      if (this.flvPlayer) {
        this.flvPlayer.destroy()
        this.flvPlayer = null
      }
    },
    play() {
      if (this.flvPlayer) {
        this.flvPlayer.play()
      }
    },
    pause() {
      if (this.flvPlayer) {
        this.flvPlayer.pause()
      }
    },
    setPlaybackRate(rate) {
      if (this.flvPlayer && this.$refs.videoElement) {
        this.$refs.videoElement.playbackRate = parseFloat(rate);
      }
    }
  },
  mounted() {
    if (this.videoUrl) {
      this.initPlayer()
    }
  },
  beforeDestroy() {
    this.destroyPlayer()
  }
}
</script>

<style scoped>
.flv-player-container {
  width: 100%;
  height: 100%;
}
.flv-player {
  width: 100%;
  background: #000;
  max-height: 100%;
}
.flv-player::-webkit-media-controls-timeline {
  display: none !important;
}
.flv-player::-webkit-media-controls-current-time-display {
  display: none !important;
}
.flv-player::-webkit-media-controls-time-remaining-display {
  display: none !important;
}
</style>