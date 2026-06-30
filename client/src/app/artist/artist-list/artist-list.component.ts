import { Component, input } from '@angular/core';
import { Artist } from '../../models/artist';
import { ArtistService } from '../../services/artist.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-artist-list',
  imports: [],
  templateUrl: './artist-list.component.html',
  styleUrls: ['../../app.component.css', './artist-list.component.css']
})
export class ArtistListComponent {
  itemList = input<Artist[] | undefined>([]);

  constructor(private artistService: ArtistService, private router: Router) {

  }
  
  getItems(): Artist[] {
    var list = this.itemList();
    if (list == undefined) {
      return [];
    } else {
      return list;
    }
  }

  onRowClick(artist: Artist) {
    this.router.navigate([this.artistService.itemUrl(artist)]);
  }
}
