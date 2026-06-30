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
  tracks: Track[] | undefined,
  radio_shows: RadioShow[] | undefined,
}