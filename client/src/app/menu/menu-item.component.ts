import { Component, input } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-menu-item',
  imports: [],
  templateUrl: './menu-item.component.html',
  styleUrls: [ '../app.component.css', './menu-item.component.css' ]
})
export class MenuItemComponent {
  title = input<string>('');
  link = input<string>('');

  constructor(private router: Router) {

  }

  onClick() {
    this.router.navigateByUrl(this.link())
  }
}
