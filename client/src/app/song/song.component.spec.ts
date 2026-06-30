import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SongComponent } from './song.component';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';
import { provideRouter } from '@angular/router';
import { routes } from '../app.routes';

describe('SongComponent', () => {
  let component: SongComponent;
  let fixture: ComponentFixture<SongComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
        provideRouter(routes),
      ],
      imports: [SongComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SongComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
