import { Component } from '@angular/core';
import { ModelComponent } from '../shared/model.component';
import { Song } from '../models/song';
import { ActivatedRoute, Router } from '@angular/router';
import { SongService } from '../services/song.service';

@Component({
  selector: 'app-song',
  imports: [],
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
      return "ARTIST NAME";
    } else {
      return '';
    }
  }

  album() {
    var song = this.model();

    if (song) {
      return "ALBUM TITLE";
    } else {
      return '';
    }
  }
}
