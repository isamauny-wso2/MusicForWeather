function transform(PlayListInfo[] playList, WeatherData weatherInfo) returns MusicSuggestion => {
    playList: playList,
    location: weatherInfo.location.name,
    weather: weatherInfo.current.condition.text,
    musicMood: getMusicMood(weatherInfo.current.condition.code)
};