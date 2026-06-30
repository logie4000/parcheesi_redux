import { Artist } from "./artist";
import { RadioShow } from "./radio-show";
import { Song } from "./song";

export interface DeeJay {
  id: number,
  email: string,
  mixcloud_user: string,
  name: string,
  radio_shows: RadioShow[] | undefined,
  songs: Song[] | undefined,
  artists: Artist[] | undefined,
}