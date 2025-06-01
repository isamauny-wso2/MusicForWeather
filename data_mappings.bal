function transform(WeatherRecord weatherData, SpotifyPlayList spotifyData) returns MusicSuggestion => {
    location: weatherData.name,
    weather: weatherData.weather[0].description,
    musicMood: getMusicMoodForWeather(weatherData.weather[0].id),
    playlist: from var itemsItem in spotifyData.playlists.items
        where itemsItem is ItemsItem
        let string name = itemsItem.name,
            string url = itemsItem.external_urls.spotify,
            string artist = itemsItem.owner.display_name
        where name != "" && url != "" && artist != ""
        select {
            name,
            url,
            artist
        }
};
