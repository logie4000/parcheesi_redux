import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AlbumIndexComponent } from './album-index.component';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';

describe('AlbumIndexComponent', () => {
  let component: AlbumIndexComponent;
  let fixture: ComponentFixture<AlbumIndexComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
      ],      
      imports: [AlbumIndexComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AlbumIndexComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
