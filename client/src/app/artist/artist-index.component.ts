import { Component } from '@angular/core';
import { ModelIndexComponent } from '../shared/model-index.component';
import { Artist } from '../models/artist';
import { ArtistService } from '../services/artist.service';
import { ArtistListComponent } from './artist-list/artist-list.component';

@Component({
  selector: 'app-artist-index',
  imports: [ArtistListComponent],
  templateUrl: './artist-index.component.html',
  styleUrls: ['../app.component.css', './artist-index.component.css']
})
export class ArtistIndexComponent extends ModelIndexComponent<Artist> {

  constructor(protected override modelService: ArtistService) {
    super(modelService);
  }
}
