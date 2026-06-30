import { Component } from '@angular/core';
import { ModelIndexComponent } from '../shared/model-index.component';
import { Song } from '../models/song';
import { SongService } from '../services/song.service';
import { SongListComponent } from './song-list/song-list.component';

@Component({
  selector: 'app-song-index',
  imports: [SongListComponent],
  templateUrl: './song-index.component.html',
  styleUrls: ['../app.component.css', './song-index.component.css']
})
export class SongIndexComponent extends ModelIndexComponent<Song> {

  constructor(protected override modelService: SongService) {
    super(modelService);
  }
}
