import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ArtistIndexComponent } from './artist-index.component';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';

describe('ArtistIndexComponent', () => {
  let component: ArtistIndexComponent;
  let fixture: ComponentFixture<ArtistIndexComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
      ],      
      imports: [ArtistIndexComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ArtistIndexComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
