import { RadioShow } from "./radio-show";
import { Song } from "./song";

export interface Track {
  id: number,
  ordinal: number,
  song: Song | undefined,
  radio_show: RadioShow | undefined,
}