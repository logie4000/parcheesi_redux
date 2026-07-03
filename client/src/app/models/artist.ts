import { Album } from "./album";
import { Song } from "./song";
import { Track } from "./track";

export interface Artist {
  id: number,
  name: string,
  comment: string,
  songs: Song[] | undefined,
  albums: Album[] | undefined,
  tracks: Track[] | undefined,
}
