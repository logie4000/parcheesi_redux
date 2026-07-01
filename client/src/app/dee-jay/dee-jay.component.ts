import { Component } from '@angular/core';
import { ModelComponent } from '../shared/model.component';
import { DeeJay } from '../models/dee-jay';
import { ActivatedRoute, Router } from '@angular/router';
import { DeeJayService } from '../services/dee-jay.service';
import { Song } from '../models/song';

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

  radio_shows() {
    var dee_jay = this.model();

    if (dee_jay && dee_jay.radio_shows) {
      return dee_jay.radio_shows
    } else {
      return [];
    }
  }
    
  songs(): Song[] {
    var dee_jay = this.model();

    if (dee_jay && dee_jay.songs) {
      return dee_jay.songs;
    } else {
      return [];
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
