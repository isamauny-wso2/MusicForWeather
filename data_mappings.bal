function transform(WeatherData weatherData, SpotifyPlayList spotifyData) returns MusicSuggestion => {
    location: weatherData.location.name,
    weather: weatherData.current.condition.text,
    musicMood: getMusicMoodForWeather(weatherData.current.condition.code),
    playlist: from var itemsItem in spotifyData.playlists.items
        select {
            name: itemsItem?.name ?: "",
            url: itemsItem?.external_urls?.spotify ?: "",
            artist: itemsItem?.owner?.display_name ?: ""
        }
};