import { Album } from "./album";
import { Song } from "./song";

export interface Artist {
  id: number,
  name: string,
  comment: string,
  songs: Song[] | undefined,
  albums: Album[] | undefined,
}
