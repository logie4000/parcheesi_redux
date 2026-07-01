import { Component } from '@angular/core';
import { ModelComponent } from '../shared/model.component';
import { Song } from '../models/song';
import { ActivatedRoute, Router } from '@angular/router';
import { SongService } from '../services/song.service';
import { RadioShowListComponent } from "../radio-show/radio-show-list/radio-show-list.component";

@Component({
  selector: 'app-song',
  imports: [RadioShowListComponent],
  templateUrl: './song.component.html',
  styleUrls: ['../app.component.css', './song.component.css']
})
export class SongComponent extends ModelComponent<Song>{

  constructor(protected override activatedRoute: ActivatedRoute, private router: Router, protected songService: SongService) {
    super(activatedRoute, songService);
  }

  title() {
    var song = this.model();

    if (song) {
      return song.title;
    } else {
      return 'Loading...';
    }
  }

  artist() {
    var song = this.model();

    if (song) {
      return song.artist?.name;
    } else {
      return 'NO ARTIST';
    }
  }

  album() {
    var song = this.model();

    if (song) {
      return song.album?.title;
    } else {
      return 'NO ALBUM';
    }
  }

  radio_shows() {
    var song = this.model();

    if (song && song.radio_shows) {
      return song.radio_shows
    } else {
      return [];
    }
  }
}
