import { Component } from '@angular/core';
import { ModelComponent } from '../shared/model.component';
import { Artist } from '../models/artist';
import { ActivatedRoute, Router } from '@angular/router';
import { ArtistService } from '../services/artist.service';

@Component({
  selector: 'app-artist',
  imports: [],
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

  comment() {
    var artist = this.model();

    if (artist) {
      return artist.comment;
    } else {
      return '';
    }
  }
}
