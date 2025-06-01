import ballerina/http;

final http:Client weatherAPIClient = check new ("https://api.openweathermap.org");
final http:Client spotifyClient = check new ("https://api.spotify.com/v1", auth = {
    tokenUrl: "https://accounts.spotify.com/api/token",
    clientId: SPOTIFY_CLIENT_ID,
    clientSecret: SPOTIFY_CLIENT_SECRET
});
