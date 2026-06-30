import { Component } from '@angular/core';
import { ModelIndexComponent } from '../shared/model-index.component';
import { Album } from '../models/album';
import { AlbumService } from '../services/album.service';
import { AlbumListComponent } from './album-list/album-list.component';

@Component({
  selector: 'app-album-index',
  imports: [AlbumListComponent],
  templateUrl: './album-index.component.html',
  styleUrls: ['../app.component.css', './album-index.component.css']
})
export class AlbumIndexComponent extends ModelIndexComponent<Album> {

  constructor(protected override modelService: AlbumService) {
    super(modelService);
  }
}
