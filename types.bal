
type Location record {|
    string name;
    string region;
    string country;
    decimal lat;
    decimal lon;
    string tz_id;
    int localtime_epoch;
    string localtime;
|};

type Condition record {|
    string text;
    string icon;
    int code;
|};

type Current record {|
    int last_updated_epoch;
    string last_updated;
    decimal temp_c;
    int temp_f;
    int is_day;
    Condition condition;
    decimal wind_mph;
    decimal wind_kph;
    int wind_degree;
    string wind_dir;
    int pressure_mb;
    decimal pressure_in;
    int precip_mm;
    int precip_in;
    int humidity;
    int cloud;
    decimal feelslike_c;
    decimal feelslike_f;
    decimal windchill_c;
    decimal windchill_f;
    decimal heatindex_c;
    decimal heatindex_f;
    decimal dewpoint_c;
    decimal dewpoint_f;
    int vis_km;
    int vis_miles;
    decimal uv;
    decimal gust_mph;
    decimal gust_kph;
|};

type WeatherData record {
    Location location;
    Current current;
};

type External_urls record {
    string spotify;
};

type ImagesItem record {
    json height;
    string url;
    json width;
};

type Owner record {
    string display_name;
    External_urls external_urls;
    string href;
    string id;
    string 'type;
    string uri;
};

type Tracks record {
    string href;
    int total;
};

type ItemsItem record {
    boolean collaborative;
    string description;
    External_urls external_urls;
    string href;
    string id;
    ImagesItem[] images;
    string name;
    Owner owner;
    json primary_color;
    boolean 'public;
    string snapshot_id;
    Tracks tracks;
    string 'type;
    string uri;
};

type Playlists record {
    string href;
    int 'limit;
    string next;
    int offset;
    int total;
    ItemsItem?[] items;
};

type SpotifyPlayList record {
    Playlists playlists;
};

type PlayListInfo record {|
    string name;
    string artist;
    string url;
|};

type MusicSuggestion record {|
    PlayListInfo[] playList;
    string location;
    string weather;
    string musicMood;
|};
