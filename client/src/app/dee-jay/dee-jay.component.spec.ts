import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DeeJayComponent } from './dee-jay.component';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';
import { provideRouter } from '@angular/router';
import { routes } from '../app.routes';

describe('DeeJayComponent', () => {
  let component: DeeJayComponent;
  let fixture: ComponentFixture<DeeJayComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
        provideRouter(routes),
      ],
      imports: [DeeJayComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DeeJayComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
