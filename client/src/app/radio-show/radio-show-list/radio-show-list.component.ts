import { Component, input } from '@angular/core';
import { Router } from '@angular/router';
import { ModelListComponent } from '../../shared/model-list.component';
import { RadioShow } from '../../models/radio-show';
import { RadioShowService } from '../../services/radio-show.service';

@Component({
  selector: 'app-radio-show-list',
  imports: [],
  templateUrl: './radio-show-list.component.html',
  styleUrls: ['../../app.component.css', './radio-show-list.component.css']
})
export class RadioShowListComponent extends ModelListComponent<RadioShow> {
  constructor(protected override itemService: RadioShowService, protected override router: Router) {
    super(itemService, router);
  }
}
