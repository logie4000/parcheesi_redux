import { Component } from '@angular/core';
import { ModelIndexComponent } from '../shared/model-index.component';
import { DeeJay } from '../models/dee-jay';
import { DeeJayService } from '../services/dee-jay.service';
import { DeeJayListComponent } from './dee-jay-list/dee-jay-list.component';

@Component({
  selector: 'app-dee-jay-index',
  imports: [DeeJayListComponent],
  templateUrl: './dee-jay-index.component.html',
  styleUrls: ['../app.component.css', './dee-jay-index.component.css']
})
export class DeeJayIndexComponent extends ModelIndexComponent<DeeJay> {

  constructor(protected override modelService: DeeJayService) {
    super(modelService);
  }
}
