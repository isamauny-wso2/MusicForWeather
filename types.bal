
// Spotify Types
type External_urls record {|
    string spotify;
|};

type ImagesItem record {|
    string url;
    int|json|() height;
    int|json|() width;
|};

type Owner record {|
    External_urls external_urls;
    string href;
    string id;
    string 'type;
    string uri;
    string display_name;
|};

type Tracks record {|
    string href;
    int total;
|};

type ItemsItem record {|
    boolean collaborative;
    string description;
    External_urls external_urls;
    string href;
    string id;
    ImagesItem[] images;
    string name;
    Owner owner;
    boolean 'public;
    string snapshot_id;
    Tracks tracks;
    string 'type;
    string uri;
    json primary_color;
|};

type Playlists record {
    string href;
    int 'limit;
    string next;
    int offset;
    json? previous;
    int total;
    ItemsItem?[] items;
};

type SpotifyPlayList record {|
    Playlists playlists;
|};

type PlaylistInfo record {|
    string name;
    string url;
    string artist;
|};

type MusicSuggestion record {|
    string location;
    string weather;
    string musicMood;
    PlaylistInfo[] playlist;
|};

//Weather.org types

type Coord record {|
    decimal lon;
    decimal lat;
|};

type WeatherItem record {|
    int id;
    string main;
    string description;
    string icon;
|};

type Main record {|
    decimal temp;
    decimal feels_like;
    decimal temp_min;
    decimal temp_max;
    int pressure;
    int humidity;
    int sea_level;
    int grnd_level;
|};

type Wind record {|
    decimal speed;
    int deg;
    decimal gust;
|};

type Clouds record {|
    int all;
|};

type Sys record {|
    int 'type;
    int id;
    string country;
    int sunrise;
    int sunset;
|};

type WeatherRecord record {|
    Coord coord;
    WeatherItem[] weather;
    string base;
    Main main;
    int visibility;
    Wind wind;
    Clouds clouds;
    int dt;
    Sys sys;
    int timezone;
    int id;
    string name;
    int cod;
|};
