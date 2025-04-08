import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

// Configurable variables
configurable string SPOTIFY_CLIENT_ID = ?;
configurable string SPOTIFY_CLIENT_SECRET = ?;
configurable string WEATHER_API_KEY = ?;

// Spotify OAuth2 client
http:Client spotifyClient = check new ("https://api.spotify.com/v1",
    auth = {
        tokenUrl: "https://accounts.spotify.com/api/token",
        clientId: SPOTIFY_CLIENT_ID,
        clientSecret: SPOTIFY_CLIENT_SECRET
    }
);
http:Client weatherClient = check new ("http://api.weatherapi.com/v1/");

function getMusicMood(int weatherCode) returns string {
    map<string> weatherMoodMap = {
        "1000": "Happy, Upbeat", // Sunny, Clear
        "1003": "Chill, Relaxing", // Partly Cloudy
        "1006": "Mellow, Acoustic", // Cloudy
        "1009": "Mellow, Acoustic", // Overcast
        "1030": "Lo-Fi, Ambient", // Mist
        "1063": "Chill, Jazz", // Patchy rain possible
        "1066": "Cozy, Classical", // Patchy snow possible
        "1069": "Cozy, Classical", // Patchy sleet possible
        "1072": "Soft Instrumental", // Patchy freezing drizzle
        "1087": "Rock, Intense", // Thunderstorms
        "1114": "Mellow, Piano", // Blowing snow
        "1117": "Soft Instrumental", // Blizzard
        "1135": "Lo-Fi, Ambient", // Fog
        "1147": "Lo-Fi, Ambient", // Freezing fog
        "1150": "Chill, Jazz", // Patchy light drizzle
        "1153": "Chill, Jazz", // Light drizzle
        "1168": "Soft Instrumental", // Freezing drizzle
        "1171": "Soft Instrumental", // Heavy freezing drizzle
        "1180": "Chill, Acoustic", // Patchy light rain
        "1183": "Blues, Acoustic", // Light rain
        "1186": "Blues, Acoustic", // Moderate rain at times
        "1189": "Blues, Acoustic", // Moderate rain
        "1192": "Blues, Emotional", // Heavy rain at times
        "1195": "Blues, Emotional", // Heavy rain
        "1198": "Soft Instrumental", // Light freezing rain
        "1201": "Soft Instrumental", // Moderate or heavy freezing rain
        "1204": "Chill, Classical", // Light sleet
        "1207": "Chill, Classical", // Moderate or heavy sleet
        "1210": "Cozy, Acoustic", // Patchy light snow
        "1213": "Cozy, Acoustic", // Light snow
        "1216": "Soft Instrumental", // Patchy moderate snow
        "1219": "Soft Instrumental", // Moderate snow
        "1222": "Calm, Lo-Fi", // Patchy heavy snow
        "1225": "Calm, Lo-Fi", // Heavy snow
        "1237": "Ambient, Electronic", // Ice pellets
        "1240": "Chill, Jazz", // Light rain shower
        "1243": "Blues, Acoustic", // Moderate or heavy rain shower
        "1246": "Rock, Intense", // Torrential rain shower
        "1249": "Soft Instrumental", // Light sleet showers
        "1252": "Soft Instrumental", // Moderate or heavy sleet showers
        "1255": "Cozy, Classical", // Light snow showers
        "1258": "Cozy, Classical", // Moderate or heavy snow showers
        "1261": "Ambient, Electronic", // Light ice pellet showers
        "1264": "Ambient, Electronic", // Moderate or heavy ice pellet showers
        "1273": "Rock, Energetic", // Patchy light rain with thunder
        "1276": "Rock, Intense", // Moderate or heavy rain with thunder
        "1279": "Soft Instrumental", // Patchy light snow with thunder
        "1282": "Soft Instrumental" // Moderate or heavy snow with thunder
    };

    return weatherMoodMap.hasKey(weatherCode.toString()) ? weatherMoodMap.get(weatherCode.toString()) : "Chill, Lo-Fi";
}

service /MusicMood on httpDefaultListener {
    resource function get playList(string location) returns error|MusicSuggestion|http:InternalServerError {
        WeatherData weatherResponse = check weatherClient->get(string `current.json?key=${WEATHER_API_KEY}&q=${location}}`);
        string musicMood = getMusicMood(weatherResponse.current.condition.code);

        log:printInfo("Weather Mood: " + weatherResponse.current.condition.text);
        log:printInfo("Music Mood: " + musicMood);

        SpotifyPlayList spotifyResponse = check spotifyClient->get(string `/search?q=${musicMood}&type=playlist`);
        PlayListInfo[] playListInfo = [];
        foreach ItemsItem|() item in spotifyResponse.playlists.items {
            if (item is ItemsItem) {
                PlayListInfo info = {
                    name: item.name,
                    artist: item.owner.display_name,
                    url: item.external_urls.spotify
                };
                playListInfo.push(info);
            }

        }
        MusicSuggestion transformResult = transform(playListInfo, weatherResponse);
        return transformResult;
    }
}
