import { Component } from '@angular/core';
import { ModelComponent } from '../shared/model.component';
import { Album } from '../models/album';
import { ActivatedRoute, Router } from '@angular/router';
import { AlbumService } from '../services/album.service';
import { Artist } from '../models/artist';

@Component({
  selector: 'app-album',
  imports: [],
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

  comment() {
    var album = this.model();

    if (album) {
      return album.comment;
    } else {
      return '';
    }
  }
}
