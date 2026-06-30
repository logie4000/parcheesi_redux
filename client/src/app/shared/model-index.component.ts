import { httpResource } from '@angular/common/http';
import { Component, computed } from '@angular/core';
import { ModelService } from '../services/model.service';

@Component({
  selector: 'app-model-index',
  imports: [],
  template: '',
  styleUrls: []
})
export abstract class ModelIndexComponent<Model> {
    loadComponentResource = httpResource<Model[]>( () => {
      return `${this.modelService.endpointUrl}`
    });
  
    constructor(protected modelService: ModelService<Model>) {
  
    }
  
    isLoading = computed(() => this.loadComponentResource.isLoading());
    error = computed(() => this.loadComponentResource.error());
    values = this.loadComponentResource.value;


  }
