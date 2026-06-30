import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RadioShowComponent } from './radio-show.component';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';
import { provideRouter } from '@angular/router';
import { routes } from '../app.routes';

describe('RadioShowComponent', () => {
  let component: RadioShowComponent;
  let fixture: ComponentFixture<RadioShowComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
        provideRouter(routes),
      ],      
      imports: [RadioShowComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RadioShowComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
