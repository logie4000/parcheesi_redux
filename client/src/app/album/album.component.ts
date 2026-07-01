import { Component } from '@angular/core';
import { ModelComponent } from '../shared/model.component';
import { Album } from '../models/album';
import { ActivatedRoute, Router } from '@angular/router';
import { AlbumService } from '../services/album.service';
import { Artist } from '../models/artist';
import { Song } from '../models/song';
import { ArtistIndexComponent } from "../artist/artist-index.component";
import { ArtistListComponent } from "../artist/artist-list/artist-list.component";
import { SongListComponent } from "../song/song-list/song-list.component";

@Component({
  selector: 'app-album',
  imports: [ArtistListComponent, SongListComponent],
  templateUrl: './album.component.html',
  styleUrls: ['../app.component.css', './album.component.css']
})
export class AlbumComponent extends ModelComponent<Album>{

  constructor(protected override activatedRoute: ActivatedRoute, private router: Router, protected albumService: AlbumService) {
    super(activatedRoute, albumService);
  }

  title() {
    var album = this.model();

    if (album) {
      return album.title;
    } else {
      return 'Loading...';
    }
  }

  artists(): Artist[] {
    var album = this.model();

    if (album && album.artists) {
      return album.artists;
    } else {
      return [];
    }
  }

  songs(): Song[] {
    var album = this.model();

    if (album && album.songs) {
      return album.songs;
    } else {
      return [];
    }
  }
  
  comment() {
    var album = this.model();

    if (album) {
      return album.comment;
    } else {
      return '';
    }
  }
}
