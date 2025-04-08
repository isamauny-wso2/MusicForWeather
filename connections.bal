import ballerina/http;

// Spotify OAuth2 client
http:Client spotifyClient = check new ("https://api.spotify.com/v1",
    auth = {
        tokenUrl: "https://accounts.spotify.com/api/token",
        clientId: SPOTIFY_CLIENT_ID,
        clientSecret: SPOTIFY_CLIENT_SECRET
    }
);

// Weather API client
http:Client weatherClient = check new ("http://api.weatherapi.com/v1/");