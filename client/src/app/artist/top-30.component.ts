import { Component, input } from '@angular/core';
import { ModelIndexComponent } from '../shared/model-index.component';
import { Artist } from '../models/artist';
import { Top30Service } from '../services/top-30.service';
import { ArtistListComponent } from "./artist-list/artist-list.component";

@Component({
  selector: 'app-top-30',
  imports: [ArtistListComponent],
  templateUrl: './top-30.component.html',
  styleUrls: ['../app.component.css', './top-30.component.css']
})
export class Top30Component extends ModelIndexComponent<Artist> {
  showDeeJay = input<boolean>(false);

  constructor(protected override modelService: Top30Service) {
    super(modelService);
  }

  deeJayName(): string {
    return '';
  }
}
