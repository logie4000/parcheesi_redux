import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RadioShowListComponent } from './radio-show-list.component';

describe('RadioShowListComponent', () => {
  let component: RadioShowListComponent;
  let fixture: ComponentFixture<RadioShowListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RadioShowListComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RadioShowListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
