import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SongIndexComponent } from './song-index.component';

describe('SongIndexComponent', () => {
  let component: SongIndexComponent;
  let fixture: ComponentFixture<SongIndexComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SongIndexComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SongIndexComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
