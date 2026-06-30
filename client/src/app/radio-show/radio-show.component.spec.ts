import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RadioShowComponent } from './radio-show.component';

describe('RadioShowComponent', () => {
  let component: RadioShowComponent;
  let fixture: ComponentFixture<RadioShowComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
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
