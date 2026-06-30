import { Component } from '@angular/core';
import { ModelIndexComponent } from '../shared/model-index.component';
import { RadioShow } from '../models/radio-show';
import { RadioShowService } from '../services/radio-show.service';
import { RadioShowListComponent } from './radio-show-list/radio-show-list.component';

@Component({
  selector: 'app-radio-show-index',
  imports: [RadioShowListComponent],
  templateUrl: './radio-show-index.component.html',
  styleUrls: ['../app.component.css', './radio-show-index.component.css']
})
export class RadioShowIndexComponent extends ModelIndexComponent<RadioShow> {

  constructor(protected override modelService: RadioShowService) {
    super(modelService);
  }
}
