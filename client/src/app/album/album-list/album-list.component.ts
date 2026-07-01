import { Component, input } from '@angular/core';
import { Router } from '@angular/router';
import { ModelListComponent } from '../../shared/model-list.component';
import { Album } from '../../models/album';
import { AlbumService } from '../../services/album.service';

@Component({
  selector: 'app-album-list',
  imports: [],
  templateUrl: './album-list.component.html',
  styleUrls: ['../../app.component.css', './album-list.component.css']
})
export class AlbumListComponent extends ModelListComponent<Album> {
  constructor(protected override itemService: AlbumService, protected override router: Router) {
    super(itemService, router);
  }

  albumArtist(album: Album) {
    if (album.artists) {
      if (album.artists.length > 0) {
        return "Various Artists";
      } else {
        return album.artists[0]?.name;
      }
    }

    return "NO ARTIST";
  }
}
