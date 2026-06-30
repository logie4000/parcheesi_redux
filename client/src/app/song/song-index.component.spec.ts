import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SongIndexComponent } from './song-index.component';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';

describe('SongIndexComponent', () => {
  let component: SongIndexComponent;
  let fixture: ComponentFixture<SongIndexComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
      ],      
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
