import { Component, input } from '@angular/core';
import { Artist } from '../../models/artist';
import { ArtistService } from '../../services/artist.service';
import { Router } from '@angular/router';
import { ModelListComponent } from '../../shared/model-list.component';

@Component({
  selector: 'app-artist-list',
  imports: [],
  templateUrl: './artist-list.component.html',
  styleUrls: ['../../app.component.css', './artist-list.component.css']
})
export class ArtistListComponent extends ModelListComponent<Artist> {
  constructor(protected override itemService: ArtistService, protected override router: Router) {
    super(itemService, router)
  }

}
