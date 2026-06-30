import { Injectable } from '@angular/core';
import { Album } from '../models/album';
import * as config from '../app.config';
import { ModelService } from './model.service';

@Injectable({
  providedIn: 'root'
})
export class AlbumService extends ModelService<Album> {
  override endpointUrl: string = config.DB_ALBUM_SERVICE;
  override api: string = config.HOST_ALBUM_SERVICE;

  override itemUrl(album: Album): string {
    return `/${config.HOST_ALBUM_SERVICE}/${album.id}`
  }
}
