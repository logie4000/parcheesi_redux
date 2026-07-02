import { Component } from '@angular/core';
import { ModelComponent } from '../shared/model.component';
import { RadioShow } from '../models/radio-show';
import { ActivatedRoute, Router } from '@angular/router';
import { RadioShowService } from '../services/radio-show.service';
import { Track } from '../models/track';
import { EMPTY_SONG, Song } from '../models/song';
import { SongListComponent } from "../song/song-list/song-list.component";

@Component({
  selector: 'app-radio-show',
  imports: [SongListComponent],
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

  tracks(): Track[] {
    var radio_show = this.model();

    if (radio_show && radio_show.tracks) {
      return radio_show.tracks;
    } else {
      return [];
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

  weblink(): string {
    var radio_show = this.model();

    if (radio_show && radio_show.web_link) {
      return radio_show.web_link;
    } else {
      return '';
    }
  }

  deeJayName(): string {
    var radio_show = this.model();

    if (radio_show && radio_show.dee_jay) {
      return radio_show.dee_jay.name;
    } else {
      return 'NO DJ';
    }
  }
  
  songs() {   
    var songs: Song[] = this.tracks().map((track: Track) => {
      if (track.song) {
        return track.song;
      } else {
        return EMPTY_SONG;
      }
    })

    return songs;
  }
}
