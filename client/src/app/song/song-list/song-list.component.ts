import { Component, input } from '@angular/core';
import { Song } from '../../models/song';
import { SongService } from '../../services/song.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-song-list',
  imports: [],
  templateUrl: './song-list.component.html',
  styleUrls: ['../../app.component.css', './song-list.component.css']
})
export class SongListComponent {
  itemList = input<Song[] | undefined>([]);

  constructor(private songService: SongService, private router: Router) {

  }
  
  getItems(): Song[] {
    var list = this.itemList();
    if (list == undefined) {
      return [];
    } else {
      return list;
    }
  }

  onRowClick(song: Song) {
    this.router.navigate([this.songService.itemUrl(song)]);
  }
}
