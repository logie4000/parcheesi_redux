import { Injectable } from '@angular/core';
import { Song } from '../models/song';

import * as config from '../app.config';
import { ModelService } from './model.service';

@Injectable({
  providedIn: 'root'
})
export class SongService extends ModelService<Song> {
  override endpointUrl: string = config.DB_SONG_SERVICE;
  override api: string = config.HOST_SONG_SERVICE;

  override itemUrl(song: Song): string {
    return `/${config.HOST_SONG_SERVICE}/${song.id}`
  }
}
