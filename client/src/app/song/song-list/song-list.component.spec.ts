import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SongListComponent } from './song-list.component';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';

describe('SongListComponent', () => {
  let component: SongListComponent;
  let fixture: ComponentFixture<SongListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
      ],      
      imports: [SongListComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SongListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
