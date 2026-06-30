import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ArtistIndexComponent } from './artist-index.component';

describe('ArtistIndexComponent', () => {
  let component: ArtistIndexComponent;
  let fixture: ComponentFixture<ArtistIndexComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
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
