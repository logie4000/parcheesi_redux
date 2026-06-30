import { Artist } from "./artist";
import { Song } from "./song";

export interface Album {
  id: number,
  title: string,
  comment: string,
  artists: Artist[] | undefined,
  songs: Song[] | undefined,
}