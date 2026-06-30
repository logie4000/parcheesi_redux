import { Component } from '@angular/core';
import { ModelComponent } from '../shared/model.component';
import { RadioShow } from '../models/radio-show';
import { ActivatedRoute, Router } from '@angular/router';
import { RadioShowService } from '../services/radio-show.service';

@Component({
  selector: 'app-radio-show',
  imports: [],
  templateUrl: './radio-show.component.html',
  styleUrls: ['../app.component.css', './radio-show.component.css']
})
export class RadioShowComponent extends ModelComponent<RadioShow>{

  constructor(protected override activatedRoute: ActivatedRoute, private router: Router, protected override modelService: RadioShowService) {
    super(activatedRoute, modelService);
  }

  title() {
    var radio_show = this.model();

    if (radio_show) {
      return radio_show.title;
    } else {
      return 'Loading...';
    }
  }

  publish_date() {
    var radio_show = this.model();

    if (radio_show) {
      return radio_show.publish_date;
    } else {
      return '';
    }
  }
}
