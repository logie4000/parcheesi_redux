import { Album } from "./album";
import { Artist } from "./artist";
import { RadioShow } from "./radio-show";
import { Track } from "./track";

export interface Song {
  id: number,
  title: string,
  comment: string,
  total_plays: number,
  album: Album | undefined,
  artist: Artist | undefined,
  last_played_overall: RadioShow | undefined,
//  tracks: Track[] | undefined,
  radio_shows: RadioShow[] | undefined,
}

export const EMPTY_SONG: Song = {
  id: 0,
  title: '',
  comment: '',
  total_plays: 0,
  album: undefined,
  artist: undefined,
  last_played_overall: undefined,
  radio_shows: undefined
}