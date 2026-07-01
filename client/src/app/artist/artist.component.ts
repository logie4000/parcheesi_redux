import { Component } from '@angular/core';
import { ModelComponent } from '../shared/model.component';
import { Artist } from '../models/artist';
import { ActivatedRoute, Router } from '@angular/router';
import { ArtistService } from '../services/artist.service';
import { Song } from '../models/song';
import { AlbumListComponent } from "../album/album-list/album-list.component";
import { SongListComponent } from "../song/song-list/song-list.component";

@Component({
  selector: 'app-artist',
  imports: [AlbumListComponent, SongListComponent],
  templateUrl: './artist.component.html',
  styleUrls: ['../app.component.css', './artist.component.css']
})
export class ArtistComponent extends ModelComponent<Artist>{

  constructor(protected override activatedRoute: ActivatedRoute, private router: Router, protected artistService: ArtistService) {
    super(activatedRoute, artistService);
  }

  name() {
    var artist = this.model();

    if (artist) {
      return artist.name;
    } else {
      return 'Loading...';
    }
  }

  albums() {
    var artist = this.model();

    if (artist && artist.albums) {
      return artist.albums;
    } else {
      return [];
    }
  }
  
  songs(): Song[] {
    var artist = this.model();

    if (artist && artist.songs) {
      return artist.songs;
    } else {
      return [];
    }
  }
  
  comment() {
    var artist = this.model();

    if (artist) {
      return artist.comment;
    } else {
      return '';
    }
  }
}
