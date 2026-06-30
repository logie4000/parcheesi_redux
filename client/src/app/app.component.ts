import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import * as config from './app.config';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = config.APP_TITLE;
}
