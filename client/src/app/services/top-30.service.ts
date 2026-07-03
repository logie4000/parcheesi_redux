import { Injectable } from '@angular/core';
import { Artist } from '../models/artist';
import { ModelService } from './model.service';

import * as config from '../app.config';

@Injectable({
  providedIn: 'root'
})
export class Top30Service extends ModelService<Artist>{
  override endpointUrl: string = config.DB_TOP30_SERVICE;
  override api: string = config.HOST_TOP30_SERVICE;

  override itemUrl(artist: Artist): string {
    return `${config.HOST_ARTIST_SERVICE}/${artist.id}`
  }
}