import { Component, input } from '@angular/core';
import { Router } from '@angular/router';
import { ModelService } from '../models/model.service';

@Component({
  selector: 'app-model-list',
  imports: [],
  template: '',
  styleUrls: []
})
export abstract class ModelListComponent<Model> {
  itemList = input<Model[] | undefined>([]);

  constructor(protected itemService: ModelService<Model>, protected router: Router) {

  }

  onRowClick(item: Model) {
    this.router.navigate([this.itemService.itemUrl(item)]);
  }

  getUrl(item: Model) {
    if (item != undefined) {
      return this.itemService.itemUrl(item);
    } else {
      return '';
    }
  }
}
