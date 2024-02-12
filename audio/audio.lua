MAudio = {
    music_general_volume = .2,
    sfx_volume = .5,
    musics = {
        intro = love.audio.newSource(
                --"music/theme-new-york-1997.mp3",
                --"music/zeropi-escape-from-new-york-main-theme-violin-cover-video.mp3",
                --"music/escape-from-new-york-theme-piano-and-synthesizer-cover.mp3",
                "music/1997-escape-from-new-york-metal-style.mp3",
                "stream"
        ),
        --map = love.audio.newSource(
        --        "music/map_music_Crossing_the_Chasm.ogg",
        --        "stream"
        --),
        --battle = love.audio.newSource(
        --        "music/battle_music_Darkling.ogg",
        --        "stream"
        --),
        --victory = love.audio.newSource(
        --        "music/victory_music_Burnt_Spirit.ogg",
        --        "stream"
        --)
    },
    sfxs = {
        blip_menu = love.audio.newSource("music/select_menu.ogg", "static"),
        crash = love.audio.newSource("music/95078__sandyrb__the-crash.wav", "static"),
        wind = love.audio.newSource("music/331527__davestalker__wind-howling-thru-window-crack.mp3","stream"),
        landing = love.audio.newSource("music/landing_sound01.wav", "static"),
        drift = love.audio.newSource("music/drifting.wav", "static"),
        deploy_stop = love.audio.newSource("music/deploy_stop.wav", "static")

    },
    playing = 'intro'
}
