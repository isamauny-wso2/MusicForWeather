import ballerina/http;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service /MusicMood on httpDefaultListener {
    resource function get playlist(string location) returns error|json|http:InternalServerError {
        do {
            //WeatherData weatherResponse = check weatherAPIClient->get(string `/data/2.5/weather?q=${location}&APPID=${WEATHER_API_KEY}`);
            WeatherRecord weatherResponse = check weatherAPIClient->get(string `/data/2.5/weather?q=${location}&APPID=${WEATHER_API_KEY}`);
            
            int weatherCode = weatherResponse.weather[0].id;
            string musicMood = getMusicMoodForWeather(weatherCode);
            SpotifyPlayList spotifyResponse = check spotifyClient->get(string `/search?q=${musicMood}&type=playlist`);

            return transform(weatherResponse, spotifyResponse);
        } on fail error err {
            return error("unhandled error", err);
        }
    }
}
