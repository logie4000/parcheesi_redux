import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DeeJayComponent } from './dee-jay.component';

describe('DeeJayComponent', () => {
  let component: DeeJayComponent;
  let fixture: ComponentFixture<DeeJayComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
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
