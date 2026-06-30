import { Component, input } from '@angular/core';
import { Router } from '@angular/router';
import { ModelListComponent } from '../../shared/model-list.component';
import { DeeJay } from '../../models/dee-jay';
import { DeeJayService } from '../../services/dee-jay.service';

@Component({
  selector: 'app-dee-jay-list',
  imports: [],
  templateUrl: './dee-jay-list.component.html',
  styleUrls: ['../../app.component.css', './dee-jay-list.component.css']
})
export class DeeJayListComponent extends ModelListComponent<DeeJay> {
  constructor(protected override itemService: DeeJayService, protected override router: Router) {
    super(itemService, router);
  }
}
