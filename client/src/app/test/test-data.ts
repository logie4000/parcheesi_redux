import { Album } from "../models/album";
import { Artist } from "../models/artist";
import { DeeJay } from "../models/dee-jay";
import { RadioShow } from "../models/radio-show";
import { Song } from "../models/song";

export const SONG_1: Song = {
  id: 1,
  title: "Welcome to New York",
  comment: "",
  total_plays: 5,
  album: undefined,
  artist: undefined,
  last_played_overall: undefined,
  tracks: undefined,
  radio_shows: undefined
}

export const RADIO_SHOW_1: RadioShow = {
  id: 1,
  dee_jay: undefined,
  publish_date: "2026-01-24",
  title: "Knucky Sandy Radio Hour",
  web_link: "http://radio.shows.org",
  tracks: undefined,
  songs: undefined
}

export const DEE_JAY_1: DeeJay = {
  id: 1,
  email: "someone@hr.com",
  mixcloud_user: "Hoo Hah",
  name: "Mr. HR",
  radio_shows: undefined,
  songs: undefined,
  artists: undefined
}

export const ARTIST_1: Artist = {
  id: 1,
  name: "Taylor Swift",
  comment: "Yes, that Taylor Swift",
  songs: undefined,
  albums: undefined
}

export const ALBUM_1: Album = {
  id: 1,
  title: "1989",
  comment: "",
  artists: undefined,
  songs: undefined
}