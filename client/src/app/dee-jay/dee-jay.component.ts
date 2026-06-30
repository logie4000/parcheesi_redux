import { Component } from '@angular/core';
import { ModelComponent } from '../shared/model.component';
import { DeeJay } from '../models/dee-jay';
import { ActivatedRoute, Router } from '@angular/router';
import { DeeJayService } from '../services/dee-jay.service';

@Component({
  selector: 'app-dee-jay',
  imports: [],
  templateUrl: './dee-jay.component.html',
  styleUrls: ['../app.component.css', './dee-jay.component.css']
})
export class DeeJayComponent extends ModelComponent<DeeJay>{

  constructor(protected override activatedRoute: ActivatedRoute, private router: Router, protected override modelService: DeeJayService) {
    super(activatedRoute, modelService);
  }

  title() {
    var dee_jay = this.model();

    if (dee_jay) {
      return dee_jay.name;
    } else {
      return 'Loading...';
    }
  }

  comment() {
    var dee_jay = this.model();

    if (dee_jay) {
      return dee_jay.email;
    } else {
      return '';
    }
  }
}
