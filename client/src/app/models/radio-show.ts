import { DeeJay } from "./dee-jay";
import { Song } from "./song";
import { Track } from "./track";

export interface RadioShow {
  id: number,
  dee_jay: DeeJay | undefined,
  publish_date: string,
  title: string,
  web_link: string,
  tracks: Track[] | undefined,
  songs: Song[] | undefined,
}