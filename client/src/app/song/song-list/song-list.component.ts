import { Component, input } from '@angular/core';
import { Song } from '../../models/song';
import { SongService } from '../../services/song.service';
import { Router } from '@angular/router';
import { ModelListComponent } from '../../shared/model-list.component';

@Component({
  selector: 'app-song-list',
  imports: [],
  templateUrl: './song-list.component.html',
  styleUrls: ['../../app.component.css', './song-list.component.css']
})
export class SongListComponent extends ModelListComponent<Song> {
  showArtist = input<boolean>(true);
  showAlbum = input<boolean>(true);

  constructor(protected override itemService: SongService, protected override router: Router) {
    super(itemService, router);
  }
}
